Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43040 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbHGPAr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 11:00:47 -0400
Message-ID: <55C4C81B.4090505@roeck-us.net>
Date: Fri, 07 Aug 2015 08:00:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>
CC: kernel@pengutronix.de, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v1 5/5] watchdog: mpc8xxx: allow to compile for MPC512x
References: <1438942067-1654-1-git-send-email-u.kleine-koenig@pengutronix.de> <1438942067-1654-6-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1438942067-1654-6-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 08/07/2015 03:07 AM, Uwe Kleine-König wrote:
> The MPC5125 processor features a watchdog compiler that is identical to

compiler ?

Guenter

> the MPC8610 one. So allow to enable the driver for MPC512x kernel
> configurations.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
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

