Return-Path: <linux@roeck-us.net>
Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/5] watchdog: it87: Drop support for resetting watchdog though CIR and Game port
Date: Sat, 10 Jun 2017 21:04:34 -0700
Message-Id: <1497153876-22921-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
References: <1497153876-22921-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Resetting the watchdog timer on CIR interrupts or on game port interrupts
is not not supported on recent chips, and doesn't really tell if the system
is stable. On top of that, at least the bit to enable resetting the
watchdog through the game port is used differently on recent chips.
Drop resetting the watchdog on CIR  or game port interrupts to simplify
the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig    |   3 -
 drivers/watchdog/it87_wdt.c | 226 ++++----------------------------------------
 2 files changed, 19 insertions(+), 210 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 20020a4bb71e..793146be38e0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1043,9 +1043,6 @@ config IT87_WDT
 	  IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726 and IT8728
 	  Super I/O chips.
 
-	  If the driver does not work, then make sure that the game port in
-	  the BIOS is enabled.
-
 	  This watchdog simply watches your kernel to make sure it doesn't
 	  freeze, and if it does, it reboots your computer after a certain
 	  amount of time.
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index 9a6523e70ffc..29aea28628c8 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -33,7 +33,6 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/ioport.h>
 #include <linux/watchdog.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
@@ -42,8 +41,6 @@
 #define WATCHDOG_NAME		"IT87 WDT"
 
 /* Defaults for Module Parameter */
-#define DEFAULT_NOGAMEPORT	0
-#define DEFAULT_NOCIR		0
 #define DEFAULT_TIMEOUT		60
 #define DEFAULT_TESTMODE	0
 #define DEFAULT_NOWAYOUT	WATCHDOG_NOWAYOUT
@@ -54,15 +51,11 @@
 
 /* Logical device Numbers LDN */
 #define GPIO		0x07
-#define GAMEPORT	0x09
-#define CIR		0x0a
 
 /* Configuration Registers and Functions */
 #define LDNREG		0x07
 #define CHIPID		0x20
 #define CHIPREV		0x22
-#define ACTREG		0x30
-#define BASEREG		0x60
 
 /* Chip Id numbers */
 #define NO_DEV_ID	0xffff
@@ -84,14 +77,6 @@
 #define WDTVALLSB	0x73
 #define WDTVALMSB	0x74
 
-/* GPIO Bits WDTCTRL */
-#define WDT_CIRINT	0x80
-#define WDT_MOUSEINT	0x40
-#define WDT_KYBINT	0x20
-#define WDT_GAMEPORT	0x10 /* not in it8718, it8720, it8721, it8728 */
-#define WDT_FORCE	0x02
-#define WDT_ZERO	0x01
-
 /* GPIO Bits WDTCFG */
 #define WDT_TOV1	0x80
 #define WDT_KRST	0x40
@@ -99,46 +84,12 @@
 #define WDT_PWROK	0x10 /* not in it8721 */
 #define WDT_INT_MASK	0x0f
 
-/* CIR Configuration Register LDN=0x0a */
-#define CIR_ILS		0x70
-
-/* The default Base address is not always available, we use this */
-#define CIR_BASE	0x0208
-
-/* CIR Controller */
-#define CIR_DR(b)	(b)
-#define CIR_IER(b)	(b + 1)
-#define CIR_RCR(b)	(b + 2)
-#define CIR_TCR1(b)	(b + 3)
-#define CIR_TCR2(b)	(b + 4)
-#define CIR_TSR(b)	(b + 5)
-#define CIR_RSR(b)	(b + 6)
-#define CIR_BDLR(b)	(b + 5)
-#define CIR_BDHR(b)	(b + 6)
-#define CIR_IIR(b)	(b + 7)
-
-/* Default Base address of Game port */
-#define GP_BASE_DEFAULT	0x0201
+static unsigned int max_units, chip_type;
 
-/* wdt_status */
-#define WDTS_USE_GP	0
-#define WDTS_USE_CIR	1
-
-static unsigned int base, gpact, ciract, max_units, chip_type;
-static unsigned long wdt_status;
-
-static int nogameport  = DEFAULT_NOGAMEPORT;
-static int nocir       = DEFAULT_NOCIR;
 static unsigned int timeout = DEFAULT_TIMEOUT;
-static int testmode    = DEFAULT_TESTMODE;
-static bool nowayout    = DEFAULT_NOWAYOUT;
-
-module_param(nogameport, int, 0);
-MODULE_PARM_DESC(nogameport, "Forbid the activation of game port, default="
-		__MODULE_STRING(DEFAULT_NOGAMEPORT));
-module_param(nocir, int, 0);
-MODULE_PARM_DESC(nocir, "Forbid the use of Consumer IR interrupts to reset timer, default="
-		__MODULE_STRING(DEFAULT_NOCIR));
+static int testmode = DEFAULT_TESTMODE;
+static bool nowayout = DEFAULT_NOWAYOUT;
+
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds, default="
 		__MODULE_STRING(DEFAULT_TIMEOUT));
