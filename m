Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53275 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbcFQNXp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2016 09:23:45 -0400
Subject: Re: [PATCH 1/2] watchdog: ziirave_wdt: Correct I2C device id to fix
 module autoloading.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1466160754-15599-1-git-send-email-enric.balletbo@collabora.com>
 <1466160754-15599-2-git-send-email-enric.balletbo@collabora.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Martyn Welch <martyn.welch@collabora.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5763F9DA.1070300@roeck-us.net>
Date: Fri, 17 Jun 2016 06:23:38 -0700
MIME-Version: 1.0
In-Reply-To: <1466160754-15599-2-git-send-email-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/17/2016 03:52 AM, Enric Balletbo i Serra wrote:
> The I2C core removes the manufacturer prefix from the compatible field
> so it reports to user-space the uevent i2c:rave-wdt, but this doesn't
> match with the i2c_device_id (i2c:ziirave-wdt) array so the module is not
> autoloaded. Correct the I2C device id to match with the reported uevent
> and fix the module autoloading functionality.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ziirave_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> index cbe373de..fa1efef 100644
> --- a/drivers/watchdog/ziirave_wdt.c
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -339,7 +339,7 @@ static int ziirave_wdt_remove(struct i2c_client *client)
>   }
>
>   static struct i2c_device_id ziirave_wdt_id[] = {
> -	{ "ziirave-wdt", 0 },
> +	{ "rave-wdt", 0 },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(i2c, ziirave_wdt_id);
>

