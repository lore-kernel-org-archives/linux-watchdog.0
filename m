Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34466 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcFAVnY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Jun 2016 17:43:24 -0400
Date: Wed, 1 Jun 2016 14:43:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: fu.wei@linaro.org
Cc: wim@iguana.be, panand@redhat.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	timur@codeaurora.org, dyoung@redhat.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, Suravee.Suthikulpanit@amd.com
Subject: Re: [PATCH 2/3] sbsa_gwdt: Use max_hw_heartbeat_ms instead of
 max_timeout
Message-ID: <20160601214305.GB2841@roeck-us.net>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
 <1464674890-10512-3-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464674890-10512-3-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 31, 2016 at 02:08:09PM +0800, fu.wei@linaro.org wrote:
> From: Pratyush Anand <panand@redhat.com>
> 
> Using max_hw_heartbeat_ms instead of max_timeout gives the flexibility to
> achieve higher user "timeout". Therefore, use this new infrastructure.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sbsa_gwdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index ad383f6..6af71e0 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -273,7 +273,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>  	wdd->info = &sbsa_gwdt_info;
>  	wdd->ops = &sbsa_gwdt_ops;
>  	wdd->min_timeout = 1;
> -	wdd->max_timeout = U32_MAX / gwdt->clk;
> +	wdd->max_hw_heartbeat_ms = U32_MAX / gwdt->clk * 1000;
>  	wdd->timeout = DEFAULT_TIMEOUT;
>  	watchdog_set_drvdata(wdd, gwdt);
>  	watchdog_set_nowayout(wdd, nowayout);
> @@ -310,7 +310,7 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>  	 * the timeout is (WOR * 2), so the maximum timeout should be doubled.
>  	 */
>  	if (!action)
> -		wdd->max_timeout *= 2;
> +		wdd->max_hw_heartbeat_ms *= 2;
>  
>  	watchdog_init_timeout(wdd, timeout, dev);
>  	/*
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
