Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36365 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbcKRPuF (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 10:50:05 -0500
Subject: Re: [PATCH v1 1/1] intel-mid_wdt: make sure watchdog is not running
 at startup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, mika.westerberg@linux.intel.com
References: <20161118145002.140630-1-andriy.shevchenko@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <1a10bf0f-963c-c603-9e47-2e667191d3c8@roeck-us.net>
Date: Fri, 18 Nov 2016 07:50:00 -0800
MIME-Version: 1.0
In-Reply-To: <20161118145002.140630-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2016 06:50 AM, Andy Shevchenko wrote:
> Make sure that the watchdog is not running after loading
> and before it is started by opening /dev/watchdog.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/watchdog/intel-mid_wdt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
> index db36d12..ff099a3 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -151,6 +151,9 @@ static int mid_wdt_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	/* Make sure the watchdog is not running */
> +	wdt_stop(wdt_dev);
> +
>  	ret = watchdog_register_device(wdt_dev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "error registering watchdog device\n");
>

This leaves the system exposed. Why not just tell the core if the watchdog
is running and let it handle the ping until the device is opened ?
Is it not possible to detect if the watchdog is running ?

Guenter

