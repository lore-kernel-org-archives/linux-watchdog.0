Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm7-vm0.access.bullet.mail.sp2.yahoo.com ([98.139.44.116]:33053
	"EHLO nm7-vm0.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760013Ab3D3PFq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 30 Apr 2013 11:05:46 -0400
Date: Tue, 30 Apr 2013 08:05:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 7/7] watchdog: ts72xx_wdt: use devm_*() functions
Message-ID: <20130430150544.GA15491@roeck-us.net>
References: <001401ce455f$e7ba02a0$b72e07e0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401ce455f$e7ba02a0$b72e07e0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Apr 30, 2013 at 02:02:25PM +0900, Jingoo Han wrote:
> Use devm_*() functions to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> No changes since v1:
> 
Side note: If you make no changes, there is no need to send V2, especially not
one marked as another version. Usually, when I do that kind of thing, I just
resend.

This also applies if you get a Reviewed-by:, Acked-by:, or similar response.
You can leave it up to the maintainer to add those to the patch.

>  drivers/watchdog/ts72xx_wdt.c |   64 +++++++----------------------------------
>  1 files changed, 11 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> index b8a9245..b19ca75 100644
> --- a/drivers/watchdog/ts72xx_wdt.c
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -396,7 +396,7 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
>  	struct resource *r1, *r2;
>  	int error = 0;
>  
> -	wdt = kzalloc(sizeof(struct ts72xx_wdt), GFP_KERNEL);
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_wdt), GFP_KERNEL);
>  	if (!wdt) {
>  		dev_err(&pdev->dev, "failed to allocate memory\n");

My understanding from other conversations is that this error message is no
longer needed.

>  		return -ENOMEM;
> @@ -405,44 +405,22 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
>  	r1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (!r1) {
>  		dev_err(&pdev->dev, "failed to get memory resource\n");
> -		error = -ENODEV;
> -		goto fail;
> -	}
> -
> -	r1 = request_mem_region(r1->start, resource_size(r1), pdev->name);
> -	if (!r1) {
> -		dev_err(&pdev->dev, "cannot request memory region\n");
> -		error = -EBUSY;
> -		goto fail;
> +		return -ENODEV;
>  	}
>  
> -	wdt->control_reg = ioremap(r1->start, resource_size(r1));
> -	if (!wdt->control_reg) {
> -		dev_err(&pdev->dev, "failed to map memory\n");
> -		error = -ENODEV;
> -		goto fail_free_control;
> -	}
> +	wdt->control_reg = devm_ioremap_resource(&pdev->dev, r1);
> +	if (IS_ERR(wdt->control_reg))
> +		return PTR_ERR(wdt->control_reg);
>  
>  	r2 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>  	if (!r2) {
>  		dev_err(&pdev->dev, "failed to get memory resource\n");
> -		error = -ENODEV;
> -		goto fail_unmap_control;
> +		return -ENODEV;
>  	}
>  
> -	r2 = request_mem_region(r2->start, resource_size(r2), pdev->name);
> -	if (!r2) {
> -		dev_err(&pdev->dev, "cannot request memory region\n");
> -		error = -EBUSY;
> -		goto fail_unmap_control;
> -	}
> -
> -	wdt->feed_reg = ioremap(r2->start, resource_size(r2));
> -	if (!wdt->feed_reg) {
> -		dev_err(&pdev->dev, "failed to map memory\n");
> -		error = -ENODEV;
> -		goto fail_free_feed;
> -	}
> +	wdt->feed_reg = devm_ioremap_resource(&pdev->dev, r2);
> +	if (IS_ERR(wdt->feed_reg))
> +		return PTR_ERR(wdt->feed_reg);
>  
>  	platform_set_drvdata(pdev, wdt);
>  	ts72xx_wdt_pdev = pdev;
> @@ -455,45 +433,25 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
>  	error = misc_register(&ts72xx_wdt_miscdev);
>  	if (error) {
>  		dev_err(&pdev->dev, "failed to register miscdev\n");
> -		goto fail_unmap_feed;
> +		goto fail;
>  	}
>  
>  	dev_info(&pdev->dev, "TS-72xx Watchdog driver\n");
>  
>  	return 0;
>  
> -fail_unmap_feed:
> -	platform_set_drvdata(pdev, NULL);
> -	iounmap(wdt->feed_reg);
> -fail_free_feed:
> -	release_mem_region(r2->start, resource_size(r2));
> -fail_unmap_control:
> -	iounmap(wdt->control_reg);
> -fail_free_control:
> -	release_mem_region(r1->start, resource_size(r1));
>  fail:
> -	kfree(wdt);
> +	platform_set_drvdata(pdev, NULL);

	platform_set_drvdata(pdev, NULL);

is not needed. By eliminating it you could get rid of the entire error path.

>  	return error;
>  }
>  
>  static int ts72xx_wdt_remove(struct platform_device *pdev)
>  {
> -	struct ts72xx_wdt *wdt = platform_get_drvdata(pdev);
> -	struct resource *res;
>  	int error;
>  
>  	error = misc_deregister(&ts72xx_wdt_miscdev);
>  	platform_set_drvdata(pdev, NULL);
>  
> -	iounmap(wdt->feed_reg);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	release_mem_region(res->start, resource_size(res));
> -
> -	iounmap(wdt->control_reg);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	release_mem_region(res->start, resource_size(res));
> -
> -	kfree(wdt);
>  	return error;
>  }
>  
> -- 
> 1.7.2.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
