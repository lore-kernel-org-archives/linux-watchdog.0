Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]:10834
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753900Ab3LFTfY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Dec 2013 14:35:24 -0500
Message-ID: <1386358508.7375.133.camel@snotra.buserror.net>
Subject: Re: [PATCH] watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
From: Scott Wood <scottwood@freescale.com>
To: Wolfgang Denk <wd@denx.de>
CC: Guenter Roeck <linux@roeck-us.net>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Date: Fri, 6 Dec 2013 13:35:08 -0600
In-Reply-To: <20131202061418.05A11380BFE@gemini.denx.de>
References: <20131130154540.E83D743E15@localhost.localdomain>
	 <529B9152.9090106@roeck-us.net> <20131202061418.05A11380BFE@gemini.denx.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2013-12-02 at 07:14 +0100, Wolfgang Denk wrote:
> Dear Guenter,
> 
> In message <529B9152.9090106@roeck-us.net> you wrote:
> > On 11/30/2013 07:45 AM, Christophe Leroy wrote:
> > > MPC8xx watchdog is enabled at startup by HW.
> > > If the bootloader disables it, it cannot be reenabled.
> > 
> > Is that true for all variants of 8xx, especially for 823 ? I am a bit concerned
> > about breaking compatibility with some chips ... assuming there was a reason
> > for not setting this flag originally.
> 
> This is correct, and applies for all variants of the MPC8xx, including
> the MPC823 / MPC823E.  From the UM:
> 
> 	"The software watchdog timer can be disabled or its timeout
> 	period can be changed in the SYPCR. Once the SYPCR is written,
> 	it cannot be written again until a system reset."
> 
> Actually this is the only correct behaviour.  Any watchdog that can be
> disabled by software is not worth it's name, and unsuitable for any
> kind of aplications where security / reliability are required.

An optional locked state is a good thing, but making that the only way
the watchdog can function can render the watchdog unusable in systems
that need to go into low power states (unless the low power state
supresses the watchdog).  And then there's broken hybrid things like the
booke watchdog, where you can't disable the watchdog reset action once
configured, but you can change the timeout to be effectively infinite
(which we've used as a workaround when entering low power states).

-Scott



