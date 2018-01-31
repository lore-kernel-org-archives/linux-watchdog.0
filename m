Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:46079 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeAaIqb (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Jan 2018 03:46:31 -0500
MIME-Version: 1.0
In-Reply-To: <1517343778-27902-11-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1517343778-27902-1-git-send-email-fabrizio.castro@bp.renesas.com> <1517343778-27902-11-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 31 Jan 2018 09:46:30 +0100
Message-ID: <CAMuHMdXkHF9R0XfcG++s0RRup+Mdtam5p=FXw26z86wAOJhZfQ@mail.gmail.com>
Subject: Re: [RFC v3 10/25] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
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
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Fabrizio,

On Tue, Jan 30, 2018 at 9:22 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This commit documents the compatibility with R-Car Gen2 and RZ/G
> devices by defining the generic compatible string "renesas,rcar-gen2-wdt".
> Also, this patch expands the list of SoC-specific compatible strings to
> include RZ/G and R-Car Gen2 devices.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

Thanks for your patch!

> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -1,17 +1,25 @@
>  Renesas Watchdog Timer (WDT) Controller
>
>  Required properties:
> -- compatible : Should be "renesas,<soctype>-wdt", and
> -              "renesas,rcar-gen3-wdt" or "renesas,rza-wdt" as fallback.
> + - compatible : Must be "renesas,<soctype>-wdt", followed by a generic
> +               fallback compatible string when compatible with the generic
> +               version.
>                Examples with soctypes are:
> +                - "renesas,r8a7743-wdt" (RZ/G1M)
> +                - "renesas,r8a7745-wdt" (RZ/G1E)
> +                - "renesas,r8a7790-wdt" (R-Car H2)
> +                - "renesas,r8a7791-wdt" (R-Car M2-W)
> +                - "renesas,r8a7792-wdt" (R-Car V2H)
> +                - "renesas,r8a7793-wdt" (R-Car M2-N)
> +                - "renesas,r8a7794-wdt" (R-Car E2)
>                  - "renesas,r8a7795-wdt" (R-Car H3)
>                  - "renesas,r8a7796-wdt" (R-Car M3-W)
>                  - "renesas,r8a77995-wdt" (R-Car D3)
>                  - "renesas,r7s72100-wdt" (RZ/A1)
> +               The generic compatible string must be:
> +                - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
> +                - "renesas,rcar-gen3-wdt" for R-Car Gen3

You've lost the generic "renesas,rza-wdt".

With that fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
