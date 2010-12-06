Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:48884
	"EHLO VA3EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753129Ab0LFTeL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 6 Dec 2010 14:34:11 -0500
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <linux-arm-kernel@lists.infradead.org>
CC: <kernel@pengutronix.de>, <u.kleine-koenig@pengutronix.de>,
	<wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] watchdog: imx: use clk_get to acquire the watchdog clock
Date: Mon, 6 Dec 2010 17:38:13 -0200
Message-ID: <1291664293-28360-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use clk_get to acquire the watchdog clock and also avoid hardcoding the clock name.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clock-imx21.c |    2 +-
 arch/arm/mach-imx/clock-imx25.c |    2 +-
 arch/arm/mach-imx/clock-imx27.c |    2 +-
 arch/arm/mach-mx3/clock-imx31.c |    2 +-
 arch/arm/mach-mx3/clock-imx35.c |    2 +-
 drivers/watchdog/imx2_wdt.c     |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/clock-imx21.c b/arch/arm/mach-imx/clock-imx21.c
index cf15ea5..c63a4f5 100644
--- a/arch/arm/mach-imx/clock-imx21.c
+++ b/arch/arm/mach-imx/clock-imx21.c
@@ -1185,7 +1185,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "brom", brom_clk)
 	_REGISTER_CLOCK(NULL, "emma", emma_clk[0])
 	_REGISTER_CLOCK(NULL, "slcdc", slcdc_clk[0])
-	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
+	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c_clk)
 	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
diff --git a/arch/arm/mach-imx/clock-imx25.c b/arch/arm/mach-imx/clock-imx25.c
index 9e4a557..2c98be8 100644
--- a/arch/arm/mach-imx/clock-imx25.c
+++ b/arch/arm/mach-imx/clock-imx25.c
@@ -296,7 +296,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("imxdi_rtc.0", NULL, dryice_clk)
 	_REGISTER_CLOCK("imx-fb.0", NULL, lcdc_clk)
-	_REGISTER_CLOCK("imx-wdt.0", NULL, wdt_clk)
+	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK("imx-ssi.0", NULL, ssi1_clk)
 	_REGISTER_CLOCK("imx-ssi.1", NULL, ssi2_clk)
 	_REGISTER_CLOCK("sdhci-esdhc-imx.0", NULL, esdhc1_clk)
diff --git a/arch/arm/mach-imx/clock-imx27.c b/arch/arm/mach-imx/clock-imx27.c
index 2202b88..f32f3b8 100644
--- a/arch/arm/mach-imx/clock-imx27.c
+++ b/arch/arm/mach-imx/clock-imx27.c
@@ -667,7 +667,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "sahara2", sahara2_clk)
 	_REGISTER_CLOCK(NULL, "ata", ata_clk)
 	_REGISTER_CLOCK(NULL, "mstick", mstick_clk)
-	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
+	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
 	_REGISTER_CLOCK("imx-i2c.0", NULL, i2c1_clk)
 	_REGISTER_CLOCK("imx-i2c.1", NULL, i2c2_clk)
diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 7cf6d29..4193cf5 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -530,7 +530,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("imx31-cspi.2", NULL, cspi3_clk)
 	_REGISTER_CLOCK(NULL, "gpt", gpt_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
-	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
+	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
 	_REGISTER_CLOCK(NULL, "epit", epit1_clk)
 	_REGISTER_CLOCK(NULL, "epit", epit2_clk)
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 61e4a31..22259d9 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -495,7 +495,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("mxc-ehci.2", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usbotg_clk)
 	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", usbahb_clk)
-	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
+	_REGISTER_CLOCK("imx2-wdt.0", NULL, wdog_clk)
 	_REGISTER_CLOCK(NULL, "max", max_clk)
 	_REGISTER_CLOCK(NULL, "audmux", audmux_clk)
 	_REGISTER_CLOCK(NULL, "csi", csi_clk)
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 2ee7dac..86f7cac 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -270,7 +270,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	imx2_wdt.clk = clk_get_sys("imx-wdt.0", NULL);
+	imx2_wdt.clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(imx2_wdt.clk)) {
 		dev_err(&pdev->dev, "can't get Watchdog clock\n");
 		return PTR_ERR(imx2_wdt.clk);
-- 
1.6.0.4


