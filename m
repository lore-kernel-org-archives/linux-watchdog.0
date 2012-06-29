Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from zmc.proxad.net ([212.27.53.206]:32990 "EHLO zmc.proxad.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332Ab2F2J0N (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 29 Jun 2012 05:26:13 -0400
From: Florian Fainelli <florian@openwrt.org>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	Florian Fainelli <florian@openwrt.org>
Subject: [PATCH] watchdog: bcm63xx_wdt: fix driver section mismatch
Date: Fri, 29 Jun 2012 11:14:44 +0200
Message-Id: <1340961284-25887-1-git-send-email-florian@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

bcm63xx_wdt was used as a platform_driver but was not suffixed with
_driver, thus causing section mismatches, fix that.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 drivers/watchdog/bcm63xx_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 8379dc3..551880b 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -302,7 +302,7 @@ static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
 	bcm63xx_wdt_pause();
 }
 
-static struct platform_driver bcm63xx_wdt = {
+static struct platform_driver bcm63xx_wdt_driver = {
 	.probe	= bcm63xx_wdt_probe,
 	.remove = __devexit_p(bcm63xx_wdt_remove),
 	.shutdown = bcm63xx_wdt_shutdown,
@@ -312,7 +312,7 @@ static struct platform_driver bcm63xx_wdt = {
 	}
 };
 
-module_platform_driver(bcm63xx_wdt);
+module_platform_driver(bcm63xx_wdt_driver);
 
 MODULE_AUTHOR("Miguel Gaio <miguel.gaio@efixo.com>");
 MODULE_AUTHOR("Florian Fainelli <florian@openwrt.org>");
-- 
1.7.9.5

