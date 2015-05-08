Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59931 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbbEHAEN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 20:04:13 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YqVm0-001v00-HK
	for linux-watchdog@vger.kernel.org; Fri, 08 May 2015 00:04:12 +0000
Message-ID: <554BFD75.1070601@roeck-us.net>
Date: Thu, 07 May 2015 17:04:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
CC: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com
Subject: Re: [PATCH 05/12] watchdog: st_wdt: Update IP layout information
 to include Clocksource
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org> <1431005924-21777-6-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-6-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/07/2015 06:38 AM, Lee Jones wrote:
> Initial submission adding support for this IP only included Watchdog and
> the Real-Time Clock.  Now the third (and final) device is enabled this
> trivial patch is required to update the comment in the Watchdog driver
> to encompass Clocksource.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/st_lpc_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
> index f32be15..6785afd 100644
> --- a/drivers/watchdog/st_lpc_wdt.c
> +++ b/drivers/watchdog/st_lpc_wdt.c
> @@ -197,7 +197,7 @@ static int st_wdog_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>
> -	/* LPC can either run in RTC or WDT mode */
> +	/* LPC can either run as a Clocksource or in RTC or WDT mode */
>   	if (mode != ST_LPC_MODE_WDT)
>   		return -ENODEV;
>
>

