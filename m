Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38649 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbcKSPzZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 19 Nov 2016 10:55:25 -0500
Subject: Re: [PATCH v1 1/1] intel-mid_wdt: make sure watchdog is not running
 at startup
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org, mika.westerberg@linux.intel.com
References: <20161118145002.140630-1-andriy.shevchenko@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <265e4708-7658-d45f-7036-f2804e12e585@roeck-us.net>
Date: Sat, 19 Nov 2016 07:55:22 -0800
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I don't really like turning off the watchdog, but I guess it is the only
remedy we have if it doesn't tell us if it is running.

Guenter

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

