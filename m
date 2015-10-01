Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41815 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751194AbbJASbd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Oct 2015 14:31:33 -0400
Date: Thu, 1 Oct 2015 20:31:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: harald@ccbib.org
Cc: rtc-linux@googlegroups.com, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [rtc-linux] [PATCH] watchdog: stmp3xxx: Implement GETBOOTSTATUS
Message-ID: <20151001183131.GA10444@piout.net>
References: <1428522355-5164-1-git-send-email-harald@ccbib.org>
 <20150417093023.GF29796@piout.net>
 <3a787a0b2777c4b734a4f153e1a3f7d7@imap.cosmopool.net>
 <20150419153743.GA4353@piout.net>
 <480bd3b38b87b44913868cbd2f3e24c6@imap.cosmopool.net>
 <20150505094031.GH4276@piout.net>
 <c75c3f0a5a1a136bac7c882178b01815@imap.cosmopool.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c75c3f0a5a1a136bac7c882178b01815@imap.cosmopool.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 01/10/2015 at 19:20:32 +0200, harald@ccbib.org wrote :
> Since the rtc and watchdog drivers need different bits of the same control
> register, we would need to use regmap_fields to pass them around.
> Unfortunately this means we can't use the _SET and _CLR registers, which
> means we need to use regmap everywhere to get proper locking. A lot of
> overhead for no benefit.
> 
> After reading lots of messages around the genesis and usage of
> regmap_mmio,
> it seems to me the intended usecases are to fix some endianness issues
> and to have a register cache available during suspend - both of which
> don't
> apply in this case.
> 

I'd say one of the main advantage of regmap is that it does proper
locking of shared registers and I think that is the main reason of using
it when with platform drivers. Obviously, because you have _SET and _CLR
register on that platform you don't really care about locking.

> If you want to get rid of the callbacks we should just pass the pointer
> to the register block to the child device, I think. Which way is
> preferable
> is probably only a matter of taste so I won't override the driver authors
> decision unless there is some clear statement that this is the preferred
> style in the rtc subsystem.
> 

Ok. Like I said, this is not blocking, it was just a cleanup I was
suggesting.
However, this device is clearly an MFD and that callback feels a bit
hackish. Also registering the watchdog would probably better be done
from the mfd subsystem (this is the only RTC driver doing so).
If you have a look at the history, this was a patch from 2011 taken in
2013 so the kernel had plenty of time to evolve in between ;)

We are dealing with legacy and I'm fine with that driver staying that
way until it is absolutely necessary to change it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
