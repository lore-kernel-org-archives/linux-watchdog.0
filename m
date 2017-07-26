Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34844 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751420AbdGZVy6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Jul 2017 17:54:58 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 1/3] watchdog: renesas_wdt: consistently use RuntimePM for clock management
Date: Wed, 26 Jul 2017 23:54:37 +0200
Message-Id: <20170726215439.9623-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Renesas R-Car archs, RuntimePM does all the clock handling. So, use
it consistently to enable/disable the clocks. Also make sure that clocks
are really enabled around clk_get_rate(). clk_summary looks proper now:

		clock	enable_cnt	prepare_cnt	rate ...
Before this commit:

At boot:	rwdt	1		1		32768 0 0
WDT running:	rwdt	2		2		32768 0 0

After this commit:

At boot:	rwdt	0		1		32768 0 0
WDT running	rwdt	1		1		32768 0 0

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index e3f204bb8802aa..a03997b418ba9c 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -76,7 +76,7 @@ static int rwdt_start(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	clk_prepare_enable(priv->clk);
+	pm_runtime_get_sync(wdev->parent);
 
 	rwdt_write(priv, 0, RWTCSRB);
 	rwdt_write(priv, priv->cks, RWTCSRA);
@@ -95,7 +95,7 @@ static int rwdt_stop(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	rwdt_write(priv, priv->cks, RWTCSRA);
-	clk_disable_unprepare(priv->clk);
+	pm_runtime_put(wdev->parent);
 
 	return 0;
 }
@@ -141,9 +141,16 @@ static int rwdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
+	pm_runtime_enable(&pdev->dev);
+
+	pm_runtime_get_sync(&pdev->dev);
 	priv->clk_rate = clk_get_rate(priv->clk);
-	if (!priv->clk_rate)
-		return -ENOENT;
+	pm_runtime_put(&pdev->dev);
+
+	if (!priv->clk_rate) {
+		ret = -ENOENT;
+		goto out_pm_disable;
+	}
 
 	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
 		clks_per_sec = priv->clk_rate / clk_divs[i];
@@ -155,12 +162,10 @@ static int rwdt_probe(struct platform_device *pdev)
 
 	if (i < 0) {
 		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
-		return -ERANGE;
+		ret = -ERANGE;
+		goto out_pm_disable;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-
 	priv->wdev.info = &rwdt_ident,
 	priv->wdev.ops = &rwdt_ops,
 	priv->wdev.parent = &pdev->dev;
@@ -178,13 +183,14 @@ static int rwdt_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "Specified timeout value invalid, using default\n");
 
 	ret = watchdog_register_device(&priv->wdev);
-	if (ret < 0) {
-		pm_runtime_put(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-		return ret;
-	}
+	if (ret < 0)
+		goto out_pm_disable;
 
 	return 0;
+
+ out_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static int rwdt_remove(struct platform_device *pdev)
@@ -192,7 +198,6 @@ static int rwdt_remove(struct platform_device *pdev)
 	struct rwdt_priv *priv = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&priv->wdev);
-	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.11.0

