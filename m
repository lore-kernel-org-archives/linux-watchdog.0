Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59347 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753449AbaBXT5H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:57:07 -0500
Date: Mon, 24 Feb 2014 20:57:06 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: bcm63xx_wdt: Remove unused field from bcm63xx_wdt_device
Message-ID: <20140224195706.GH20712@spo001.leaseweb.com>
References: <1392456063-29918-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456063-29918-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> Field "default_ticks" is not used anywhere in the driver code.
> This patch removes this field.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/watchdog/bcm63xx_wdt.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
> index 4eb188b..d055e3c 100644
> --- a/drivers/watchdog/bcm63xx_wdt.c
> +++ b/drivers/watchdog/bcm63xx_wdt.c
> @@ -45,7 +45,6 @@
>  static struct {
>  	void __iomem *regs;
>  	struct timer_list timer;
> -	int default_ticks;
>  	unsigned long inuse;
>  	atomic_t ticks;
>  } bcm63xx_wdt_device;
> -- 
> 1.8.3.2
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

