Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:46033 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932288AbeBLRqX (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Feb 2018 12:46:23 -0500
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
Subject: [PATCH v5 17/26] clk: renesas: r8a7790: Add rwdt clock
Date: Mon, 12 Feb 2018 17:44:26 +0000
Message-Id: <1518457475-4480-18-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add "rwdt" clock to r8a7790_mod_clks. Also, since we may need to access
the watchdog registers at any time, declare the clock as critical.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v4->v5:
* no change

 drivers/clk/renesas/r8a7790-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a7790-cpg-mssr.c b/drivers/clk/renesas/r8a7790-cpg-mssr.c
index 46bb55b..f936cb7 100644
--- a/drivers/clk/renesas/r8a7790-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7790-cpg-mssr.c
@@ -140,6 +140,7 @@ static const struct mssr_mod_clk r8a7790_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",			 329,	R8A7790_CLK_R),
 	DEF_MOD("usbhs-dmac0",		 330,	R8A7790_CLK_HP),
 	DEF_MOD("usbhs-dmac1",		 331,	R8A7790_CLK_HP),
+	DEF_MOD("rwdt",			 402,	R8A7790_CLK_R),
 	DEF_MOD("irqc",			 407,	R8A7790_CLK_CP),
 	DEF_MOD("intc-sys",		 408,	R8A7790_CLK_ZS),
 	DEF_MOD("audio-dmac1",		 501,	R8A7790_CLK_HP),
@@ -211,6 +212,7 @@ static const struct mssr_mod_clk r8a7790_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a7790_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-SYS (GIC) */
 };
 
-- 
2.7.4

