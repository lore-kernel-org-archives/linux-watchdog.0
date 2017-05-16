Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:40408 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdEPIQv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 16 May 2017 04:16:51 -0400
Date: Tue, 16 May 2017 10:16:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Moritz Fischer <mdf@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-watchdog@vger.kernel.org,
        rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, wim@iguana.be, a.zummo@towertech.it,
        mark.rutland@arm.com
Subject: Re: [RFC/PATCH 1/2] dt-binding: mfd: Add Maxim/Dallas DS1374 MFD
 device binding
Message-ID: <20170516081638.xg34g52xpvlkpqfg@piout.net>
References: <1494354021-370-1-git-send-email-mdf@kernel.org>
 <20170513000029.tgzt5p67tcl7uhbx@rob-hp-laptop>
 <20170516023417.GA28179@tyrael.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170516023417.GA28179@tyrael.amer.corp.natinst.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 15/05/2017 at 19:34:17 -0700, Moritz Fischer wrote:
> On Fri, May 12, 2017 at 07:00:29PM -0500, Rob Herring wrote:
> > On Tue, May 09, 2017 at 11:20:20AM -0700, Moritz Fischer wrote:
> > > +			<0> for RTC
> > > +			<1> for RTC + Alarm (Interrupt)
> > > +			<2> for RTC + Watchdog
> > > +
> > > +Required child:
> > > +A single available child device of type matching the "dallas,ds1374-mode"
> > > +property.
> > > +
> > > +Optional properties (watchdog):
> > > +- dallas,ds1374-remap-wdt-reset: Boolean describing whether the INT pin
> > > +				 on the device is used as interrupt for
> > > +				 the alarm
> > 
> > Isn't presence of the interrupt property or not enough? It would be 
> > kind of useless to have no interrupt and also not do anything on 
> > timeout.
> 
> So you're saying:
> 
> If interrupt not present AND mode = <0> ignore interrupt
> 
> If interrupt present AND mode = <1> (maybe define here would be nicer),
> make it an interrupt.
> 

If mode == 1, WDSTR doesn't matter so it will always be on the INT pin
anyway.

> If interrupt not present AND mode = <2> then this implies that reset
> output is mapped to RST pin.
> 
> If Interrupt present AND mode = <2> then this implies that the reset
> output is (re)mapped to INT pin?
> 

Yes, I think this is sufficient.



-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
