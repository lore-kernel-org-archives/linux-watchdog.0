Return-path: <horms@verge.net.au>
Date: Tue, 28 Jun 2016 07:06:33 +0200
From: Simon Horman <horms@verge.net.au>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: r8a7796: Add watchdog support
Message-ID: <20160628050632.GA10154@verge.net.au>
References: <1467049847-7469-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1467049847-7469-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Jun 27, 2016 at 07:50:44PM +0200, Geert Uytterhoeven wrote:
> 	Hi Wim, Günter, Simon, Magnus,
> 
> This patch series adds support for the Watchdog Timer (WDT) Controller
> in the Renesas R-Car M3-W (r8a7796) SoC.
>         
>   - The first patch updates the DT binding documentation for the Renesas
>     WDT driver, and should go in through the watchdog tree.
>   - The remaining patches update the DTS for the r8a7796 SoC and
>     Salvator-X development board, and should go in through the renesas
>     tree. This can happen as soon as the DT binding update has been
>     accepted.

As the binding update seems minor and unlikely to be rejected
I have taken the liberty of queueing up the DTS patches now.

> 
> To use the watchdog, there is a runtime dependency on "[PATCH 0/2] clk:
> renesas: r8a7796: Add watchdog clocks".
> 
> This has been tested on r8a7796/Salvator-X.
> 
> Thanks!
> 
> Geert Uytterhoeven (3):
>   watchdog: renesas-wdt: Add support for the r8a7796 wdt
>   arm64: dts: r8a7796: Add RWDT node
>   arm64: dts: r8a7796/salvator-x: Enable watchdog timer
> 
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 6 +++++-
>  arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts         | 5 +++++
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi                   | 9 +++++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
