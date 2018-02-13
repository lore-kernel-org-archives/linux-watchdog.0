Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45445 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933645AbeBMITP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Feb 2018 03:19:15 -0500
Date: Tue, 13 Feb 2018 09:19:10 +0100
From: Simon Horman <horms@verge.net.au>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
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
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: Re: [PATCH v5 09/26] soc: renesas: rcar-rst: Enable watchdog as
 reset trigger for Gen2
Message-ID: <20180213081910.x5llcsmwza44u4ow@verge.net.au>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1518457475-4480-10-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518457475-4480-10-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 12, 2018 at 05:44:18PM +0000, Fabrizio Castro wrote:
> This patch allows for platform specific quirks as some of the SoC need
> further customization for the watchdog to work properly, like for R-Car
> Gen2 and for RZ/G.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

I am fine with this patch but please rebase it on top of
renesas-devel-20180212-v4.16-rc1 (or later).
