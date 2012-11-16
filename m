Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 18.mo3.mail-out.ovh.net ([87.98.172.162]:59116 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752069Ab2KPOPe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Nov 2012 09:15:34 -0500
Received: from mail617.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 62DD9FF8B35
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Nov 2012 15:01:50 +0100 (CET)
Date: Fri, 16 Nov 2012 14:49:01 +0100
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	nicolas.ferre@atmel.com, JM.Lin@atmel.com
Subject: Re: [PATCH 03/11] watchdog/at91sam9_wdt: change the wdt_read and
 wdt_write macro to the inline function
Message-ID: <20121116134901.GH4398@game.jcrosoft.org>
References: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
 <1352877369-19740-4-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1352877369-19740-4-git-send-email-wenyou.yang@atmel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 15:16 Wed 14 Nov     , Wenyou Yang wrote:
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
>  drivers/watchdog/at91sam9_wdt.c |   28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 31c914a..98e7d5a 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -34,11 +34,6 @@
>  
>  #define DRV_NAME "AT91SAM9 Watchdog"
>  
> -#define wdt_read(field) \
> -	__raw_readl(at91wdt_private.base + field)
> -#define wdt_write(field, val) \
> -	__raw_writel((val), at91wdt_private.base + field)
> -
>  /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
>   * use this to convert a watchdog
>   * value from/to milliseconds.
> @@ -75,13 +70,24 @@ struct at91wdt_drvdata {
>  
>  /* ......................................................................... */
>  
> +static inline unsigned int wdt_read(struct at91wdt_drvdata *driver_data,
> +					unsigned int field)
> +{
> +	return __raw_readl(driver_data->base + field);
> +}
> +
> +static inline void wdt_write(struct at91wdt_drvdata *driver_data,
> +				unsigned int field, unsigned int val)
> +{
> +	__raw_writel((val), driver_data->base + field);
> +}
use relaxed version

Best Regrds,
J.
