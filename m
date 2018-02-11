Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44335 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeBKRqj (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Feb 2018 12:46:39 -0500
Date: Sun, 11 Feb 2018 09:46:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [v2] watchdog: asm9260_wdt: fix error handling in
 asm9260_wdt_probe()
Message-ID: <20180211174637.GA19546@roeck-us.net>
References: <1518257847-28796-1-git-send-email-khoroshilov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518257847-28796-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 10, 2018 at 01:17:27PM +0300, Alexey Khoroshilov wrote:
> If devm_reset_control_get_exclusive() fails, asm9260_wdt_probe()
> returns immediately. But clks has been already enabled at that point,
> so it is required to disable them or to move the code around.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: Move the code around instead of disabling clks as Guenter Roeck suggested.
> 
>  drivers/watchdog/asm9260_wdt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
> index 7dd0da644a7f..2cf56b459d84 100644
> --- a/drivers/watchdog/asm9260_wdt.c
> +++ b/drivers/watchdog/asm9260_wdt.c
> @@ -292,14 +292,14 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->iobase))
>  		return PTR_ERR(priv->iobase);
>  
> -	ret = asm9260_wdt_get_dt_clks(priv);
> -	if (ret)
> -		return ret;
> -
>  	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
>  	if (IS_ERR(priv->rst))
>  		return PTR_ERR(priv->rst);
>  
> +	ret = asm9260_wdt_get_dt_clks(priv);
> +	if (ret)
> +		return ret;
> +
>  	wdd = &priv->wdd;
>  	wdd->info = &asm9260_wdt_ident;
>  	wdd->ops = &asm9260_wdt_ops;
