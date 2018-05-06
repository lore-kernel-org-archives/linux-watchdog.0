Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36850 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeEFF7G (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 6 May 2018 01:59:06 -0400
Date: Sat, 5 May 2018 22:59:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [v2] watchdog: renesas-wdt: Add support for the R8A77965 WDT
Message-ID: <20180506055902.GA3711@roeck-us.net>
References: <20180414101858.3208-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180414101858.3208-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Apr 14, 2018 at 12:18:58PM +0200, Wolfram Sang wrote:
> Document support for the Watchdog Timer (WDT) Controller in the Renesas
> R-Car M3-N (R8A77965) SoC. No driver update is needed.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [wsa: rebased to top-of-tree]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Vaishali Thakkar <vthakkar@vaishalithakkar.in>

Unfortunately this patch isn't based on anything recognized by git,
and even though it is simple I can't get it to apply. Can someone please
rebase it to mainline and resend ?

Thanks,
Guenter

> ---
> 
> Change since v1: s/M3N/M3-N/ (Thanks, Geert!)
> 
>  Documentation/devicetree/bindings/watchdog/renesas-wdt.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> index 123bb1b2654b..613d860f2353 100644
> --- a/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
> @@ -15,6 +15,7 @@ Required properties:
>  		 - "renesas,r8a7794-wdt" (R-Car E2)
>  		 - "renesas,r8a7795-wdt" (R-Car H3)
>  		 - "renesas,r8a7796-wdt" (R-Car M3-W)
> +		 - "renesas,r8a77965-wdt" (R-Car M3-N)
>  		 - "renesas,r8a77970-wdt" (R-Car V3M)
>  		 - "renesas,r8a77995-wdt" (R-Car D3)
>  	       The generic compatible string must be:
