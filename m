Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:28078 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751213AbeAYSFq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 25 Jan 2018 13:05:46 -0500
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
Subject: [RFC 26/37] clk: renesas: r8a7743: Add rwdt clock
Date: Thu, 25 Jan 2018 18:03:00 +0000
Message-Id: <1516903391-30467-27-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add "rwdt" clock to r8a7743_mod_clks. Also, since we may need to access
the watchdog registers at any time, declare the clock as critical.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
---
 drivers/clk/renesas/r8a7743-cpg-mssr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r8a7743-cpg-mssr.c b/drivers/clk/renesas/r8a7743-cpg-mssr.c
index 6dc0b30..d3c8b1e 100644
--- a/drivers/clk/renesas/r8a7743-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7743-cpg-mssr.c
@@ -117,6 +117,7 @@ static const struct mssr_mod_clk r8a7743_mod_clks[] __initconst = {
 	DEF_MOD("cmt1",			 329,	R8A7743_CLK_R),
 	DEF_MOD("usbhs-dmac0",		 330,	R8A7743_CLK_HP),
 	DEF_MOD("usbhs-dmac1",		 331,	R8A7743_CLK_HP),
+	DEF_MOD("rwdt",			 402,	R8A7743_CLK_R),
 	DEF_MOD("irqc",			 407,	R8A7743_CLK_CP),
 	DEF_MOD("intc-sys",		 408,	R8A7743_CLK_ZS),
 	DEF_MOD("audio-dmac1",		 501,	R8A7743_CLK_HP),
@@ -195,6 +196,7 @@ static const struct mssr_mod_clk r8a7743_mod_clks[] __initconst = {
 };
 
 static const unsigned int r8a7743_crit_mod_clks[] __initconst = {
+	MOD_CLK_ID(402),	/* RWDT */
 	MOD_CLK_ID(408),	/* INTC-SYS (GIC) */
 };
 
-- 
2.7.4

