Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50024 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751897AbaBGVaZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Feb 2014 16:30:25 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 1/3] watchdog: sunxi: Change compatibles
Date: Fri,  7 Feb 2014 22:29:24 +0100
Message-Id: <1391808566-31008-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Allwinner A10 and A31 compatibles were following a slightly different
compatible patterns than the rest of the SoCs for historical reasons. Change
the compatibles to match the other pattern in the watchdog controller driver
for consistency.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 6 +++---
 drivers/watchdog/sunxi_wdt.c                             | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
index e39cb26..b8f75c5 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -2,13 +2,13 @@ Allwinner SoCs Watchdog timer
 
 Required properties:
 
-- compatible : should be "allwinner,<soc-family>-wdt", the currently supported
-  SoC families being sun4i and sun6i
+- compatible : should be either "allwinner,sun4i-a10-wdt" or
+               "allwinner,sun6i-a31-wdt"
 - reg : Specifies base physical address and size of the registers.
 
 Example:
 
 wdt: watchdog@01c20c90 {
-	compatible = "allwinner,sun4i-wdt";
+	compatible = "allwinner,sun4i-a10-wdt";
 	reg = <0x01c20c90 0x10>;
 };
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 76332d8..cd00a78 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -205,7 +205,7 @@ static void sunxi_wdt_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id sunxi_wdt_dt_ids[] = {
-	{ .compatible = "allwinner,sun4i-wdt" },
+	{ .compatible = "allwinner,sun4i-a10-wdt" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
-- 
1.8.4.2

