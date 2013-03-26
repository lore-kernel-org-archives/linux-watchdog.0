Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps.mortis.eu ([79.99.135.181]:58833 "EHLO vps.mortis.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753131Ab3CZRdf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Mar 2013 13:33:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 26 Mar 2013 18:26:07 +0100
From: Giel van Schijndel <me@mortis.eu>
To: BrunoFerreira <bruno.ferreira@efacec.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, <linux-watchdog@vger.kernel.org>
Subject: Re: Fintek F81865 chip (Wdog support)
In-Reply-To: <51409586.4030204@efacec.com>
References: <51409586.4030204@efacec.com>
Message-ID: <07936d3ec21c2de67a97b2664c7bf484@mortis.eu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

 On Wed, 13 Mar 2013 15:04:38 +0000, BrunoFerreira wrote:
> I'm currently working with a new board iEi NOVA-PV-D5251 [1] that
> have the Fintek F81865 chip for Super I/O support and I will need to
> develop the watchdog driver and another to access to the IO that this
> board supports (gpio). I made a search and I see that already exists 
> a
> driver for F71808E chip, I use this driver as an example an I made a
> new driver for F81865 chip. My driver is working pretty well, but 
> I've
> a question that I can't find the answer on datasheet of this chip 
> that
> may be Wim or Giel could know.

> On both chips, we need to configure a pin that can work as a normal
> GPIO (F81865: Set pin 70 the function of WDTRST#/GPIO15 is WDTRST# |
> F71808E: Set pin 21 to GPIO23/WDTRST#, then to WDTRST#), this is here
> where I get myself confused, this WDTRST will be mapped in any GPIO
> output on my board? I mean, if the watchdog is enable I will get any
> output pin set to 1 (i.e. the GPIO15, output 5?) and when the 
> watchdog
> goes down this output goes to 0?

 Sorry, I can't give you a definite answer on that. All Fintek 
 datasheets I've seen are very poorly written. At one point I actually 
 stopped trusting the datasheet enough to go through the hassle of 
 hooking up a scope to the pins of the chip.

 Hazarding a guess however, I'd say that when the watchdog is enabled 
 you cannot use the WDTRST pin as a GPIO pin.

> The other question is to Wim, can you tell me if there is interest in
> add this chip support to kernel?

 This would be a yes, unless there are good reasons not to include it in 
 mainline.

-- 
 Giel
