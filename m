Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39789 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934316AbbKTERA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 23:17:00 -0500
Subject: Re: [PATCH 4/7] watchdog: gpio_wdt: stop on SYS_DOWN instead of
 SYS_POWER_OFF
To: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-watchdog@vger.kernel.org
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447880542-19320-5-git-send-email-damien.riegel@savoirfairelinux.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564E9EB7.7010808@roeck-us.net>
Date: Thu, 19 Nov 2015 20:16:55 -0800
MIME-Version: 1.0
In-Reply-To: <1447880542-19320-5-git-send-email-damien.riegel@savoirfairelinux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2015 01:02 PM, Damien Riegel wrote:
> gpio_wdt is one the very few drivers that do not stop the device on
> SYS_HALT and SYS_DOWN, but on SYS_HALT and SYS_POWER_OFF.
>
> As most of the drivers, it makes more sense to stop the watchdog on
> SYS_DOWN instead of SYS_POWER_OFF.
>
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Makes sense.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/gpio_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
> index 90d59d3..1a3c6e8 100644
> --- a/drivers/watchdog/gpio_wdt.c
> +++ b/drivers/watchdog/gpio_wdt.c
> @@ -136,7 +136,7 @@ static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
>
>   	switch (code) {
>   	case SYS_HALT:
> -	case SYS_POWER_OFF:
> +	case SYS_DOWN:
>   		gpio_wdt_disable(priv);
>   		break;
>   	default:
>

