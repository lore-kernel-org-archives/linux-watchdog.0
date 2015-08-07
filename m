Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41764 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbbHGR2q (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Aug 2015 13:28:46 -0400
Message-ID: <55C4EAC8.3090005@roeck-us.net>
Date: Fri, 07 Aug 2015 10:28:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: kbuild test robot <fengguang.wu@intel.com>,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
CC: kbuild-all@01.org, lm-sensors@lm-sensors.org,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
Subject: Re: [PATCH hwmon] watchdog: lpc18xx_wdt_get_timeleft() can be static
References: <201508080133.jDW20mAc%fengguang.wu@intel.com> <20150807170350.GA92637@athens>
In-Reply-To: <20150807170350.GA92637@athens>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/07/2015 10:03 AM, kbuild test robot wrote:
>
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>

Wrong subsystem (should be watchdog), but still makes sense on top
of the offending patch. I'll add it to my pull request for Wim.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   lpc18xx_wdt.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
> index 00ff5bd..ab7b8b1 100644
> --- a/drivers/watchdog/lpc18xx_wdt.c
> +++ b/drivers/watchdog/lpc18xx_wdt.c
> @@ -123,7 +123,7 @@ static int lpc18xx_wdt_set_timeout(struct watchdog_device *wdt_dev,
>   	return 0;
>   }
>
> -unsigned int lpc18xx_wdt_get_timeleft(struct watchdog_device *wdt_dev)
> +static unsigned int lpc18xx_wdt_get_timeleft(struct watchdog_device *wdt_dev)
>   {
>   	struct lpc18xx_wdt_dev *lpc18xx_wdt = watchdog_get_drvdata(wdt_dev);
>   	unsigned int val;
>

