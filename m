Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:54930 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab2HNNne (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Aug 2012 09:43:34 -0400
From: Gabor Juhos <juhosg@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH] watchdog: ath79_wdt: convert to use module_platform_driver
Date: Tue, 14 Aug 2012 15:35:19 +0200
Message-Id: <1344951319-13821-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This makes the code a bit smaller by getting rid of
some boilerplate code.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/watchdog/ath79_wdt.c |   13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 1f9371f..79cc407 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -284,6 +284,7 @@ static void ath97_wdt_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver ath79_wdt_driver = {
+	.probe		= ath79_wdt_probe,
 	.remove		= __devexit_p(ath79_wdt_remove),
 	.shutdown	= ath97_wdt_shutdown,
 	.driver		= {
@@ -292,17 +293,7 @@ static struct platform_driver ath79_wdt_driver = {
 	},
 };
 
-static int __init ath79_wdt_init(void)
-{
-	return platform_driver_probe(&ath79_wdt_driver, ath79_wdt_probe);
-}
-module_init(ath79_wdt_init);
-
-static void __exit ath79_wdt_exit(void)
-{
-	platform_driver_unregister(&ath79_wdt_driver);
-}
-module_exit(ath79_wdt_exit);
+module_platform_driver(ath79_wdt_driver);
 
 MODULE_DESCRIPTION("Atheros AR71XX/AR724X/AR913X hardware watchdog driver");
 MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org");
-- 
1.7.10

