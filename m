Return-Path: <geert.uytterhoeven@gmail.com>
Return-path: <geert.uytterhoeven@gmail.com>
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1516903391-30467-22-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1516903391-30467-1-git-send-email-fabrizio.castro@bp.renesas.com> <1516903391-30467-22-git-send-email-fabrizio.castro@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Jan 2018 11:10:28 +0100
Message-ID: <CAMuHMdVn-XbsT1PQpcxKNHJ3ErecZtHy9=oJAGKd+heGLpLgcg@mail.gmail.com>
Subject: Re: [RFC 21/37] dt-bindings: watchdog: renesas-wdt: Add R-Car Gen2 support
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Wim Van Sebroeck <wim@iguana.be>,
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-clk <linux-clk@vger.kernel.org>, Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-watchdog@vger.kernel.org>

Hi Fabrizio,

On Thu, Jan 25, 2018 at 7:02 PM, Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> This commit documents the compatibility with R-Car Gen2 and RZ/G
> devices by defining the generifc compatible string "renesas,rcar-gen2-wdt".

generic

+ SoC-specific compatible values.

> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index bf6d1ca..436dca5 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -1,17 +1,20 @@
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

I guess you wanted to add r8a779[0-4], too, as you use (some of) them in
later patches in this series?

>                  - "renesas,r8a7795-wdt" (R-Car H3)
>                  - "renesas,r8a7796-wdt" (R-Car M3-W)
>                  - "renesas,r8a77995-wdt" (R-Car D3)
>                  - "renesas,r7s72100-wdt" (RZ/A1)
> +               The generic compatible string must be:
> +                - "renesas,rcar-gen2-wdt" for R-Car Gen2 and RZ/G
> +                - "renesas,rcar-gen3-wdt" for R-Car Gen3
>
> -  When compatible with the generic version, nodes must list the SoC-specific
> -  version corresponding to the platform first, followed by the generic
> -  version.
>
>  - reg : Should contain WDT registers location and length
>  - clocks : the clock feeding the watchdog timer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
