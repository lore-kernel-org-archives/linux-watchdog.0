Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:16180 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751109AbeAYSEP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 Jan 2018 13:04:15 -0500
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: [RFC 09/37] soc: renesas: rcar-rst: Add generic compatible strings
Date: Thu, 25 Jan 2018 18:02:43 +0000
Message-Id: <1516903391-30467-10-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit introduces generic compatible strings to use as fallback,
so that devices compatible with the generic implementation may avoid
changing the driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 drivers/soc/renesas/rcar-rst.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/renesas/rcar-rst.c b/drivers/soc/renesas/rcar-rst.c
index 3316b02..f7a0d54 100644
--- a/drivers/soc/renesas/rcar-rst.c
+++ b/drivers/soc/renesas/rcar-rst.c
@@ -25,8 +25,16 @@ static const struct rst_config rcar_rst_gen2 __initconst = {
 	.modemr = 0x60,
 };
 
+static const struct rst_config rcar_rst_gen3 __initconst = {
+	.modemr = 0x60,
+};
+
 static const struct of_device_id rcar_rst_matches[] __initconst = {
-	/* RZ/G is handled like R-Car Gen2 */
+	/* generic compatible strings */
+	{ .compatible = "renesas,rcar-gen1-rst", .data = &rcar_rst_gen1 },
+	{ .compatible = "renesas,rcar-gen2-rst", .data = &rcar_rst_gen2 },
+	{ .compatible = "renesas,rcar-gen3-rst", .data = &rcar_rst_gen3 },
+	/* RZ/G */
 	{ .compatible = "renesas,r8a7743-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7745-rst", .data = &rcar_rst_gen2 },
 	/* R-Car Gen1 */
@@ -38,11 +46,11 @@ static const struct of_device_id rcar_rst_matches[] __initconst = {
 	{ .compatible = "renesas,r8a7792-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7793-rst", .data = &rcar_rst_gen2 },
 	{ .compatible = "renesas,r8a7794-rst", .data = &rcar_rst_gen2 },
-	/* R-Car Gen3 is handled like R-Car Gen2 */
-	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen2 },
-	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen2 },
+	/* R-Car Gen3 */
+	{ .compatible = "renesas,r8a7795-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a7796-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77970-rst", .data = &rcar_rst_gen3 },
+	{ .compatible = "renesas,r8a77995-rst", .data = &rcar_rst_gen3 },
 	{ /* sentinel */ }
 };
 
-- 
2.7.4

