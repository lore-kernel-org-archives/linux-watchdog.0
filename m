Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:43876 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRNhb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 18 Apr 2018 09:37:31 -0400
MIME-Version: 1.0
In-Reply-To: <20180313200548.fgexoxlha3coa7hs@verge.net.au>
References: <1518457475-4480-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdX=m9ui6GczF51SJH2X7Cw1OnxoH9pfk1DybpDX-A873Q@mail.gmail.com>
 <20180221161326.ktvf3mlzzxith5kw@verge.net.au> <CAMuHMdUTSmrWggMK4ehSL3Ux-JUzVpamTuToveuXogjuvGKkaw@mail.gmail.com>
 <20180221183223.qacrmmuzoqlzzbpo@verge.net.au> <CAMuHMdXCt1-coXGgtgFBm4rZLGBRMvSjbgeBSweiyKrOfCF0Xg@mail.gmail.com>
 <20180223081443.ak6kl3z72kamcxob@verge.net.au> <CAMuHMdVKPFSVTbnQy9RwAg13OC3R=H1PN9+1FyU0SDHQPa1cuQ@mail.gmail.com>
 <20180313200548.fgexoxlha3coa7hs@verge.net.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Apr 2018 15:37:29 +0200
Message-ID: <CAMuHMdVAi+rU3+TLSp7YQSHzJKFyMH8ZbS3-d8yADKmfz1KiTA@mail.gmail.com>
Subject: Re: [PATCH v5 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/G1
To: Simon Horman <horms@verge.net.au>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Simon,

On Tue, Mar 13, 2018 at 9:05 PM, Simon Horman <horms@verge.net.au> wrote:
> I understand that the watchdog driver has been accepted and that as things
> currently stand if it is enabled in the build it will be enabled in DT and
> a crash will result. From my POV that is a regression so I have decided
> to adopt the alternate plan proposed by Geert above: in short drop DT
> patches (to avoid enabling broken driver) and enqueue mach-shmobile
> patches (which don't make things any worse.
>
> Patch-by-patch things are as follows.
>
> Dropped from "[PATCH v5 00/26] Fix watchdog on Renesas R-Car Gen2 and RZ/G1":
>
> 979d28f29742 ARM: dts: r8a7743: Adjust SMP routine size
> 0b205f679f5d ARM: dts: r8a7745: Adjust SMP routine size
> 2ad21a1d78b3 ARM: dts: r8a7790: Adjust SMP routine size
> 82c978459c77 ARM: dts: r8a7791: Adjust SMP routine size
> d303698e6ff3 ARM: dts: r8a7792: Adjust SMP routine size
> d8b8b9a1e295 ARM: dts: r8a7793: Adjust SMP routine size
> 70b3ab369773 ARM: dts: r8a7794: Adjust SMP routine size
>
> ebf26cf1b1de ARM: dts: r8a7743: Add watchdog support to SoC dtsi
> 5a4566ab3777 ARM: dts: r8a7745: Add watchdog support to SoC dtsi
> acd58e2bb1e5 ARM: dts: r8a7790: Add watchdog support to SoC dtsi
> e3f89168e72f ARM: dts: r8a7791: Add watchdog support to SoC dtsi
> e76a6a69a1fc ARM: dts: r8a7794: Add watchdog support to SoC dtsi
> 242cc1ab7f7c ARM: dts: iwg20m: Add watchdog support to SoM dtsi
> 748ed07f6c7c ARM: dts: iwg22m: Add watchdog support to SoM dtsi
>
>
> Dropped from "[PATCH/RFC 00/11] ARM: dts: rcar-gen2: Enable watchdog support":
>
> c257202482e2 ARM: dts: r8a7792: Add RWDT node
> 01ec04dec8eb ARM: dts: r8a7793: Add RWDT node
> 8e6ebe4f2f94 ARM: dts: lager: Enable watchdog support
> f223ad0198f6 ARM: dts: koelsch: Enable watchdog support
> 1d14d2bb700d ARM: dts: porter: Enable watchdog support
> bf71652fc955 ARM: dts: blanche: Enable watchdog support
> 13a0b10aeea4 ARM: dts: wheat: Enable watchdog support
> 4e247bf110b8 ARM: dts: gose: Enable watchdog support
> 2dcbd24bbf5e ARM: dts: alt: Enable watchdog support
> 7f6844c900b4 ARM: dts: silk: Enable watchdog support
>
> And applied:
>
> [v5] ARM: shmobile: rcar-gen2: Add watchdog support
> [v5] ARM: shmobile: Add watchdog support
>
> In the case of the last patch above I removed the #ifdef from the header file.

I guess the time is ripe to apply the DTS patches again, in the following order:
  1. SMP routine size adjustments,
  2. Watchdog support additions to dtsi,
  3. Watchdog enablement for dts?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
