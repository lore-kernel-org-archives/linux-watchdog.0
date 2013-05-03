Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm12.access.bullet.mail.sp2.yahoo.com ([98.139.44.139]:42608
	"EHLO nm12.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933219Ab3ECP5C (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 May 2013 11:57:02 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Dirk Eibach <dirk.eibach@gdsys.cc>
Subject: [RFC PATCH 2/2] watchdog: booke: Add device tree support
Date: Fri,  3 May 2013 08:56:46 -0700
Message-Id: <1367596606-22476-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1367596606-22476-1-git-send-email-linux@roeck-us.net>
References: <1367596606-22476-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Enable timeout initialization from device tree data.

Cc: Dirk Eibach <dirk.eibach@gdsys.cc>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested only. Need to determine final "compatible" strings
documentation of properties.

 drivers/watchdog/booke_wdt.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 9b066b9..d433675 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/watchdog.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 
 #include <asm/reg_booke.h>
 #include <asm/time.h>
@@ -238,8 +239,10 @@ static int booke_wdt_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "powerpc book-e watchdog driver loaded\n");
 
 	booke_wdt_info.firmware_version = cur_cpu_spec->pvr_value;
-	booke_wdt_set_timeout(&booke_wdt_dev,
-			      period_to_sec(CONFIG_BOOKE_WDT_DEFAULT_TIMEOUT));
+	watchdog_init_timeout(&booke_wdt_dev,
+			      period_to_sec(CONFIG_BOOKE_WDT_DEFAULT_TIMEOUT),
+			      &pdev->dev);
+	booke_wdt_set_timeout(&booke_wdt_dev, booke_wdt_dev.timeout);
 	watchdog_set_nowayout(&booke_wdt_dev, nowayout);
 	if (booke_wdt_enabled)
 		__booke_wdt_start(&booke_wdt_dev);
@@ -249,6 +252,13 @@ static int booke_wdt_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static const struct of_device_id booke_wdt_of_match[] = {
+	{ .compatible = "booke_wdt", },
+	{ .compatible = "fsl,booke-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, booke_wdt_of_match);
+
 static struct platform_driver booke_wdt_driver = {
 	.probe = booke_wdt_probe,
 	.remove = booke_wdt_remove,
@@ -256,6 +266,7 @@ static struct platform_driver booke_wdt_driver = {
 	.driver = {
 		.owner  = THIS_MODULE,
 		.name = "booke_wdt",
+		.of_match_table = booke_wdt_of_match,
 	},
 };
 
-- 
1.7.9.7

