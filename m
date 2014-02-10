Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:57544 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbaBJQ5B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Feb 2014 11:57:01 -0500
Message-ID: <20140210105700.16955eu5u42a9xoo@67.228.131.205>
Date: Mon, 10 Feb 2014 10:57:00 -0600
From: linux@roeck-us.net
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 05/19] watchdog: orion: Make sure the watchdog is
 initially stopped
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1391707226-18258-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <52F43ED0.4050808@roeck-us.net> <20140207104044.GA11063@localhost>
 <20140207174314.GB16263@obsidianresearch.com>
 <20140210122223.GF10872@localhost>
 <20140210104850.48324szjwjihb7cw@67.228.131.205>
 <20140210165405.GF15607@localhost>
In-Reply-To: <20140210165405.GF15607@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Quoting Ezequiel Garcia <ezequiel.garcia@free-electrons.com>:

> On Mon, Feb 10, 2014 at 10:48:50AM -0600, linux@roeck-us.net wrote:
>> Quoting Ezequiel Garcia <ezequiel.garcia@free-electrons.com>:
>>
>> > On Fri, Feb 07, 2014 at 10:43:14AM -0700, Jason Gunthorpe wrote:
>> >> On Fri, Feb 07, 2014 at 07:40:45AM -0300, Ezequiel Garcia wrote:
>> >>
>> >> > Well, this is related to the discussion about the bootloader not
>> >> > reseting the watchdog properly, provoking spurious watchdog triggering.
>> >> >
>> >> > Jason Gunthorpe explained [1] that we needed a particular sequence:
>> >> >
>> >> >  1. Disable WDT
>> >> >  2. Clear bridge
>> >> >  3. Enable WDT
>> >> >
>> >> > We added the irq handling to satisfy (2), and the watchdog  
>> stop for (1).
>> >>
>> >> The issue here is the driver configures two 'machine kill' elements:
>> >> the PANIC IRQ and the RstOut setup.
>> >>
>> >> Before configuring either of those the driver needs to ensure that any
>> >> old watchdog events are cleared out of the HW. We must not get a
>> >> spurious event.
>> >>
>> >> I agree not disabling an already functional and properly configured
>> >> counter from the bootloader is desirable.
>> >>
>> >> So lets break it down a bit..
>> >>
>> >> 1) The IRQ:
>> >>   It looks like the cause bit latches high on watchdog timer
>> >>   expiration but has no side effect unless it is unmasked.
>> >>
>> >>   The new IRQ flow code ensures the bit is cleared during request_irq
>> >>   so no old events can trigger the IRQ. Thus it is solved now.
>> >>
>> >
>> > Agreed.
>> >
>> >> 3) The timer itself:
>> >>   The WDT is just a general timer with an optional hookup to the
>> >>   rst control. If it is harmlessly counting but not resetting we need
>> >>   to stop that before enabling rst out.
>> >>
>> >
>> > Actually, the current flow is to:
>> >
>> > 1. Disable rst out and then disable the counter, in probe().
>> >
>> > 2. Enable the counter, and then enable rst out, in start().
>> >
>> >> So, how about this for psuedo-code in probe:
>> >>
>> >> if (readl(RSTOUTn) & WDRstOutEn)
>> >> {
>> >>     /* Watchdog is configured and may be down counting,
>> >>        don't touch it */
>> >>     request_irq(..);
>> >> }
>> >> else
>> >> {
>> >>     /* Watchdog is not configured, fully disable the timer
>> >>        and configure for watchdog operation. */
>> >>     disable_watchdog();
>> >>     request_irq();
>> >>     writel(RSTOUTn), .. WDRstOutEn);
>> >> }
>> >>
>> >
>> > Sounds good, although it seems to me it's actually simpler:
>> >
>> >   /* Let's make sure the watchdog is fully stopped, unless
>> >    * it's explicitly enabled and running
>> >    */
>> >   if ( !(wdt_rst_out_en && wdt_timer_enabled) ) {
>> >     watchdog_stop();
>> >   }
>> >
>>
>>      if (!wdt_rst_out_en || !wdt_timer_enabled)
>>          watchdog_stop();
>>
>> seems to be a bit easier to understand.
>>
>
> Yeah, I was actually planning to have a orion_wdt_enabled() function
> to get the running and enabled status. Looks cleaner I think.
>
> 	if (!orion_wdt_enabled())
> 		watchdog_stop();
>
> So the idea is OK?
>
Sounds good to me.

> I'll push the new series in a short while. Unfortunately, this change
> means I have to rebase almost all the series, because I introduce the
> orion watchdog struct :-(

Just trying to keep you busy :-)

Guenter


