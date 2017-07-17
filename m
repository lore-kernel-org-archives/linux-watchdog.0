Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33841 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751306AbdGQPNr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Jul 2017 11:13:47 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/5] watchdog: renesas_wdt: apply better precision
Date: Mon, 17 Jul 2017 17:12:29 +0200
Message-Id: <20170717151230.12680-5-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
References: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The error margin of the clks_per_second variable was too large and
caused offsets when used with clock frequencies which left a remainder
after applying the dividers. Now we always calculate directly using the
clock rate and the divider using some helper macros. That also means
that DIV_ROUND_UP moves from probe to the multiplication macro. In
probe, we don't need to ensure anymore that 'clks_per_sec' would go too
fast but rather ensure that the lower limit is really at least 1 to
certainly get a full cycle.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index d2390695d3453f..599ba5aaa0536f 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -26,6 +26,17 @@
 
 #define RWDT_DEFAULT_TIMEOUT 60U
 
+/*
+ * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
+ * divider (10 bits). d is only a factor to fully utilize the WDT counter and
+ * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
+ */
+#define MUL_BY_CLKS_PER_SEC(p, d) \
+	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
+
+/* d is 16 bit, clk_divs 10 bit -> no 32 bit overflow */
+#define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
+
 static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -37,7 +48,7 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	struct clk *clk;
-	unsigned int clks_per_sec;
+	unsigned long clk_rate;
 	u8 cks;
 };
 
@@ -55,7 +66,7 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	rwdt_write(priv, 65536 - wdev->timeout * priv->clks_per_sec, RWTCNT);
+	rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout), RWTCNT);
 
 	return 0;
 }
@@ -92,7 +103,7 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 	u16 val = readw_relaxed(priv->base + RWTCNT);
 
-	return (65536 - val) / priv->clks_per_sec;
+	return DIV_BY_CLKS_PER_SEC(priv, 65536 - val);
 }
 
 static const struct watchdog_info rwdt_ident = {
@@ -112,7 +123,7 @@ static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
 	struct resource *res;
-	unsigned long rate, clks_per_sec;
+	unsigned long clks_per_sec;
 	int ret, i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -128,14 +139,13 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	rate = clk_get_rate(priv->clk);
-	if (!rate)
+	priv->clk_rate = clk_get_rate(priv->clk);
+	if (!priv->clk_rate)
 		return -ENOENT;
 
 	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
-		clks_per_sec = DIV_ROUND_UP(rate, clk_divs[i]);
+		clks_per_sec = priv->clk_rate / clk_divs[i];
 		if (clks_per_sec && clks_per_sec < 65536) {
-			priv->clks_per_sec = clks_per_sec;
 			priv->cks = i;
 			break;
 		}
@@ -153,7 +163,7 @@ static int rwdt_probe(struct platform_device *pdev)
 	priv->wdev.ops = &rwdt_ops,
 	priv->wdev.parent = &pdev->dev;
 	priv->wdev.min_timeout = 1;
-	priv->wdev.max_timeout = 65536 / clks_per_sec;
+	priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
 	priv->wdev.timeout = min(priv->wdev.max_timeout, RWDT_DEFAULT_TIMEOUT);
 
 	platform_set_drvdata(pdev, priv);
-- 
2.11.0

