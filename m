Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38028 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeIJWyy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 10 Sep 2018 18:54:54 -0400
Date: Mon, 10 Sep 2018 10:59:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
        <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH v3 1/2] watchdog: rza_wdt: Support longer timeouts
Message-ID: <20180910175934.GA16216@roeck-us.net>
References: <20180907012243.86603-1-chris.brandt@renesas.com>
 <20180907012243.86603-2-chris.brandt@renesas.com>
 <314e2981-8fbd-43ed-2f2d-c080a2961055@roeck-us.net>
 <TY1PR01MB156229CF6EA73FD0B083B0A18A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <20180910161300.GA19858@roeck-us.net>
 <TY1PR01MB1562909374EEAA97DFAC173C8A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1562909374EEAA97DFAC173C8A050@TY1PR01MB1562.jpnprd01.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Sep 10, 2018 at 05:36:39PM +0000, Chris Brandt wrote:
> On Monday, September 10, 2018 1, Guenter Roeck wrote:
> > > #2. If the CKS is only 4-bits, the max HW timeout is 32 seconds. (so
> > > 'timeout' can never be more that a u8).
> > >
> > That is not the point. The point is that there is no need to keep two
> > 'timeout' variables.
> 
> But there was a reason.
> 
> The reason was that the upper layer would call the .ping() function 
> without calling .start() again.
> 
> Meaning it would change 'timeout' in the structure, but not explicitly 
> tell the driver.
> 

It does that because there is no set_timeout function.

> That why I had to keep track of my own timeout (what the HW was actually
> set to).
> 
> Every time the upper layer calls .ping(), I have to see if the timeout 
> field still matches.
> 
> 
> > > The number "4194304" is exactly how it is documented in the hardware
> > > manual, that is why I'm using it that way. Yes, 0x400000 makes more
> > > sense, but I like matching the device documenting as much as possible to
> > > help the next person that comes along and has to debug this code.
> > >
> > Use at least a define.
> 
> OK.
> 
> 
> > > Because when I was doing all my testing, I found cases where '.ping' was
> > > called from the upper layer without '.start' being called first. So, I
> > > changed the code as you see it now. This guaranteed I would also get the
> > > timeout the user was requesting.
> > >
> > That would only happen if the watchdog is considered to be running.
> > Also, we are talking about the set_timeout function which is the one which
> > should set the timeout and update the HW if needed, ie if the watchdog is
> > already running.
> 
> This driver doesn't have .set_timeout
> 
> static const struct watchdog_ops rza_wdt_ops = {
> 	.owner = THIS_MODULE,
> 	.start = rza_wdt_start,
> 	.stop = rza_wdt_stop,
> 	.ping = rza_wdt_ping,
> 	.restart = rza_wdt_restart,
> };
> 

It wasn't needed before, but that doesn't mean it is not needed now.

> 
> If you really don't like checking in .ping, I can add a set_timeout 
> function and remove the local priv->timeout.
> 

No, I do not like checking and setting the timeout in the ping function
at all. That is what the set_timeout function is for, and I don't see
a point in bypassing the infrastructure.

Guenter
