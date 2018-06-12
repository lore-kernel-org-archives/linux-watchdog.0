Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Tue, 12 Jun 2018 15:40:35 -0600
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Add support for the
 R8A77990 wdt
Message-ID: <20180612214035.GA24451@rob-hp-laptop>
References: <1528219113-29014-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528219113-29014-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Jun 05, 2018 at 07:18:33PM +0200, Geert Uytterhoeven wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> 
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car E3 (R8A77990) SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index f24d802b8056f6c6..5d47a262474cfe0e 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -16,6 +16,7 @@ Required properties:
>  	         - "renesas,r8a7796-wdt" (R-Car M3-W)
>  		 - "renesas,r8a77965-wdt" (R-Car M3-N)
>  	         - "renesas,r8a77970-wdt" (R-Car V3M)
> +	         - "renesas,r8a77990-wdt" (R-Car E3)
>  	         - "renesas,r8a77995-wdt" (R-Car D3)
>  	         - "renesas,r7s72100-wdt" (RZ/A1)
>  		The generic compatible string must be:
> -- 
> 2.7.4
> 
