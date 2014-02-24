Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59354 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753669AbaBXUAJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 15:00:09 -0500
Date: Mon, 24 Feb 2014 21:00:08 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: shwdt: Remove unused variable
Message-ID: <20140224200008.GL20712@spo001.leaseweb.com>
References: <1392456187-30082-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456187-30082-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> Variable "wdt" is not used anywhere in the function sh_wdt_remove().
> This patch removes this variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/watchdog/shwdt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index af3528f..d04d02b 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -293,8 +293,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  
>  static int sh_wdt_remove(struct platform_device *pdev)
>  {
> -	struct sh_wdt *wdt = platform_get_drvdata(pdev);
> -
>  	watchdog_unregister_device(&sh_wdt_dev);
>  
>  	pm_runtime_disable(&pdev->dev);
> -- 
> 1.8.3.2
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

