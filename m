Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62825 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab3JaAnk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 30 Oct 2013 20:43:40 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so2143108pbc.36
        for <linux-watchdog@vger.kernel.org>; Wed, 30 Oct 2013 17:43:40 -0700 (PDT)
Date: Wed, 30 Oct 2013 17:43:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: add module device table
Message-ID: <20131031004338.GA20335@roeck-us.net>
References: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1VbfdE-0003gA-4q@rmk-PC.arm.linux.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 30, 2013 at 11:57:00PM +0000, Russell King wrote:
> Add the module device table declaration so the module can be loaded
> automatically at boot time.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Hi Russell,

Wim should have this patch in his queue already, as 'watchdog: imx2_wdt:
expose module alias for loading from device-tree', submitted by Niels
de Vos back in July.

Thanks,
Guenter

> ---
>  drivers/watchdog/imx2_wdt.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 693ac3f4de5a..ae1ac198d968 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -340,3 +340,4 @@ MODULE_DESCRIPTION("Watchdog driver for IMX2 and later");
>  MODULE_LICENSE("GPL v2");
>  MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
>  MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_DEVICE_TABLE(of, imx2_wdt_dt_ids);
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
