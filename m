Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from proxima.lp0.eu ([81.2.80.65]:34147 "EHLO proxima.lp0.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210AbbKUTO7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 21 Nov 2015 14:14:59 -0500
Subject: [PATCH 4/4] MIPS: bmips: Convert bcm63xx_wdt to use WATCHDOG_CORE
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Miguel Gaio <miguel.gaio@efixo.com>,
	Maxime Bizon <mbizon@freebox.fr>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
From: Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5650C08C.6090300@simon.arlott.org.uk>
Date: Sat, 21 Nov 2015 19:05:48 +0000
MIME-Version: 1.0
In-Reply-To: <5650BFD6.5030700@simon.arlott.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Convert bcm63xx_wdt to use WATCHDOG_CORE and add a device tree binding.

Adds support for the time left value and provides a more effective
interrupt handler based on the watchdog warning interrupt behaviour.

This removes the unnecessary software countdown timer and replaces the
use of bcm63xx_timer with a normal interrupt when not using mach-bcm63xx.

Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
---
 arch/mips/bcm63xx/prom.c                          |   1 +
 arch/mips/bcm63xx/setup.c                         |   1 +
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h |  22 --
 drivers/watchdog/Kconfig                          |   4 +-
 drivers/watchdog/bcm63xx_wdt.c                    | 420 +++++++++++-----------
 include/linux/bcm63xx_wdt.h                       |  22 ++
 6 files changed, 244 insertions(+), 226 deletions(-)
 create mode 100644 include/linux/bcm63xx_wdt.h

diff --git a/arch/mips/bcm63xx/prom.c b/arch/mips/bcm63xx/prom.c
index 7019e29..ba8b354 100644
--- a/arch/mips/bcm63xx/prom.c
+++ b/arch/mips/bcm63xx/prom.c
@@ -17,6 +17,7 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
+#include <linux/bcm63xx_wdt.h>
 
 void __init prom_init(void)
 {
diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
index 240fb4f..6abf364 100644
--- a/arch/mips/bcm63xx/setup.c
+++ b/arch/mips/bcm63xx/setup.c
@@ -21,6 +21,7 @@
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_gpio.h>
+#include <linux/bcm63xx_wdt.h>
 
 void bcm63xx_machine_halt(void)
 {
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
index 5035f09..16a745b 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h
@@ -441,28 +441,6 @@
 
 
 /*************************************************************************
- * _REG relative to RSET_WDT
- *************************************************************************/
-
-/* Watchdog default count register */
-#define WDT_DEFVAL_REG			0x0
-
-/* Watchdog control register */
-#define WDT_CTL_REG			0x4
-
-/* Watchdog control register constants */
-#define WDT_START_1			(0xff00)
-#define WDT_START_2			(0x00ff)
-#define WDT_STOP_1			(0xee00)
-#define WDT_STOP_2			(0x00ee)
-
-/* Watchdog reset length register */
-#define WDT_RSTLEN_REG			0x8
-
-/* Watchdog soft reset register (BCM6328 only) */
-#define WDT_SOFTRESET_REG		0xc
-
-/*************************************************************************
  * _REG relative to RSET_GPIO
  *************************************************************************/
 
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7a8a6c6..0c50add 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1272,7 +1272,9 @@ config OCTEON_WDT
 
 config BCM63XX_WDT
 	tristate "Broadcom BCM63xx hardware watchdog"
-	depends on BCM63XX
+	depends on BCM63XX || BMIPS_GENERIC
+	select WATCHDOG_CORE
+	select BCM6345_L2_TIMER_IRQ if BMIPS_GENERIC
 	help
 	  Watchdog driver for the built in watchdog hardware in Broadcom
 	  BCM63xx SoC.
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index ab26fd9..fff92d0 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2007, Miguel Gaio <miguel.gaio@efixo.com>
  *  Copyright (C) 2008, Florian Fainelli <florian@openwrt.org>
+ *  Copyright 2015 Simon Arlott
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -12,235 +13,165 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-#include <linux/bitops.h>
+#include <linux/bcm63xx_wdt.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/errno.h>
-#include <linux/fs.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/uaccess.h>
 #include <linux/watchdog.h>
-#include <linux/timer.h>
-#include <linux/jiffies.h>
-#include <linux/interrupt.h>
-#include <linux/ptrace.h>
-#include <linux/resource.h>
-#include <linux/platform_device.h>
 
-#include <bcm63xx_cpu.h>
-#include <bcm63xx_io.h>
-#include <bcm63xx_regs.h>
-#include <bcm63xx_timer.h>
+#ifdef CONFIG_BCM63XX
+# include <bcm63xx_regs.h>
+# include <bcm63xx_timer.h>
+#endif
 
 #define PFX KBUILD_MODNAME
 
-#define WDT_HZ		50000000 /* Fclk */
-#define WDT_DEFAULT_TIME	30      /* seconds */
-#define WDT_MAX_TIME		256     /* seconds */
-
-static struct {
-	void __iomem *regs;
-	struct timer_list timer;
-	unsigned long inuse;
-	atomic_t ticks;
-} bcm63xx_wdt_device;
-
-static int expect_close;
-
-static int wdt_time = WDT_DEFAULT_TIME;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-/* HW functions */
-static void bcm63xx_wdt_hw_start(void)
-{
-	bcm_writel(0xfffffffe, bcm63xx_wdt_device.regs + WDT_DEFVAL_REG);
-	bcm_writel(WDT_START_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-	bcm_writel(WDT_START_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-}
-
-static void bcm63xx_wdt_hw_stop(void)
-{
-	bcm_writel(WDT_STOP_1, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-	bcm_writel(WDT_STOP_2, bcm63xx_wdt_device.regs + WDT_CTL_REG);
-}
-
-static void bcm63xx_wdt_isr(void *data)
-{
-	struct pt_regs *regs = get_irq_regs();
-
-	die(PFX " fire", regs);
-}
-
-static void bcm63xx_timer_tick(unsigned long unused)
-{
-	if (!atomic_dec_and_test(&bcm63xx_wdt_device.ticks)) {
-		bcm63xx_wdt_hw_start();
-		mod_timer(&bcm63xx_wdt_device.timer, jiffies + HZ);
-	} else
-		pr_crit("watchdog will restart system\n");
-}
-
-static void bcm63xx_wdt_pet(void)
-{
-	atomic_set(&bcm63xx_wdt_device.ticks, wdt_time);
-}
-
-static void bcm63xx_wdt_start(void)
-{
-	bcm63xx_wdt_pet();
-	bcm63xx_timer_tick(0);
-}
+struct bcm63xx_wdt_hw {
+	raw_spinlock_t lock;
+	void __iomem *base;
+	struct clk *clk;
+	u32 clock_hz;
+	int irq;
+	bool running;
+};
 
-static void bcm63xx_wdt_pause(void)
+static int bcm63xx_wdt_start(struct watchdog_device *wdd)
 {
-	del_timer_sync(&bcm63xx_wdt_device.timer);
-	bcm63xx_wdt_hw_stop();
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	__raw_writel(wdd->timeout * hw->clock_hz, hw->base + WDT_DEFVAL_REG);
+	__raw_writel(WDT_START_1, hw->base + WDT_CTL_REG);
+	__raw_writel(WDT_START_2, hw->base + WDT_CTL_REG);
+	hw->running = true;
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
+	return 0;
 }
 
-static int bcm63xx_wdt_settimeout(int new_time)
+static int bcm63xx_wdt_stop(struct watchdog_device *wdd)
 {
-	if ((new_time <= 0) || (new_time > WDT_MAX_TIME))
-		return -EINVAL;
-
-	wdt_time = new_time;
-
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	__raw_writel(WDT_STOP_1, hw->base + WDT_CTL_REG);
+	__raw_writel(WDT_STOP_2, hw->base + WDT_CTL_REG);
+	hw->running = false;
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
 	return 0;
 }
 
-static int bcm63xx_wdt_open(struct inode *inode, struct file *file)
+static unsigned int bcm63xx_wdt_get_timeleft(struct watchdog_device *wdd)
 {
-	if (test_and_set_bit(0, &bcm63xx_wdt_device.inuse))
-		return -EBUSY;
-
-	bcm63xx_wdt_start();
-	return nonseekable_open(inode, file);
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	val = __raw_readl(hw->base + WDT_CTL_REG);
+	val /= hw->clock_hz;
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
+	return val;
 }
 
-static int bcm63xx_wdt_release(struct inode *inode, struct file *file)
+static int bcm63xx_wdt_set_timeout(struct watchdog_device *wdd,
+	unsigned int timeout)
 {
-	if (expect_close == 42)
-		bcm63xx_wdt_pause();
-	else {
-		pr_crit("Unexpected close, not stopping watchdog!\n");
-		bcm63xx_wdt_start();
-	}
-	clear_bit(0, &bcm63xx_wdt_device.inuse);
-	expect_close = 0;
-	return 0;
+	wdd->timeout = timeout;
+	return bcm63xx_wdt_start(wdd);
 }
 
-static ssize_t bcm63xx_wdt_write(struct file *file, const char *data,
-				size_t len, loff_t *ppos)
+/* The watchdog interrupt occurs when half the timeout is remaining */
+#ifdef CONFIG_BCM63XX
+static void bcm63xx_wdt_interrupt(void *data)
+#else
+static irqreturn_t bcm63xx_wdt_interrupt(int irq, void *data)
+#endif
 {
-	if (len) {
-		if (!nowayout) {
-			size_t i;
-
-			/* In case it was set long ago */
-			expect_close = 0;
-
-			for (i = 0; i != len; i++) {
-				char c;
-				if (get_user(c, data + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_close = 42;
-			}
+	struct watchdog_device *wdd = data;
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&hw->lock, flags);
+	if (!hw->running) {
+		/* Oops */
+		__raw_writel(WDT_STOP_1, hw->base + WDT_CTL_REG);
+		__raw_writel(WDT_STOP_2, hw->base + WDT_CTL_REG);
+	} else {
+		u32 timeleft = __raw_readl(hw->base + WDT_CTL_REG);
+		u32 ms;
+
+		if (timeleft >= 2) {
+			/* The only way to stop this interrupt without masking
+			 * the whole timer interrupt or disrupting the intended
+			 * behaviour of the watchdog is to restart the watchdog
+			 * with the remaining time value so that the interrupt
+			 * occurs again at 1/4th, 1/8th, etc. of the timeout
+			 * until we reboot.
+			 *
+			 * This is done with a lock held in case userspace is
+			 * restarting the watchdog on another CPU.
+			 */
+			__raw_writel(timeleft, hw->base + WDT_DEFVAL_REG);
+			__raw_writel(WDT_START_1, hw->base + WDT_CTL_REG);
+			__raw_writel(WDT_START_2, hw->base + WDT_CTL_REG);
+		} else {
+			/* The watchdog cannot be started with a time of less
+			 * than 2 ticks (it won't fire).
+			 */
+			die(PFX ": watchdog timer expired\n", get_irq_regs());
 		}
-		bcm63xx_wdt_pet();
-	}
-	return len;
-}
-
-static struct watchdog_info bcm63xx_wdt_info = {
-	.identity       = PFX,
-	.options        = WDIOF_SETTIMEOUT |
-				WDIOF_KEEPALIVEPING |
-				WDIOF_MAGICCLOSE,
-};
-
-
-static long bcm63xx_wdt_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	int new_value, retval = -EINVAL;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &bcm63xx_wdt_info,
-			sizeof(bcm63xx_wdt_info)) ? -EFAULT : 0;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-
-	case WDIOC_SETOPTIONS:
-		if (get_user(new_value, p))
-			return -EFAULT;
-
-		if (new_value & WDIOS_DISABLECARD) {
-			bcm63xx_wdt_pause();
-			retval = 0;
-		}
-		if (new_value & WDIOS_ENABLECARD) {
-			bcm63xx_wdt_start();
-			retval = 0;
-		}
-
-		return retval;
-
-	case WDIOC_KEEPALIVE:
-		bcm63xx_wdt_pet();
-		return 0;
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_value, p))
-			return -EFAULT;
-
-		if (bcm63xx_wdt_settimeout(new_value))
-			return -EINVAL;
-
-		bcm63xx_wdt_pet();
-
-	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_time, p);
-
-	default:
-		return -ENOTTY;
 
+		ms = timeleft / (hw->clock_hz / 1000);
+		dev_alert(wdd->dev, "warning timer fired, reboot in %ums", ms);
 	}
+	raw_spin_unlock_irqrestore(&hw->lock, flags);
+#ifndef CONFIG_BCM63XX
+	return IRQ_HANDLED;
+#endif
 }
 
-static const struct file_operations bcm63xx_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.write		= bcm63xx_wdt_write,
-	.unlocked_ioctl	= bcm63xx_wdt_ioctl,
-	.open		= bcm63xx_wdt_open,
-	.release	= bcm63xx_wdt_release,
+static struct watchdog_ops bcm63xx_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = bcm63xx_wdt_start,
+	.stop = bcm63xx_wdt_stop,
+	.get_timeleft = bcm63xx_wdt_get_timeleft,
+	.set_timeout = bcm63xx_wdt_set_timeout,
 };
 
-static struct miscdevice bcm63xx_wdt_miscdev = {
-	.minor	= WATCHDOG_MINOR,
-	.name	= "watchdog",
-	.fops	= &bcm63xx_wdt_fops,
+static const struct watchdog_info bcm63xx_wdt_info = {
+	.options = WDIOC_GETTIMELEFT | WDIOF_SETTIMEOUT |
+			WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "BCM63xx Watchdog",
 };
 
-
 static int bcm63xx_wdt_probe(struct platform_device *pdev)
 {
-	int ret;
+	struct bcm63xx_wdt_hw *hw;
+	struct watchdog_device *wdd;
 	struct resource *r;
+	unsigned int timeleft;
+	int ret;
 
-	setup_timer(&bcm63xx_wdt_device.timer, bcm63xx_timer_tick, 0L);
+	hw = devm_kzalloc(&pdev->dev, sizeof(*hw), GFP_KERNEL);
+	wdd = devm_kzalloc(&pdev->dev, sizeof(*wdd), GFP_KERNEL);
+	if (!hw || !wdd)
+		return -ENOMEM;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -248,63 +179,145 @@ static int bcm63xx_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bcm63xx_wdt_device.regs = devm_ioremap_nocache(&pdev->dev, r->start,
-							resource_size(r));
-	if (!bcm63xx_wdt_device.regs) {
+	hw->base = devm_ioremap_nocache(&pdev->dev, r->start, resource_size(r));
+	if (!hw->base) {
 		dev_err(&pdev->dev, "failed to remap I/O resources\n");
 		return -ENXIO;
 	}
 
-	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_isr, NULL);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register wdt timer isr\n");
+#ifdef CONFIG_BCM63XX
+	hw->clk = devm_clk_get(&pdev->dev, "periph");
+#else
+	hw->clk = devm_clk_get(&pdev->dev, NULL);
+#endif
+	if (IS_ERR(hw->clk)) {
+		dev_err(&pdev->dev, "unable to request clock\n");
+		return PTR_ERR(hw->clk);
+	}
+
+	hw->clock_hz = clk_get_rate(hw->clk);
+	if (!hw->clock_hz) {
+		dev_err(&pdev->dev, "unable to fetch clock rate\n");
+		return -EINVAL;
+	}
+
+	ret = clk_prepare_enable(hw->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to enable clock\n");
 		return ret;
 	}
 
-	if (bcm63xx_wdt_settimeout(wdt_time)) {
-		bcm63xx_wdt_settimeout(WDT_DEFAULT_TIME);
-		dev_info(&pdev->dev,
-			": wdt_time value must be 1 <= wdt_time <= 256, using %d\n",
-			wdt_time);
+	raw_spin_lock_init(&hw->lock);
+	hw->running = false;
+
+	wdd->parent = &pdev->dev;
+	wdd->ops = &bcm63xx_wdt_ops;
+	wdd->info = &bcm63xx_wdt_info;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = 0xffffffff / hw->clock_hz;
+	wdd->timeout = min(30U, wdd->max_timeout);
+
+	watchdog_set_drvdata(wdd, hw);
+	platform_set_drvdata(pdev, wdd);
+
+	watchdog_init_timeout(wdd, 0, &pdev->dev);
+	watchdog_set_nowayout(wdd, nowayout);
+
+	timeleft = bcm63xx_wdt_get_timeleft(wdd);
+	if (timeleft > 0)
+		hw->running = true;
+
+#ifdef CONFIG_BCM63XX
+	ret = bcm63xx_timer_register(TIMER_WDT_ID, bcm63xx_wdt_interrupt, wdd);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register with bcm63xx_timer\n");
+		goto disable_clk;
 	}
+	hw->irq = 0;
+#endif
 
-	ret = misc_register(&bcm63xx_wdt_miscdev);
+	ret = watchdog_register_device(wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register watchdog device\n");
+#ifdef CONFIG_BCM63XX
 		goto unregister_timer;
+#else
+		goto disable_clk;
+#endif
 	}
 
-	dev_info(&pdev->dev, " started, timer margin: %d sec\n",
-						WDT_DEFAULT_TIME);
+#ifndef CONFIG_BCM63XX
+	hw->irq = platform_get_irq(pdev, 0);
+	if (hw->irq) {
+		ret = devm_request_irq(&pdev->dev, hw->irq,
+			bcm63xx_wdt_interrupt, IRQF_TIMER,
+			dev_name(&pdev->dev), wdd);
+		if (ret)
+			hw->irq = 0;
+	}
+#endif
+
+	if (hw->irq) {
+		dev_info(&pdev->dev,
+			"%s at MMIO 0x%p (irq = %d, timeout = %us, max_timeout = %us)",
+			dev_name(wdd->dev), hw->base, hw->irq,
+			wdd->timeout, wdd->max_timeout);
+	} else {
+		dev_info(&pdev->dev,
+			"%s at MMIO 0x%p (timeout = %us, max_timeout = %us)",
+			dev_name(wdd->dev), hw->base,
+			wdd->timeout, wdd->max_timeout);
+	}
 
+	if (timeleft > 0)
+		dev_alert(wdd->dev, "running, reboot in %us\n", timeleft);
 	return 0;
 
+#ifdef CONFIG_BCM63XX
 unregister_timer:
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
+#endif
+disable_clk:
+	clk_disable(hw->clk);
 	return ret;
 }
 
 static int bcm63xx_wdt_remove(struct platform_device *pdev)
 {
-	if (!nowayout)
-		bcm63xx_wdt_pause();
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+	struct bcm63xx_wdt_hw *hw = watchdog_get_drvdata(wdd);
 
-	misc_deregister(&bcm63xx_wdt_miscdev);
+	if (hw->irq)
+		devm_free_irq(&pdev->dev, hw->irq, wdd);
+
+#ifdef CONFIG_BCM63XX
 	bcm63xx_timer_unregister(TIMER_WDT_ID);
+#endif
+	watchdog_unregister_device(wdd);
+	clk_disable(hw->clk);
 	return 0;
 }
 
 static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
 {
-	bcm63xx_wdt_pause();
+	struct watchdog_device *wdd = platform_get_drvdata(pdev);
+
+	bcm63xx_wdt_stop(wdd);
 }
 
+static const struct of_device_id bcm63xx_wdt_dt_ids[] = {
+	{ .compatible = "brcm,bcm6345-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, bcm63xx_wdt_dt_ids);
+
 static struct platform_driver bcm63xx_wdt_driver = {
 	.probe	= bcm63xx_wdt_probe,
 	.remove = bcm63xx_wdt_remove,
 	.shutdown = bcm63xx_wdt_shutdown,
 	.driver = {
 		.name = "bcm63xx-wdt",
+		.of_match_table = bcm63xx_wdt_dt_ids,
 	}
 };
 
@@ -312,6 +325,7 @@ module_platform_driver(bcm63xx_wdt_driver);
 
 MODULE_AUTHOR("Miguel Gaio <miguel.gaio@efixo.com>");
 MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
+MODULE_AUTHOR("Simon Arlott");
 MODULE_DESCRIPTION("Driver for the Broadcom BCM63xx SoC watchdog");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:bcm63xx-wdt");
diff --git a/include/linux/bcm63xx_wdt.h b/include/linux/bcm63xx_wdt.h
new file mode 100644
index 0000000..ef4792e
--- /dev/null
+++ b/include/linux/bcm63xx_wdt.h
@@ -0,0 +1,22 @@
+#ifndef LINUX_BCM63XX_WDT_H_
+#define LINUX_BCM63XX_WDT_H_
+
+/* Watchdog default count register */
+#define WDT_DEFVAL_REG			0x0
+
+/* Watchdog control register */
+#define WDT_CTL_REG			0x4
+
+/* Watchdog control register constants */
+#define WDT_START_1			(0xff00)
+#define WDT_START_2			(0x00ff)
+#define WDT_STOP_1			(0xee00)
+#define WDT_STOP_2			(0x00ee)
+
+/* Watchdog reset length register (in clock ticks) */
+#define WDT_RSTLEN_REG			0x8
+
+/* Watchdog soft reset register (BCM6328 only) */
+#define WDT_SOFTRESET_REG		0xc
+
+#endif
-- 
2.1.4

-- 
Simon Arlott
