Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:55717 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165Ab1I1T3g (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Sep 2011 15:29:36 -0400
Date: Wed, 28 Sep 2011 12:28:49 -0700
From: Andrew Morton <akpm@google.com>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] rtc: stmp3xxx: add wdt-accessor function
Message-Id: <20110928122849.42f903a2.akpm@google.com>
In-Reply-To: <1317212997-26668-2-git-send-email-w.sang@pengutronix.de>
References: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
	<1317212997-26668-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 28 Sep 2011 14:29:54 +0200
Wolfram Sang <w.sang@pengutronix.de> wrote:

> This RTC also includes a watchdog timer. Provide an accessor function
> for it to be picked up by a watchdog driver. Also register the
> platform_device here to get proper boot-time dependencies.
> 
> ...
>
> Andrew, Wim: Alessandro was not around in the last weeks, so I'd suggest this
> patch goes via the watchdog-tree together with the rest of this series if it
> passes the review of the watchdog-list? All changes here are in preparation for
> the watchdog driver and do not affect the general RTC. Is that okay?

OK by me.  Be careful about the Kconfig setup when doing
cross-subsystem dependencies like this.  Otherwise you get sad emails
from Randy when his build breaks.

>
> ...
>
>  struct stmp3xxx_rtc_data {
>  	struct rtc_device *rtc;
>  	void __iomem *io;
>  	int irq_alarm;
>  };
>  
> +#ifdef CONFIG_STMP3XXX_RTC_WATCHDOG

Should it be

#if defined(CONFIG_STMP3XXX_RTC_WATCHDOG) || defined(CONFIG_STMP3XXX_RTC_WATCHDOG_MODULE)

?

> +struct platform_device stmp3xxx_wdt_pdev = {

static?

> +	.name = "stmp3xxx_rtc_wdt",
> +	.id = -1,
> +};
> +
> +void stmp3xxx_wdt_setup(struct device *dev, u32 timeout)

I'd suggest documenting `timeout' at least.  Why would one want to set
it to zero and what effect does that have?  What are its units?

> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct stmp3xxx_rtc_data *rtc_data = platform_get_drvdata(pdev);
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
> +EXPORT_SYMBOL_GPL(stmp3xxx_wdt_setup);

The patch adds a global symbol but fails to declare that symbol in a
header file.  This is always wrong.

> +static void stmp3xxx_wdt_register(struct device *dev)
> +{
> +	stmp3xxx_wdt_pdev.dev.parent = dev;
> +	platform_device_register(&stmp3xxx_wdt_pdev);
> +}
> +#else
> +static void stmp3xxx_wdt_register(struct device *dev)
> +{
> +}
> +#endif /* CONFIG_STMP3XXX_RTC_WATCHDOG */
> +
>  static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
>  {
>  	/*
> @@ -231,6 +274,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
>  		goto out_irq_alarm;
>  	}
>  
> +	stmp3xxx_wdt_register(&pdev->dev);
>  	return 0;

