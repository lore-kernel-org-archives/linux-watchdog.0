Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59351 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753025AbaBXT6n (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:58:43 -0500
Date: Mon, 24 Feb 2014 20:58:43 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: intel_scu_watchdog: Remove unused variable
Message-ID: <20140224195843.GJ20712@spo001.leaseweb.com>
References: <1392456138-30003-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392456138-30003-1-git-send-email-shc_work@mail.ru>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Alexander,

> Variable "hw_pre_value" is not used anywhere in the
> function intel_scu_set_heartbeat().
> This patch removes this variable.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
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

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

