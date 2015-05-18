Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34755 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752756AbbERRjc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 May 2015 13:39:32 -0400
Date: Mon, 18 May 2015 19:39:27 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Alessandro Zummo <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [rtc-linux] RE: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog
 driver
Message-ID: <20150518173927.GV3338@piout.net>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
 <5555ED4F.5070003@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B6E2@SW-EX-MBX02.diasemi.com>
 <20150515202005.GA23133@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B8C8@SW-EX-MBX02.diasemi.com>
 <20150518152737.GA14403@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22B8FE@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B22B8FE@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 18/05/2015 at 16:03:06 +0000, Opensource [Steve Twiss] wrote :
> > Since the interrupt is optional, the driver should also not fail to load
> > if no interrupt is assigned to it in the first place.
> 
> Yeah. I've been thinking about it and I agree now. I'll erase the handler. 
> 
> > On a separate note, there was a comment stating that the da9062 watchdog
> > is identical to the da9063 watchdog. If so, why can't you just use the da9063
> > watchdog driver ?
> 
> Well, the short answer to this is, it's not the same. I was just in the process of
> replying to that other thread. The OnKey and RTC are functionally similar, so I
> am going to look at integrating the two drivers in some future patch sets, but
> the watchdog is definitely not based upon DA9063.
> 
> I did mention this in a previous thread: 
> https://lkml.org/lkml/2015/5/6/505
> 

Sure, what I understand is that the base functionality is the same and
even the registers are compatible. Are you sure the new features can't
be added to the da9063 and called conditionally? Plenty of drivers are
doing that.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
