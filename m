Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55528 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1GMUZC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Jul 2011 16:25:02 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	wim@iguana.be, tim.bird@am.sony.com,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 6/6] WIP watchdog: pnx4008: refactor disabling device
Date: Wed, 13 Jul 2011 22:26:06 +0200
Message-Id: <1310588766-16638-7-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
References: <1310588766-16638-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

wdt_disable and clk_disable must always be used in combination in stop()
to match the initialization in start(), so group them together. Also,
fix disabling clock in remove, which should have been done before.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/watchdog/pnx4008_wdt.c |   23 +++++++++--------------
 1 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 1ccb49a..9f049d7 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -111,19 +111,11 @@ static int pnx4008_wdt_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
-static void wdt_disable(void)
-{
-	spin_lock(&io_lock);
-
-	writel(0, WDTIM_CTRL(wdt_base));	/*stop counter */
-
-	spin_unlock(&io_lock);
-}
-
 static int pnx4008_wdt_start(struct watchdog_device *wdd)
 {
 	int ret;
 
+	//FIXME: better in an open-callback?
 	ret = clk_enable(wdt_clk);
 	if (ret)
 		return ret;
@@ -135,7 +127,11 @@ static int pnx4008_wdt_start(struct watchdog_device *wdd)
 
 static int pnx4008_wdt_stop(struct watchdog_device *wdd)
 {
-	wdt_disable();
+	spin_lock(&io_lock);
+	writel(0, WDTIM_CTRL(wdt_base));
+	spin_unlock(&io_lock);
+
+	//FIXME: better in a close-callback?
 	clk_disable(wdt_clk);
 
 	return 0;
@@ -216,8 +212,8 @@ static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	wdt_disable();		/*disable for now */
-	clk_disable(wdt_clk);
+	/* disable watchdog and its clock until opened */
+	pnx4008_wdt_stop(&pnx4008_wdd);
 
 	dev_info(&pdev->dev, "PNX4008 Watchdog Timer: heartbeat %d sec\n",
 			heartbeat);
@@ -235,8 +231,7 @@ static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
 static int __devexit pnx4008_wdt_remove(struct platform_device *pdev)
 {
 	watchdog_unregister_device(&pnx4008_wdd);
-
-	clk_disable(wdt_clk);
+	/* clk has been disabled on close. If not, we'll reboot anyhow */
 	clk_put(wdt_clk);
 
 	return 0;
-- 
1.7.2.5

