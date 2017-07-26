Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34848 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdGZVy7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Jul 2017 17:54:59 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 2/3] watchdog: renesas_wdt: make 'clk' a variable local to probe()
Date: Wed, 26 Jul 2017 23:54:38 +0200
Message-Id: <20170726215439.9623-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It is not needed outside probe() anymore.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index a03997b418ba9c..2927b5086e156e 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -48,7 +48,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
-	struct clk *clk;
 	unsigned long clk_rate;
 	u8 cks;
 };
@@ -125,6 +124,7 @@ static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
 	struct resource *res;
+	struct clk *clk;
 	unsigned long clks_per_sec;
 	int ret, i;
 
@@ -137,14 +137,14 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
 
 	pm_runtime_enable(&pdev->dev);
 
 	pm_runtime_get_sync(&pdev->dev);
-	priv->clk_rate = clk_get_rate(priv->clk);
+	priv->clk_rate = clk_get_rate(clk);
 	pm_runtime_put(&pdev->dev);
 
 	if (!priv->clk_rate) {
-- 
2.11.0

