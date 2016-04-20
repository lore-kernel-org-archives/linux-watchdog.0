Return-path: <knpo@ieee.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 Linux Watchdog <linux-watchdog@vger.kernel.org>
From: Knud Poulsen <knpo@ieee.org>
Subject: [PATCH] watchdog: f71808e_wdt: Add F81865 support
Message-ID: <5717C2D7.8030902@ieee.org>
Date: Wed, 20 Apr 2016 19:56:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Adds watchdog support for Fintek F81865 Super-IO chip to
Fintek wdt driver (f71808e_wdt)

Tested and verified on Lanner LEC-3030 Industrial PC

Datasheet references:
http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html

Signed-off-by: Knud Poulsen <knpo@ieee.org>
---
 drivers/watchdog/f71808e_wdt.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 016bd93..956f8eb 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -2,6 +2,7 @@
  *   Copyright (C) 2006 by Hans Edgington <hans@edgington.nl>              *
  *   Copyright (C) 2007-2009 Hans de Goede <hdegoede@redhat.com>           *
  *   Copyright (C) 2010 Giel van Schijndel <me@mortis.eu>                  *
+ *   Copyright (C) 2016 Knud Poulsen <knpo@ieee.org>                       *
  *                                                                         *
  *   This program is free software; you can redistribute it and/or modify  *
  *   it under the terms of the GNU General Public License as published by  *
@@ -38,7 +39,7 @@

 #define SIO_F71808FG_LD_WDT	0x07	/* Watchdog timer logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
-#define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
+#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */

 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
@@ -59,6 +60,7 @@
 #define SIO_F71869A_ID		0x1007	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
+#define SIO_F81865_ID		0x0704	/* Chipset ID */

 #define F71808FG_REG_WDO_CONF		0xf0
 #define F71808FG_REG_WDT_CONF		0xf5
@@ -71,6 +73,10 @@
 #define F71808FG_FLAG_WD_PULSE		4
 #define F71808FG_FLAG_WD_UNIT		3

+#define F81865_REG_WDO_CONF		0xfa
+#define F81865_FLAG_WDOUT_EN		0
+#define F81865_FLAG_WDTMOUT_STS		6
+
 /* Default values */
 #define WATCHDOG_TIMEOUT	60	/* 1 minute default timeout */
 #define WATCHDOG_MAX_TIMEOUT	(60 * 255)
@@ -112,7 +118,7 @@ module_param(start_withtimeout, uint, 0);
 MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
 	" given initial timeout. Zero (default) disables this feature.");

-enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg };
+enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865 };

 static const char *f71808e_names[] = {
 	"f71808fg",
@@ -121,6 +127,7 @@ static const char *f71808e_names[] = {
 	"f71869",
 	"f71882fg",
 	"f71889fg",
+	"f81865",
 };

 /* Super-I/O Function prototypes */
@@ -360,6 +367,11 @@ static int watchdog_start(void)
 			superio_inb(watchdog.sioaddr, SIO_REG_MFUNCT3) & 0xcf);
 		break;

+	case f81865:
+		/* Set pin 70 to WDTRST# */
+		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT3, 5);
+		break;
+
 	default:
 		/*
 		 * 'default' label to shut up the compiler and catch
@@ -371,9 +383,13 @@ static int watchdog_start(void)

 	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
 	superio_set_bit(watchdog.sioaddr, SIO_REG_ENABLE, 0);
-	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
-			F71808FG_FLAG_WDOUT_EN);
-
+	if (watchdog.type == f81865) {
+		superio_set_bit(watchdog.sioaddr, F81865_REG_WDO_CONF,
+				F81865_FLAG_WDOUT_EN);
+	} else {
+		superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
+				F71808FG_FLAG_WDOUT_EN);
+	}
 	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDT_CONF,
 			F71808FG_FLAG_WD_EN);

@@ -655,7 +671,12 @@ static int __init watchdog_init(int sioaddr)
 	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);

 	wdt_conf = superio_inb(sioaddr, F71808FG_REG_WDT_CONF);
-	watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
+	if (watchdog.type == f81865) {
+		watchdog.caused_reboot = wdt_conf & F81865_FLAG_WDTMOUT_STS;
+	} else {
+		watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
+	}
+

 	superio_exit(sioaddr);

@@ -770,6 +791,9 @@ static int __init f71808e_find(int sioaddr)
 		/* Confirmed (by datasheet) not to have a watchdog. */
 		err = -ENODEV;
 		goto exit;
+	case SIO_F81865_ID:
+		watchdog.type = f81865;
+		break;
 	default:
 		pr_info("Unrecognized Fintek device: %04x\n",
 			(unsigned int)devid);
-- 
2.5.5
