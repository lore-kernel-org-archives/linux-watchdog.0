Return-path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1489165549.20145.197.camel@linux.intel.com>
Subject: Re: [PATCH v2] watchdog: intel-mid_wdt: Keep watchdog running
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Date: Fri, 10 Mar 2017 19:05:49 +0200
In-Reply-To: <20170310165138.53825-1-andriy.shevchenko@linux.intel.com>
References: <20170310165138.53825-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, 2017-03-10 at 18:51 +0200, Andy Shevchenko wrote:
> Firmware followed by bootloader leaves watchdog running.
> 
> Keep it running in the driver.
> 
> User will not need any additional options to reboot in case of panic
> during boot.

> -	/* Make sure the watchdog is not running */
> -	wdt_stop(wdt_dev);
> +	/*
> +	 * Make sure the watchdog is serviced.
> +	 *
> +	 * The firmware followed by U-Boot leaves the watchdog
> running
> +	 * with the default threshold 60 seconds. Our default timeout
> is
> +	 * 90 seconds, but internal worker divides it by two, which
> is
> +	 * 45 seconds and should be enough (less by 15 seconds than
> +	 * threshold).
> +	 */
> +	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);

Giving one more thought here perhaps more robust will be to start
watchdog unconditionally here?

In that case it will be no matter how it's configured in firmware and/or
boot loader.

>  
>  	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
>  	if (ret) {

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
