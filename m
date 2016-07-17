Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43784 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751188AbcGQUOL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:14:11 -0400
Date: Sun, 17 Jul 2016 22:14:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: Implement status function in watchdog core
Message-ID: <20160717201409.GL32751@spo001.leaseweb.nl>
References: <20160717195916.GD32751@spo001.leaseweb.nl> <578BE661.9080709@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <578BE661.9080709@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> On 07/17/2016 12:59 PM, Wim Van Sebroeck wrote:
> >Hi Guenter,
> >
> >I didn't find the following patches that are in your tree in my e-mail:
> >watchdog: Improve description of min_hw_heartbeat_ms
> >watchdog: Implement status function in watchdog core
> >watchdog: sbsa: Drop status function
> >watchdog: tangox: Mark running watchdog correctly
> >watchdog: Eliminate status callback
> >
> 
> Interesting. I checked my logs ... looks like I never sent those to the 
> list. Oops :-(. Sorry for that; I thought I did.

No problem :-)

> >I added "watchdog: Improve description of min_hw_heartbeat_ms" and 
> >"watchdog: tangox: Mark running watchdog correctly" to the 
> >linux-watchdog-next tree.
> >
> 
> Great, thanks!
> 
> >I didn't add the status function implementation. The reason is because 
> >there are cards that have means to read certain info life (like pcwd cards 
> >and the wdt cards). The implementation doesn't foresee this functionality 
> >and thus should be corrected first. (for these cards you want to call the 
> >status functions of these cards).
> 
> Ok, thanks for letting me know. I'll have another look.
> 
> What would be the best approach to use for those drivers ? Overlay the data
> from the driver with the data from the watchdog core, or completely rely
> on the data from the driver ?

If the status function call exists, use that one of the driver if not fallback to the generic framework.
But the WDIOF_MAGICCLOSE and WDIOF_KEEPALIVEPING should be looked at seperately: they might need to always be in the generic framework.

Kind regards,
Wim.

