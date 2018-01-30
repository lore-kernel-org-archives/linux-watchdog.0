Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:14213 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751755AbeA3UYo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 Jan 2018 15:24:44 -0500
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
Subject: [RFC v3 17/25] clk: renesas: r8a7791/r8a7793: Add rwdt clock
Date: Tue, 30 Jan 2018 20:22:50 +0000
Message-Id: <1517343778-27902-18-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add "rwdt" clock to r8a7791_mod_clks. Also, since we may need to access
the watchdog registers at any time, declare the clock as critical.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
v1->v3:
* no change

 drivers/clk/renesas/r8a7791-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a7791-cpg-mssr.c b/drivers/clk/renesas/r8a7791-cpg-mssr.c
index c0b51f9..820b220 100644
--- a/drivers/clk/renesas/r8a7791-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7791-cpg-mssr.c
@@ -128,6 +128,7 @@ static const struct mssr_mod_clk r8a7791_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",			 329,	R8A7791_CLK_R),
 	DEF_MOD("usbhs-dmac0",		 330,	R8A7791_CLK_HP),
 	DEF_MOD("usbhs-dmac1",		 331,	R8A7791_CLK_HP),
+	DEF_MOD("rwdt",			 402,	R8A7791_CLK_R),
 	DEF_MOD("irqc",			 407,	R8A7791_CLK_CP),
 	DEF_MOD("intc-sys",		 408,	R8A7791_CLK_ZS),
 	DEF_MOD("audio-dmac1",		 501,	R8A7791_CLK_HP),
@@ -209,6 +210,7 @@ static const struct mssr_mod_clk r8a7791_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a7791_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-SYS (GIC) */
 };
 
-- 
2.7.4

