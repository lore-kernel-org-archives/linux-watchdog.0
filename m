Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41012 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbdCKPy0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 11 Mar 2017 10:54:26 -0500
Subject: Re: [PATCH v3] watchdog: intel-mid_wdt: Keep watchdog running
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
References: <20170310222217.87272-1-andriy.shevchenko@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <62ad208b-ac4e-d402-5b21-6943962db686@roeck-us.net>
Date: Sat, 11 Mar 2017 07:54:22 -0800
MIME-Version: 1.0
In-Reply-To: <20170310222217.87272-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/10/2017 02:22 PM, Andy Shevchenko wrote:
> Firmware followed by bootloader leaves watchdog running.
>
> Keep it running in the driver.
>
> User will not need any additional options to reboot in case of panic
> during boot.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/intel-mid_wdt.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 45e4d02221b5..72c108a12c19 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -147,8 +147,21 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> -	/* Make sure the watchdog is not running */
> -	wdt_stop(wdt_dev);
> +	/*
> +	 * The firmware followed by U-Boot leaves the watchdog running
> +	 * with the default threshold which may vary. When we get here
> +	 * we should make a decision to prevent any side effects before
> +	 * user space daemon will take care of it. The best option,
> +	 * taking into consideration that there is no way to read values
> +	 * back from hardware, is to enforce watchdog being run with
> +	 * deterministic values.
> +	 */
> +	ret = wdt_start(wdt_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* Make sure the watchdog is serviced */
> +	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
>
>  	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
>  	if (ret) {
>

