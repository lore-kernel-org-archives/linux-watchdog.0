Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51250 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754644AbbESI0t (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:49 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 10/10] watchdog: omap_wdt: Convert to use new core extensions
Date: Tue, 19 May 2015 11:26:09 +0300
Message-Id: <1432023969-20736-11-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the new watchdog core extensions to let watchdog core take over
boot time watchdog behavior. The difference is that early-timeout-sec
device tree property becomes available for this driver and a running
watchdog is not stopped unless the core decides to stop it.

Omap watchdog is running by default in the boot up but bootloader
might have stopped it. Therefore we will set the watchdog_active flag
depending on the actual watchdog state so that the watchdog core can
act properly depending on the watchdog policy.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/omap_wdt.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1e6be9e..fc230b0 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -78,6 +78,13 @@ static void omap_wdt_reload(struct omap_wdt_dev *wdev)
 	/* reloaded WCRR from WLDR */
 }
 
+static int omap_wdt_is_running(struct omap_wdt_dev *wdev)
+{
+	void __iomem *base = wdev->base;
+
+	return readl_relaxed(base + OMAP_WATCHDOG_SPR) == 0x4444;
+}
+
 static void omap_wdt_enable(struct omap_wdt_dev *wdev)
 {
 	void __iomem *base = wdev->base;
@@ -183,6 +190,7 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 	omap_wdt_enable(wdev);
 	omap_wdt_reload(wdev);
 	wdog->timeout = timeout;
+	wdog->hw_heartbeat = timeout * 1000;
 	mutex_unlock(&wdev->lock);
 
 	return 0;
@@ -233,12 +241,14 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	omap_wdt->ops	      = &omap_wdt_ops;
 	omap_wdt->min_timeout = TIMER_MARGIN_MIN;
 	omap_wdt->max_timeout = TIMER_MARGIN_MAX;
+	omap_wdt->hw_max_timeout = TIMER_MARGIN_MAX * 1000;
 
 	if (timer_margin >= TIMER_MARGIN_MIN &&
 	    timer_margin <= TIMER_MARGIN_MAX)
 		omap_wdt->timeout = timer_margin;
 	else
 		omap_wdt->timeout = TIMER_MARGIN_DEFAULT;
+	omap_wdt->hw_heartbeat = omap_wdt->timeout / 2 * 1000;
 
 	watchdog_set_drvdata(omap_wdt, wdev);
 	watchdog_set_nowayout(omap_wdt, nowayout);
@@ -248,6 +258,18 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	pm_runtime_enable(wdev->dev);
 	pm_runtime_get_sync(wdev->dev);
 
+	if (omap_wdt_is_running(wdev))
+		watchdog_set_hw_active(omap_wdt, 1);
+	else
+		/*
+		 * The watchdog should be stopped already by
+		 * bootloader. But unless we call disable here, the
+		 * timeout might not be set correctly on the first
+		 * start. So call disable anyway to make sure the
+		 * watchdog really is stopped properly.
+		 */
+		omap_wdt_disable(wdev);
+
 	if (pdata && pdata->read_reset_sources)
 		rs = pdata->read_reset_sources();
 	else
@@ -255,7 +277,9 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	omap_wdt->bootstatus = (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
 				WDIOF_CARDRESET : 0;
 
-	omap_wdt_disable(wdev);
+	ret = watchdog_init_params(omap_wdt, &pdev->dev);
+	if (ret)
+		return ret;
 
 	ret = watchdog_register_device(omap_wdt);
 	if (ret) {
-- 
2.1.0

