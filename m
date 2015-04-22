Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:34979 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756829AbbDVNif (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Apr 2015 09:38:35 -0400
Date: Wed, 22 Apr 2015 15:38:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Michal Simek <michal.simek@xilinx.com>,
	Mathieu Olivari <mathieu@codeaurora.org>,
	Joe Perches <joe@perches.com>
Subject: [GIT PULL REQUEST] watchdog - v4.1 merge window
Message-ID: <20150422133831.GA24466@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git

This contains following changes:
* Octeon: convert to watchdog-API and apply some fixes
* Cadence wdt: remove dependency on ARCH
* Add DT bindings for qcom + msm
* bcm281xx: Remove use of seq_printf return value
* stmp3xxx_rtc_wdt + pnx4008_wdt: fix broken email addresses

This will update the following files:

 Documentation/devicetree/bindings/arm/msm/timer.txt |   16 +
 arch/arm/boot/dts/qcom-ipq8064.dtsi                 |   14 +
 drivers/watchdog/Kconfig                            |    2 
 drivers/watchdog/bcm_kona_wdt.c                     |   27 +-
 drivers/watchdog/octeon-wdt-main.c                  |  201 ++++----------------
 drivers/watchdog/pnx4008_wdt.c                      |    2 
 drivers/watchdog/qcom-wdt.c                         |   21 +-
 drivers/watchdog/stmp3xxx_rtc_wdt.c                 |    4 
 8 files changed, 109 insertions(+), 178 deletions(-)

with these Changes:

commit cf82f52d3619d2e15c83ec9a03c6ce8cdf6c6b58
Author: Wolfram Sang <wsa@the-dreams.de>
Date:   Mon Apr 20 15:51:44 2015 +0200

    watchdog: stmp3xxx_rtc_wdt: fix broken email address
    
    My Pengutronix address is not valid anymore, redirect people to the Pengutronix
    kernel team.
    
    Reported-by: Harald Geyer <harald@ccbib.org>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
    Acked-by: Robert Schwebel <r.schwebel@pengutronix.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e8cc53665728860a56dbbd56bfc32ac934efb70a
Author: Wolfram Sang <wsa@the-dreams.de>
Date:   Mon Apr 20 15:51:43 2015 +0200

    watchdog: pnx4008_wdt: fix broken email address
    
    My Pengutronix address is not valid anymore, redirect people to the Pengutronix
    kernel team.
    
    Reported-by: Harald Geyer <harald@ccbib.org>
    Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
    Acked-by: Robert Schwebel <r.schwebel@pengutronix.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3a30c07e712df895981deac0782655997942bc75
Author: Aaro Koskinen <aaro.koskinen@iki.fi>
Date:   Sat Mar 28 20:05:40 2015 +0200

    watchdog: octeon: use fixed length string for register names
    
    Use fixed length string for register names. This saves 416 bytes
    in text size.
    
    Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8692cf0ad31b3654c798c23de01e4c23c4536dea
Author: Aaro Koskinen <aaro.koskinen@iki.fi>
Date:   Sat Mar 28 20:05:39 2015 +0200

    watchdog: octeon: fix some trivial coding style issues
    
    Fix some trivial coding style issues to reduce noise from static analyzers.
    
    Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 3d588c93c040c4aacca81b15a7aa9761357ecdc4
Author: Aaro Koskinen <aaro.koskinen@iki.fi>
Date:   Sat Mar 28 20:05:38 2015 +0200

    watchdog: octeon: convert to WATCHDOG_CORE API
    
    Convert OCTEON watchdog to WATCHDOG_CORE API. This enables support
    for multiple watchdogs on OCTEON boards.
    
    Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 6290d8c826023a633da3e675784b5f317a9600f0
Author: Michal Simek <michal.simek@xilinx.com>
Date:   Mon Mar 9 09:50:12 2015 +0100

    watchdog: cadence: Remove Kconfig dependency on ARCH
    
    Remove Kconfig dependency and enable driver for
    all ARCHs.
    
    Signed-off-by: Michal Simek <michal.simek@xilinx.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit cf79fb14d09f8a9aaadfce59d01cfedf4f96d99d
Author: Mathieu Olivari <mathieu@codeaurora.org>
Date:   Fri Feb 20 18:19:36 2015 -0800

    ARM: msm: add watchdog entries to DT timer binding doc
    
    The watchdog has been reworked to use the same DT node as the timer.
    This change is updating the device tree doc accordingly.
    
    Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 4ba1c98b552c58b1a29bd943aef51b1788465b2d
Author: Mathieu Olivari <mathieu@codeaurora.org>
Date:   Fri Feb 20 18:19:35 2015 -0800

    ARM: qcom: add description of KPSS WDT for IPQ8064
    
    Add the watchdog related entries to the Krait Processor Sub-system
    (KPSS) timer IPQ8064 devicetree section. Also, add a fixed-clock
    description of SLEEP_CLK, which will do for now.
    
    Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
    Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
    Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 0dfd582e026af8a37917164aaba7227fa812e5c2
Author: Mathieu Olivari <mathieu@codeaurora.org>
Date:   Fri Feb 20 18:19:34 2015 -0800

    watchdog: qcom: use timer devicetree binding
    
    MSM watchdog configuration happens in the same register block as the
    timer, so we'll use the same binding as the existing timer.
    
    The qcom-wdt will now be probed when devicetree has an entry compatible
    with "qcom,kpss-timer" or "qcom-scss-timer".
    
    Signed-off-by: Mathieu Olivari <mathieu@codeaurora.org>
    Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit e1dbde29609a4f829589f0e48361470327ae3f62
Author: Joe Perches <joe@perches.com>
Date:   Sat Feb 21 18:53:48 2015 -0800

    watchdog: bcm281xx: Remove use of seq_printf return value
    
    The seq_printf return value, because it's frequently misused,
    will eventually be converted to void.
    
    See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
         seq_has_overflowed() and make public")
    
    Signed-off-by: Joe Perches <joe@perches.com>
    Acked-by: Guenter Roeck <linux~roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/arm/msm/timer.txt b/Documentation/devicetree/bindings/arm/msm/timer.txt
index 74607b6..5e10c34 100644
--- a/Documentation/devicetree/bindings/arm/msm/timer.txt
+++ b/Documentation/devicetree/bindings/arm/msm/timer.txt
@@ -9,11 +9,17 @@ Properties:
                "qcom,scss-timer" - scorpion subsystem
 
 - interrupts : Interrupts for the debug timer, the first general purpose
-               timer, and optionally a second general purpose timer in that
-               order.
+               timer, and optionally a second general purpose timer, and
+               optionally as well, 2 watchdog interrupts, in that order.
 
 - reg : Specifies the base address of the timer registers.
 
+- clocks: Reference to the parent clocks, one per output clock. The parents
+          must appear in the same order as the clock names.
+
+- clock-names: The name of the clocks as free-form strings. They should be in
+               the same order as the clocks.
+
 - clock-frequency : The frequency of the debug timer and the general purpose
                     timer(s) in Hz in that order.
 
@@ -29,9 +35,13 @@ Example:
                compatible = "qcom,scss-timer", "qcom,msm-timer";
                interrupts = <1 1 0x301>,
                             <1 2 0x301>,
-                            <1 3 0x301>;
+                            <1 3 0x301>,
+                            <1 4 0x301>,
+                            <1 5 0x301>;
                reg = <0x0200a000 0x100>;
                clock-frequency = <19200000>,
                                  <32768>;
+               clocks = <&sleep_clk>;
+               clock-names = "sleep";
                cpu-offset = <0x40000>;
        };
diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index cb225da..d01f618 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -60,6 +60,14 @@
 		};
 	};
 
+	clocks {
+		sleep_clk: sleep_clk {
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			#clock-cells = <0>;
+		};
+	};
+
 	soc: soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -89,10 +97,14 @@
 			compatible = "qcom,kpss-timer", "qcom,msm-timer";
 			interrupts = <1 1 0x301>,
 				     <1 2 0x301>,
-				     <1 3 0x301>;
+				     <1 3 0x301>,
+				     <1 4 0x301>,
+				     <1 5 0x301>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <25000000>,
 					  <32768>;
+			clocks = <&sleep_clk>;
+			clock-names = "sleep";
 			cpu-offset = <0x80000>;
 		};
 
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 16f2023..7acc71e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -169,7 +169,6 @@ config AT91SAM9X_WATCHDOG
 
 config CADENCE_WATCHDOG
 	tristate "Cadence Watchdog Timer"
-	depends on ARM
 	select WATCHDOG_CORE
 	help
 	  Say Y here if you want to include support for the watchdog
@@ -1190,6 +1189,7 @@ config OCTEON_WDT
 	tristate "Cavium OCTEON SOC family Watchdog Timer"
 	depends on CAVIUM_OCTEON_SOC
 	default y
+	select WATCHDOG_CORE
 	select EXPORT_UASM if OCTEON_WDT = m
 	help
 	  Hardware driver for OCTEON's on chip watchdog timer.
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 4e37db3..22d8ae6 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -99,12 +99,14 @@ static int secure_register_read(struct bcm_kona_wdt *wdt, uint32_t offset)
 
 static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 {
-	int ctl_val, cur_val, ret;
+	int ctl_val, cur_val;
 	unsigned long flags;
 	struct bcm_kona_wdt *wdt = s->private;
 
-	if (!wdt)
-		return seq_puts(s, "No device pointer\n");
+	if (!wdt) {
+		seq_puts(s, "No device pointer\n");
+		return 0;
+	}
 
 	spin_lock_irqsave(&wdt->lock, flags);
 	ctl_val = secure_register_read(wdt, SECWDOG_CTRL_REG);
@@ -112,7 +114,7 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 	spin_unlock_irqrestore(&wdt->lock, flags);
 
 	if (ctl_val < 0 || cur_val < 0) {
-		ret = seq_puts(s, "Error accessing hardware\n");
+		seq_puts(s, "Error accessing hardware\n");
 	} else {
 		int ctl, cur, ctl_sec, cur_sec, res;
 
@@ -121,15 +123,18 @@ static int bcm_kona_wdt_dbg_show(struct seq_file *s, void *data)
 		cur = cur_val & SECWDOG_COUNT_MASK;
 		ctl_sec = TICKS_TO_SECS(ctl, wdt);
 		cur_sec = TICKS_TO_SECS(cur, wdt);
-		ret = seq_printf(s, "Resolution: %d / %d\n"
-				"Control: %d s / %d (%#x) ticks\n"
-				"Current: %d s / %d (%#x) ticks\n"
-				"Busy count: %lu\n", res,
-				wdt->resolution, ctl_sec, ctl, ctl, cur_sec,
-				cur, cur, wdt->busy_count);
+		seq_printf(s,
+			   "Resolution: %d / %d\n"
+			   "Control: %d s / %d (%#x) ticks\n"
+			   "Current: %d s / %d (%#x) ticks\n"
+			   "Busy count: %lu\n",
+			   res, wdt->resolution,
+			   ctl_sec, ctl, ctl,
+			   cur_sec, cur, cur,
+			   wdt->busy_count);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int bcm_kona_dbg_open(struct inode *inode, struct file *file)
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 8453531..14521c8 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -3,6 +3,8 @@
  *
  * Copyright (C) 2007, 2008, 2009, 2010 Cavium Networks
  *
+ * Converted to use WATCHDOG_CORE by Aaro Koskinen <aaro.koskinen@iki.fi>.
+ *
  * Some parts derived from wdt.c
  *
  *	(c) Copyright 1996-1997 Alan Cox <alan@lxorguk.ukuu.org.uk>,
@@ -103,13 +105,10 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static unsigned long octeon_wdt_is_open;
-static char expect_close;
-
-static u32 __initdata nmi_stage1_insns[64];
+static u32 nmi_stage1_insns[64] __initdata;
 /* We need one branch and therefore one relocation per target label. */
-static struct uasm_label __initdata labels[5];
-static struct uasm_reloc __initdata relocs[5];
+static struct uasm_label labels[5] __initdata;
+static struct uasm_reloc relocs[5] __initdata;
 
 enum lable_id {
 	label_enter_bootloader = 1
@@ -218,7 +217,8 @@ static void __init octeon_wdt_build_stage1(void)
 	pr_debug("\t.set pop\n");
 
 	if (len > 32)
-		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n", len);
+		panic("NMI stage 1 handler exceeds 32 instructions, was %d\n",
+		      len);
 }
 
 static int cpu2core(int cpu)
@@ -294,6 +294,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 {
 	int d;
 	int v;
+
 	for (d = 0; d < digits; d++) {
 		v = (value >> ((digits - d - 1) * 4)) & 0xf;
 		if (v >= 10)
@@ -303,7 +304,7 @@ static void octeon_wdt_write_hex(u64 value, int digits)
 	}
 }
 
-const char *reg_name[] = {
+static const char reg_name[][3] = {
 	"$0", "at", "v0", "v1", "a0", "a1", "a2", "a3",
 	"a4", "a5", "a6", "a7", "t0", "t1", "t2", "t3",
 	"s0", "s1", "s2", "s3", "s4", "s5", "s6", "s7",
@@ -444,7 +445,7 @@ static int octeon_wdt_cpu_callback(struct notifier_block *nfb,
 	return NOTIFY_OK;
 }
 
-static void octeon_wdt_ping(void)
+static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
 {
 	int cpu;
 	int coreid;
@@ -457,10 +458,12 @@ static void octeon_wdt_ping(void)
 		    !cpumask_test_cpu(cpu, &irq_enabled_cpus)) {
 			/* We have to enable the irq */
 			int irq = OCTEON_IRQ_WDOG0 + coreid;
+
 			enable_irq(irq);
 			cpumask_set_cpu(cpu, &irq_enabled_cpus);
 		}
 	}
+	return 0;
 }
 
 static void octeon_wdt_calc_parameters(int t)
@@ -489,7 +492,8 @@ static void octeon_wdt_calc_parameters(int t)
 	timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * timeout_sec) >> 8;
 }
 
