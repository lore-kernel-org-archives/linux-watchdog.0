Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:36779 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753660AbaBORqL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 15 Feb 2014 12:46:11 -0500
Received: by mail-pb0-f41.google.com with SMTP id up15so13726559pbc.0
        for <linux-watchdog@vger.kernel.org>; Sat, 15 Feb 2014 09:46:11 -0800 (PST)
Date: Sat, 15 Feb 2014 09:46:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: intel_scu_watchdog: Remove unused variable
Message-ID: <20140215174608.GD19001@roeck-us.net>
References: <1392456138-30003-1-git-send-email-shc_work@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456138-30003-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 15, 2014 at 01:22:18PM +0400, Alexander Shiyan wrote:
> Variable "hw_pre_value" is not used anywhere in the
> function intel_scu_set_heartbeat().
> This patch removes this variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel_scu_watchdog.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
> index e13e65e..0caab62 100644
> --- a/drivers/watchdog/intel_scu_watchdog.c
> +++ b/drivers/watchdog/intel_scu_watchdog.c
> @@ -211,7 +211,6 @@ static int intel_scu_set_heartbeat(u32 t)
>  	int			 ipc_ret;
>  	int			 retry_count;
>  	u32			 soft_value;
> -	u32			 hw_pre_value;
>  	u32			 hw_value;
>  
>  	watchdog_device.timer_set = t;
> @@ -273,8 +272,7 @@ static int intel_scu_set_heartbeat(u32 t)
>  			watchdog_device.timer_load_count_addr);
>  
>  		/* read count value before starting timer */
> -		hw_pre_value = ioread32(watchdog_device.timer_load_count_addr);
> -		hw_pre_value = hw_pre_value & 0xFFFF0000;
> +		ioread32(watchdog_device.timer_load_count_addr);
>  
>  		/* Start the timer */
>  		iowrite32(0x00000003, watchdog_device.timer_control_addr);
> -- 
> 1.8.3.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
