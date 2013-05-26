Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:48124 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754183Ab3EZQoN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 May 2013 12:44:13 -0400
Date: Sun, 26 May 2013 18:44:10 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Giel van Schijndel <me@mortis.eu>
Cc: BrunoFerreira <bruno.ferreira@efacec.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: Fintek F81865 chip (Wdog support)
Message-ID: <20130526164410.GA8274@spo001.leaseweb.com>
References: <51409586.4030204@efacec.com> <07936d3ec21c2de67a97b2664c7bf484@mortis.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07936d3ec21c2de67a97b2664c7bf484@mortis.eu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi All,

> On Wed, 13 Mar 2013 15:04:38 +0000, BrunoFerreira wrote:
> >I'm currently working with a new board iEi NOVA-PV-D5251 [1] that
> >have the Fintek F81865 chip for Super I/O support and I will need to
> >develop the watchdog driver and another to access to the IO that this
> >board supports (gpio). I made a search and I see that already exists 
> >a
> >driver for F71808E chip, I use this driver as an example an I made a
> >new driver for F81865 chip. My driver is working pretty well, but 
> >I've
> >a question that I can't find the answer on datasheet of this chip 
> >that
> >may be Wim or Giel could know.
> 
> >On both chips, we need to configure a pin that can work as a normal
> >GPIO (F81865: Set pin 70 the function of WDTRST#/GPIO15 is WDTRST# |
> >F71808E: Set pin 21 to GPIO23/WDTRST#, then to WDTRST#), this is here
> >where I get myself confused, this WDTRST will be mapped in any GPIO
> >output on my board? I mean, if the watchdog is enable I will get any
> >output pin set to 1 (i.e. the GPIO15, output 5?) and when the 
> >watchdog
> >goes down this output goes to 0?
> 
> Sorry, I can't give you a definite answer on that. All Fintek 
> datasheets I've seen are very poorly written. At one point I actually 
> stopped trusting the datasheet enough to go through the hassle of 
> hooking up a scope to the pins of the chip.
> 
> Hazarding a guess however, I'd say that when the watchdog is enabled 
> you cannot use the WDTRST pin as a GPIO pin.
> 
> >The other question is to Wim, can you tell me if there is interest in
> >add this chip support to kernel?
> 
> This would be a yes, unless there are good reasons not to include it in 
> mainline.

The answer is indeed yes. Has a patch been created since this message?

Kind regards,
Wim.