-static int octeon_wdt_set_heartbeat(int t)
+static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
+				  unsigned int t)
 {
 	int cpu;
 	int coreid;
@@ -509,158 +513,45 @@ static int octeon_wdt_set_heartbeat(int t)
 		cvmx_write_csr(CVMX_CIU_WDOGX(coreid), ciu_wdog.u64);
 		cvmx_write_csr(CVMX_CIU_PP_POKEX(coreid), 1);
 	}
-	octeon_wdt_ping(); /* Get the irqs back on. */
+	octeon_wdt_ping(wdog); /* Get the irqs back on. */
 	return 0;
 }
 
-/**
- *	octeon_wdt_write:
- *	@file: file handle to the watchdog
- *	@buf: buffer to write (unused as data does not matter here
- *	@count: count of bytes
- *	@ppos: pointer to the position to write. No seeks allowed
- *
- *	A write to a watchdog device is defined as a keepalive signal. Any
- *	write of data will do, as we we don't define content meaning.
- */
-
-static ssize_t octeon_wdt_write(struct file *file, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	if (count) {
-		if (!nowayout) {
-			size_t i;
-
-			/* In case it was set long ago */
-			expect_close = 0;
-
-			for (i = 0; i != count; i++) {
-				char c;
-				if (get_user(c, buf + i))
-					return -EFAULT;
-				if (c == 'V')
-					expect_close = 1;
-			}
-		}
-		octeon_wdt_ping();
-	}
-	return count;
-}
-
-/**
- *	octeon_wdt_ioctl:
- *	@file: file handle to the device
- *	@cmd: watchdog command
- *	@arg: argument pointer
- *
- *	The watchdog API defines a common set of functions for all
- *	watchdogs according to their available features. We only
- *	actually usefully support querying capabilities and setting
- *	the timeout.
- */
-
-static long octeon_wdt_ioctl(struct file *file, unsigned int cmd,
-			     unsigned long arg)
-{
-	void __user *argp = (void __user *)arg;
-	int __user *p = argp;
-	int new_heartbeat;
-
-	static struct watchdog_info ident = {
-		.options =		WDIOF_SETTIMEOUT|
-					WDIOF_MAGICCLOSE|
-					WDIOF_KEEPALIVEPING,
-		.firmware_version =	1,
-		.identity =		"OCTEON",
-	};
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		return copy_to_user(argp, &ident, sizeof(ident)) ? -EFAULT : 0;
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, p);
-	case WDIOC_KEEPALIVE:
-		octeon_wdt_ping();
-		return 0;
-	case WDIOC_SETTIMEOUT:
-		if (get_user(new_heartbeat, p))
-			return -EFAULT;
-		if (octeon_wdt_set_heartbeat(new_heartbeat))
-			return -EINVAL;
-		/* Fall through. */
-	case WDIOC_GETTIMEOUT:
-		return put_user(heartbeat, p);
-	default:
-		return -ENOTTY;
-	}
-}
-
-/**
- *	octeon_wdt_open:
- *	@inode: inode of device
- *	@file: file handle to device
- *
- *	The watchdog device has been opened. The watchdog device is single
- *	open and on opening we do a ping to reset the counters.
- */
-
-static int octeon_wdt_open(struct inode *inode, struct file *file)
+static int octeon_wdt_start(struct watchdog_device *wdog)
 {
-	if (test_and_set_bit(0, &octeon_wdt_is_open))
-		return -EBUSY;
-	/*
-	 *	Activate
-	 */
-	octeon_wdt_ping();
+	octeon_wdt_ping(wdog);
 	do_coundown = 1;
-	return nonseekable_open(inode, file);
+	return 0;
 }
 
