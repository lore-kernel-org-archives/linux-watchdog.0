Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:45564 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1033321AbeCASRq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 1 Mar 2018 13:17:46 -0500
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
Subject: [PATCH v7 1/3] watchdog: renesas_wdt: Add suspend/resume support
Date: Thu,  1 Mar 2018 18:17:21 +0000
Message-Id: <1519928243-28596-2-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1519928243-28596-1-git-send-email-fabrizio.castro@bp.renesas.com>
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
v6->v7:
* backup and restore register RWTCNT instead of using rwdt_get_timeleft and
  rwdt_set_timeleft

 drivers/watchdog/renesas_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 831ef83..024d54e 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -49,6 +49,7 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	unsigned long clk_rate;
+	u16 time_left;
 	u8 cks;
 };
 
@@ -203,6 +204,30 @@ static int rwdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static int __maybe_unused rwdt_suspend(struct device *dev)
+{
+	struct rwdt_priv *priv = dev_get_drvdata(dev);
+
+	if (watchdog_active(&priv->wdev)) {
+		priv->time_left = readw(priv->base + RWTCNT);
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
+		rwdt_write(priv, priv->time_left, RWTCNT);
+	}
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rwdt_pm_ops, rwdt_suspend, rwdt_resume);
+
 /*
  * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
  * to work there, one also needs a RESET (RST) driver which does not exist yet
@@ -218,6 +243,7 @@ static struct platform_driver rwdt_driver = {
 	.driver = {
 		.name = "renesas_wdt",
 		.of_match_table = rwdt_ids,
+		.pm = &rwdt_pm_ops,
 	},
 	.probe = rwdt_probe,
 	.remove = rwdt_remove,
-- 
2.7.4

