Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59994 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbaBKG6v (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:58:51 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T00623KPYJ130@mailout3.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:58:46 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: Re: [PATCH 0/8] watchdog: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:58:44 +0900
Message-id: <001901cf26f6$b4915f30$1db41d90$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday, February 11, 2014 3:47 PM, Jingoo Han wrote:
> 
> The site-specific OOM messages are unnecessary, because they
> duplicate the MM subsystem generic OOM message. For example,
> k.alloc and v.alloc failures use dump_stack().
> 
> Jingoo Han (8):
>       watchdog: at32ap700x: Remove unnecessary OOM messages
>       watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static

There is a mistake. The followings are right.

Jingoo Han (8):
      watchdog: at32ap700x: Remove unnecessary OOM messages
      watchdog: bcm2835: Remove unnecessary OOM messages
      watchdog: da9052: Remove unnecessary OOM messages
      watchdog: da9055: Remove unnecessary OOM messages
      watchdog: pcwd_usb: Remove unnecessary OOM messages
      watchdog: sp805_wdt: Remove unnecessary OOM messages
      watchdog: ts72xx_wdt: Remove unnecessary OOM messages
      watchdog: wm831x: Remove unnecessary OOM messages

Best regards,
Jingoo Han

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

