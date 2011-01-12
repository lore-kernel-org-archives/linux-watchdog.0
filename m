Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41670 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756390Ab1ALAGT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Jan 2011 19:06:19 -0500
Date: Wed, 12 Jan 2011 01:06:12 +0100
From: Lutz Ballaschke <vegan.grindcore@googlemail.com>
To: me@mortis.eu
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv4] watchdog: f71808e_wdt: add support for the F71862FG
Message-ID: <20110112000612.GA9517@kreios.titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Lutz Ballaschke <vegan.grindcore@googlemail.com>
---

 drivers/watchdog/Kconfig       |    4 +-
 drivers/watchdog/f71808e_wdt.c |   53 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a5ad77e..b259ff8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -409,11 +409,11 @@ config ALIM7101_WDT
 	  Most people will say N.
 
 config F71808E_WDT
-	tristate "Fintek F71808E, F71882FG and F71889FG Watchdog"
+	tristate "Fintek F71808E, F71862FG, F71882FG and F71889FG Watchdog"
 	depends on X86 && EXPERIMENTAL
 	help
 	  This is the driver for the hardware watchdog on the Fintek
-	  F71808E, F71882FG and F71889FG Super I/O controllers.
+	  F71808E, F71862FG, F71882FG and F71889FG Super I/O controllers.
 
 	  You can compile this driver directly into the kernel, or use
 	  it as a module.  The module will be called f71808e_wdt.
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 65e5796..afec8d8 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -42,6 +42,11 @@
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
 #define SIO_REG_DEVREV		0x22	/* Device revision */
 #define SIO_REG_MANID		0x23	/* Fintek ID (2 bytes) */
+#define SIO_REG_ROM_ADDR_SEL	0x27	/* ROM address select */
+#define SIO_REG_MFUNCT1		0x29	/* Multi function select 1 */
+#define SIO_REG_MFUNCT2		0x2a	/* Multi function select 2 */
+#define SIO_REG_MFUNCT3		0x2b	/* Multi function select 3 */
+#define SIO_REG_MFUNCT4		0x2c	/* Multi function select 4 */
 #define SIO_REG_ENABLE		0x30	/* Logical device enable */
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
@@ -70,6 +75,8 @@
 #define WATCHDOG_MAX_TIMEOUT	(60 * 255)
 #define WATCHDOG_PULSE_WIDTH	125	/* 125 ms, default pulse width for
 					   watchdog signal */
+#define WATCHDOG_F71862FG_PIN	63	/* default watchdog reset output
+					   pin number 63 */
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -89,6 +96,12 @@ MODULE_PARM_DESC(pulse_width,
 	"Watchdog signal pulse width. 0(=level), 1 ms, 25 ms, 125 ms or 5000 ms"
 			" (default=" __MODULE_STRING(WATCHDOG_PULSE_WIDTH) ")");
 
+static unsigned int f71862fg_pin = WATCHDOG_F71862FG_PIN;
+module_param(f71862fg_pin, uint, 0);
+MODULE_PARM_DESC(f71862fg_pin,
+	"Watchdog f71862fg reset output pin configuration. Choose pin 56 or 63"
+			" (default=" __MODULE_STRING(WATCHDOG_F71862FG_PIN)")");
+
 static int nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0444);
 MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
@@ -282,6 +295,34 @@ exit_unlock:
 	return err;
 }
 
+/*
+ *      f71862fg_pin_configure:
+ *      @ioaddr: system I/O-port address to access superio
+ *
+ *      The F71862FG chip provides two different pins which can be used
+ *      as watchdog reset output. Pin dependent configuration is done here.
+ *      NOTE: When ioaddr is non-zero the calling function has to take care of
+ *      mutex handling and superio preparation!
+ */
+static int f71862fg_pin_configure(unsigned short ioaddr)
+{
+	if (f71862fg_pin == 63) {
+		if (ioaddr) {
+			/* SPI must be disabled first to use this pin! */
+			superio_clear_bit(ioaddr, SIO_REG_ROM_ADDR_SEL, 6);
+			superio_set_bit(ioaddr, SIO_REG_MFUNCT3, 4);
+		}
+	} else if (f71862fg_pin == 56) {
+		if (ioaddr)
+			superio_set_bit(ioaddr, SIO_REG_MFUNCT1, 1);
+	} else {
+		printk(KERN_ERR DRVNAME ": Invalid argument f71862fg_pin=%d\n",
+				f71862fg_pin);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int watchdog_start(void)
 {
 	/* Make sure we don't die as soon as the watchdog is enabled below */
@@ -303,6 +344,12 @@ static int watchdog_start(void)
 		superio_clear_bit(watchdog.sioaddr, 0x2b, 3);
 		break;
 
+	case f71862fg:
+		err = f71862fg_pin_configure(watchdog.sioaddr);
+		if (err)
+			goto exit_superio;
+		break;
+
 	case f71882fg:
 		/* Set pin 56 to WDTRST# */
 		superio_set_bit(watchdog.sioaddr, 0x29, 1);
@@ -718,9 +765,9 @@ static int __init f71808e_find(int sioaddr)
 		watchdog.type = f71889fg;
 		break;
 	case SIO_F71862_ID:
-		/* These have a watchdog, though it isn't implemented (yet). */
-		err = -ENOSYS;
-		goto exit;
+		watchdog.type = f71862fg;
+		err = f71862fg_pin_configure(0); /* validate module parameter */
+		break;
 	case SIO_F71858_ID:
 		/* Confirmed (by datasheet) not to have a watchdog. */
 		err = -ENODEV;
