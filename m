Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:46522 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751735AbeAaSZ5 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 13:25:57 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC v4 12/26] watchdog: renesas_wdt: Add R-Car Gen2 support
Date: Wed, 31 Jan 2018 18:24:16 +0000
Message-Id: <1517423070-24236-13-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Due to commits:
* "ARM: shmobile: Add watchdog support",
* "ARM: shmobile: rcar-gen2: Add watchdog support", and
* "soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2",
we now have everything we needed for the watchdog to work on Gen2 and
RZ/G1.

This commit adds "renesas,rcar-gen2-wdt" as compatible string for R-Car
Gen2 and RZ/G1, and since on those platforms the rwdt clock needs to be
always ON, when suspending to RAM we need to explicitly disable the
counting by clearing TME from RWTCSRA.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v3->4:
* in this new version the changes to the driver have been splitted into
  two commits, this patch takes care of the basic Gen2 support, patch 13/26
  takes care of the restart handler.

 drivers/watchdog/renesas_wdt.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 831ef83..0a1a402 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -203,13 +203,42 @@ static int rwdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * This driver does also fit for R-Car Gen2 (r8a779[0-4]) WDT. However, for SMP
- * to work there, one also needs a RESET (RST) driver which does not exist yet
- * due to HW issues. This needs to be solved before adding compatibles here.
- */
+#ifdef CONFIG_PM
+static int rwdt_suspend(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct rwdt_priv *priv;
+
+	pdev = to_platform_device(dev);
+	priv = platform_get_drvdata(pdev);
+	if (watchdog_active(&priv->wdev)) {
+		rwdt_write(priv, priv->cks, RWTCSRA);
+	}
+	return 0;
+}
+
+static int rwdt_resume(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct rwdt_priv *priv;
+
+	pdev = to_platform_device(dev);
+	priv = platform_get_drvdata(pdev);
+	if (watchdog_active(&priv->wdev)) {
+		rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops rwdt_pm = {
+	.suspend = rwdt_suspend,
+	.resume = rwdt_resume,
+};
+#endif
+
 static const struct of_device_id rwdt_ids[] = {
 	{ .compatible = "renesas,rcar-gen3-wdt", },
+	{ .compatible = "renesas,rcar-gen2-wdt", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rwdt_ids);
@@ -218,6 +247,9 @@ static struct platform_driver rwdt_driver = {
 	.driver = {
 		.name = "renesas_wdt",
 		.of_match_table = rwdt_ids,
+#ifdef CONFIG_PM
+		.pm = &rwdt_pm,
+#endif
 	},
 	.probe = rwdt_probe,
 	.remove = rwdt_remove,
-- 
2.7.4

