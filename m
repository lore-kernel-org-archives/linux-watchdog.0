Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56947 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbdGTDS2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 23:18:28 -0400
Subject: Re: [PATCH] watchdog: imx2_wdt: use new_timeout value to override the
 old
To: yanjiang.jin@windriver.com, wim@iguana.be
Cc: jinyanjiang@gmail.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20170720024533.70081-1-yanjiang.jin@windriver.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b433d1ff-0d89-fbd9-3e2d-04bd278371fb@roeck-us.net>
Date: Wed, 19 Jul 2017 20:18:24 -0700
MIME-Version: 1.0
In-Reply-To: <20170720024533.70081-1-yanjiang.jin@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/19/2017 07:45 PM, yanjiang.jin@windriver.com wrote:
> From: Yanjiang Jin <yanjiang.jin@windriver.com>
> 
> Without this patch we couldn't change the timeout value of imx2_wdt.
> 
> Signed-off-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> ---
>   drivers/watchdog/imx2_wdt.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 4874b0f..6cfeee6 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -178,6 +178,9 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
>   
>   	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
>   			   WDOG_SEC_TO_COUNT(new_timeout));
> +
> +	wdog->timeout = new_timeout;
> +

I must be missing something. That very same code is already in line 177,
added with commit 30dd4a8f08b57 ("watchdog: imx2_wdt: also set wdog->timeout
to new_timeout") back in 2015.

Did you see this in an older kernel, maybe ?

Guenter
