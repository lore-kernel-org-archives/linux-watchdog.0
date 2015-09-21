Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bn0109.outbound.protection.outlook.com ([157.56.110.109]:12704
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753525AbbIUMpM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Sep 2015 08:45:12 -0400
From: Zhiqiang Hou <B48286@freescale.com>
To: <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
	<will.deacon@arm.com>, <linux-i2c@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-clk@vger.kernel.org>
CC: <wsa@the-dreams.de>, <wim@iguana.be>, <corbet@lwn.net>,
	<mturquette@baylibre.com>, <sboyd@codeaurora.org>,
	<Mingkai.Hu@freescale.com>, <Shaohui.Xie@freescale.com>,
	<Wenbin.Song@freescale.com>, <scottwood@freescale.com>,
	<bhupesh.sharma@freescale.com>, <leoli@freescale.com>,
	Hou Zhiqiang <B48286@freescale.com>
Subject: [PATCH 5/6] clk: qoriq: Add ls1043a support.
Date: Mon, 21 Sep 2015 20:22:37 +0800
Message-ID: <1442838158-2964-6-git-send-email-B48286@freescale.com>
In-Reply-To: <1442838158-2964-1-git-send-email-B48286@freescale.com>
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Hou Zhiqiang <B48286@freescale.com>

Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
 drivers/clk/clk-qoriq.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 7753fa3..e71927b 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -244,6 +244,28 @@ static const struct clockgen_muxinfo clockgen2_cmux_cgb = {
 	},
 };
 
+static const struct clockgen_muxinfo ls1043a_hwa1 = {
+	{
+		{},
+		{},
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL1, PLL_DIV3 },
+		{},
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV2 },
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+	},
+};
+
+static const struct clockgen_muxinfo ls1043a_hwa2 = {
+	{
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV1 },
+		{},
+		{ CLKSEL_VALID, CGA_PLL2, PLL_DIV3 },
+	},
+};
+
 static const struct clockgen_muxinfo t1023_hwa1 = {
 	{
 		{},
@@ -452,6 +474,21 @@ static const struct clockgen_chipinfo chipinfo[] = {
 		.pll_mask = 0x03,
 	},
 	{
+		.compat = "fsl,ls1043a-clockgen",
+		.init_periph = t2080_init_periph,
+		.cmux_groups = {
+			&t1040_cmux
+		},
+		.hwaccel = {
+			&ls1043a_hwa1, &ls1043a_hwa2
+		},
+		.cmux_to_group = {
+			0, -1
+		},
+		.pll_mask = 0x07,
+		.flags = CG_PLL_8BIT,
+	},
+	{
 		.compat = "fsl,ls2080a-clockgen",
 		.cmux_groups = {
 			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
@@ -1228,6 +1265,7 @@ err:
 CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_2, "fsl,qoriq-clockgen-2.0", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls1021a, "fsl,ls1021a-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_ls2080a, "fsl,ls2080a-clockgen", clockgen_init);
 
 /* Legacy nodes */
-- 
2.1.0.27.g96db324