@@ -210,29 +161,28 @@ static inline void superio_outw(int val, int reg)
 }
 
 /* Internal function, should be called after superio_select(GPIO) */
-static void _wdt_update_timeout(void)
+static void _wdt_update_timeout(unsigned int t)
 {
 	unsigned char cfg = WDT_KRST;
-	int tm = timeout;
 
 	if (testmode)
 		cfg = 0;
 
-	if (tm <= max_units)
+	if (t <= max_units)
 		cfg |= WDT_TOV1;
 	else
-		tm /= 60;
+		t /= 60;
 
 	if (chip_type != IT8721_ID)
 		cfg |= WDT_PWROK;
 
 	superio_outb(cfg, WDTCFG);
-	superio_outb(tm, WDTVALLSB);
+	superio_outb(t, WDTVALLSB);
 	if (max_units > 255)
-		superio_outb(tm>>8, WDTVALMSB);
+		superio_outb(t >> 8, WDTVALMSB);
 }
 
-static int wdt_update_timeout(void)
+static int wdt_update_timeout(unsigned int t)
 {
 	int ret;
 
@@ -241,7 +191,7 @@ static int wdt_update_timeout(void)
 		return ret;
 
 	superio_select(GPIO);
-	_wdt_update_timeout();
+	_wdt_update_timeout(t);
 	superio_exit();
 
 	return 0;
@@ -256,55 +206,14 @@ static int wdt_round_time(int t)
 
 /* watchdog timer handling */
 
-static int wdt_keepalive(struct watchdog_device *wdd)
-{
-	int ret = 0;
-
-	if (test_bit(WDTS_USE_GP, &wdt_status))
-		inb(base);
-	else if (test_bit(WDTS_USE_CIR, &wdt_status))
-		/* The timer reloads with around 5 msec delay */
-		outb(0x55, CIR_DR(base));
-	else
-		ret = wdt_update_timeout();
-
-	return ret;
-}
-
 static int wdt_start(struct watchdog_device *wdd)
 {
-	int ret = superio_enter();
-	if (ret)
-		return ret;
-
-	superio_select(GPIO);
-	if (test_bit(WDTS_USE_GP, &wdt_status))
-		superio_outb(WDT_GAMEPORT, WDTCTRL);
-	else if (test_bit(WDTS_USE_CIR, &wdt_status))
-		superio_outb(WDT_CIRINT, WDTCTRL);
-
-	_wdt_update_timeout();
-
-	superio_exit();
-
-	return 0;
+	return wdt_update_timeout(wdd->timeout);
 }
 
 static int wdt_stop(struct watchdog_device *wdd)
 {
-	int ret = superio_enter();
-	if (ret)
-		return ret;
-
-	superio_select(GPIO);
-	superio_outb(0x00, WDTCTRL);
-	superio_outb(WDT_TOV1, WDTCFG);
-	superio_outb(0x00, WDTVALLSB);
-	if (max_units > 255)
-		superio_outb(0x00, WDTVALMSB);
-
-	superio_exit();
-	return 0;
+	return wdt_update_timeout(0);
 }
 
 /**
@@ -327,7 +236,7 @@ static int wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 	wdd->timeout = t;
 
 	if (watchdog_hw_running(wdd))
-		ret = wdt_update_timeout();
+		ret = wdt_update_timeout(t);
 
 	return ret;
 }
@@ -342,7 +251,6 @@ static struct watchdog_ops wdt_ops = {
 	.owner = THIS_MODULE,
 	.start = wdt_start,
 	.stop = wdt_stop,
-	.ping = wdt_keepalive,
 	.set_timeout = wdt_set_timeout,
 };
 
@@ -366,12 +274,8 @@ static struct notifier_block wdt_notifier = {
 
 static int __init it87_wdt_init(void)
 {
-	int rc = 0;
-	int try_gameport = !nogameport;
 	u8  chip_rev;
-	int gp_rreq_fail = 0;
-
-	wdt_status = 0;
+	int rc;
 
 	rc = superio_enter();
 	if (rc)
@@ -399,7 +303,6 @@ static int __init it87_wdt_init(void)
 	case IT8728_ID:
 	case IT8783_ID:
 		max_units = 65535;
-		try_gameport = 0;
 		break;
 	case IT8705_ID:
 		pr_err("Unsupported Chip found, Chip %04x Revision %02x\n",
@@ -421,48 +324,7 @@ static int __init it87_wdt_init(void)
 	superio_select(GPIO);
 	superio_outb(WDT_TOV1, WDTCFG);
 	superio_outb(0x00, WDTCTRL);
-
-	/* First try to get Gameport support */
-	if (try_gameport) {
-		superio_select(GAMEPORT);
-		base = superio_inw(BASEREG);
-		if (!base) {
-			base = GP_BASE_DEFAULT;
-			superio_outw(base, BASEREG);
-		}
-		gpact = superio_inb(ACTREG);
-		superio_outb(0x01, ACTREG);
-		if (request_region(base, 1, WATCHDOG_NAME))
-			set_bit(WDTS_USE_GP, &wdt_status);
-		else
-			gp_rreq_fail = 1;
-	}
-
-	/* If we haven't Gameport support, try to get CIR support */
-	if (!nocir && !test_bit(WDTS_USE_GP, &wdt_status)) {
-		if (!request_region(CIR_BASE, 8, WATCHDOG_NAME)) {
-			if (gp_rreq_fail)
-				pr_err("I/O Address 0x%04x and 0x%04x already in use\n",
-				       base, CIR_BASE);
-			else
-				pr_err("I/O Address 0x%04x already in use\n",
-				       CIR_BASE);
-			rc = -EIO;
-			goto err_out;
-		}
-		base = CIR_BASE;
-
-		superio_select(CIR);
-		superio_outw(base, BASEREG);
-		superio_outb(0x00, CIR_ILS);
-		ciract = superio_inb(ACTREG);
-		superio_outb(0x01, ACTREG);
-		if (gp_rreq_fail) {
-			superio_select(GAMEPORT);
-			superio_outb(gpact, ACTREG);
-		}
-		set_bit(WDTS_USE_CIR, &wdt_status);
-	}
+	superio_exit();
 
 	if (timeout < 1 || timeout > max_units * 60) {
 		timeout = DEFAULT_TIMEOUT;
@@ -479,18 +341,7 @@ static int __init it87_wdt_init(void)
 	rc = register_reboot_notifier(&wdt_notifier);
 	if (rc) {
 		pr_err("Cannot register reboot notifier (err=%d)\n", rc);
-		goto err_out_region;
-	}
-
-	/* Initialize CIR to use it as keepalive source */
-	if (test_bit(WDTS_USE_CIR, &wdt_status)) {
-		outb(0x00, CIR_RCR(base));
-		outb(0xc0, CIR_TCR1(base));
-		outb(0x5c, CIR_TCR2(base));
-		outb(0x10, CIR_IER(base));
-		outb(0x00, CIR_BDHR(base));
-		outb(0x01, CIR_BDLR(base));
-		outb(0x09, CIR_IER(base));
+		return rc;
 	}
 
 	rc = watchdog_register_device(&wdt_dev);
@@ -499,59 +350,20 @@ static int __init it87_wdt_init(void)
 		goto err_out_reboot;
 	}
 
-	pr_info("Chip IT%04x revision %d initialized. timeout=%d sec (nowayout=%d testmode=%d nogameport=%d nocir=%d)\n",
-		chip_type, chip_rev, timeout,
-		nowayout, testmode, nogameport, nocir);
+	pr_info("Chip IT%04x revision %d initialized. timeout=%d sec (nowayout=%d testmode=%d)\n",
+		chip_type, chip_rev, timeout, nowayout, testmode);
 
-	superio_exit();
 	return 0;
 
 err_out_reboot:
 	unregister_reboot_notifier(&wdt_notifier);
-err_out_region:
-	if (test_bit(WDTS_USE_GP, &wdt_status))
-		release_region(base, 1);
-	else if (test_bit(WDTS_USE_CIR, &wdt_status)) {
-		release_region(base, 8);
-		superio_select(CIR);
-		superio_outb(ciract, ACTREG);
-	}
-err_out:
-	if (try_gameport) {
-		superio_select(GAMEPORT);
-		superio_outb(gpact, ACTREG);
-	}
-
-	superio_exit();
 	return rc;
 }
 
 static void __exit it87_wdt_exit(void)
 {
-	if (superio_enter() == 0) {
-		superio_select(GPIO);
-		superio_outb(0x00, WDTCTRL);
-		superio_outb(0x00, WDTCFG);
-		superio_outb(0x00, WDTVALLSB);
-		if (max_units > 255)
-			superio_outb(0x00, WDTVALMSB);
-		if (test_bit(WDTS_USE_GP, &wdt_status)) {
-			superio_select(GAMEPORT);
-			superio_outb(gpact, ACTREG);
-		} else if (test_bit(WDTS_USE_CIR, &wdt_status)) {
-			superio_select(CIR);
-			superio_outb(ciract, ACTREG);
-		}
-		superio_exit();
-	}
-
 	watchdog_unregister_device(&wdt_dev);
 	unregister_reboot_notifier(&wdt_notifier);
-
-	if (test_bit(WDTS_USE_GP, &wdt_status))
-		release_region(base, 1);
-	else if (test_bit(WDTS_USE_CIR, &wdt_status))
-		release_region(base, 8);
 }
 
 module_init(it87_wdt_init);
-- 
2.7.4
