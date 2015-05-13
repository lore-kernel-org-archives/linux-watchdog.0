Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:32901 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933335AbbEMM7A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 May 2015 08:59:00 -0400
Date: Wed, 13 May 2015 14:58:58 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
Message-ID: <20150513125858.GX3338@piout.net>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com>
 <20150510095838.GF3338@piout.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 13/05/2015 at 12:31:36 +0000, Opensource [Steve Twiss] wrote :
> Something similar is being discussed for the OnKey component of the DA9062.
> https://lkml.org/lkml/2015/4/24/304
> 
> It is only the OnKey and RTC components that are similar to the DA9063 chip
> and I was hoping to keep the 62 RTC separate in this case ... however it should
> definitely be possible to re-use the DA9063 RTC driver if this is your requirement.
> If this will block my submission of the DA9062 then I will drop the RTC from my
> next patch set and try to re-work the existing 63 RTC driver accordingly.
> 
> I think this sort of thing has been done before:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/rtc/rtc-pm8xxx.c
>  ... at first glance -- it seems to support that sort of thing.
> 

Isn't that exactly the point of using the MFD infrastructure? It allows
to reuse existing drivers even when the IP is part of a different chip.
The RTC inside the da9062 and the da9063 are obviously the same so there
is no point in duplicating the driver.

I'm guessing using da9063-rtc instead of da9062-rtc is just working
fine.

> I guess it would be possible to rename the da9063-rtc to something more sensible like
> da9xxx-rtc.c if this goes ahead?
> 

Sure, that can be done but this means that the module name will change.
if you feel that your current users can cope with that, I'm fine with it.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
