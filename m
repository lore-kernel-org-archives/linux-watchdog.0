Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36158 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeGPN6n (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 16 Jul 2018 09:58:43 -0400
Subject: Re: watchdog: davinci_wdt: add possibility to configure watchdog
 period
To: michele.dionisio@gmail.com, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michele Dionisio <michele.dionisio@powersoft.com>
References: <20180716121909.4869-1-michele.dionisio@gmail.com>
 <20180716121909.4869-2-michele.dionisio@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6803158b-27b2-63ae-1720-72d9da78df1f@roeck-us.net>
Date: Mon, 16 Jul 2018 06:31:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180716121909.4869-2-michele.dionisio@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/16/2018 05:19 AM, michele.dionisio@gmail.com wrote:
> From: Michele Dionisio <michele.dionisio@powersoft.com>
> 
> It is not possible to implement setting of watchdog period because it is
> not possible to stop watchdog so it is nice to have possibility to
> configure watchdog period at module loading.
> 
> Signed-off-by: Michele Dionisio <michele.dionisio@gmail.com>
> 
> diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
> index 6c6594261cb7..5f95afa20fee 100644
> --- a/drivers/watchdog/davinci_wdt.c
> +++ b/drivers/watchdog/davinci_wdt.c
> @@ -54,6 +54,10 @@
>   #define WDKEY_SEQ0		(0xa5c6 << 16)
>   #define WDKEY_SEQ1		(0xda7e << 16)
>   
> +static unsigned int init_timeout;
> +module_param(init_timeout, uint, 0);
> +MODULE_PARM_DESC(init_timeout, "initial watchdog timeout (in seconds)");
> +
>   static int heartbeat;
>   
>   /*
> @@ -223,8 +227,10 @@ static int davinci_wdt_probe(struct platform_device *pdev)
>   	wdd->ops		= &davinci_wdt_ops;
>   	wdd->min_timeout	= 1;
>   	wdd->max_timeout	= MAX_HEARTBEAT;
> -	wdd->timeout		= DEFAULT_HEARTBEAT;
> -	wdd->parent		= &pdev->dev;
> +	if ((init_timeout >= 1) && (init_timeout <= MAX_HEARTBEAT))
> +		wdd->timeout = init_timeout;
> +	else
> +		wdd->timeout = DEFAULT_HEARTBEAT;
>   
>   	watchdog_init_timeout(wdd, heartbeat, dev);
>   

NACK. This is done with the 'heartbeat' module parameter already.

Guenter


