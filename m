Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41332 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755138Ab2AYBAA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Jan 2012 20:00:00 -0500
Date: Tue, 24 Jan 2012 16:59:58 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com,
	Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
Message-Id: <20120124165958.2091fa94.akpm@linux-foundation.org>
In-Reply-To: <1327347185-620-2-git-send-email-w.sang@pengutronix.de>
References: <1327347185-620-1-git-send-email-w.sang@pengutronix.de>
	<1327347185-620-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 23 Jan 2012 20:33:03 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> This RTC also includes a watchdog timer. Provide an accessor function
> for it to be picked up by a watchdog driver. Also register the
> platform_device here to get the boot-time dependencies right.
> 
>
> ...
>
>  struct stmp3xxx_rtc_data {
>  	struct rtc_device *rtc;
>  	void __iomem *io;
>  	int irq_alarm;
>  };
>  
> +#if defined(CONFIG_STMP3XXX_RTC_WATCHDOG) || defined(CONFIG_STMP3XXX_RTC_WATCHDOG_MODULE)

You can use IS_ENABLED() here.

> +/**
> + * stmp3xxx_wdt_set_timeout - configure the watchdog inside the STMP3xxx RTC
> + * @dev: the parent device of the watchdog (= the RTC)
> + * @timeout: the desired value for the timeout register of the watchdog.
> + *           0 disables the watchdog
> + *
> + * The watchdog needs one register and two bits which are in the RTC domain.
> + * To handle the resource conflict, the RTC driver will create another
> + * platform_device for the watchdog driver as a child of the RTC device.
> + * The watchdog driver is passed the below accessor function via platform_data
> + * to configure the watchdog. Locking is not needed because accessing SET/CLR
> + * registers is atomic.
> + */
> +
> +void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
> +{
> +	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
> +	void __iomem *base;
> +
> +	if (timeout) {
> +		writel(timeout, rtc_data->io + STMP3XXX_RTC_WATCHDOG);
> +		base = rtc_data->io + MXS_SET_ADDR;
> +	} else {
> +		base = rtc_data->io + MXS_CLR_ADDR;
> +	}
> +	writel(STMP3XXX_RTC_CTRL_WATCHDOGEN, base + STMP3XXX_RTC_CTRL);
> +	writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
> +		base + STMP3XXX_RTC_PERSISTENT1);
> +}

This wants EXPORT_SYMBOL(), surely?

Which points suspicious fingers at your testing ;) Please test all
combinations of y, n and m on both config symbols.

> +static struct stmp3xxx_wdt_pdata wdt_pdata = {
> +	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
> +};
> +
> +static struct platform_device stmp3xxx_wdt_pdev = {
> +	.name = "stmp3xxx_rtc_wdt",
> +	.dev = {
> +		.platform_data = &wdt_pdata,
> +	},
> +};
> +
> +static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
> +{
> +	stmp3xxx_wdt_pdev.dev.parent = &rtc_pdev->dev;
> +	stmp3xxx_wdt_pdev.id = rtc_pdev->id;
> +	platform_device_register(&stmp3xxx_wdt_pdev);
> +}
> +#else
> +static void stmp3xxx_wdt_register(struct device *dev)
> +{
> +}

This stub is unfortunate.  If
!IS_ENABLED(CONFIG_STMP3XXX_RTC_WATCHDOG), the user still must load
this module just to get a silly empty function.  If the
stmp3xxx_wdt_register() stub were made static inline in a header file,
the user won't need to compile or load this module at all.  There may
be other (initialisation?) reasons why the user must still load this
module?
