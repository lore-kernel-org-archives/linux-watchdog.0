Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42656 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331Ab3KTIOP (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 20 Nov 2013 03:14:15 -0500
Date: Wed, 20 Nov 2013 09:14:07 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: Drop unnecessary include of miscdevice.h
Message-ID: <20131120091407.1a94acbf@endymion.delvare>
In-Reply-To: <1384896377-32382-1-git-send-email-linux@roeck-us.net>
References: <1384896377-32382-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

On Tue, 19 Nov 2013 13:26:17 -0800, Guenter Roeck wrote:
> After commit 487722cf2 (watchdog: Get rid of MODULE_ALIAS_MISCDEV
> statements) the affected drivers no longer need to include miscdevice.h.
> Only exception is rt2880_wdt.c which never needed it.

I'm surprised because I thought I did check after applying my changes
and had removed the #include <linux/miscdevice.h> every time it was OK
to do so. But apparently I missed many...  Thanks for noticing.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Compile tested.
> 
>  drivers/watchdog/bcm2835_wdt.c      |    1 -
>  drivers/watchdog/ep93xx_wdt.c       |    1 -
>  drivers/watchdog/ie6xx_wdt.c        |    1 -
>  drivers/watchdog/jz4740_wdt.c       |    1 -
>  drivers/watchdog/kempld_wdt.c       |    1 -
>  drivers/watchdog/max63xx_wdt.c      |    1 -
>  drivers/watchdog/orion_wdt.c        |    1 -
>  drivers/watchdog/pnx4008_wdt.c      |    1 -
>  drivers/watchdog/rt2880_wdt.c       |    1 -
>  drivers/watchdog/shwdt.c            |    1 -
>  drivers/watchdog/softdog.c          |    1 -
>  drivers/watchdog/stmp3xxx_rtc_wdt.c |    1 -
>  drivers/watchdog/txx9wdt.c          |    1 -
>  drivers/watchdog/ux500_wdt.c        |    1 -
>  14 files changed, 14 deletions(-)
> (...)

-- 
Jean Delvare
Suse L3 Support
