Return-path: <wens@mirror2.csie.ntu.edu.tw>
From: Chen-Yu Tsai <wens@csie.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] watchdog: sunxi: Add A31 watchdog support
Date: Mon, 22 Sep 2014 00:05:19 +0800
Message-Id: <1411315519-26257-3-git-send-email-wens@csie.org>
In-Reply-To: <1411315519-26257-1-git-send-email-wens@csie.org>
References: <1411315519-26257-1-git-send-email-wens@csie.org>
List-ID: <linux-watchdog@vger.kernel.org>

This patch adds support for the watchdog hardware found in A31 and
newer SoCs. This new hardware has registers at different offsets, and
the system reset control has been split out of the "mode" register
into a new "configuration" register.

Differences not supported by this driver include separate interrupt
lines for each watchdog, instead of sharing an interrupt line and
registers with the timer block.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/watchdog/sunxi_wdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index a1f7113..b62301e 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -219,8 +219,18 @@ static const struct sunxi_wdt_reg sun4i_wdt_reg = {
 	.wdt_reset_val = 0x02,
 };
 
+static const struct sunxi_wdt_reg sun6i_wdt_reg = {
+	.wdt_ctrl = 0x10,
+	.wdt_cfg = 0x14,
+	.wdt_mode = 0x18,
+	.wdt_timeout_shift = 4,
+	.wdt_reset_mask = 0x03,
+	.wdt_reset_val = 0x01,
+};
+
 static const struct of_device_id sunxi_wdt_dt_ids[] = {
 	{ .compatible = "allwinner,sun4i-a10-wdt", .data = &sun4i_wdt_reg },
+	{ .compatible = "allwinner,sun6i-a31-wdt", .data = &sun6i_wdt_reg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_wdt_dt_ids);
-- 
2.1.0
