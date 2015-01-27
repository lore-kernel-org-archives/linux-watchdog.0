Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64810 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933097AbbA0Wgo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Jan 2015 17:36:44 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
	wim@iguana.be, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	paul@crapouillou.net
Subject: Re: [PATCH 1/2] dt: watchdog: Add DT binding documentation for jz47xx watchdog timer
Date: Tue, 27 Jan 2015 23:36:36 +0100
Message-ID: <2960717.ZtXrNMeS1F@wuerfel>
In-Reply-To: <20150127221909.GA21671@roeck-us.net>
References: <1422371490-44402-1-git-send-email-Zubair.Kakakhel@imgtec.com> <16185448.sH4QMJhjYS@wuerfel> <20150127221909.GA21671@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 27 January 2015 14:19:09 Guenter Roeck wrote:
> On Tue, Jan 27, 2015 at 10:29:49PM +0100, Arnd Bergmann wrote:
> > On Tuesday 27 January 2015 12:52:29 Guenter Roeck wrote:
> > > Driver does this (today):
> > > 
> > >          drvdata->rtc_clk = clk_get(&pdev->dev, "rtc");
> > > 
> > > Isn't that the name to use ? Just wondering.
> > 
> > Just because the driver uses it at the moment does not mean it's the name
> > that the IP block uses.
> > 
> > clk_get() has the unpleasant property of doing fuzzy matching
> > on the name that is passed. It first tries to use the string
> > as the name of the clock input of the device, but if that is
> > not there, it falls back to looking for a global clk with a con_id.
> > 
> > In DT, we only support the first kind, but if a driver currently
> > uses the second, you get the wrong name.
> > 
> > Looking at arch/mips/jz4740/clock.c now, this seems to be exactly
> > what is going on here: there is no clkdev_add call to associate
> > the device clocks, so it can only match a global clock entry. 
> > 
> Me confused :-(.
> 
> Does that mean the driver needs to be fixed, that the DT property
> needs to change (to what ?), or both ?

Both.

The jz47xx clock driver should register a clkdev lookup table with
proper clock input names for each clock that is referenced by a
device, and then the drivers can use the right names.

In a lot of cases, the best name for a clock is no name so you
just use an anonymous clock like

	clk = clk_get(dev, NULL);

but this still requires a clock lookup table.

	Arnd
