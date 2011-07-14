Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43377 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754365Ab1GNKxM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2011 06:53:12 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>,
	Renaud Cerrato <r.cerrato@til-technologies.fr>
Subject: [PATCH 1/3] watchdog: at91: remove empty pm-functions
Date: Thu, 14 Jul 2011 12:53:01 +0200
Message-Id: <1310640783-16543-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
References: <1310640783-16543-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Renaud Cerrato <r.cerrato@til-technologies.fr>
---
 drivers/watchdog/at91sam9_wdt.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index eac2602..5cfbcc5 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -284,27 +284,8 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 	return res;
 }
 
-#ifdef CONFIG_PM
-
-static int at91wdt_suspend(struct platform_device *pdev, pm_message_t message)
-{
-	return 0;
-}
-
-static int at91wdt_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
-#else
-#define at91wdt_suspend	NULL
-#define at91wdt_resume	NULL
-#endif
-
 static struct platform_driver at91wdt_driver = {
 	.remove		= __exit_p(at91wdt_remove),
-	.suspend	= at91wdt_suspend,
-	.resume		= at91wdt_resume,
 	.driver		= {
 		.name	= "at91_wdt",
 		.owner	= THIS_MODULE,
-- 
1.7.5.4

