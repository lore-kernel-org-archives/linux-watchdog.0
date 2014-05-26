Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56482 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751128AbaEZTDg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 15:03:36 -0400
Date: Mon, 26 May 2014 21:03:34 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Gabor Juhos <juhosg@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: switch to clk_prepare/clk_disable
Message-ID: <20140526190334.GB21584@spo001.leaseweb.com>
References: <1397640950-21859-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1397640950-21859-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Gabor,

> Replace clk_enable() and clk_disable() calls with
> clk_prepare_enable() and clk_disable_unprepare()
> to get ready for the migration to the common clock
> framework.
> 
> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> ---
>  drivers/watchdog/ath79_wdt.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
> index 0e67d96..41ac466 100644
> --- a/drivers/watchdog/ath79_wdt.c
> +++ b/drivers/watchdog/ath79_wdt.c
> @@ -265,7 +265,7 @@ static int ath79_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(wdt_clk))
>  		return PTR_ERR(wdt_clk);
>  
> -	err = clk_enable(wdt_clk);
> +	err = clk_prepare_enable(wdt_clk);
>  	if (err)
>  		return err;
>  
> @@ -296,14 +296,14 @@ static int ath79_wdt_probe(struct platform_device *pdev)
>  	return 0;
>  
>  err_clk_disable:
> -	clk_disable(wdt_clk);
> +	clk_disable_unprepare(wdt_clk);
>  	return err;
>  }
>  
>  static int ath79_wdt_remove(struct platform_device *pdev)
>  {
>  	misc_deregister(&ath79_wdt_miscdev);
> -	clk_disable(wdt_clk);
> +	clk_disable_unprepare(wdt_clk);
>  	return 0;
>  }
>  

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

