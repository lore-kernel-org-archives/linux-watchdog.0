Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40608 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753262AbbCLMIN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 12 Mar 2015 08:08:13 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v5 03/10] watchdog: at91rm9200: use the system timer syscon
Date: Thu, 12 Mar 2015 13:07:27 +0100
Message-Id: <1426162054-9987-4-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1426162054-9987-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use a syscon regmap to access the system timer registers.

Also, rename the driver atmel_st_watchdog to stop conflicting with
at91sam9_wdt.c

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/watchdog/Kconfig          |  2 +-
 drivers/watchdog/at91rm9200_wdt.c | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 16f202350997..ce4f3a7f95fd 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -154,7 +154,7 @@ config ARM_SP805_WATCHDOG
 
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
-	depends on SOC_AT91RM9200
+	depends on SOC_AT91RM9200 && MFD_SYSCON
 	help
 	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
 	  system when the timeout is reached.
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index d244112d5b6f..e6fa87d85de3 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -17,22 +17,25 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/atmel-st.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <mach/at91_st.h>
 
 #define WDT_DEFAULT_TIME	5	/* seconds */
 #define WDT_MAX_TIME		256	/* seconds */
 
 static int wdt_time = WDT_DEFAULT_TIME;
 static bool nowayout = WATCHDOG_NOWAYOUT;
+static struct regmap *regmap_st;
 
 module_param(wdt_time, int, 0);
 MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default="
@@ -55,7 +58,7 @@ static unsigned long at91wdt_busy;
  */
 static inline void at91_wdt_stop(void)
 {
-	at91_st_write(AT91_ST_WDMR, AT91_ST_EXTEN);
+	regmap_write(regmap_st, AT91_ST_WDMR, AT91_ST_EXTEN);
 }
 
 /*
@@ -63,9 +66,9 @@ static inline void at91_wdt_stop(void)
  */
 static inline void at91_wdt_start(void)
 {
-	at91_st_write(AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN |
+	regmap_write(regmap_st, AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN |
 				(((65536 * wdt_time) >> 8) & AT91_ST_WDV));
-	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
+	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
 }
 
 /*
@@ -73,7 +76,7 @@ static inline void at91_wdt_start(void)
  */
 static inline void at91_wdt_reload(void)
 {
-	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
+	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
 }
 
 /* ......................................................................... */
@@ -203,12 +206,24 @@ static struct miscdevice at91wdt_miscdev = {
 
 static int at91wdt_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct device *parent;
 	int res;
 
 	if (at91wdt_miscdev.parent)
 		return -EBUSY;
 	at91wdt_miscdev.parent = &pdev->dev;
 
+	parent = dev->parent;
+	if (!parent) {
+		dev_err(dev, "no parent\n");
+		return -ENODEV;
+	}
+
+	regmap_st = syscon_node_to_regmap(parent->of_node);
+	if (!regmap_st)
+		return -ENODEV;
+
 	res = misc_register(&at91wdt_miscdev);
 	if (res)
 		return res;
@@ -267,7 +282,7 @@ static struct platform_driver at91wdt_driver = {
 	.suspend	= at91wdt_suspend,
 	.resume		= at91wdt_resume,
 	.driver		= {
-		.name	= "at91_wdt",
+		.name	= "atmel_st_watchdog",
 		.of_match_table = at91_wdt_dt_ids,
 	},
 };
@@ -296,4 +311,4 @@ module_exit(at91_wdt_exit);
 MODULE_AUTHOR("Andrew Victor");
 MODULE_DESCRIPTION("Watchdog driver for Atmel AT91RM9200");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:at91_wdt");
+MODULE_ALIAS("platform:atmel_st_watchdog");
-- 
2.1.0