-/**
- *	octeon_wdt_release:
- *	@inode: inode to board
- *	@file: file handle to board
- *
- *	The watchdog has a configurable API. There is a religious dispute
- *	between people who want their watchdog to be able to shut down and
- *	those who want to be sure if the watchdog manager dies the machine
- *	reboots. In the former case we disable the counters, in the latter
- *	case you have to open it again very soon.
- */
-
-static int octeon_wdt_release(struct inode *inode, struct file *file)
+static int octeon_wdt_stop(struct watchdog_device *wdog)
 {
-	if (expect_close) {
-		do_coundown = 0;
-		octeon_wdt_ping();
-	} else {
-		pr_crit("WDT device closed unexpectedly.  WDT will not stop!\n");
-	}
-	clear_bit(0, &octeon_wdt_is_open);
-	expect_close = 0;
+	do_coundown = 0;
+	octeon_wdt_ping(wdog);
 	return 0;
 }
 
-static const struct file_operations octeon_wdt_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= no_llseek,
-	.write		= octeon_wdt_write,
-	.unlocked_ioctl	= octeon_wdt_ioctl,
-	.open		= octeon_wdt_open,
-	.release	= octeon_wdt_release,
+static struct notifier_block octeon_wdt_cpu_notifier = {
+	.notifier_call = octeon_wdt_cpu_callback,
 };
 
