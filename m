Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34570 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeKCFBx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 3 Nov 2018 01:01:53 -0400
Date: Fri, 2 Nov 2018 12:48:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] watchdog: renesas_wdt: Fix typos
Message-ID: <20181102194808.GA17913@roeck-us.net>
References: <1541186471-2998-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541186471-2998-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 02, 2018 at 07:21:11PM +0000, Fabrizio Castro wrote:

Do not use "," but ";" to separate instructions.

> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/renesas_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 0d74c3e..b570962 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -220,8 +220,8 @@ static int rwdt_probe(struct platform_device *pdev)
>  		goto out_pm_disable;
>  	}
>  
> -	priv->wdev.info = &rwdt_ident,
> -	priv->wdev.ops = &rwdt_ops,
> +	priv->wdev.info = &rwdt_ident;
> +	priv->wdev.ops = &rwdt_ops;
>  	priv->wdev.parent = &pdev->dev;
>  	priv->wdev.min_timeout = 1;
>  	priv->wdev.max_timeout = DIV_BY_CLKS_PER_SEC(priv, 65536);
> -- 
> 2.7.4
> 
