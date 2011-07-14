Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43381 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373Ab1GNKxN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2011 06:53:13 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 3/3] watchdog: sch311x: remove empty pm-functions
Date: Thu, 14 Jul 2011 12:53:03 +0200
Message-Id: <1310640783-16543-4-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
References: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/sch311x_wdt.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index c7cf4b0..029467e 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -472,15 +472,10 @@ static void sch311x_wdt_shutdown(struct platform_device *dev)
 	sch311x_wdt_stop();
 }
 
-#define sch311x_wdt_suspend NULL
-#define sch311x_wdt_resume  NULL
-
 static struct platform_driver sch311x_wdt_driver = {
 	.probe		= sch311x_wdt_probe,
 	.remove		= __devexit_p(sch311x_wdt_remove),
 	.shutdown	= sch311x_wdt_shutdown,
-	.suspend	= sch311x_wdt_suspend,
-	.resume		= sch311x_wdt_resume,
 	.driver		= {
 		.owner = THIS_MODULE,
 		.name = DRV_NAME,
-- 
1.7.5.4

