Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34611 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbcFAVnd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 1 Jun 2016 17:43:33 -0400
Date: Wed, 1 Jun 2016 14:43:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: fu.wei@linaro.org
Cc: wim@iguana.be, panand@redhat.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	timur@codeaurora.org, dyoung@redhat.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, Suravee.Suthikulpanit@amd.com
Subject: Re: [PATCH 3/3] sbsa_gwdt: Set WDOG_HW_RUNNING, when watchdog is
 already running.
Message-ID: <20160601214330.GC2841@roeck-us.net>
References: <1464674890-10512-1-git-send-email-fu.wei@linaro.org>
 <1464674890-10512-4-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1464674890-10512-4-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, May 31, 2016 at 02:08:10PM +0800, fu.wei@linaro.org wrote:
> From: Pratyush Anand <panand@redhat.com>
> 
> This patch uses the new flag WDOG_HW_RUNNING in driver.
> According to the definition of this flag, it should be set,
> if watchdog is running after booting, before it's opened.
> 
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> Signed-off-by: Fu Wei <fu.wei@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sbsa_gwdt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 6af71e0..cc885f1 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -283,6 +283,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
>  		dev_warn(dev, "System reset by WDT.\n");
>  		wdd->bootstatus |= WDIOF_CARDRESET;
>  	}
> +	if (status & SBSA_GWDT_WCS_EN)
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
>  
>  	if (action) {
>  		irq = platform_get_irq(pdev, 0);
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
