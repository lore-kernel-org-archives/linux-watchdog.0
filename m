Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm4.access.bullet.mail.mud.yahoo.com ([66.94.237.205]:38218
	"EHLO nm4.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752133Ab3D2SCg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 14:02:36 -0400
Date: Mon, 29 Apr 2013 11:02:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 4/7] watchdog: nuc900_wdt: use devm_*() functions
Message-ID: <20130429180235.GD5183@roeck-us.net>
References: <000e01ce44bc$e5d1dec0$b1759c40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01ce44bc$e5d1dec0$b1759c40$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:35:33PM +0900, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/nuc900_wdt.c |   45 ++++++++--------------------------------
>  1 files changed, 9 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
> index 04c45a1..89e8991 100644
> --- a/drivers/watchdog/nuc900_wdt.c
> +++ b/drivers/watchdog/nuc900_wdt.c
> @@ -246,7 +246,8 @@ static int nuc900wdt_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
>  
> -	nuc900_wdt = kzalloc(sizeof(struct nuc900_wdt), GFP_KERNEL);
> +	nuc900_wdt = devm_kzalloc(&pdev->dev, sizeof(struct nuc900_wdt),
> +				GFP_KERNEL);

General hint: sizeof(*nuc900_wdt) is preferred by most maintainers.

>  	if (!nuc900_wdt)
>  		return -ENOMEM;
>  
> @@ -257,30 +258,18 @@ static int nuc900wdt_probe(struct platform_device *pdev)
>  	nuc900_wdt->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (nuc900_wdt->res == NULL) {

It is no longer necessary to save the resource in nuc900_wdt, as it is only
used in the probe function. So you might as well drop the variable from the
structure and declare it locally.

>  		dev_err(&pdev->dev, "no memory resource specified\n");
> -		ret = -ENOENT;
> -		goto err_get;
> +		return -ENOENT;
>  	}
>  
> -	if (!request_mem_region(nuc900_wdt->res->start,
> -				resource_size(nuc900_wdt->res), pdev->name)) {
> -		dev_err(&pdev->dev, "failed to get memory region\n");
> -		ret = -ENOENT;
> -		goto err_get;
> -	}
> -
> -	nuc900_wdt->wdt_base = ioremap(nuc900_wdt->res->start,
> -					resource_size(nuc900_wdt->res));
> -	if (nuc900_wdt->wdt_base == NULL) {
> -		dev_err(&pdev->dev, "failed to ioremap() region\n");
> -		ret = -EINVAL;
> -		goto err_req;
> -	}
> +	nuc900_wdt->wdt_base = devm_ioremap_resource(&pdev->dev,
> +						nuc900_wdt->res);
> +	if (IS_ERR(nuc900_wdt->wdt_base))
> +		return PTR_ERR(nuc900_wdt->wdt_base);
>  
Does devm_ioremap_resource() spit out an error if it fails ?
If not, you might want to add an error message for consistency
with the other messages.

Thanks,
Guenter