-static struct miscdevice octeon_wdt_miscdev = {
-	.minor	= WATCHDOG_MINOR,
-	.name	= "watchdog",
-	.fops	= &octeon_wdt_fops,
+static const struct watchdog_info octeon_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "OCTEON",
 };
 
-static struct notifier_block octeon_wdt_cpu_notifier = {
-	.notifier_call = octeon_wdt_cpu_callback,
+static const struct watchdog_ops octeon_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= octeon_wdt_start,
+	.stop		= octeon_wdt_stop,
+	.ping		= octeon_wdt_ping,
+	.set_timeout	= octeon_wdt_set_timeout,
 };
 
+static struct watchdog_device octeon_wdt = {
+	.info	= &octeon_wdt_info,
+	.ops	= &octeon_wdt_ops,
+};
 
 /**
  * Module/ driver initialization.
@@ -685,7 +576,8 @@ static int __init octeon_wdt_init(void)
 	max_timeout_sec = 6;
 	do {
 		max_timeout_sec--;
-		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * max_timeout_sec) >> 8;
+		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) *
+			      max_timeout_sec) >> 8;
 	} while (timeout_cnt > 65535);
 
 	BUG_ON(timeout_cnt == 0);
@@ -694,11 +586,15 @@ static int __init octeon_wdt_init(void)
 
 	pr_info("Initial granularity %d Sec\n", timeout_sec);
 
-	ret = misc_register(&octeon_wdt_miscdev);
+	octeon_wdt.timeout	= timeout_sec;
+	octeon_wdt.max_timeout	= UINT_MAX;
+
+	watchdog_set_nowayout(&octeon_wdt, nowayout);
+
+	ret = watchdog_register_device(&octeon_wdt);
 	if (ret) {
-		pr_err("cannot register miscdev on minor=%d (err=%d)\n",
-		       WATCHDOG_MINOR, ret);
-		goto out;
+		pr_err("watchdog_register_device() failed: %d\n", ret);
+		return ret;
 	}
 
 	/* Build the NMI handler ... */
