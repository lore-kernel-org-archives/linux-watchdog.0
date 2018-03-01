Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:56093 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1031910AbeCAPoo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 10:44:44 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 1/3] watchdog: renesas_wdt: Add suspend/resume support
Date: Thu,  1 Mar 2018 15:44:06 +0000
Message-Id: <1519919048-21884-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519919048-21884-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On R-Car Gen2 and RZ/G1 the watchdog IP clock needs to be always ON,
on R-Car Gen3 we power the IP down during suspend.

This commit adds suspend/resume support, so that the watchdog counting
"pauses" during suspend on all of the SoCs compatible with this driver
and on those we are now adding support for (R-Car Gen2 and RZ/G1).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v5->v6:
* pausing the watchdog during suspend

Geert,

you marked v5 as:
Reviewed-and-Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

but I believe this patch deserves a fresh review and fresh testing.

Thanks,
Fab

 drivers/watchdog/renesas_wdt.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 831ef83..cbf8e4d 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -49,6 +49,7 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	unsigned long clk_rate;
+	unsigned int timeleft;
 	u8 cks;
 };
 
@@ -62,12 +63,16 @@ static void rwdt_write(struct rwdt_priv *priv, u32 val, unsigned int reg)
 	writel_relaxed(val, priv->base + reg);
 }
 
+static void rwdt_set_timeleft(struct rwdt_priv *priv, unsigned int timeleft)
+{
+	rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, timeleft), RWTCNT);
+}
+
 static int rwdt_init_timeout(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	rwdt_write(priv, 65536 - MUL_BY_CLKS_PER_SEC(priv, wdev->timeout), RWTCNT);
-
+	rwdt_set_timeleft(priv, wdev->timeout);
 	return 0;
 }
 
@@ -203,6 +208,30 @@ static int rwdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused rwdt_suspend(struct device *dev)
+{
+	struct rwdt_priv *priv = dev_get_drvdata(dev);
+
+	if (watchdog_active(&priv->wdev)) {
+		priv->timeleft = rwdt_get_timeleft(&priv->wdev);
+		rwdt_stop(&priv->wdev);
+	}
+	return 0;
+}
+
+static int __maybe_unused rwdt_resume(struct device *dev)
+{
+	struct rwdt_priv *priv = dev_get_drvdata(dev);
+
+	if (watchdog_active(&priv->wdev)) {
+		rwdt_start(&priv->wdev);
+		rwdt_set_timeleft(priv, priv->timeleft);
+	}
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rwdt_pm_ops, rwdt_suspend, rwdt_resume);
+
 /*
  * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
  * to work there, one also needs a RESET (RST) driver which does not exist yet
@@ -218,6 +247,7 @@ static struct platform_driver rwdt_driver = {
 	.driver = {
 		.name = "renesas_wdt",
 		.of_match_table = rwdt_ids,
+		.pm = &rwdt_pm_ops,
 	},
 	.probe = rwdt_probe,
 	.remove = rwdt_remove,
-- 
2.7.4

