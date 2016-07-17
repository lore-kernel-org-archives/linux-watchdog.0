Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43765 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751181AbcGQUIi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:08:38 -0400
Date: Sun, 17 Jul 2016 22:08:36 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Martyn Welch <martyn.welch@collabora.com>
Subject: Re: [PATCH 1/2] watchdog: ziirave_wdt: Correct I2C device id to fix module autoloading.
Message-ID: <20160717200836.GI32751@spo001.leaseweb.nl>
References: <1466160754-15599-1-git-send-email-enric.balletbo@collabora.com> <1466160754-15599-2-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1466160754-15599-2-git-send-email-enric.balletbo@collabora.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Enric,

> The I2C core removes the manufacturer prefix from the compatible field
> so it reports to user-space the uevent i2c:rave-wdt, but this doesn't
> match with the i2c_device_id (i2c:ziirave-wdt) array so the module is not
> autoloaded. Correct the I2C device id to match with the reported uevent
> and fix the module autoloading functionality.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/watchdog/ziirave_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> index cbe373de..fa1efef 100644
> --- a/drivers/watchdog/ziirave_wdt.c
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -339,7 +339,7 @@ static int ziirave_wdt_remove(struct i2c_client *client)
>  }
>  
>  static struct i2c_device_id ziirave_wdt_id[] = {
> -	{ "ziirave-wdt", 0 },
> +	{ "rave-wdt", 0 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, ziirave_wdt_id);
> -- 
> 2.1.0
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

