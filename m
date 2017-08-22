Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Mon, 21 Aug 2017 21:17:10 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Add support for the
 r8a77995 wdt
Message-ID: <20170822021710.brn3h5mzzj5l5sla@rob-hp-laptop>
References: <1502968465-7809-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1502968465-7809-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Aug 17, 2017 at 01:14:25PM +0200, Geert Uytterhoeven wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car D3 (r8a77995) SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
