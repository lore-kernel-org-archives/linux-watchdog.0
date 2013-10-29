Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 08:45:09 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ts72xx_wdt: Propagate return value from timeout_to_regval
Message-ID: <20131029074509.GB19704@spo001.leaseweb.com>
References: <1381768368-25062-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381768368-25062-1-git-send-email-linux@roeck-us.net>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

> timeout_to_regval() returns a valid error code. Might as well use it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/ts72xx_wdt.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> index 42913f1..a4f3ce5 100644
> --- a/drivers/watchdog/ts72xx_wdt.c
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -192,7 +192,7 @@ static int ts72xx_wdt_open(struct inode *inode, struct file *file)
>  		dev_err(&wdt->pdev->dev,
>  			"failed to convert timeout (%d) to register value\n",
>  			timeout);
> -		return -EINVAL;
> +		return regval;
>  	}
>  
>  	if (mutex_lock_interruptible(&wdt->lock))

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
