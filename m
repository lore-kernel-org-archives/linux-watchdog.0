Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42061 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbbICPZL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Sep 2015 11:25:11 -0400
Message-ID: <55E86650.3030602@roeck-us.net>
Date: Thu, 03 Sep 2015 08:25:04 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Luis de Bethencourt <luis@debethencourt.com>,
	linux-kernel@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH 3/3] watchdog: gef_wdt: Fix module autoload for OF platform
 driver
References: <20150903110722.GA17450@goodgumbo.baconseed.org>
In-Reply-To: <20150903110722.GA17450@goodgumbo.baconseed.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/03/2015 04:07 AM, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/gef_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
> index cc1bdfc..006e234 100644
> --- a/drivers/watchdog/gef_wdt.c
> +++ b/drivers/watchdog/gef_wdt.c
> @@ -303,6 +303,7 @@ static const struct of_device_id gef_wdt_ids[] = {
>   	},
>   	{},
>   };
> +MODULE_DEVICE_TABLE(of, gef_wdt_ids);
>
>   static struct platform_driver gef_wdt_driver = {
>   	.driver = {
>

