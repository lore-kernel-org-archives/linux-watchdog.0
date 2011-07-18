Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59582 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab1GRDDa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2011 23:03:30 -0400
Received: by iwn6 with SMTP id 6so2722182iwn.19
        for <linux-watchdog@vger.kernel.org>; Sun, 17 Jul 2011 20:03:29 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org, patches@linaro.org,
	Shawn Guo <shawn.guo@linaro.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: imx2_wdt: add device tree probe support
Date: Mon, 18 Jul 2011 11:15:21 +0800
Message-Id: <1310958921-18083-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It adds device tree probe support for imx2_wdt driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |   14 ++++++++++++++
 drivers/watchdog/imx2_wdt.c                        |    6 ++++++
 2 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
new file mode 100644
index 0000000..2144af1
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -0,0 +1,14 @@
+* Freescale i.MX Watchdog Timer (WDT) Controller
+
+Required properties:
+- compatible : Should be "fsl,<soc>-wdt"
+- reg : Should contain WDT registers location and length
+- interrupts : Should contain WDT interrupt
+
+Examples:
+
+wdt@73f98000 {
+	compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+	reg = <0x73f98000 0x4000>;
+	interrupts = <58>;
+};
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 86f7cac..b8ef2c6 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -329,12 +329,18 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 	}
 }
 
+static const struct of_device_id imx2_wdt_dt_ids[] = {
+	{ .compatible = "fsl,imx21-wdt", },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver imx2_wdt_driver = {
 	.remove		= __exit_p(imx2_wdt_remove),
 	.shutdown	= imx2_wdt_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = imx2_wdt_dt_ids,
 	},
 };
 
-- 
1.7.4.1

