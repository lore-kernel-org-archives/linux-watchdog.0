Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:42889 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbbBWKMa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 05:12:30 -0500
Received: by wesw62 with SMTP id w62so16892400wes.9
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Feb 2015 02:12:29 -0800 (PST)
Date: Mon, 23 Feb 2015 10:12:23 +0000
From: Peter Griffin <peter.griffin@linaro.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kernel@stlinux.com,
	rtc-linux@googlegroups.com, wim@iguana.be, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [STLinux Kernel] [PATCH v3 7/8] rtc: st: add new driver for ST's
 LPC RTC
Message-ID: <20150223101223.GA14142@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1424260154-12868-1-git-send-email-lee.jones@linaro.org>
 <1424260154-12868-8-git-send-email-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1424260154-12868-8-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Lee,

On Wed, 18 Feb 2015, Lee Jones wrote:

> ST's Low Power Controller (LPC) controls two devices; watchdog and RTC.
> Only one of the devices can be used at any one time.  This is enforced
> by the correlating MFD driver.  This portion of the driver-set controls
> the Real Time Clock.

<snip>

> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rtc->lock, flags);
> +
> +	writel(1, rtc->ioaddr + LPC_WDT_OFF);
> +
> +	writel(msb, rtc->ioaddr + LPC_LPA_MSB_OFF);
> +	writel(lsb, rtc->ioaddr + LPC_LPA_LSB_OFF);
> +	writel(1, rtc->ioaddr + LPC_LPA_START_OFF);
> +
> +	writel(0, rtc->ioaddr + LPC_WDT_OFF);

I think all the writel IO accessors in this driver can be replaced
with the *_relaxed variant. This will avoid the overhead of taking a
spinlock in the l2 outer cache part of writel.

<snip>

> +#ifdef CONFIG_PM_SLEEP
> +static int st_rtc_suspend(struct device *dev)
> +{
> +	struct st_rtc *rtc = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		return 0;
> +
> +	writel(1, rtc->ioaddr + LPC_WDT_OFF);
> +	writel(0, rtc->ioaddr + LPC_LPA_START_OFF);
> +	writel(0, rtc->ioaddr + LPC_WDT_OFF);

Is there a reason for not disabling the IP clock in suspend / resume functions?

regards,

Peter.
