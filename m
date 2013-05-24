Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55936 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109Ab3EXO6B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 May 2013 10:58:01 -0400
Date: Fri, 24 May 2013 07:58:17 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Andrew Morton' <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/5] watchdog: cpwd: use platform_{get,set}_drvdata()
Message-ID: <20130524145817.GB6085@roeck-us.net>
References: <003401ce57a2$658fbb80$30af3280$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003401ce57a2$658fbb80$30af3280$@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, May 23, 2013 at 07:43:43PM +0900, Jingoo Han wrote:
> Use the wrapper functions for getting and setting the driver data using
> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
> so we can directly pass a struct platform_device.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/cpwd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> index 7038758..213225e 100644
> --- a/drivers/watchdog/cpwd.c
> +++ b/drivers/watchdog/cpwd.c
> @@ -621,7 +621,7 @@ static int cpwd_probe(struct platform_device *op)
>  			WD_BADMODEL);
>  	}
>  
> -	dev_set_drvdata(&op->dev, p);
> +	platform_set_drvdata(op, p);
>  	cpwd_device = p;
>  	err = 0;
>  
> @@ -642,7 +642,7 @@ out_free:
>  
>  static int cpwd_remove(struct platform_device *op)
>  {
> -	struct cpwd *p = dev_get_drvdata(&op->dev);
> +	struct cpwd *p = platform_get_drvdata(op);
>  	int i;
>  
>  	for (i = 0; i < WD_NUMDEVS; i++) {
> -- 
> 1.7.10.4
> 
> 
> 
