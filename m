Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40433 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbaLPB6W (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Dec 2014 20:58:22 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Y0hP4-004426-5M
	for linux-watchdog@vger.kernel.org; Tue, 16 Dec 2014 01:58:22 +0000
Message-ID: <548F91B9.7000705@roeck-us.net>
Date: Mon, 15 Dec 2014 17:58:17 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH] watchdog: imx2_wdt: Fix the argument of watchdog_active()
References: <1418690999-28294-1-git-send-email-festevam@gmail.com>
In-Reply-To: <1418690999-28294-1-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/15/2014 04:49 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Fix the following build warning by passing the expected argument type to
> watchdog_active():
>
> drivers/watchdog/imx2_wdt.c: In function 'imx2_wdt_suspend':
> drivers/watchdog/imx2_wdt.c:340:2: warning: passing argument 1 of 'watchdog_active' from incompatible pointer type [enabled by default]
> In file included from drivers/watchdog/imx2_wdt.c:38:0:
> include/linux/watchdog.h:104:20: note: expected 'struct watchdog_device *' but argument is of type 'struct watchdog_device **'
>
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/imx2_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 51d940b..d6add51 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -337,7 +337,7 @@ static int imx2_wdt_suspend(struct device *dev)
>   	imx2_wdt_ping(wdog);
>
>   	/* Watchdog has been stopped but IP block is still running */
> -	if (!watchdog_active(&wdog) && imx2_wdt_is_running(wdev))
> +	if (!watchdog_active(wdog) && imx2_wdt_is_running(wdev))
>   		del_timer_sync(&wdev->timer);
>
>   	clk_disable_unprepare(wdev->clk);
>

