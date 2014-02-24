Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59357 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753690AbaBXUAu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 15:00:50 -0500
Date: Mon, 24 Feb 2014 21:00:50 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: wdt285: Fix variable type
Message-ID: <20140224200050.GM20712@spo001.leaseweb.com>
References: <1392456205-30121-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456205-30121-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> Variable "new_margin" is checked in the function watchdog_ioctl()
> to be positive, so change its type to "int".
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/watchdog/wdt285.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
> index 7355ddd0..ebbb183 100644
> --- a/drivers/watchdog/wdt285.c
> +++ b/drivers/watchdog/wdt285.c
> @@ -139,9 +139,8 @@ static const struct watchdog_info ident = {
>  static long watchdog_ioctl(struct file *file, unsigned int cmd,
>  			   unsigned long arg)
>  {
> -	unsigned int new_margin;
>  	int __user *int_arg = (int __user *)arg;
> -	int ret = -ENOTTY;
> +	int new_margin, ret = -ENOTTY;
>  
>  	switch (cmd) {
>  	case WDIOC_GETSUPPORT:
> -- 
> 1.8.3.2
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

