Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42024 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbbICPYt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Sep 2015 11:24:49 -0400
Message-ID: <55E8663E.1040706@roeck-us.net>
Date: Thu, 03 Sep 2015 08:24:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Luis de Bethencourt <luis@debethencourt.com>,
	linux-kernel@vger.kernel.org
CC: Johannes Thumshirn <morbidrsa@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 2/3] watchdog: mena21_wdt: Fix module autoload for OF
 platform driver
References: <20150903110650.GA17441@goodgumbo.baconseed.org>
In-Reply-To: <20150903110650.GA17441@goodgumbo.baconseed.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/03/2015 04:06 AM, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/mena21_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
> index d193a5e..f2861e4 100644
> --- a/drivers/watchdog/mena21_wdt.c
> +++ b/drivers/watchdog/mena21_wdt.c
> @@ -252,6 +252,7 @@ static const struct of_device_id a21_wdt_ids[] = {
>   	{ .compatible = "men,a021-wdt" },
>   	{ },
>   };
> +MODULE_DEVICE_TABLE(of, a21_wdt_ids);
>
>   static struct platform_driver a21_wdt_driver = {
>   	.probe = a21_wdt_probe,
>

