Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:59325 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752794AbaBXTx1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 24 Feb 2014 14:53:27 -0500
Date: Mon, 24 Feb 2014 20:53:26 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Jingoo Han <jg1.han@samsung.com>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>
Subject: Re: [PATCH 0/8] watchdog: Remove unnecessary OOM messages
Message-ID: <20140224195326.GC20712@spo001.leaseweb.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jingoo,

> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().
> 
> Jingoo Han (8):
>       watchdog: at32ap700x: Remove unnecessary OOM messages
>       watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static
>       watchdog: bcm2835: Remove unnecessary OOM messages
>       watchdog: da9052: Remove unnecessary OOM messages
>       watchdog: da9055: Remove unnecessary OOM messages
>       watchdog: pcwd_usb: Remove unnecessary OOM messages
>       watchdog: sp805_wdt: Remove unnecessary OOM messages
>       watchdog: ts72xx_wdt: Remove unnecessary OOM messages
>       watchdog: wm831x: Remove unnecessary OOM messages
> 
> ---
>  drivers/watchdog/at32ap700x_wdt.c |    4 +---
>  drivers/watchdog/bcm2835_wdt.c    |    4 +---
>  drivers/watchdog/da9052_wdt.c     |    1 -
>  drivers/watchdog/da9055_wdt.c     |    4 +---
>  drivers/watchdog/pcwd_usb.c       |    4 +---
>  drivers/watchdog/sp805_wdt.c      |    1 -
>  drivers/watchdog/ts72xx_wdt.c     |    6 ++----
>  drivers/watchdog/wm831x_wdt.c     |    1 -
>  8 files changed, 6 insertions(+), 19 deletions(-)
> 

This has been added as a single patch to linux-watchdog-next.

Kind regards,
Wim.

