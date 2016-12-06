Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59908 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbcLFTE3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 6 Dec 2016 14:04:29 -0500
Date: Tue, 6 Dec 2016 11:03:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: akkushwaha9896@gmail.com
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: cpwd: remove memory allocate failure message
Message-ID: <20161206190352.GA24777@roeck-us.net>
References: <1481048388-4140-1-git-send-email-akkushwaha9896@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1481048388-4140-1-git-send-email-akkushwaha9896@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Dec 06, 2016 at 10:19:48AM -0800, akkushwaha9896@gmail.com wrote:
> From: Amit Kushwaha <akkushwaha9896@gmail.com>
> 
> Replaced goto with a return statement and dropped the kfree()
> calls because memory allocated with devm_kzalloc() is
> automatically freed on driver detach
> 
> Signed-off-by: Amit Kushwaha <akkushwaha9896@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in v2:
>   - replaced goto and kzalloc() as suggested.
> 
>  drivers/watchdog/cpwd.c |   23 +++++++----------------
>  1 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index 71ee079..3d43775 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -538,12 +538,9 @@ static int cpwd_probe(struct platform_device *op)
>  	if (cpwd_device)
>  		return -EINVAL;
>  
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> -	err = -ENOMEM;
> -	if (!p) {
> -		pr_err("Unable to allocate struct cpwd\n");
> -		goto out;
> -	}
> +	p = devm_kzalloc(&op->dev, sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
>  
>  	p->irq = op->archdata.irqs[0];
>  
> @@ -553,12 +550,12 @@ static int cpwd_probe(struct platform_device *op)
>  			     4 * WD_TIMER_REGSZ, DRIVER_NAME);
>  	if (!p->regs) {
>  		pr_err("Unable to map registers\n");
> -		goto out_free;
> +		return -ENOMEM;
>  	}
>  
>  	options = of_find_node_by_path("/options");
> -	err = -ENODEV;
>  	if (!options) {
> +		err = -ENODEV;
>  		pr_err("Unable to find /options node\n");
>  		goto out_iounmap;
>  	}
> @@ -620,10 +617,7 @@ static int cpwd_probe(struct platform_device *op)
>  
>  	platform_set_drvdata(op, p);
>  	cpwd_device = p;
> -	err = 0;
> -
> -out:
> -	return err;
> +	return 0;
>  
>  out_unregister:
>  	for (i--; i >= 0; i--)
> @@ -632,9 +626,7 @@ static int cpwd_probe(struct platform_device *op)
>  out_iounmap:
>  	of_iounmap(&op->resource[0], p->regs, 4 * WD_TIMER_REGSZ);
>  
> -out_free:
> -	kfree(p);
> -	goto out;
> +	return err;
>  }
>  
>  static int cpwd_remove(struct platform_device *op)
> @@ -659,7 +651,6 @@ static int cpwd_remove(struct platform_device *op)
>  		free_irq(p->irq, p);
>  
>  	of_iounmap(&op->resource[0], p->regs, 4 * WD_TIMER_REGSZ);
> -	kfree(p);
>  
>  	cpwd_device = NULL;
>  
> -- 
> 1.7.1
> 
