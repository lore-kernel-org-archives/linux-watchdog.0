Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52769 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbcGSOdQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 Jul 2016 10:33:16 -0400
Subject: Re: [PATCH -next] watchdog: core: Fix error handling of
 watchdog_dev_init()
To: Wei Yongjun <weiyj_lk@163.com>, Wim Van Sebroeck <wim@iguana.be>
References: <1468927354-32155-1-git-send-email-weiyj_lk@163.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578E3A2B.802@roeck-us.net>
Date: Tue, 19 Jul 2016 07:33:15 -0700
MIME-Version: 1.0
In-Reply-To: <1468927354-32155-1-git-send-email-weiyj_lk@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/19/2016 04:22 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Fix the error handling paths of watchdog_dev_init().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/watchdog_dev.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 14f8a92..f6e6751 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -952,17 +952,22 @@ int __init watchdog_dev_init(void)
>   	err = class_register(&watchdog_class);
>   	if (err < 0) {
>   		pr_err("couldn't register class\n");
> -		return err;
> +		goto err_register;
>   	}
>
>   	err = alloc_chrdev_region(&watchdog_devt, 0, MAX_DOGS, "watchdog");
>   	if (err < 0) {
>   		pr_err("watchdog: unable to allocate char dev region\n");
> -		class_unregister(&watchdog_class);
> -		return err;
> +		goto err_alloc;
>   	}
>
>   	return 0;
> +
> +err_alloc:
> +	class_unregister(&watchdog_class);
> +err_register:
> +	destroy_workqueue(watchdog_wq);
> +	return err;
>   }
>
>   /*
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

