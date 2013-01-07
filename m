Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:39365 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab3AGXx1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 7 Jan 2013 18:53:27 -0500
Date: Mon, 7 Jan 2013 15:53:26 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: Re: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
Message-Id: <20130107155326.6f404914.akpm@linux-foundation.org>
In-Reply-To: <1357307929-1666-2-git-send-email-w.sang@pengutronix.de>
References: <1357307929-1666-1-git-send-email-w.sang@pengutronix.de>
	<1357307929-1666-2-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri,  4 Jan 2013 14:58:47 +0100
Wolfram Sang <w.sang@pengutronix.de> wrote:

> This RTC also includes a watchdog timer. Provide an accessor function for
> setting the watchdog timeout value which will be picked up by a watchdog
> driver. Also register the platform_device for the watchdog here to get the
> boot-time dependencies right. The watchdog driver will depend on this RTC
> driver in Kconfig.

Patch looks OK, but I don't have patches 2-3 and nothing in my tree
enables CONFIG_STMP3XXX_RTC_WATCHDOG.

Wim, please merge this one with the other two if/when you take thenm,
thanks.

