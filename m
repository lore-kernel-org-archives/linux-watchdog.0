Return-Path: <chris.brandt@renesas.com>
Return-path: <chris.brandt@renesas.com>
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Simon Horman <horms+renesas@verge.net.au>,
	Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH] watchdog: rza_wdt: Extend clock sources for RZ/A2
Date: Wed,  5 Sep 2018 12:37:43 -0500
Message-Id: <20180905173743.47938-1-chris.brandt@renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

The RZ/A2 watchdog timer extends the clock source options in order to give
you longer timeout options.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/watchdog/rza_wdt.c | 75 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
index e618218d2374..78e0d61519ec 100644
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -38,8 +38,37 @@ struct rza_wdt {
 	struct watchdog_device wdev;
 	void __iomem *base;
 	struct clk *clk;
+	bool ext_cks;
+	u8 count;
+	u8 cks;
+	u8 timeout;
 };
 
+static void rza_wdt_calc_timeout(struct rza_wdt *priv, int timeout)
+{
+	int rate = clk_get_rate(priv->clk);
+	u16 counter;
+
+	if (priv->ext_cks) {
+		/* Add the 1 to deal with the inevitable fraction */
+		counter = ((timeout * rate) /  4194304) + 1;
+		if (counter > 255)
+			counter = 0;
+
+		priv->cks = 0xF;
+		priv->count = 256 - counter;
+	} else {
+		/* Start timer with longest timeout */
+		priv->cks = 7;
+		priv->count = 0;
+	}
+
+	priv->timeout = timeout;
+
+	pr_debug("%s: timeout set to %d (WTCNT=%d)\n", __func__,
+		 timeout, priv->count);
+}
+
 static int rza_wdt_start(struct watchdog_device *wdev)
 {
 	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
@@ -51,13 +80,12 @@ static int rza_wdt_start(struct watchdog_device *wdev)
 	readb(priv->base + WRCSR);
 	writew(WRCSR_CLEAR_WOVF, priv->base + WRCSR);
 
-	/*
-	 * Start timer with slowest clock source and reset option enabled.
-	 */
+	rza_wdt_calc_timeout(priv, wdev->timeout);
+
 	writew(WRCSR_MAGIC | WRCSR_RSTE, priv->base + WRCSR);
-	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
-	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME | WTSCR_CKS(7),
-	       priv->base + WTCSR);
+	writew(WTCNT_MAGIC | priv->count, priv->base + WTCNT);
+	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME |
+	       WTSCR_CKS(priv->cks), priv->base + WTCSR);
 
 	return 0;
 }
@@ -75,7 +103,12 @@ static int rza_wdt_ping(struct watchdog_device *wdev)
 {
 	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
 
-	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
+	if (priv->timeout != wdev->timeout)
+		rza_wdt_calc_timeout(priv, wdev->timeout);
+
+	writew(WTCNT_MAGIC | priv->count, priv->base + WTCNT);
+
+	pr_debug("%s: timeout = %d\n", __func__, wdev->timeout);
 
 	return 0;
 }
@@ -130,6 +163,7 @@ static int rza_wdt_probe(struct platform_device *pdev)
 	struct resource *res;
 	unsigned long rate;
 	int ret;
+	struct device_node *np = pdev->dev.of_node;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -150,20 +184,29 @@ static int rza_wdt_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	/* Assume slowest clock rate possible (CKS=7) */
-	rate /= 16384;
+	if (of_device_is_compatible(np, "renesas,r7s9210-wdt"))
+		priv->ext_cks = true;
 
 	priv->wdev.info = &rza_wdt_ident,
 	priv->wdev.ops = &rza_wdt_ops,
 	priv->wdev.parent = &pdev->dev;
 
-	/*
-	 * Since the max possible timeout of our 8-bit count register is less
-	 * than a second, we must use max_hw_heartbeat_ms.
-	 */
-	priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX) / rate;
-	dev_dbg(&pdev->dev, "max hw timeout of %dms\n",
-		 priv->wdev.max_hw_heartbeat_ms);
+	if (priv->ext_cks) {
+		/* Assume slowest clock rate possible (CKS=0xF) */
+		priv->wdev.max_timeout = (4194304 * U8_MAX) / rate;
+	} else {
+		/* Assume slowest clock rate possible (CKS=7) */
+		rate /= 16384;
+
+		/*
+		 * Since the max possible timeout of our 8-bit count
+		 * register is less than a second, we must use
+		 * max_hw_heartbeat_ms.
+		 */
+		priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX) / rate;
+		dev_dbg(&pdev->dev, "max hw timeout of %dms\n",
+			 priv->wdev.max_hw_heartbeat_ms);
+	}
 
 	priv->wdev.min_timeout = 1;
 	priv->wdev.timeout = DEFAULT_TIMEOUT;
-- 
2.16.1
