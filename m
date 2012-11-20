Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15401 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751883Ab2KTM7k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Nov 2012 07:59:40 -0500
Date: Tue, 20 Nov 2012 07:59:16 -0500
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
Subject: Re: [PATCH v5 7/8] watchdog: orion_wdt: move the min_timeout
 initialization
Message-ID: <20121120125916.GV22106@titan.lakedaemon.net>
References: <1353334243-16703-1-git-send-email-fabio.porcedda@gmail.com>
 <1353334243-16703-8-git-send-email-fabio.porcedda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353334243-16703-8-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 19, 2012 at 03:10:42PM +0100, Fabio Porcedda wrote:
> Move the min_timeout initialization inside the orion_wdt definition.
> 
> Only compile tested.
> 
> Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.

> ---
>  drivers/watchdog/orion_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 446a3e9..3b4e228 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -140,6 +140,7 @@ static const struct watchdog_ops orion_wdt_ops = {
>  static struct watchdog_device orion_wdt = {
>  	.info = &orion_wdt_info,
>  	.ops = &orion_wdt_ops,
> +	.min_timeout = 1,
>  };
>  
>  static int __devinit orion_wdt_probe(struct platform_device *pdev)
> @@ -162,7 +163,6 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
>  
>  	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
>  
> -	orion_wdt.min_timeout = 1;
>  	orion_wdt.timeout = wdt_max_duration;
>  	orion_wdt.max_timeout = wdt_max_duration;
>  	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
> -- 
> 1.8.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
