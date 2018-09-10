Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:28593 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728834AbeIKAsm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Sep 2018 20:48:42 -0400
From: Chris Brandt <chris.brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v4 1/2] watchdog: rza_wdt: Support longer timeouts
Date: Mon, 10 Sep 2018 14:52:32 -0500
Message-Id: <20180910195233.25296-2-chris.brandt@renesas.com>
In-Reply-To: <20180910195233.25296-1-chris.brandt@renesas.com>
References: <20180910195233.25296-1-chris.brandt@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The RZ/A2 watchdog timer extends the clock source options in order to
allow for longer timeouts.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v4:
 * Documented CKS_3BIT/CKS_4BIT better
 * Changed 16384 and 4194304 into #define
 * Removed rza_wdt.timeout
 * Removed extra ( ) from DIV_ROUND_UP
 * Removed check for counter value > 256
 * Added set_timeout function
 * Removed checking for new timeout value in ping function
 * Removed unneeded 'else' case when checking .data in probe
v3:
 * Removed + 1 from DIV_ROUND_UP line
 * resetting to 0 if time to big did not make as much sense are resetting
   to 256
v2:
* use DIV_ROUND_UP
* use %u for pr_debug
* use of_match data to determine the size of CKS register
---
 drivers/watchdog/rza_wdt.c | 88 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
index e618218d2374..aeca6b13c797 100644
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
@@ -34,12 +35,45 @@
 #define WRCSR_RSTE		BIT(6)
 #define WRCSR_CLEAR_WOVF	0xA500	/* special value */
 
+/* The maximum CKS register setting value to get the longest timeout */
+#define CKS_3BIT		0x7
+#define CKS_4BIT		0xF
+
+#define DIVIDER_3BIT		16384	/* Clock divider when CKS = 0x7 */
+#define DIVIDER_4BIT		4194304	/* Clock divider when CKS = 0xF */
+
 struct rza_wdt {
 	struct watchdog_device wdev;
 	void __iomem *base;
 	struct clk *clk;
+	u8 count;
+	u8 cks;
 };
 
+static void rza_wdt_calc_timeout(struct rza_wdt *priv, int timeout)
+{
+	unsigned long rate = clk_get_rate(priv->clk);
+	unsigned int ticks;
+
+	if (priv->cks == CKS_4BIT) {
+		ticks = DIV_ROUND_UP(timeout * rate, DIVIDER_4BIT);
+
+		/*
+		 * Since max_timeout was set in probe, we know that the timeout
+		 * value passed will never calculate to a tick value greater
+		 * than 256.
+		 */
+		priv->count = 256 - ticks;
+
+	} else {
+		/* Start timer with longest timeout */
+		priv->count = 0;
+	}
+
+	pr_debug("%s: timeout set to %u (WTCNT=%d)\n", __func__,
+		 timeout, priv->count);
+}
+
 static int rza_wdt_start(struct watchdog_device *wdev)
 {
 	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
@@ -51,13 +85,12 @@ static int rza_wdt_start(struct watchdog_device *wdev)
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
@@ -75,8 +108,17 @@ static int rza_wdt_ping(struct watchdog_device *wdev)
 {
 	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
 
-	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
+	writew(WTCNT_MAGIC | priv->count, priv->base + WTCNT);
 
+	pr_debug("%s: timeout = %u\n", __func__, wdev->timeout);
+
+	return 0;
+}
+
+static int rza_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
+{
+	wdev->timeout = timeout;
+	rza_wdt_start(wdev);
 	return 0;
 }
 
@@ -121,6 +163,7 @@ static const struct watchdog_ops rza_wdt_ops = {
 	.start = rza_wdt_start,
 	.stop = rza_wdt_stop,
 	.ping = rza_wdt_ping,
+	.set_timeout = rza_set_timeout,
 	.restart = rza_wdt_restart,
 };
 
@@ -150,20 +193,28 @@ static int rza_wdt_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	/* Assume slowest clock rate possible (CKS=7) */
-	rate /= 16384;
-
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
+	priv->cks = (unsigned int)of_device_get_match_data(&pdev->dev);
+	if (priv->cks == CKS_4BIT) {
+		/* Assume slowest clock rate possible (CKS=0xF) */
+		priv->wdev.max_timeout = (DIVIDER_4BIT * U8_MAX) / rate;
+
+	} else if (priv->cks == CKS_3BIT) {
+		/* Assume slowest clock rate possible (CKS=7) */
+		rate /= DIVIDER_3BIT;
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
@@ -179,7 +230,8 @@ static int rza_wdt_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id rza_wdt_of_match[] = {
-	{ .compatible = "renesas,rza-wdt", },
+	{ .compatible = "renesas,r7s9210-wdt",	.data = (void *)CKS_4BIT, },
+	{ .compatible = "renesas,rza-wdt",	.data = (void *)CKS_3BIT, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rza_wdt_of_match);
-- 
2.16.1
