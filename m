Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35036 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbeAASOc (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 1 Jan 2018 13:14:32 -0500
Subject: Re: [PATCH v3] watchdog: imx2_wdt: restore previous timeout after
 suspend+resume
To: Martin Kaiser <martin@kaiser.cx>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de, Fabio Estevam <fabio.estevam@freescale.com>,
        stable@vger.kernel.org
References: <1514555950-28743-1-git-send-email-martin@kaiser.cx>
 <1514827607-11580-1-git-send-email-martin@kaiser.cx>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1c785aca-3a2b-2a86-cc11-c37dc7550421@roeck-us.net>
Date: Mon, 1 Jan 2018 10:14:28 -0800
MIME-Version: 1.0
In-Reply-To: <1514827607-11580-1-git-send-email-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/01/2018 09:26 AM, Martin Kaiser wrote:
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
> Fix this by adding a new function __imx2_wdt_set_timeout() which
> only updates the hardware settings. imx2_wdt_set_timeout() now calls
> __imx2_wdt_set_timeout() and then saves the new timeout to
> wdog->timeout.
> 
> During suspend, we call __imx2_wdt_set_timeout() directly so that
> wdog->timeout won't be updated and we can restore the previous value
> during resume. This approach makes wdog->timeout different from the
> actual setting in the hardware which is usually not a good thing.
> However, the two differ only while we're suspended and no kernel code is
> running, so it should be ok in this case.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Cc: stable@vger.kernel.org

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> changes in v3:
>   reformat
>   remove return value of __imx2_wdt_set_timeout()
> 
> changes in v2:
>   helper function that updates the hw settings, as per Guenter's proposal
> 
>   drivers/watchdog/imx2_wdt.c | 20 +++++++++++++++-----
>   1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
> index 4874b0f..518dfa1 100644
> --- a/drivers/watchdog/imx2_wdt.c
> +++ b/drivers/watchdog/imx2_wdt.c
> @@ -169,15 +169,21 @@ static int imx2_wdt_ping(struct watchdog_device *wdog)
>   	return 0;
>   }
>   
> -static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
> -				unsigned int new_timeout)
> +static void __imx2_wdt_set_timeout(struct watchdog_device *wdog,
> +				   unsigned int new_timeout)
>   {
>   	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
>   
> -	wdog->timeout = new_timeout;
> -
>   	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
>   			   WDOG_SEC_TO_COUNT(new_timeout));
> +}
> +
> +static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
> +				unsigned int new_timeout)
> +{
> +	__imx2_wdt_set_timeout(wdog, new_timeout);
> +
> +	wdog->timeout = new_timeout;
>   	return 0;
>   }
>   
> @@ -371,7 +377,11 @@ static int imx2_wdt_suspend(struct device *dev)
>   
>   	/* The watchdog IP block is running */
>   	if (imx2_wdt_is_running(wdev)) {
> -		imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
> +		/*
> +		 * Don't update wdog->timeout, we'll restore the current value
> +		 * during resume.
> +		 */
> +		__imx2_wdt_set_timeout(wdog, IMX2_WDT_MAX_TIME);
>   		imx2_wdt_ping(wdog);
>   	}
>   
> 

