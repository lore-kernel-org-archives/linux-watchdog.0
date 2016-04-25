Return-path: <knpo@ieee.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>,
 Linux Watchdog <linux-watchdog@vger.kernel.org>
From: Knud Poulsen <knpo@ieee.org>
Subject: [PATCH v3] watchdog: f71808e_wdt: Add F81865 support
Message-ID: <571DF163.4090907@ieee.org>
Date: Mon, 25 Apr 2016 12:28:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Adds watchdog enable support for Fintek F81865 Super-IO chip to
Fintek wdt driver (f71808e_wdt)

Tested and verified on Lanner LEC-3030 Industrial PC

Datasheet references:
http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html

Signed-off-by: Knud Poulsen <knpo@ieee.org>
---
 drivers/watchdog/f71808e_wdt.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 016bd93..f650e89 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -59,6 +59,7 @@
 #define SIO_F71869A_ID		0x1007	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
+#define SIO_F81865_ID		0x0704	/* Chipset ID */

 #define F71808FG_REG_WDO_CONF		0xf0
 #define F71808FG_REG_WDT_CONF		0xf5
@@ -71,6 +72,9 @@
 #define F71808FG_FLAG_WD_PULSE		4
 #define F71808FG_FLAG_WD_UNIT		3

+#define F81865_REG_WDO_CONF		0xfa
+#define F81865_FLAG_WDOUT_EN		0
+
 /* Default values */
 #define WATCHDOG_TIMEOUT	60	/* 1 minute default timeout */
 #define WATCHDOG_MAX_TIMEOUT	(60 * 255)
@@ -112,7 +116,7 @@ module_param(start_withtimeout, uint, 0);
 MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
 	" given initial timeout. Zero (default) disables this feature.");

-enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg };
+enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865 };

 static const char *f71808e_names[] = {
 	"f71808fg",
@@ -121,6 +125,7 @@ static const char *f71808e_names[] = {
 	"f71869",
 	"f71882fg",
 	"f71889fg",
+	"f81865",
 };

 /* Super-I/O Function prototypes */
@@ -360,6 +365,11 @@ static int watchdog_start(void)
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
@@ -371,8 +381,13 @@ static int watchdog_start(void)

 	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
 	superio_set_bit(watchdog.sioaddr, SIO_REG_ENABLE, 0);
-	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
-			F71808FG_FLAG_WDOUT_EN);
+
+	if (watchdog.type == f81865)
+		superio_set_bit(watchdog.sioaddr, F81865_REG_WDO_CONF,
+				F81865_FLAG_WDOUT_EN);
+	else
+		superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
+				F71808FG_FLAG_WDOUT_EN);

 	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDT_CONF,
 			F71808FG_FLAG_WD_EN);
@@ -770,6 +785,9 @@ static int __init f71808e_find(int sioaddr)
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
