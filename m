Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53776 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbcHRTZF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Aug 2016 15:25:05 -0400
Date: Thu, 18 Aug 2016 11:58:36 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Mark Brown <broonie@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>, linux-clk@vger.kernel.org,
	linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: txx9wdt: Add missing clock (un)prepare
 calls for CCF
Message-ID: <20160818185836.GA7221@roeck-us.net>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 18, 2016 at 07:34:26PM +0200, Geert Uytterhoeven wrote:
> While the custom minimal TXx9 clock implementation doesn't need or use
> clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
> they are mandatory when using the Common Clock Framework.
> 
> Hence add them, to prepare for the advent of CCF.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Tested on RBTX4927.
> ---
>  drivers/watchdog/txx9wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
> index c2da880292bc2f32..6f7a9deb27d05d25 100644
> --- a/drivers/watchdog/txx9wdt.c
> +++ b/drivers/watchdog/txx9wdt.c
> @@ -112,7 +112,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
>  		txx9_imclk = NULL;
>  		goto exit;
>  	}
> -	ret = clk_enable(txx9_imclk);
> +	ret = clk_prepare_enable(txx9_imclk);
>  	if (ret) {
>  		clk_put(txx9_imclk);
>  		txx9_imclk = NULL;
> @@ -144,7 +144,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
>  	return 0;
>  exit:
>  	if (txx9_imclk) {
> -		clk_disable(txx9_imclk);
> +		clk_disable_unprepare(txx9_imclk);
>  		clk_put(txx9_imclk);
>  	}
>  	return ret;
> @@ -153,7 +153,7 @@ exit:
>  static int __exit txx9wdt_remove(struct platform_device *dev)
>  {
>  	watchdog_unregister_device(&txx9wdt);
> -	clk_disable(txx9_imclk);
> +	clk_disable_unprepare(txx9_imclk);
>  	clk_put(txx9_imclk);
>  	return 0;
>  }
> -- 
> 1.9.1
> 
