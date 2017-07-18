Return-Path: <lee.jones@linaro.org>
Return-path: <lee.jones@linaro.org>
Date: Tue, 18 Jul 2017 10:22:45 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, wim@iguana.be,
	linux@roeck-us.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] mfd: ds1374: Add Dallas/Maxim DS1374 Multi Function
 Device
Message-ID: <20170718092245.tc5oosbbb6lzvqpy@dell>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
 <1499975665-14581-2-git-send-email-mdf@kernel.org>
 <20170717075117.btnhbmgpofwn7zdk@dell>
 <20170717181409.GB8750@tyrael.ni.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170717181409.GB8750@tyrael.ni.corp.natinst.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, 17 Jul 2017, Moritz Fischer wrote:

> Hi Lee,
> 
> On Mon, Jul 17, 2017 at 08:51:17AM +0100, Lee Jones wrote:
> > On Thu, 13 Jul 2017, Moritz Fischer wrote:
> > 
> > > From: Moritz Fischer <moritz.fischer@ettus.com>
> > > 
> > > Add support for the Maxim/Dallas DS1374 RTC/WDT with trickle charger.
> > > The device can either be configured as simple RTC, as simple RTC with
> > > Alarm (IRQ) as well as simple RTC with watchdog timer.
> > > 
> > > Break up the old monolithic driver in drivers/rtc/rtc-ds1374.c into:
> > > - rtc part in drivers/rtc/rtc-ds1374.c
> > > - watchdog part under drivers/watchdog/ds1374-wdt.c
> > > - mfd part drivers/mfd/ds1374.c
> > > 
> > > The MFD part takes care of trickle charging and mode selection,
> > > since the usage modes of a) RTC + Alarm or b) RTC + WDT
> > > are mutually exclusive.
> > > 
> > > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > > ---
> > >  drivers/mfd/Kconfig              |  10 +
> > >  drivers/mfd/Makefile             |   1 +
> > >  drivers/mfd/ds1374.c             | 260 ++++++++++++++++
> > >  drivers/rtc/rtc-ds1374.c         | 639 ++++++++++-----------------------------
> > 
> > It looks like this should now depend on MFD_DS1374, right?
> > 
> > >  drivers/watchdog/Kconfig         |  10 +
> > >  drivers/watchdog/Makefile        |   1 +
> > >  drivers/watchdog/ds1374-wdt.c    | 208 +++++++++++++
> > 
> > The RTC and Watchdog drivers need to be split out of this patch and
> > placed into their own.  Then we can take them through their respective
> > subsystem trees and do not have to rely on immutable branches for
> > unification.
> 
> Ok, I haven't found a good way to keep this bisectable in that case. I'm
> open to suggestions. If the consensus ends up being to split it up, I'm
> more than happy to separate it out into multiple patches.

If it's genuinely not bisectable, then leave it as is.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
