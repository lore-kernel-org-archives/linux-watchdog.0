Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64017 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932438Ab2CZOMi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 Mar 2012 10:12:38 -0400
Date: Mon, 26 Mar 2012 10:12:33 -0400
From: Jason Cooper <jason@lakedaemon.net>
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sylver Bruneau <sylver.bruneau@googlemail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFT v2] watchdog: Convert orion_wdt driver to watchdog
 core
Message-ID: <20120326141233.GR2484@titan.lakedaemon.net>
References: <1332761395.20711.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332761395.20711.1.camel@phoenix>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Mar 26, 2012 at 07:29:55PM +0800, Axel Lin wrote:
> Convert the orion_wdt driver to the watchdog framework API.
> 

Hi Axel, thanks for the patch.

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> v2: v1 does not apply to current tree. so I re-generate this patch.
>  drivers/watchdog/Kconfig     |    1 +
>  drivers/watchdog/orion_wdt.c |  198 ++++++++++--------------------------------
>  2 files changed, 48 insertions(+), 151 deletions(-)
> 
...
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 788aa15..8ba7d76 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
...
> @@ -31,7 +30,7 @@
>   * Watchdog timer block registers.
>   */
>  #define TIMER_CTRL		0x0000
> -#define  WDT_EN			0x0010
> +#define WDT_EN			0x0010

nit, whitespace change.

...
>  static int __devinit orion_wdt_probe(struct platform_device *pdev)
> @@ -241,26 +146,28 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	int ret;
>  
> -	if (pdata) {
> -		wdt_tclk = pdata->tclk;
> -	} else {
> +	if (!pdata) {
>  		pr_err("misses platform data\n");
>  		return -ENODEV;
>  	}

Platform data is changing soon with devicetree support (and converting
to common clock).  Please don't change this if you don't need to.

Also, I'll include Andrew Lunn in the CC.  He's doing the conversion of
orion over to common clock, which affects this driver.

hth,

Jason.
