Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49246 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbcADOQC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Jan 2016 09:16:02 -0500
Subject: Re: [PATCH v2] watchdog: stmp3xxx: Remove unused variables
To: Fabio Estevam <fabio.estevam@nxp.com>, wim@iguana.be
References: <1451910647-9313-1-git-send-email-fabio.estevam@nxp.com>
Cc: harald@ccbib.org, festevam@gmail.com,
	linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <568A7E9F.6070600@roeck-us.net>
Date: Mon, 4 Jan 2016 06:15:59 -0800
MIME-Version: 1.0
In-Reply-To: <1451910647-9313-1-git-send-email-fabio.estevam@nxp.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/04/2016 04:30 AM, Fabio Estevam wrote:
> Commit 8d2fa17151ea3 ("watchdog: stmp3xxx: Stop the watchdog on system
> halt") introduced the following build warning:
>
> drivers/watchdog/stmp3xxx_rtc_wdt.c: In function 'wdt_notify_sys':
> drivers/watchdog/stmp3xxx_rtc_wdt.c:78:29: warning: unused variable 'pdata' [-Wunused-variable]
>
> Remove the unused 'pdata' and 'dev' variables.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v1:
> - Also remove the 'dev' variable.
>
>   drivers/watchdog/stmp3xxx_rtc_wdt.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> index dbe0372..d8b11eb 100644
> --- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
> +++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
> @@ -74,9 +74,6 @@ static struct watchdog_device stmp3xxx_wdd = {
>   static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
>   			  void *unused)
>   {
> -	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
> -	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
> -
>   	switch (code) {
>   	case SYS_DOWN:	/* keep enabled, system might crash while going down */
>   		break;
>

