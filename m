Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54509 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbbDWJn7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Apr 2015 05:43:59 -0400
Date: Thu, 23 Apr 2015 11:43:54 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Lokesh Vutla <lokeshvutla@ti.com>,
	Shubhrajyoti D <shubhrajyoti@ti.com>,
	Varadarajan Charulatha <charu@ti.com>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: races in omap_wdt
Message-ID: <20150423094354.GD19431@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

I'm working on an AM335x machine and want to make use of the hardware
watchdog. I write to you because you contributed to the respective Linux
driver and judging from your email address you might be in a position to
help me with a problem I see.

To get reliable behaviour, I don't want to have situations where the
watchdog is disabled. There are currently two situation where this
happens with the current state of linux/drivers/watchdog/omap_wdt.c:

 a) in omap_wdt_probe() there is an unconditional call to
    omap_wdt_disable() which stops the counter. Ideally I'd want to take
    over the hardware in the state that it is in when Linux is started.
    This is a bit complicated, but should be doable. Would such a patch
    be welcome?

 b) The reference manual demands:

	To modify the timer counter value (the WDT_WCRR register),
	prescaler ratio (the WDT_WCLR[4:2] PTV bit field), delay
	configuration value (the WDT_WDLY[31:0] DLY_VALUE bit field), or
	the load value (the WDT_WLDR[31:0] TIMER_LOAD bit field), the
	watchdog timer must be disabled by using the start/stop sequence
	(the WDT_WSPR register).

    This effectively means (and is implemented accordingly in the
    driver) that on .set_timeout the driver has to stop the counter.
    So we have an (admittedly small) unprotected window each time the
    timeout is set (which happens for example when /dev/watchdog is
    opened). Is there something that can be done here? I imagine that
    the above statement from the reference manual could be holding out
    some details like "When writing a new load value (WDT_WLDR) without
    stopping the timer first, the new load value doesn't have any
    influence on the running timer. It is only used on the next trigger
    event." Is this too much to wish for?

    Maybe you can forward this problem to one of the hardware guys at TI
    who can give a definite picture what happens at the hardware level
    when the load value is updated for a running watchdog?
    (This would also simplify the patch for case a). For a) it would be
    nice to know the according details for the WDT_WCLR register, too.)

Thanks in advance,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
