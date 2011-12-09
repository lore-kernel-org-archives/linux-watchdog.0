Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:34736
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836Ab1LIAOh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 8 Dec 2011 19:14:37 -0500
Date: Fri, 9 Dec 2011 08:27:24 +0800
From: Shawn Guo <shawn.guo@freescale.com>
To: Wolfram Sang <w.sang@pengutronix.de>
CC: <linux-watchdog@vger.kernel.org>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	<rtc-linux@googlegroups.com>, Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
Message-ID: <20111209002722.GG7913@S2100-06.ap.freescale.net>
References: <1323364783-1059-1-git-send-email-w.sang@pengutronix.de>
 <1323364783-1059-2-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1323364783-1059-2-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wolfram,

On Thu, Dec 08, 2011 at 06:19:41PM +0100, Wolfram Sang wrote:
> @@ -0,0 +1,15 @@
> +/*
> + * stmp3xxx_rtc_wdt.h
> + *
> + * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
> + *
> + * This file is released under the GPLv2.
> + */
> +#ifndef __LINUX_STMP3XXX_RTC_WDT_H
> +#define __LINUX_STMP3XXX_RTC_WDT_H
> +
> +struct stmp3xxx_wdt_pdata {
> +	void (*wdt_set_timeout)(struct device *dev, u32 timeout);

Passing callback with platform_data will make device tree migration
difficult.  Is there any possibility we can save the callback here?

Regards,
Shawn

> +};
> +
> +#endif /* __LINUX_STMP3XXX_RTC_WDT_H */
> -- 
> 1.7.7.3

