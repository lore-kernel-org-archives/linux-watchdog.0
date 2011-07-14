Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43379 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab1GNKxM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2011 06:53:12 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 2/3] watchdog: iTCO: remove empty pm-functions
Date: Thu, 14 Jul 2011 12:53:02 +0200
Message-Id: <1310640783-16543-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
References: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/iTCO_wdt.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 1190bf1..751a591 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -923,15 +923,10 @@ static void iTCO_wdt_shutdown(struct platform_device *dev)
 	iTCO_wdt_stop();
 }
 
-#define iTCO_wdt_suspend NULL
-#define iTCO_wdt_resume  NULL
-
 static struct platform_driver iTCO_wdt_driver = {
 	.probe          = iTCO_wdt_probe,
 	.remove         = __devexit_p(iTCO_wdt_remove),
 	.shutdown       = iTCO_wdt_shutdown,
-	.suspend        = iTCO_wdt_suspend,
-	.resume         = iTCO_wdt_resume,
 	.driver         = {
 		.owner  = THIS_MODULE,
 		.name   = DRV_NAME,
-- 
1.7.5.4

