Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from nm17.access.bullet.mail.sp2.yahoo.com ([98.139.44.144]:23152
	"EHLO nm17.access.bullet.mail.sp2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757190Ab3D2SHz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 14:07:55 -0400
Date: Mon, 29 Apr 2013 11:07:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RESEND 6/7] watchdog: riowd: use devm_kzalloc()
Message-ID: <20130429180755.GF5183@roeck-us.net>
References: <001001ce44bc$faf2ce40$f0d86ac0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001001ce44bc$faf2ce40$f0d86ac0$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Apr 29, 2013 at 06:36:09PM +0900, Jingoo Han wrote:
> Use devm_kzalloc() to make cleanup paths simpler.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/watchdog/riowd.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
> index 0040451..13363ad 100644
> --- a/drivers/watchdog/riowd.c
> +++ b/drivers/watchdog/riowd.c
> @@ -183,7 +183,7 @@ static int riowd_probe(struct platform_device *op)
>  		goto out;
>  
>  	err = -ENOMEM;
> -	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	p = devm_kzalloc(&op->dev, sizeof(*p), GFP_KERNEL);
>  	if (!p)
>  		goto out;
>  
That goto is really unnecessary. Just return -ENOMEM and drop the label.
Though that is really another logical change and should be done separately,
so

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> @@ -192,7 +192,7 @@ static int riowd_probe(struct platform_device *op)
>  	p->regs = of_ioremap(&op->resource[0], 0, 2, DRIVER_NAME);
>  	if (!p->regs) {
>  		pr_err("Cannot map registers\n");
> -		goto out_free;
> +		goto out;
>  	}
>  	/* Make miscdev useable right away */
>  	riowd_device = p;
> @@ -213,9 +213,6 @@ out_iounmap:
>  	riowd_device = NULL;
>  	of_iounmap(&op->resource[0], p->regs, 2);
>  
> -out_free:
> -	kfree(p);
> -
>  out:
>  	return err;
>  }
> @@ -226,7 +223,6 @@ static int riowd_remove(struct platform_device *op)
>  
>  	misc_deregister(&riowd_miscdev);
>  	of_iounmap(&op->resource[0], p->regs, 2);
> -	kfree(p);
>  
>  	return 0;
>  }
> -- 
> 1.7.2.5
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
