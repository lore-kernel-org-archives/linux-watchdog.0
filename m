Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44781 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753031AbcLTV7m (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Dec 2016 16:59:42 -0500
Subject: Re: [PATCH] watchdog: update my email address
To: John Crispin <john@phrozen.org>, Wim Van Sebroeck <wim@iguana.be>
References: <1482260219-61453-1-git-send-email-john@phrozen.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d5277d18-841c-286e-6d77-c61be39309f4@roeck-us.net>
Date: Tue, 20 Dec 2016 12:28:10 -0800
MIME-Version: 1.0
In-Reply-To: <1482260219-61453-1-git-send-email-john@phrozen.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/20/2016 10:56 AM, John Crispin wrote:
> This patch updates my email address as I no longer have access to the old
> one.
>
> Signed-off-by: John Crispin <john@phrozen.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/lantiq_wdt.c |    4 ++--
>  drivers/watchdog/mt7621_wdt.c |    4 ++--
>  drivers/watchdog/rt2880_wdt.c |    2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
> index 582f2fa..e082367 100644
> --- a/drivers/watchdog/lantiq_wdt.c
> +++ b/drivers/watchdog/lantiq_wdt.c
> @@ -3,7 +3,7 @@
>   *  under the terms of the GNU General Public License version 2 as published
>   *  by the Free Software Foundation.
>   *
> - *  Copyright (C) 2010 John Crispin <blogic@openwrt.org>
> + *  Copyright (C) 2010 John Crispin <john@phrozen.org>
>   *  Based on EP93xx wdt driver
>   */
>
> @@ -240,6 +240,6 @@
>
>  module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
> -MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
> +MODULE_AUTHOR("John Crispin <john@phrozen.org>");
>  MODULE_DESCRIPTION("Lantiq SoC Watchdog");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> index d5735c1..2fb5a30 100644
> --- a/drivers/watchdog/mt7621_wdt.c
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -1,7 +1,7 @@
>  /*
>   * Ralink MT7621/MT7628 built-in hardware watchdog timer
>   *
> - * Copyright (C) 2014 John Crispin <blogic@openwrt.org>
> + * Copyright (C) 2014 John Crispin <john@phrozen.org>
>   *
>   * This driver was based on: drivers/watchdog/rt2880_wdt.c
>   *
> @@ -181,5 +181,5 @@ static void mt7621_wdt_shutdown(struct platform_device *pdev)
>  module_platform_driver(mt7621_wdt_driver);
>
>  MODULE_DESCRIPTION("MediaTek MT762x hardware watchdog driver");
> -MODULE_AUTHOR("John Crispin <blogic@openwrt.org");
> +MODULE_AUTHOR("John Crispin <john@phrozen.org");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
> index 14b4fd4..4c471fe7 100644
> --- a/drivers/watchdog/rt2880_wdt.c
> +++ b/drivers/watchdog/rt2880_wdt.c
> @@ -2,7 +2,7 @@
>   * Ralink RT288x/RT3xxx/MT76xx built-in hardware watchdog timer
>   *
>   * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
> - * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + * Copyright (C) 2013 John Crispin <john@phrozen.org>
>   *
>   * This driver was based on: drivers/watchdog/softdog.c
>   *
>

