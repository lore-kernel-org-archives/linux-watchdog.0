Return-Path: <robherring2@gmail.com>
Return-path: <robherring2@gmail.com>
Date: Wed, 1 Nov 2017 16:46:30 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: renesas-wdt: Add support for the
 r8a77970 wdt
Message-ID: <20171101214630.cspdffzbutcqdyy3@rob-hp-laptop>
References: <1509378199-19388-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509378199-19388-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Oct 30, 2017 at 04:43:19PM +0100, Geert Uytterhoeven wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car V3M (r8a77970) SoC.  Restore sort order while at it.
> 
> No driver update is needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
