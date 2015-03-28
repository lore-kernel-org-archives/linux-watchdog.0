Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:57795 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198AbbC1SGE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 28 Mar 2015 14:06:04 -0400
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Wim Van Sebroeck <wim@iguana.be>,
	David Daney <david.daney@cavium.com>,
	linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org, Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/3] watchdog: octeon: convert to WATCHDOG_CORE API
Date: Sat, 28 Mar 2015 20:05:38 +0200
Message-Id: <1427565940-22951-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Convert OCTEON watchdog to WATCHDOG_CORE API. This enables support
for multiple watchdogs on OCTEON boards.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/watchdog/Kconfig           |   1 +
 drivers/watchdog/octeon-wdt-main.c | 185 ++++++++-----------------------------
 2 files changed, 39 insertions(+), 147 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 16f2023..0fcd60b 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1190,6 +1190,7 @@ config OCTEON_WDT
 	tristate "Cavium OCTEON SOC family Watchdog Timer"
 	depends on CAVIUM_OCTEON_SOC
 	default y
+	select WATCHDOG_CORE
 	select EXPORT_UASM if OCTEON_WDT = m
 	help
 	  Hardware driver for OCTEON's on chip watchdog timer.
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 8453531..9aa5121 100644
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
@@ -103,9 +105,6 @@ MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
 				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static unsigned long octeon_wdt_is_open;
-static char expect_close;
-
 static u32 __initdata nmi_stage1_insns[64];
 /* We need one branch and therefore one relocation per target label. */
 static struct uasm_label __initdata labels[5];
@@ -444,7 +443,7 @@ static int octeon_wdt_cpu_callback(struct notifier_block *nfb,
 	return NOTIFY_OK;
 }
 
-static void octeon_wdt_ping(void)
+static int octeon_wdt_ping(struct watchdog_device __always_unused *wdog)
 {
 	int cpu;
 	int coreid;
@@ -461,6 +460,7 @@ static void octeon_wdt_ping(void)
 			cpumask_set_cpu(cpu, &irq_enabled_cpus);
 		}
 	}
+	return 0;
 }
 
 static void octeon_wdt_calc_parameters(int t)
@@ -489,7 +489,8 @@ static void octeon_wdt_calc_parameters(int t)
 	timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * timeout_sec) >> 8;
 }
 
-static int octeon_wdt_set_heartbeat(int t)
+static int octeon_wdt_set_timeout(struct watchdog_device *wdog,
+				  unsigned int t)
 {
 	int cpu;
 	int coreid;
@@ -509,158 +510,45 @@ static int octeon_wdt_set_heartbeat(int t)
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
@@ -694,11 +582,15 @@ static int __init octeon_wdt_init(void)
 
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
@@ -721,8 +613,7 @@ static int __init octeon_wdt_init(void)
 	__register_hotcpu_notifier(&octeon_wdt_cpu_notifier);
 	cpu_notifier_register_done();
 
-out:
-	return ret;
+	return 0;
 }
 
 /**
@@ -732,7 +623,7 @@ static void __exit octeon_wdt_cleanup(void)
 {
 	int cpu;
 
-	misc_deregister(&octeon_wdt_miscdev);
+	watchdog_unregister_device(&octeon_wdt);
 
 	cpu_notifier_register_begin();
 	__unregister_hotcpu_notifier(&octeon_wdt_cpu_notifier);
-- 
2.2.0

