Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44406 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcFETY2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 5 Jun 2016 15:24:28 -0400
Date: Sun, 5 Jun 2016 21:24:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160605192424.GB20086@amd>
References: <cover.1464029828.git.vilhelm.gray@gmail.com>
 <d7320150373a0a04ba44b12c5c56d92370853316.1464029828.git.vilhelm.gray@gmail.com>
 <20160603205703.GC11253@amd>
 <20160603211244.GA6831@sophia>
 <20160604071408.GA22045@amd>
 <20160604111204.GA19180@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160604111204.GA19180@sophia>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat 2016-06-04 07:12:21, William Breathitt Gray wrote:
> On Sat, Jun 04, 2016 at 09:14:08AM +0200, Pavel Machek wrote:
> >On Fri 2016-06-03 17:12:44, William Breathitt Gray wrote:
> >> On Fri, Jun 03, 2016 at 10:57:03PM +0200, Pavel Machek wrote:
> >> >Should we do "depends on PC104" here, because that is what it really
> >> >means, and have PC104 enabled when ISA_BUS_API is enabled or something
> >> >like that?
> >> 
> >> Since the functionality remains the same, I'm a bit indifferent to that
> >> change; as long as the driver builds for systems in which it's intended
> >> to be used, I'm satisfied.
> >> 
> >> Differentiating between PC/104 and ISA may be a pointless endeavor
> >> though since both buses appear the same to software. But if it is better
> >> to differentiate between devices as such, then I see little harm in
> >> adding a PC104 Kconfig option which follows the ISA_BUS_API Kconfig
> >> option.
> >
> >Well, they are same to the software, but not at the hardware. If I
> >have a development board that has PC104 (but not isa), I'd like to see
> >prompts for PC104 extensions, not for isa. If PC105 comes out, still
> >ISA compatible, I will want to see prompts for PC104 boards or PC105
> >boards, but not neccessarily both...
> 
> I think I see the merit of a prompt for PC104 devices. I've encountered
> a use case recently which I'm curious about in this scenario. Given the
> compatibility with ISA, manufacturers may occasionally develop variants
> of existing ISA devices by duplicating the firmware on a PC/104 form
> factor.
> 
> I'm working on an IIO DAC driver for the Measurement Computing CIO-DAC
> family (CIO-DAC08, CIO-DAC16, and PC104-DAC06); while not a GPIO driver,
> I believe it can serve as a decent example. Interestingly, while the
> CIO-DAC08 and CIO-DAC16 are true ISA devices, the PC104-DAC06 is a
> PC/104 variant compatible with the others in the family. The IIO DAC
> driver works just as well with the PC104-DAC06, as it does with the true
> ISA devices in the family.
> 
> What would the Kconfig depends line look in this scenario? I imagine
> simply "depends on PC104" would be inappropriate since there are a
> number of true ISA devices supported by the driver, but "depends on
> ISA_BUS_API || PC104" seems somewhat redundant when the PC104 Kconfig
> option implies ISA_BUS_API. This situation isn't that much of an issue
> overall, but I anticipate encountering it occassionally as I develop
> future PC/104 drivers.

ISA_BUS_API || PC104 sounds fine to me. But it seems probable to me
that such devices will be connectable by PC104 and something else that
is logically ISA but physically something else...?

So in such case it would be logical to have driver depend on PC104 ||
SOMETHING_ELSE. Of course, if some hardware is so common it is on many
such buses, we can use ISA_BUS_API...

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