@@ -721,8 +617,7 @@ static int __init octeon_wdt_init(void)
 	__register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
 	cpu_notifier_register_done();
 
-out:
-	return ret;
+	return 0;
 }
 
 /**
@@ -732,7 +627,7 @@ static void __exit octeon_wdt_cleanup(void)
 {
 	int cpu;
 
-	misc_deregister(&octeon_wdt_miscdev);
+	watchdog_unregister_device(&octeon_wdt);
 
 	cpu_notifier_register_begin();
 	__unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 55e2201..b9c6049 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -216,7 +216,7 @@ static struct platform_driver platform_wdt_driver = {
 module_platform_driver(platform_wdt_driver);
 
 MODULE_AUTHOR("MontaVista Software, Inc. <source@mvista.com>");
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
 MODULE_DESCRIPTION("PNX4008 Watchdog Driver");
 
 module_param(heartbeat, uint, 0);
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index aa85618..aa03ca8 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -20,9 +20,9 @@
 #include <linux/reboot.h>
 #include <linux/watchdog.h>
 
-#define WDT_RST		0x0
-#define WDT_EN		0x8
-#define WDT_BITE_TIME	0x24
+#define WDT_RST		0x38
+#define WDT_EN		0x40
+#define WDT_BITE_TIME	0x5C
 
 struct qcom_wdt {
 	struct watchdog_device	wdd;
@@ -117,6 +117,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 {
 	struct qcom_wdt *wdt;
 	struct resource *res;
+	struct device_node *np = pdev->dev.of_node;
+	u32 percpu_offset;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -124,6 +126,14 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/* We use CPU0's DGT for the watchdog */
+	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
+		percpu_offset = 0;
+
+	res->start += percpu_offset;
+	res->end += percpu_offset;
+
 	wdt->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
@@ -203,9 +213,8 @@ static int qcom_wdt_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_wdt_of_table[] = {
-	{ .compatible = "qcom,kpss-wdt-msm8960", },
-	{ .compatible = "qcom,kpss-wdt-apq8064", },
-	{ .compatible = "qcom,kpss-wdt-ipq8064", },
+	{ .compatible = "qcom,kpss-timer" },
+	{ .compatible = "qcom,scss-timer" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, qcom_wdt_of_table);
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index a62b1b6..e7f0d5b 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -1,7 +1,7 @@
 /*
  * Watchdog driver for the RTC based watchdog in STMP3xxx and i.MX23/28
  *
- * Author: Wolfram Sang <w.sang@pengutronix.de>
+ * Author: Wolfram Sang <kernel@pengutronix.de>
  *
  * Copyright (C) 2011-12 Wolfram Sang, Pengutronix
  *
@@ -129,4 +129,4 @@ module_platform_driver(stmp3xxx_wdt_driver);
 
 MODULE_DESCRIPTION("STMP3XXX RTC Watchdog Driver");
 MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_AUTHOR("Wolfram Sang <kernel@pengutronix.de>");
