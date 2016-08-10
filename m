Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48582 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbcHJXTp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Aug 2016 19:19:45 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH] watchdog: dw_wdt: Read clock rate only once and validate it
Date: Tue,  9 Aug 2016 22:35:58 -0700
Message-Id: <1470807358-8839-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Coverity reports:

divide_by_zero: In expression readl(dw_wdt->regs + 8) /
clk_get_rate(dw_wdt->clk), division by expression clk_get_rate(dw_wdt->clk)
which may be zero has undefined behavior.

The clock used for the watchdog timer won't change its rate, so read it
only once during probe. Also validate it and abort the probe function
with an error if it is 0.

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/dw_wdt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2acb51cf5504..3c6a3de13a1b 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -54,6 +54,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 struct dw_wdt {
 	void __iomem		*regs;
 	struct clk		*clk;
+	unsigned long		rate;
 	struct notifier_block	restart_handler;
 	struct watchdog_device	wdd;
 };
@@ -72,7 +73,7 @@ static inline int dw_wdt_top_in_seconds(struct dw_wdt *dw_wdt, unsigned top)
 	 * There are 16 possible timeout values in 0..15 where the number of
 	 * cycles is 2 ^ (16 + i) and the watchdog counts down.
 	 */
-	return (1U << (16 + top)) / clk_get_rate(dw_wdt->clk);
+	return (1U << (16 + top)) / dw_wdt->rate;
 }
 
 static int dw_wdt_get_top(struct dw_wdt *dw_wdt)
@@ -163,7 +164,7 @@ static unsigned int dw_wdt_get_timeleft(struct watchdog_device *wdd)
 	struct dw_wdt *dw_wdt = to_dw_wdt(wdd);
 
 	return readl(dw_wdt->regs + WDOG_CURRENT_COUNT_REG_OFFSET) /
-		clk_get_rate(dw_wdt->clk);
+		dw_wdt->rate;
 }
 
 static const struct watchdog_info dw_wdt_ident = {
@@ -231,6 +232,12 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	dw_wdt->rate = clk_get_rate(dw_wdt->clk);
+	if (dw_wdt->rate == 0) {
+		ret = -EINVAL;
+		goto out_disable_clk;
+	}
+
 	wdd = &dw_wdt->wdd;
 	wdd->info = &dw_wdt_ident;
 	wdd->ops = &dw_wdt_ops;
-- 
2.5.0

