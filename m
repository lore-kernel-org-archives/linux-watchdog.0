Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20350 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753526Ab2KTAZI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Nov 2012 19:25:08 -0500
Date: Mon, 19 Nov 2012 11:06:43 -0500
From: Jason Cooper <jason@lakedaemon.net>
To: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH v5 3/8] watchdog: orion_wdt: add timeout-sec property
 binding
Message-ID: <20121119160643.GI22106@titan.lakedaemon.net>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
 <1353334243-16703-4-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353334243-16703-4-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 19, 2012 at 03:10:38PM +0100, Fabio Porcedda wrote:
> Only compile tested.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> ---
>  Documentation/devicetree/bindings/watchdog/marvel.txt | 5 +++++
>  drivers/watchdog/orion_wdt.c                          | 8 +++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
> index 0b2503a..5dc8d30 100644
> --- a/Documentation/devicetree/bindings/watchdog/marvel.txt
> +++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
> @@ -5,10 +5,15 @@ Required Properties:
>  - Compatibility : "marvell,orion-wdt"
>  - reg		: Address of the timer registers
>  
> +Optional properties:
> +
> +- timeout-sec	: Contains the watchdog timeout in seconds
> +
>  Example:
>  
>  	wdt@20300 {
>  		compatible = "marvell,orion-wdt";
>  		reg = <0x20300 0x28>;
> +		timeout-sec = <10>;
>  		status = "okay";
>  	};
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index c20f96b..446a3e9 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -162,12 +162,10 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
>  
>  	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
>  
> -	if ((heartbeat < 1) || (heartbeat > wdt_max_duration))
> -		heartbeat = wdt_max_duration;
> -
> -	orion_wdt.timeout = heartbeat;
>  	orion_wdt.min_timeout = 1;
> +	orion_wdt.timeout = wdt_max_duration;
>  	orion_wdt.max_timeout = wdt_max_duration;
> +	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);

Hi Fabio,

There are many boards using pdata, !CONFIG_OF.  Have you compile-tested
this without CONFIG_OF?

thx,

Jason.

>  
>  	watchdog_set_nowayout(&orion_wdt, nowayout);
>  	ret = watchdog_register_device(&orion_wdt);
> @@ -177,7 +175,7 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
>  	}
>  
>  	pr_info("Initial timeout %d sec%s\n",
> -		heartbeat, nowayout ? ", nowayout" : "");
> +		orion_wdt.timeout, nowayout ? ", nowayout" : "");
>  	return 0;
>  }
>  
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
