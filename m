Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:16798 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729055AbeIFXPE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Sep 2018 19:15:04 -0400
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v2 1/2] watchdog: rza_wdt: Support longer timeouts
Date: Thu,  6 Sep 2018 13:37:37 -0500
Message-Id: <20180906183738.81238-2-chris.brandt@renesas.com>
In-Reply-To: <20180906183738.81238-1-chris.brandt@renesas.com>
References: <20180906183738.81238-1-chris.brandt@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The RZ/A2 watchdog timer extends the clock source options in order to
allow for longer timeouts.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
* use DIV_ROUND_UP
* use %u for pr_debug
* use of_match data to determine the size of CKS register
---
 drivers/watchdog/rza_wdt.c | 81 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
index e618218d2374..d55eb947d08c 100644
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 
@@ -34,12 +35,40 @@
 #define WRCSR_RSTE		BIT(6)
 #define WRCSR_CLEAR_WOVF	0xA500	/* special value */
 
+#define CKS_3BIT		0x7
+#define CKS_4BIT		0xF
+
 struct rza_wdt {
 	struct watchdog_device wdev;
 	void __iomem *base;
 	struct clk *clk;
+	u8 count;
+	u8 cks;
+	u8 timeout;
 };
 
+static void rza_wdt_calc_timeout(struct rza_wdt *priv, int timeout)
+{
+	int rate = clk_get_rate(priv->clk);
+	u16 counter;
+
+	if (priv->cks == CKS_4BIT) {
+		counter = DIV_ROUND_UP((timeout * rate),  4194304) + 1;
+		if (counter > 255)
+			counter = 0;
+
+		priv->count = 256 - counter;
+	} else {
+		/* Start timer with longest timeout */
+		priv->count = 0;
+	}
+
+	priv->timeout = timeout;
+
+	pr_debug("%s: timeout set to %u (WTCNT=%d)\n", __func__,
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
+	pr_debug("%s: timeout = %u\n", __func__, wdev->timeout);
 
 	return 0;
 }
@@ -150,20 +183,31 @@ static int rza_wdt_probe(struct platform_device *pdev)
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
+		priv->wdev.max_timeout = (4194304 * U8_MAX) / rate;
+
+	} else if (priv->cks == CKS_3BIT) {
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
+	} else {
+		dev_err(&pdev->dev, "invalid CKS value (%u)\n", priv->cks);
+		return -EINVAL;
+	}
 
 	priv->wdev.min_timeout = 1;
 	priv->wdev.timeout = DEFAULT_TIMEOUT;
@@ -179,7 +223,8 @@ static int rza_wdt_probe(struct platform_device *pdev)
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
