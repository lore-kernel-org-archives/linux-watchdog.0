Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbdBXPVN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 10:21:13 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/8] watchdog: s3c2410: Remove confusing CONFIG prefix from local defines
Date: Fri, 24 Feb 2017 17:11:15 +0200
Message-Id: <20170224151122.12142-2-krzk@kernel.org>
In-Reply-To: <20170224151122.12142-1-krzk@kernel.org>
References: <20170224151122.12142-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The CONFIG prefix from defines in the s3c2410_wdt.c might suggest that
these constants come from Kconfig.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/s3c2410_wdt.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 59e95762a6de..3e216f54cb6f 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -64,8 +64,8 @@
 #define S3C2410_WTCON_PRESCALE_MASK	(0xff << 8)
 #define S3C2410_WTCON_PRESCALE_MAX	0xff
 
-#define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
-#define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
+#define S3C2410_WATCHDOG_ATBOOT		(0)
+#define S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
 #define EXYNOS5_RST_STAT_REG_OFFSET		0x0404
 #define EXYNOS5_WDT_DISABLE_REG_OFFSET		0x0408
@@ -79,7 +79,7 @@
 
 static bool nowayout	= WATCHDOG_NOWAYOUT;
 static int tmr_margin;
-static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
+static int tmr_atboot	= S3C2410_WATCHDOG_ATBOOT;
 static int soft_noboot;
 static int debug;
 
@@ -90,10 +90,10 @@ module_param(soft_noboot, int, 0);
 module_param(debug,	  int, 0);
 
 MODULE_PARM_DESC(tmr_margin, "Watchdog tmr_margin in seconds. (default="
-		__MODULE_STRING(CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME) ")");
+		__MODULE_STRING(S3C2410_WATCHDOG_DEFAULT_TIME) ")");
 MODULE_PARM_DESC(tmr_atboot,
 		"Watchdog is started at boot time if set to 1, default="
-			__MODULE_STRING(CONFIG_S3C2410_WATCHDOG_ATBOOT));
+			__MODULE_STRING(S3C2410_WATCHDOG_ATBOOT));
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 MODULE_PARM_DESC(soft_noboot, "Watchdog action, set to 1 to ignore reboots, "
@@ -406,7 +406,7 @@ static struct watchdog_ops s3c2410wdt_ops = {
 static struct watchdog_device s3c2410_wdd = {
 	.info = &s3c2410_wdt_ident,
 	.ops = &s3c2410wdt_ops,
-	.timeout = CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME,
+	.timeout = S3C2410_WATCHDOG_DEFAULT_TIME,
 };
 
 /* interrupt handler code */
@@ -600,12 +600,12 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 					wdt->wdt_device.timeout);
 	if (ret) {
 		started = s3c2410wdt_set_heartbeat(&wdt->wdt_device,
-					CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME);
+					S3C2410_WATCHDOG_DEFAULT_TIME);
 
 		if (started == 0)
 			dev_info(dev,
 			   "tmr_margin value out of range, default %d used\n",
-			       CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME);
+			       S3C2410_WATCHDOG_DEFAULT_TIME);
 		else
 			dev_info(dev, "default timer value is out of range, "
 							"cannot start\n");
-- 
2.9.3

