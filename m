Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f182.google.com ([209.85.210.182]:39982 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbeI0T0t (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Sep 2018 15:26:49 -0400
Received: by mail-pf1-f182.google.com with SMTP id s5-v6so1888943pfj.7
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Sep 2018 06:08:37 -0700 (PDT)
Subject: Re: Default behavior of watchdog drivers
To: Jean Delvare <jdelvare@suse.de>, linux-watchdog@vger.kernel.org,
        Martin Wilck <mwilck@suse.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Giel van Schijndel <me@mortis.eu>,
        "Steven J. Hill" <Steven.Hill@cavium.com>
References: <20180927143855.6f8cc48e@endymion>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <253a3ffa-2965-cb74-addb-ebcda2f6ab55@roeck-us.net>
Date: Thu, 27 Sep 2018 06:08:34 -0700
MIME-Version: 1.0
In-Reply-To: <20180927143855.6f8cc48e@endymion>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jean,

On 09/27/2018 05:38 AM, Jean Delvare wrote:
> Hello,
> 
> It seems that various watchdog drivers behave differently if the
> watchdog timer is already enabled when the driver is loaded:
> 
> * iTCO_wdt will disable the timer. I think this is what most drivers
>    do, but not all.
> * w83627hf_wdt will let the timer run, unless option early_disable=1 is
>    passed.
> 
> These are the 2 which bother me the most because they are among the
> most popular watchdog drivers on x86 systems. Having a different
> behavior depending on which driver is used is quite confusing.
> 
> Can we please settle on a default behavior (either all drivers reset
> the timer a load time, or none do it) and have all watchdog drivers
> stick to that?
> 

Since

ee142889e32f watchdog: Introduce WDOG_HW_RUNNING flag
664a39236e71 watchdog: Introduce hardware maximum heartbeat in watchdog core

the default behavior _should_ be that the timer is kept running but the
core is informed that it is running. Of course, that doesn't mean that
(legacy) drivers actually do that.

Please note that some watchdog drivers can not be stopped, so a common
mechanism to stop watchdogs during probe is technically impossible.

> If an option to get the opposite behavior is deemed useful, can we
> settle on a standard name for it? Or even implement it at the
> watchdog_core level, so that each driver doesn't need to implement it
> separately?
> 
> While looking into this, I found a few other strange module parameters:
> 
> * f71808e_wdt has "start_withtimeout", which starts the timer even if
>    nobody opens the watchdog device node. Giel, do we really need this?

We had requests for a common mechanism to do that, ie some kind of boot
timeout. Idea would be to reboot the system if the watchdog device has
not been opened after a set period of time. Maybe that is the idea here.

Guenter

> * octeon-wdt has "disable", which completely disables the watchdog
>    function. This "feature" was sneaked in via commit 381cec022e46
>    ("watchdog: octeon-wdt: File cleaning.") which was supposed to be a
>    cleanup-only patch, without any explanation nor even mention. I can't
>    see how such an option can be useful. If you don't need the driver,
>    just don't load it. Steven, can you explain?
> 
> Thanks,
> 
