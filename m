Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.167]:42510 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753121AbbESIev convert rfc822-to-8bit
	(ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:34:51 -0400
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"Alessandro Zummo" <a.zummo@towertech.it>,
	DEVICETREE <devicetree@vger.kernel.org>,
	"David Dajun Chen" <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	"Support Opensource" <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: RE: [rtc-linux] [PATCH V2 1/4] mfd: da9062: DA9062 MFD core driver
Date: Tue, 19 May 2015 08:34:45 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B961@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <af5a7d289bb149e9111ebc70bb0589a994ee2407.1431621833.git.stwiss.opensource@diasemi.com>
 <20150516085328.GI3338@piout.net>
In-Reply-To: <20150516085328.GI3338@piout.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 16 May 2015 09:53 Alexandre Belloni wrote:

Hi Alexandre,

> On 14/05/2015 at 17:43:52 +0100, S Twiss wrote :

[...]

> > +	{
> > +		.name		= "da9062-watchdog",
> > +		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
> > +		.resources	= da9062_wdt_resources,
> > +		.of_compatible  = "dlg,da9062-wdt",
> > +	},
> > +	{
> > +		.name		= "da9062-onkey",
> > +		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
> > +		.resources	= da9062_onkey_resources,
> > +		.of_compatible  = "dlg,da9062-onkey",
> > +	},
> > +	{
> > +		.name		= "da9062-thermal",
> > +		.num_resources	= ARRAY_SIZE(da9062_thermal_resources),
> > +		.resources	= da9062_thermal_resources,
> > +		.of_compatible  = "dlg,da9062-thermal",
> > +	},
> > +	{
> > +		.name		= "da9062-rtc",
> > +		.num_resources	= ARRAY_SIZE(da9062_rtc_resources),
> > +		.resources	= da9062_rtc_resources,
> > +		.of_compatible  = "dlg,da9062-rtc",
> 
> Did you try to use "da9063-rtc"? The register set seems to be exactly
> the same. Unfortunately, the datasheet are not available on the diasemi
> website...

I will remove the DA9062 OnKey and RTC parts with a view to putting them back
when I do the work for the DA9063 alterations.

> Also, the .of_compatibles are not necessary because you don't add any of
> bindings to the underlying drivers. The match happens on .name.
> 
> > diff --git a/include/linux/mfd/da9062/registers.h
> b/include/linux/mfd/da9062/registers.h
> > new file mode 100644
> > index 0000000..d07c2bc
> > --- /dev/null
> > +++ b/include/linux/mfd/da9062/registers.h
> 
> Comparing that file with da9063/registers.h, It really seems that
> DA062AA, DA9063AD and DA9063BB are register compatible, apart from a
> few
> differences in the regulator and the gpio count.
> 
> Also, at least the watchdog and rtc driver are duplicating their da9063
> counterpart. I'm not trying to annoy you, I just want you to understand
> that the less code is duplicated, the easiest it will be to maintain
> later.

This has come up a lot lately.

https://lkml.org/lkml/2015/4/24/304
https://lkml.org/lkml/2015/5/13/383
https://lkml.org/lkml/2015/5/6/505
https://lkml.org/lkml/2015/5/18/511

The short answer is that the DA9062 and DA9063 chips are not identical. Although
their numbers are sequential and there are functional similarities for some of the
components, this is not the norm for the two chips.

In some cases re-using driver components from DA9063 is a good way forward, but
making all components part of a monolithic driver would make both DA9062 and
DA9063 over complicated and unmaintainable -- in my opinion.

However it's not just my opinion we have to consider here I think.

The RTC and OnKey in this case can be done fairly easily I think -- there can be some
re-use in those components -- although there are fairly important RTC differences between
the DA9063 AD and DA9063 BB silicon revisions (in the form of a new register, different
functionality in the alarm and a register shift). So even that is not a straight-forward
"swap" to run DA9062.

Regards,
Steve

