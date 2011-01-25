Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:53999 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab1AYOkZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Jan 2011 09:40:25 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RESEND PATCH] Intel SCU Watchdog Timer Driver for Moorestown and
 Medfield platforms.
To: linux-watchdog@vger.kernel.org, wim@iguana.be
Date: Tue, 25 Jan 2011 14:13:38 +0000
Message-ID: <20110125141322.8904.29179.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Donald Johnson <donald.k.johnson@intel.com>

This submission includes:
  - Fix to intel_scu_write() to start watchdog timer the on the
    first write, and refresh on subsequent writes.
    This enables Open, write, write, ... usage model.
  - Moves boot parameter checks from intel_scu_open() to
    intel_scu_watchdog_init(), so driver init will fail if these
    parameters are out of bounds.
  - Adds check for whether process waiting in wait_event_interruptible()
    received a signal while it was waiting.
  - Other small error handling changes.

Signed-off-by: Donald Johnson <donald.k.johnson@intel.com>
[Fix a backwards check]
Signed-off-by: Shuduo Sang <shuduo.sang@intel.com>
[Printk and style clean + check loaded on a MID device]
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/watchdog/Kconfig              |   10 +
 drivers/watchdog/Makefile             |    1 
 drivers/watchdog/intel_scu_watchdog.c |  620 +++++++++++++++++++++++++++++++++
 drivers/watchdog/intel_scu_watchdog.h |   66 ++++
 4 files changed, 697 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/intel_scu_watchdog.c
 create mode 100644 drivers/watchdog/intel_scu_watchdog.h


diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index cbd37bb..3bc099f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -533,6 +533,16 @@ config I6300ESB_WDT
 	  To compile this driver as a module, choose M here: the
 	  module will be called i6300esb.
 
+config INTEL_SCU_WATCHDOG
+	bool "Intel SCU Watchdog for Mobile Platforms"
+	depends on WATCHDOG
+	depends on INTEL_SCU_IPC
+	---help---
+	  Hardware driver for the watchdog time built into the Intel SCU
+	  for Intel Mobile Platforms.
+
+	  To compile this driver as a module, choose M here.
+
 config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on (X86 || IA64) && PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index cd1e7fe..d7901fb 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
 obj-$(CONFIG_W83977F_WDT) += w83977f_wdt.o
 obj-$(CONFIG_MACHZ_WDT) += machzwd.o
 obj-$(CONFIG_SBC_EPX_C3_WATCHDOG) += sbc_epx_c3.o
+obj-$(CONFIG_INTEL_SCU_WATCHDOG) += intel_scu_watchdog.o
 
 # M32R Architecture
 
diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
new file mode 100644
index 0000000..e72704a
--- /dev/null
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -0,0 +1,620 @@
+/*
+ *      Intel_SCU 0.2:  An Intel SCU IOH Based Watchdog Device
+ *			for Intel part #(s):
+ *				- AF82MP20 PCH
+ *
+ *      Copyright (C) 2009-2010 Intel Corporation. All rights reserved.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of version 2 of the GNU General
+ *      Public License as published by the Free Software Foundation.
+ *
+ *      This program is distributed in the hope that it will be
+ *      useful, but WITHOUT ANY WARRANTY; without even the implied
+ *      warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ *      PURPOSE.  See the GNU General Public License for more details.
+ *      You should have received a copy of the GNU General Public
+ *      License along with this program; if not, write to the Free
+ *      Software Foundation, Inc., 59 Temple Place - Suite 330,
+ *      Boston, MA  02111-1307, USA.
+ *      The full GNU General Public License is included in this
+ *      distribution in the file called COPYING.
+ *
+ */
+
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/moduleparam.h>
+#include <linux/types.h>
+#include <linux/miscdevice.h>
+#include <linux/watchdog.h>
+#include <linux/fs.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/uaccess.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/sfi.h>
+#include <linux/types.h>
+#include <asm/irq.h>
+#include <asm/atomic.h>
+#include <asm/intel_scu_ipc.h>
+#include <asm/apb_timer.h>
+#include <asm/mrst.h>
+
+#include "intel_scu_watchdog.h"
+
+/* Bounds number of times we will retry loading time count */
+/* This retry is a work around for a silicon bug.	   */
+#define MAX_RETRY 16
+
+#define IPC_SET_WATCHDOG_TIMER	0xF8
+
+static DECLARE_WAIT_QUEUE_HEAD(read_wq);
+
+/* The read function (intel_scu_read) waits for the warning_flag to */
+/* be set by the watchdog interrupt handler. */
+/* When warning_flag is set intel_scu_read wakes up the user level */
+/* process, which is responsible for refreshing the watchdog timer */
+static int warning_flag;
+
+static int timer_margin = DEFAULT_SOFT_TO_HARD_MARGIN;
+module_param(timer_margin, int, 0);
+MODULE_PARM_DESC(timer_margin,
+		"Watchdog timer margin"
+		"Time between interrupt and resetting the system"
+		"The range is from 1 to 160"
+		"This is the time for all keep alives to arrive");
+
+static int timer_set = DEFAULT_TIME;
+module_param(timer_set, int, 0);
+MODULE_PARM_DESC(timer_set,
+		"Default Watchdog timer setting"
+		"Complete cycle time"
+		"The range is from 1 to 170"
+		"This is the time for all keep alives to arrive");
+
+/* After watchdog device is closed, check force_boot. If:
+ * force_boot == 0, then force boot on next watchdog interrupt after close,
+ * force_boot == 1, then force boot immediately when device is closed.
+ */
+static int force_boot;
+module_param(force_boot, int, 0);
+MODULE_PARM_DESC(force_boot,
+		"A value of 1 means that the driver will reboot"
+		"the system immediately if the /dev/watchdog device is closed"
+		"A value of 0 means that when /dev/watchdog device is closed"
+		"the watchdog timer will be refreshed for one more interval"
+		"of length: timer_set. At the end of this interval, the"
+		"watchdog timer will reset the system."
+		);
+
+/* there is only one device in the system now; this can be made into
+ * an array in the future if we have more than one device */
+
+static struct intel_scu_watchdog_dev watchdog_device;
+
+/* Forces restart, if force_reboot is set */
+static void watchdog_fire(void)
+{
+	if (force_boot) {
+		printk(KERN_CRIT PFX "Initiating system reboot.\n");
+		emergency_restart();
+		printk(KERN_CRIT PFX "Reboot didn't ?????\n");
+	}
+
+	else {
+		printk(KERN_CRIT PFX "Immediate Reboot Disabled\n");
+		printk(KERN_CRIT PFX
+			"System will reset when watchdog timer times out!\n");
+	}
+}
+
+static int check_timer_margin(int new_margin)
+{
+	if ((new_margin < MIN_TIME_CYCLE) ||
+	    (new_margin > MAX_TIME - timer_set)) {
+		pr_debug("Watchdog timer: value of new_margin %d is out of the range %d to %d\n",
+			  new_margin, MIN_TIME_CYCLE, MAX_TIME - timer_set);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * IPC operations
+ */
+static int watchdog_set_ipc(int soft_threshold, int threshold)
+{
+	u32	*ipc_wbuf;
+	u8	 cbuf[16] = { '\0' };
+	int	 ipc_ret = 0;
+
+	ipc_wbuf = (u32 *)&cbuf;
+	ipc_wbuf[0] = soft_threshold;
+	ipc_wbuf[1] = threshold;
+
+	ipc_ret = intel_scu_ipc_command(
+			IPC_SET_WATCHDOG_TIMER,
+			0,
+			ipc_wbuf,
+			2,
+			NULL,
+			0);
+
+	if (ipc_ret != 0)
+		pr_err("Error setting SCU watchdog timer: %x\n", ipc_ret);
+
+	return ipc_ret;
+};
+
+/*
+ *      Intel_SCU operations
+ */
+
+/* timer interrupt handler */
+static irqreturn_t watchdog_timer_interrupt(int irq, void *dev_id)
+{
+	int int_status;
+	int_status = ioread32(watchdog_device.timer_interrupt_status_addr);
+
+	pr_debug("Watchdog timer: irq, int_status: %x\n", int_status);
+
+	if (int_status != 0)
+		return IRQ_NONE;
+
+	/* has the timer been started? If not, then this is spurious */
+	if (watchdog_device.timer_started == 0) {
+		pr_debug("Watchdog timer: spurious interrupt received\n");
+		return IRQ_HANDLED;
+	}
+
+	/* wake up read to send data to user (reminder for keep alive */
+	warning_flag = 1;
+
+	/* temporarily disable the timer */
+	iowrite32(0x00000002, watchdog_device.timer_control_addr);
+
+	/* set the timer to the threshold */
+	iowrite32(watchdog_device.threshold,
+		  watchdog_device.timer_load_count_addr);
+
+	/* allow the timer to run */
+	iowrite32(0x00000003, watchdog_device.timer_control_addr);
+
+	wake_up_interruptible(&read_wq);
+
+	return IRQ_HANDLED;
+}
+
+static int intel_scu_keepalive(void)
+{
+
+	/* read eoi register - clears interrupt */
+	ioread32(watchdog_device.timer_clear_interrupt_addr);
+
+	/* temporarily disable the timer */
+	iowrite32(0x00000002, watchdog_device.timer_control_addr);
+
+	/* set the timer to the soft_threshold */
+	iowrite32(watchdog_device.soft_threshold,
+		  watchdog_device.timer_load_count_addr);
+
+	/* allow the timer to run */
+	iowrite32(0x00000003, watchdog_device.timer_control_addr);
+
+	return 0;
+}
+
+static int intel_scu_stop(void)
+{
+	iowrite32(0, watchdog_device.timer_control_addr);
+	return 0;
+}
+
+static int intel_scu_set_heartbeat(u32 t)
+{
+	int			 ipc_ret;
+	int			 retry_count;
+	u32			 soft_value;
+	u32			 hw_pre_value;
+	u32			 hw_value;
+
+	watchdog_device.timer_set = t;
+	watchdog_device.threshold =
+		timer_margin * watchdog_device.timer_tbl_ptr->freq_hz;
+	watchdog_device.soft_threshold =
+		(watchdog_device.timer_set - timer_margin)
+		* watchdog_device.timer_tbl_ptr->freq_hz;
+
+	pr_debug("Watchdog timer: set_heartbeat: timer freq is %d\n",
+		watchdog_device.timer_tbl_ptr->freq_hz);
+	pr_debug("Watchdog timer: set_heartbeat: timer_set is %x (hex)\n",
+		watchdog_device.timer_set);
+	pr_debug("Watchdog timer: set_hearbeat: timer_margin is %x (hex)\n",
+		timer_margin);
+	pr_debug("Watchdog timer: set_heartbeat: threshold is %x (hex)\n",
+		watchdog_device.threshold);
+	pr_debug("Watchdog timer: set_heartbeat: soft_threshold is %x (hex)\n",
+		watchdog_device.soft_threshold);
+
+	/* Adjust thresholds by FREQ_ADJUSTMENT factor, to make the */
+	/* watchdog timing come out right. */
+	watchdog_device.threshold =
+		watchdog_device.threshold / FREQ_ADJUSTMENT;
+	watchdog_device.soft_threshold =
+		watchdog_device.soft_threshold / FREQ_ADJUSTMENT;
+
+	/* temporarily disable the timer */
+	iowrite32(0x00000002, watchdog_device.timer_control_addr);
+
+	/* send the threshold and soft_threshold via IPC to the processor */
+	ipc_ret = watchdog_set_ipc(watchdog_device.soft_threshold,
+				   watchdog_device.threshold);
+
+	if (ipc_ret != 0) {
+		/* Make sure the watchdog timer is stopped */
+		intel_scu_stop();
+		return ipc_ret;
+	}
+
+	/* Soft Threshold set loop. Early versions of silicon did */
+	/* not always set this count correctly.  This loop checks */
+	/* the value and retries if it was not set correctly.     */
+
+	retry_count = 0;
+	soft_value = watchdog_device.soft_threshold & 0xFFFF0000;
+	do {
+
+		/* Make sure timer is stopped */
+		intel_scu_stop();
+
+		if (MAX_RETRY < retry_count++) {
+			/* Unable to set timer value */
+			pr_err("Watchdog timer: Unable to set timer\n");
+			return -ENODEV;
+		}
+
+		/* set the timer to the soft threshold */
+		iowrite32(watchdog_device.soft_threshold,
+			watchdog_device.timer_load_count_addr);
+
+		/* read count value before starting timer */
+		hw_pre_value = ioread32(watchdog_device.timer_load_count_addr);
+		hw_pre_value = hw_pre_value & 0xFFFF0000;
+
+		/* Start the timer */
+		iowrite32(0x00000003, watchdog_device.timer_control_addr);
+
+		/* read the value the time loaded into its count reg */
+		hw_value = ioread32(watchdog_device.timer_load_count_addr);
+		hw_value = hw_value & 0xFFFF0000;
+
+
+	} while (soft_value != hw_value);
+
+	watchdog_device.timer_started = 1;
+
+	return 0;
+}
+
+/*
+ * /dev/watchdog handling
+ */
+
+static int intel_scu_open(struct inode *inode, struct file *file)
+{
+
+	/* Set flag to indicate that watchdog device is open */
+	if (test_and_set_bit(0, &watchdog_device.driver_open))
+		return -EBUSY;
+
+	/* Check for reopen of driver. Reopens are not allowed */
+	if (watchdog_device.driver_closed)
+		return -EPERM;
+
+	return nonseekable_open(inode, file);
+}
+
+static int intel_scu_release(struct inode *inode, struct file *file)
+{
+	/*
+	 * This watchdog should not be closed, after the timer
+	 * is started with the WDIPC_SETTIMEOUT ioctl
+	 * If force_boot is set watchdog_fire() will cause an
+	 * immediate reset. If force_boot is not set, the watchdog
+	 * timer is refreshed for one more interval. At the end
+	 * of that interval, the watchdog timer will reset the system.
+	 */
+
+	if (!test_and_clear_bit(0, &watchdog_device.driver_open)) {
+		pr_debug("Watchdog timer: intel_scu_release, without open\n");
+		return -ENOTTY;
+	}
+
+	if (!watchdog_device.timer_started) {
+		/* Just close, since timer has not been started */
+		pr_debug("Watchdog timer: closed, without starting timer\n");
+		return 0;
+	}
+
+	printk(KERN_CRIT PFX
+	       "Unexpected close of /dev/watchdog!\n");
+
+	/* Since the timer was started, prevent future reopens */
+	watchdog_device.driver_closed = 1;
+
+	/* Refresh the timer for one more interval */
+	intel_scu_keepalive();
+
+	/* Reboot system (if force_boot is set) */
+	watchdog_fire();
+
+	/* We should only reach this point if force_boot is not set */
+	return 0;
+}
+
+static ssize_t intel_scu_write(struct file *file,
+			      char const *data,
+			      size_t len,
+			      loff_t *ppos)
+{
+
+	if (watchdog_device.timer_started)
+		/* Watchdog already started, keep it alive */
+		intel_scu_keepalive();
+	else
+		/* Start watchdog with timer value set by init */
+		intel_scu_set_heartbeat(watchdog_device.timer_set);
+
+	return len;
+}
+
+static ssize_t intel_scu_read(struct file *file,
+			     char __user *user_data,
+			     size_t len,
+			     loff_t *user_ppos)
+{
+	int result;
+	u8 buf = 0;
+
+	/* we wait for the next interrupt; if more than one */
+	/* interrupt has occurred since the last read, we */
+	/* dont care. The data is not critical. We will do */
+	/* a copy to user each time we get and interrupt */
+	/* It is up to the Watchdog daemon to be ready to */
+	/* do the read (which signifies that the driver is */
+	/* awaiting a keep alive and that a limited time */
+	/* is available for the keep alive before the system */
+	/* is rebooted by the timer */
+	if (wait_event_interruptible(read_wq, warning_flag != 0))
+		return -ERESTARTSYS;
+
+	warning_flag = 0;
+
+	/* Please note that the content of the data is irrelevent */
+	/* All that matters is that the read is available to the user */
+	result = copy_to_user(user_data, (void *)&buf, 1);
+
+	if (result != 0)
+		return -EFAULT;
+	else
+		return 1;
+
+}
+
+static long intel_scu_ioctl(struct file *file,
+			   unsigned int cmd,
+			   unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	u32 __user *p = argp;
+	u32 new_margin;
+
+
+	static const struct watchdog_info ident = {
+		.options =          WDIOF_SETTIMEOUT
+				    | WDIOF_KEEPALIVEPING,
+		.firmware_version = 0,  /* @todo Get from SCU via
+						 ipc_get_scu_fw_version()? */
+		.identity =         "Intel_SCU IOH Watchdog"  /* len < 32 */
+	};
+
+	switch (cmd) {
+	case WDIOC_GETSUPPORT:
+		return copy_to_user(argp,
+				    &ident,
+				    sizeof(ident)) ? -EFAULT : 0;
+	case WDIOC_GETSTATUS:
+	case WDIOC_GETBOOTSTATUS:
+		return put_user(0, p);
+	case WDIOC_KEEPALIVE:
+		intel_scu_keepalive();
+
+		return 0;
+	case WDIOC_SETTIMEOUT:
+		if (get_user(new_margin, p))
+			return -EFAULT;
+
+		if (check_timer_margin(new_margin))
+			return -EINVAL;
+
+		if (intel_scu_set_heartbeat(new_margin))
+			return -EINVAL;
+		return 0;
+	case WDIOC_GETTIMEOUT:
+		return put_user(watchdog_device.soft_threshold, p);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+/*
+ *      Notifier for system down
+ */
+static int intel_scu_notify_sys(struct notifier_block *this,
+			       unsigned long code,
+			       void *another_unused)
+{
+	if (code == SYS_DOWN || code == SYS_HALT)
+		/* Turn off the watchdog timer. */
+		intel_scu_stop();
+	return NOTIFY_DONE;
+}
+
+/*
+ *      Kernel Interfaces
+ */
+static const struct file_operations intel_scu_fops = {
+	.owner          = THIS_MODULE,
+	.llseek         = no_llseek,
+	.write          = intel_scu_write,
+	.read		= intel_scu_read,
+	.unlocked_ioctl = intel_scu_ioctl,
+	.open           = intel_scu_open,
+	.release        = intel_scu_release,
+};
+
+static int __init intel_scu_watchdog_init(void)
+{
+	int ret;
+	u32 __iomem *tmp_addr;
+
+	/*
+	 * We don't really need to check this as the SFI timer get will fail
+	 * but if we do so we can exit with a clearer reason and no noise.
+	 *
+	 * If it isn't an intel MID device then it doesn't have this watchdog
+	 */
+	if (!mrst_identify_cpu())
+		return -ENODEV;
+
+	/* Check boot parameters to verify that their initial values */
+	/* are in range. */
+	/* Check value of timer_set boot parameter */
+	if ((timer_set < MIN_TIME_CYCLE) ||
+	    (timer_set > MAX_TIME - MIN_TIME_CYCLE)) {
+		pr_err("Watchdog timer: value of timer_set %x (hex) "
+		  "is out of range from %x to %x (hex)\n",
+		  timer_set, MIN_TIME_CYCLE, MAX_TIME - MIN_TIME_CYCLE);
+		return -EINVAL;
+	}
+
+	/* Check value of timer_margin boot parameter */
+	if (check_timer_margin(timer_margin))
+		return -EINVAL;
+
+	watchdog_device.timer_tbl_ptr = sfi_get_mtmr(sfi_mtimer_num-1);
+
+	if (watchdog_device.timer_tbl_ptr == NULL) {
+		pr_debug("Watchdog timer - Intel SCU watchdog: timer is not available\n");
+		return -ENODEV;
+	}
+	/* make sure the timer exists */
+	if (watchdog_device.timer_tbl_ptr->phys_addr == 0) {
+		pr_debug("Watchdog timer - Intel SCU watchdog - timer %d does not have valid physical memory\n",
+								sfi_mtimer_num);
+		return -ENODEV;
+	}
+
+	if (watchdog_device.timer_tbl_ptr->irq == 0) {
+		pr_debug("Watchdog timer: timer %d invalid irq\n",
+							sfi_mtimer_num);
+		return -ENODEV;
+	}
+
+	tmp_addr = ioremap_nocache(watchdog_device.timer_tbl_ptr->phys_addr,
+			20);
+
+	if (tmp_addr == NULL) {
+		pr_debug("Watchdog timer: timer unable to ioremap\n");
+		return -ENOMEM;
+	}
+
+	watchdog_device.timer_load_count_addr = tmp_addr++;
+	watchdog_device.timer_current_value_addr = tmp_addr++;
+	watchdog_device.timer_control_addr = tmp_addr++;
+	watchdog_device.timer_clear_interrupt_addr = tmp_addr++;
+	watchdog_device.timer_interrupt_status_addr = tmp_addr++;
+
+	/* Set the default time values in device structure */
+
+	watchdog_device.timer_set = timer_set;
+	watchdog_device.threshold =
+		timer_margin * watchdog_device.timer_tbl_ptr->freq_hz;
+	watchdog_device.soft_threshold =
+		(watchdog_device.timer_set - timer_margin)
+		* watchdog_device.timer_tbl_ptr->freq_hz;
+
+
+	watchdog_device.intel_scu_notifier.notifier_call =
+		intel_scu_notify_sys;
+
+	ret = register_reboot_notifier(&watchdog_device.intel_scu_notifier);
+	if (ret) {
+		pr_err("Watchdog timer: cannot register notifier %d)\n", ret);
+		goto register_reboot_error;
+	}
+
+	watchdog_device.miscdev.minor = WATCHDOG_MINOR;
+	watchdog_device.miscdev.name = "watchdog";
+	watchdog_device.miscdev.fops = &intel_scu_fops;
+
+	ret = misc_register(&watchdog_device.miscdev);
+	if (ret) {
+		pr_err("Watchdog timer: cannot register miscdev %d err =%d\n",
+							WATCHDOG_MINOR, ret);
+		goto misc_register_error;
+	}
+
+	ret = request_irq((unsigned int)watchdog_device.timer_tbl_ptr->irq,
+		watchdog_timer_interrupt,
+		IRQF_SHARED, "watchdog",
+		&watchdog_device.timer_load_count_addr);
+	if (ret) {
+		pr_err("Watchdog timer: error requesting irq %d\n", ret);
+		goto request_irq_error;
+	}
+	/* Make sure timer is disabled before returning */
+	intel_scu_stop();
+	return 0;
+
+/* error cleanup */
+
+request_irq_error:
+	misc_deregister(&watchdog_device.miscdev);
+misc_register_error:
+	unregister_reboot_notifier(&watchdog_device.intel_scu_notifier);
+register_reboot_error:
+	intel_scu_stop();
+	iounmap(watchdog_device.timer_load_count_addr);
+	return ret;
+}
+
+static void __exit intel_scu_watchdog_exit(void)
+{
+
+	misc_deregister(&watchdog_device.miscdev);
+	unregister_reboot_notifier(&watchdog_device.intel_scu_notifier);
+	/* disable the timer */
+	iowrite32(0x00000002, watchdog_device.timer_control_addr);
+	iounmap(watchdog_device.timer_load_count_addr);
+}
+
+late_initcall(intel_scu_watchdog_init);
+module_exit(intel_scu_watchdog_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel SCU Watchdog Device Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
+MODULE_VERSION(WDT_VER);
+
diff --git a/drivers/watchdog/intel_scu_watchdog.h b/drivers/watchdog/intel_scu_watchdog.h
new file mode 100644
index 0000000..d2b074a
--- /dev/null
+++ b/drivers/watchdog/intel_scu_watchdog.h
@@ -0,0 +1,66 @@
+/*
+ *      Intel_SCU 0.2:  An Intel SCU IOH Based Watchdog Device
+ *			for Intel part #(s):
+ *				- AF82MP20 PCH
+ *
+ *      Copyright (C) 2009-2010 Intel Corporation. All rights reserved.
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of version 2 of the GNU General
+ *      Public License as published by the Free Software Foundation.
+ *
+ *      This program is distributed in the hope that it will be
+ *      useful, but WITHOUT ANY WARRANTY; without even the implied
+ *      warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
+ *      PURPOSE.  See the GNU General Public License for more details.
+ *      You should have received a copy of the GNU General Public
+ *      License along with this program; if not, write to the Free
+ *      Software Foundation, Inc., 59 Temple Place - Suite 330,
+ *      Boston, MA  02111-1307, USA.
+ *      The full GNU General Public License is included in this
+ *      distribution in the file called COPYING.
+ *
+ */
+
+#ifndef __INTEL_SCU_WATCHDOG_H
+#define __INTEL_SCU_WATCHDOG_H
+
+#define PFX "Intel_SCU: "
+#define WDT_VER "0.3"
+
+/* minimum time between interrupts */
+#define MIN_TIME_CYCLE 1
+
+/* Time from warning to reboot is 2 seconds */
+#define DEFAULT_SOFT_TO_HARD_MARGIN 2
+
+#define MAX_TIME 170
+
+#define DEFAULT_TIME 5
+
+#define MAX_SOFT_TO_HARD_MARGIN (MAX_TIME-MIN_TIME_CYCLE)
+
+/* Ajustment to clock tick frequency to make timing come out right */
+#define FREQ_ADJUSTMENT 8
+
+struct intel_scu_watchdog_dev {
+	ulong driver_open;
+	ulong driver_closed;
+	u32 timer_started;
+	u32 timer_set;
+	u32 threshold;
+	u32 soft_threshold;
+	u32 __iomem *timer_load_count_addr;
+	u32 __iomem *timer_current_value_addr;
+	u32 __iomem *timer_control_addr;
+	u32 __iomem *timer_clear_interrupt_addr;
+	u32 __iomem *timer_interrupt_status_addr;
+	struct sfi_timer_table_entry *timer_tbl_ptr;
+	struct notifier_block intel_scu_notifier;
+	struct miscdevice miscdev;
+};
+
+extern int sfi_mtimer_num;
+
+/* extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint); */
+#endif /* __INTEL_SCU_WATCHDOG_H */

