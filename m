Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32986 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdL2QKW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 29 Dec 2017 11:10:22 -0500
Subject: Re: [PATCH] watchdog: imx2_wdt: restore previous timeout after
 suspend+resume
To: Martin Kaiser <martin@kaiser.cx>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xiubo Li <Li.Xiubo@freescale.com>, kernel@pengutronix.de,
        Fabio Estevam <fabio.estevam@freescale.com>,
        stable@vger.kernel.org
References: <1514555950-28743-1-git-send-email-martin@kaiser.cx>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <080e499c-a31b-e805-f761-6564e02d1be9@roeck-us.net>
Date: Fri, 29 Dec 2017 08:10:19 -0800
MIME-Version: 1.0
In-Reply-To: <1514555950-28743-1-git-send-email-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/29/2017 05:59 AM, Martin Kaiser wrote:
> When the watchdog device is suspended, its timeout is set to the maximum
> value. During resume, the previously set timeout should be restored.
> This does not work at the moment.
> 
> The suspend function calls
> 
> imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
> 
> and resume reverts this by calling
> 
> imx2_wdt_set_timeout(wdog, wdog->timeout);
> 
> However, imx2_wdt_set_timeout() updates wdog->timeout. Therefore,
> wdog->timeout is set to IMX2_WDT_MAX_TIME when we enter the resume
> function.
> 
> Fix this by setting wdog->timeout to the previous value at the end of
> the suspend function. This manual update makes wdog->timeout different
> from the actual setting in the hardware. This should be ok in our case
> as kernel code is not running while we're suspended.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Cc: stable@vger.kernel.org

That works, though it is a bit hackish. Better would be to have a function
such as _imx2_wdt_set_timeout() which doesn't actually update wdt->timeout
and could be called from all the other places doing the same.
Separate patch, maybe.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/imx2_wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 4874b0f..66efcc0 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -368,6 +368,7 @@ static int imx2_wdt_suspend(struct device *dev)
>   {
>   	struct watchdog_device *wdog = dev_get_drvdata(dev);
>   	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
> +	unsigned int resume_timeout = wdog->timeout;
>   
>   	/* The watchdog IP block is running */
>   	if (imx2_wdt_is_running(wdev)) {
> @@ -377,6 +378,7 @@ static int imx2_wdt_suspend(struct device *dev)
>   
>   	clk_disable_unprepare(wdev->clk);
>   
> +	wdog->timeout = resume_timeout;
>   	return 0;
>   }
>   
> 

