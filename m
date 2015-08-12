Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41819 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754429AbbHLKWN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Aug 2015 06:22:13 -0400
Message-ID: <55CB1E50.1020609@roeck-us.net>
Date: Wed, 12 Aug 2015 03:22:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 7/7] watchdog: mpc8xxx: allow to compile for MPC512x
References: <1439367358-5338-1-git-send-email-u.kleine-koenig@pengutronix.de> <1439367358-5338-8-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1439367358-5338-8-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/12/2015 01:15 AM, Uwe Kleine-König wrote:
> The MPC5125 processor features a watchdog device that is identical to
> the MPC8610 one. So allow to enable the driver for MPC512x kernel
> configurations.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 241fafde42cb..8c43ae9bde2b 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1333,7 +1333,7 @@ config MPC5200_WDT
>
>   config 8xxx_WDT
>   	tristate "MPC8xxx Platform Watchdog Timer"
> -	depends on PPC_8xx || PPC_83xx || PPC_86xx
> +	depends on PPC_8xx || PPC_83xx || PPC_86xx || PPC_MPC512x
>   	select WATCHDOG_CORE
>   	help
>   	  This driver is for a SoC level watchdog that exists on some
>

