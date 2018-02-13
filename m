Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:34685 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935118AbeBMNDV (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Feb 2018 08:03:21 -0500
From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To: Simon Horman <horms@verge.net.au>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [PATCH v6 09/26] soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
Date: Tue, 13 Feb 2018 13:02:44 +0000
Message-Id: <1518526964-7400-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <20180213081910.x5llcsmwza44u4ow@verge.net.au>
References: <20180213081910.x5llcsmwza44u4ow@verge.net.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch allows for platform specific quirks as some of the SoC need
further customization for the watchdog to work properly, like for R-Car
Gen2 and for RZ/G.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v5->v6:
* rebased on top of renesas-devel-20180213-v4.16-rc1

 drivers/soc/renesas/rcar-rst.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index e2340eb..3413666 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -13,8 +13,18 @@
 #include <linux/of_address.h>
 #include <linux/soc/renesas/rcar-rst.h>
 
+#define WDTRSTCR_RESET		0xA55A0002
+#define WDTRSTCR		0x0054
+
+static int rcar_rst_enable_wdt_reset(void __iomem *base)
+{
+	iowrite32(WDTRSTCR_RESET, base + WDTRSTCR);
+	return 0;
+}
+
 struct rst_config {
-	unsigned int modemr;	/* Mode Monitoring Register Offset */
+	unsigned int modemr;		/* Mode Monitoring Register Offset */
+	int (*configure)(void *base);	/* Platform specific configuration */
 };
 
 static const struct rst_config rcar_rst_gen1 __initconst = {
@@ -23,6 +33,11 @@ static const struct rst_config rcar_rst_gen1 __initconst = {
 
 static const struct rst_config rcar_rst_gen2 __initconst = {
 	.modemr = 0x60,
+	.configure = rcar_rst_enable_wdt_reset,
+};
+
+static const struct rst_config rcar_rst_gen3 __initconst = {
+	.modemr = 0x60,
 };
 
 static const struct of_device_id rcar_rst_matches[] __initconst = {
@@ -38,12 +53,12 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a7792-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7793-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7794-rst", .data = &rcar_rst_gen2 },
-	/* R-Car Gen3 is handled like R-Car Gen2 */
-	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77980-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen2 },
+	/* R-Car Gen3 */
+	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77980-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen3 },
 	{ /* sentinel */ }
 };
 
@@ -72,6 +87,14 @@ static int __init rcar_rst_init(void)
 	rcar_rst_base = base;
 	cfg = match->data;
 	saved_mode = ioread32(base + cfg->modemr);
+	if (cfg->configure) {
+		error = cfg->configure(base);
+		if (error) {
+			pr_warn("%pOF: Cannot run SoC specific configuration\n",
+				np);
+			goto out_put;
+		}
+	}
 
 	pr_debug("%pOF: MODE = 0x%08x\n", np, saved_mode);
 
-- 
2.7.4

