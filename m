Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56815 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbbCZP3h (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Mar 2015 11:29:37 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Yb9iy-000jXy-3l
	for linux-watchdog@vger.kernel.org; Thu, 26 Mar 2015 15:29:36 +0000
Date: Thu, 26 Mar 2015 08:29:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Andrew Victor <linux@maxim.org.za>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] watchdog: at91sam9: use endian agnostic IO
Message-ID: <20150326152910.GA1115@roeck-us.net>
References: <1427380454-2002-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427380454-2002-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Mar 26, 2015 at 02:34:14PM +0000, Ben Dooks wrote:
> Use endian agnostic IO functions for the watchdog driver for when it
> is enabled on ATSAMA5D36 devices running in big endian.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> CC: Boris Brezillon <boris.brezillon@free-electrons.com>
> CC: Guenter Roeck <linux@roeck-us.net>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Wim Van Sebroeck <wim@iguana.be>
> CC: linux-watchdog@vger.kernel.org
> CC: Andrew Victor <linux@maxim.org.za>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> ---
>  drivers/watchdog/at91sam9_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index 1443b3c..e4698f7 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -40,9 +40,9 @@
>  #define DRV_NAME "AT91SAM9 Watchdog"
>  
>  #define wdt_read(wdt, field) \
> -	__raw_readl((wdt)->base + (field))
> +	readl_relaxed((wdt)->base + (field))
>  #define wdt_write(wtd, field, val) \
> -	__raw_writel((val), (wdt)->base + (field))
> +	writel_relaxed((val), (wdt)->base + (field))
>  
>  /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
>   * use this to convert a watchdog
> -- 
> 2.1.4
> 
