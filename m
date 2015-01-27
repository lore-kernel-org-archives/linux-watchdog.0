Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44127 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933075AbbA0WT3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Jan 2015 17:19:29 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YGETp-002HPW-6l
	for linux-watchdog@vger.kernel.org; Tue, 27 Jan 2015 22:19:29 +0000
Date: Tue, 27 Jan 2015 14:19:09 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	wim@iguana.be, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	paul@crapouillou.net
Subject: Re: [PATCH 1/2] dt: watchdog: Add DT binding documentation for
 jz47xx watchdog timer
Message-ID: <20150127221909.GA21671@roeck-us.net>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <11680810.808F8uDyN0@wuerfel>
 <20150127205229.GA6983@roeck-us.net>
 <16185448.sH4QMJhjYS@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16185448.sH4QMJhjYS@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 27, 2015 at 10:29:49PM +0100, Arnd Bergmann wrote:
> On Tuesday 27 January 2015 12:52:29 Guenter Roeck wrote:
> > Driver does this (today):
> > 
> >          drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
> > 
> > Isn't that the name to use ? Just wondering.
> 
> Just because the driver uses it at the moment does not mean it's the name
> that the IP block uses.
> 
> clk_get() has the unpleasant property of doing fuzzy matching
> on the name that is passed. It first tries to use the string
> as the name of the clock input of the device, but if that is
> not there, it falls back to looking for a global clk with a con_id.
> 
> In DT, we only support the first kind, but if a driver currently
> uses the second, you get the wrong name.
> 
> Looking at arch/mips/jz4740/clock.c now, this seems to be exactly
> what is going on here: there is no clkdev_add call to associate
> the device clocks, so it can only match a global clock entry. :(
> 
Me confused :-(.

Does that mean the driver needs to be fixed, that the DT property
needs to change (to what ?), or both ?

Thanks,
Guenter
