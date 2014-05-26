Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:56477 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751200AbaEZTBI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 26 May 2014 15:01:08 -0400
Date: Mon, 26 May 2014 21:01:06 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: shwdt: Remove unused platform_set_drvdata()
Message-ID: <20140526190106.GB21481@spo001.leaseweb.com>
References: <1396088940-9224-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1396088940-9224-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> This patch removes platform_set_drvdata() which is not used in
> the driver.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/watchdog/shwdt.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index d04d02b..061756e 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -282,8 +282,6 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  	wdt->timer.data		= (unsigned long)wdt;
>  	wdt->timer.expires	= next_ping_period(clock_division_ratio);
>  
> -	platform_set_drvdata(pdev, wdt);
> -
>  	dev_info(&pdev->dev, "initialized.\n");
>  
>  	pm_runtime_enable(&pdev->dev);

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

