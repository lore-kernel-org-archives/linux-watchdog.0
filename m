Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40491 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdCHQE3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 8 Mar 2017 11:04:29 -0500
Subject: Re: [PATCH v1] watchdog: intel-mid_wdt: Keep watchdog running
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
References: <20170308111029.60744-1-andriy.shevchenko@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <846f18ec-e41c-364e-c867-fa6b3dbc18d4@roeck-us.net>
Date: Wed, 8 Mar 2017 06:21:09 -0800
MIME-Version: 1.0
In-Reply-To: <20170308111029.60744-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Andy,

On 03/08/2017 03:10 AM, Andy Shevchenko wrote:
> Firmware followed by bootloader leaves watchdog running.
>

Is that always the case ? If not, does it hurt if the watchdog is pinged
while not active ?

Also, this assumes that its default timeout is in the default range
configured by the driver, ie not (much) lower than 30 seconds.

Not objecting, but it would help to have comments in the code explaining
the context in some more detail.

Thanks,
Guenter

> Keep it running in the driver.
>
> User will not need any additional options to reboot in case of panic.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/watchdog/intel-mid_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index 45e4d02221b5..a128ccb085b0 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -147,8 +147,8 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> -	/* Make sure the watchdog is not running */
> -	wdt_stop(wdt_dev);
> +	/* Make sure the watchdog is serviced */
> +	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
>
>  	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
>  	if (ret) {
>

