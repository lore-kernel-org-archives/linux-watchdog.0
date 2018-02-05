Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45135 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752847AbeBEGIl (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Feb 2018 01:08:41 -0500
Date: Mon, 5 Feb 2018 00:08:38 -0600
From: Rob Herring <robh@kernel.org>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
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
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Subject: Re: [RFC v4 11/26] dt-bindings: watchdog: renesas-wdt: Add R-Car
 Gen2 support
Message-ID: <20180205033433.zldw5xywxjz4jset@rob-hp-laptop>
References: <1517423070-24236-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1517423070-24236-12-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517423070-24236-12-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 31, 2018 at 06:24:15PM +0000, Fabrizio Castro wrote:
> This commit documents the compatibility with R-Car Gen2 and RZ/G
> devices by defining the generic compatible string "renesas,rcar-gen2-wdt".
> Also, this patch expands the list of SoC-specific compatible strings to
> include RZ/G and R-Car Gen2 devices.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3->4:
> * Reinstated lost "renesas,rza-wdt" compatible string
> 
>  .../devicetree/bindings/watchdog/renesas-wdt.txt      | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
