Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38909 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966732AbbDXJSo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 05:18:44 -0400
Date: Fri, 24 Apr 2015 11:18:40 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@ti.com>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: races in omap_wdt
Message-ID: <20150424091840.GK19431@pengutronix.de>
References: <20150423094354.GD19431@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20150423094354.GD19431@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

[dropped Varadarajan Charulatha and Shubhrajyoti D from the addressees
because the ti mailserver doesn't know them :-(, added Felipe instead]

On Thu, Apr 23, 2015 at 11:43:54AM +0200, Uwe Kleine-König wrote:
> I'm working on an AM335x machine and want to make use of the hardware
> watchdog. I write to you because you contributed to the respective Linux
> driver and judging from your email address you might be in a position to
> help me with a problem I see.
> 
> To get reliable behaviour, I don't want to have situations where the
> watchdog is disabled. There are currently two situation where this
> happens with the current state of linux/drivers/watchdog/omap_wdt.c:
> 
>  a) in omap_wdt_probe() there is an unconditional call to
>     omap_wdt_disable() which stops the counter. Ideally I'd want to take
>     over the hardware in the state that it is in when Linux is started.
>     This is a bit complicated, but should be doable. Would such a patch
>     be welcome?
> 
>  b) The reference manual demands:
> 
> 	To modify the timer counter value (the WDT_WCRR register),
> 	prescaler ratio (the WDT_WCLR[4:2] PTV bit field), delay
> 	configuration value (the WDT_WDLY[31:0] DLY_VALUE bit field), or
> 	the load value (the WDT_WLDR[31:0] TIMER_LOAD bit field), the
> 	watchdog timer must be disabled by using the start/stop sequence
> 	(the WDT_WSPR register).
> 
>     This effectively means (and is implemented accordingly in the
>     driver) that on .set_timeout the driver has to stop the counter.
>     So we have an (admittedly small) unprotected window each time the
>     timeout is set (which happens for example when /dev/watchdog is
>     opened). Is there something that can be done here? I imagine that
>     the above statement from the reference manual could be holding out
>     some details like "When writing a new load value (WDT_WLDR) without
>     stopping the timer first, the new load value doesn't have any
>     influence on the running timer. It is only used on the next trigger
>     event." Is this too much to wish for?
As Felipe predicted (via irc) it's really needed to stop the timer to
reprogram the reload value. I proved this by hacking my bootloader's mw
command to correctly write to the watchdog registers (i.e wait until the
corresponding bit in the Watchdog Write Posting Bits Register disappears
to signal the write has reached the hardware) and did:

	# make the wdog slow
	mw 0x44e35024 0x3c

	# set reload value (WLDR)
	mw 0x44e3502c 0xff000000

	# start wdog
	mw 0x44e35048 0xbbbb
	mw 0x44e35048 0x4444

	# set reload value lower (WLDR)
	mw 0x44e35024 0x00000000

	# trigger
	mw 0x44e35030 0x12345678
	mw 0x44e35030 0x87654321

	# show current counter (WCRR)
	md 0x44e35028+4

	sleep 4

	# trigger again
	mw 0x44e35030 0x12345678
	mw 0x44e35030 0x87654321

	# show current counter (WCRR)
	md 0x44e35028+4

	# stop wdog
	mw 0x44e35048 0xaaaa
	mw 0x44e35048 0x5555

The output is twice

	44e35028: ff000001

:-(.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
