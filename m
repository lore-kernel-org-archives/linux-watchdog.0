Return-Path: <horms@verge.net.au>
Return-path: <horms@verge.net.au>
Date: Wed, 7 Nov 2018 11:09:30 +0100
From: Simon Horman <horms@verge.net.au>
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: renesas_wdt: Fix typos
Message-ID: <20181107100930.l4opb3k43yqe7ayt@verge.net.au>
References: <1541415227-4991-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541415227-4991-1-git-send-email-fabrizio.castro@bp.renesas.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Nov 05, 2018 at 10:53:47AM +0000, Fabrizio Castro wrote:
> Do not use "," but ";" to separate instructions.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> ---
> v1->v2:
> * Added changelog as suggested by Guenter Roeck

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> 
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
