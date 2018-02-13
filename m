Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:45350 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeBMIFR (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 13 Feb 2018 03:05:17 -0500
Date: Tue, 13 Feb 2018 09:05:12 +0100
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
Subject: Re: [PATCH v5 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
Message-ID: <20180213080512.huhc6pkowhie74nq@verge.net.au>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Feb 12, 2018 at 05:44:09PM +0000, Fabrizio Castro wrote:
> Dear All,
> 
> this series has been around for some time as RFC, and it has collected
> useful comments from the community along the way.
> The solution proposed by this patch set works for most R-Car Gen2 and
> RZ/G1 devices, but not all of them. We now know that for some R-Car
> Gen2 early revisions there is no proper software fix. Anyway, no
> product has been built around early revisions, but development boards
> mounting early revisions (basically prototypes) are still out there.
> As a result, this series isn't enabling the internal watchdog on R-Car
> Gen2 boards, developers may enable it in board specific device trees
> if needed.
> This series has been tested by me on the iwg20d, iwg22d, Lager, Alt,
> and Koelsch boards.
> 
> The problem
> ===========
> To deal with SMP on R-Car Gen2 and RZ/G1, we install a reset vector
> to ICRAM1 and we program the [S]BAR registers so that when we turn ON
> the non-boot CPUs they are redirected to the reset vector installed by
> Linux in ICRAM1, and eventually they continue the execution to RAM,
> where the SMP bring-up code will take care of the rest.
> The content of the [S]BAR registers survives a watchdog triggered reset,
> and as such after the watchdog fires the boot core will try and execute
> the SMP bring-up code instead of jumping to the bootrom code.
> 
> The fix
> =======
> The main strategy for the solution is to let the reset vector decide
> if it needs to jump to shmobile_boot_fn or to the bootrom code.
> In a watchdog triggered reset scenario, since the [S]BAR registers keep
> their values, the boot CPU will jump into the newly designed reset
> vector, the assembly routine will eventually test WOVF (a bit in register
> RWTCSRA that indicates if the watchdog counter has overflown, the value
> of this bit gets retained in this scenario), and jump to the bootrom code
> which will in turn load up the bootloader, etc.
> When bringing up SMP or using CPU hotplug, the reset vector will jump
> to shmobile_boot_fn instead.
> 
> Thank you All for your help.
> 
> Best regards,
> 
> Fabrizio Castro (26):
>   ARM: shmobile: Add watchdog support
>   ARM: dts: r8a7743: Adjust SMP routine size
>   ARM: dts: r8a7745: Adjust SMP routine size
>   ARM: dts: r8a7790: Adjust SMP routine size
>   ARM: dts: r8a7791: Adjust SMP routine size
>   ARM: dts: r8a7792: Adjust SMP routine size
>   ARM: dts: r8a7793: Adjust SMP routine size
>   ARM: dts: r8a7794: Adjust SMP routine size
>   soc: renesas: rcar-rst: Enable watchdog as reset trigger for Gen2
>   ARM: shmobile: rcar-gen2: Add watchdog support
>   dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
>   watchdog: renesas_wdt: Add R-Car Gen2 support
>   watchdog: renesas_wdt: Add restart handler
>   ARM: shmobile: defconfig: Enable RENESAS_WDT_GEN
>   clk: renesas: r8a7743: Add rwdt clock
>   clk: renesas: r8a7745: Add rwdt clock
>   clk: renesas: r8a7790: Add rwdt clock
>   clk: renesas: r8a7791/r8a7793: Add rwdt clock
>   clk: renesas: r8a7794: Add rwdt clock
>   ARM: dts: r8a7743: Add watchdog support to SoC dtsi
>   ARM: dts: r8a7745: Add watchdog support to SoC dtsi
>   ARM: dts: r8a7790: Add watchdog support to SoC dtsi
>   ARM: dts: r8a7791: Add watchdog support to SoC dtsi
>   ARM: dts: r8a7794: Add watchdog support to SoC dtsi
>   ARM: dts: iwg20m: Add watchdog support to SoM dtsi
>   ARM: dts: iwg22m: Add watchdog support to SoM dtsi

Thanks, I have applied the above "dts" and "defconfig" patches for v4.17.
