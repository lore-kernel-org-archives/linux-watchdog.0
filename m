Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36452 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcFDHON (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 4 Jun 2016 03:14:13 -0400
Date: Sat, 4 Jun 2016 09:14:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/4] gpio: Allow PC/104 devices on X86_64
Message-ID: <20160604071408.GA22045@amd>
References: <cover.1464029828.git.vilhelm.gray@gmail.com>
 <d7320150373a0a04ba44b12c5c56d92370853316.1464029828.git.vilhelm.gray@gmail.com>
 <20160603205703.GC11253@amd>
 <20160603211244.GA6831@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160603211244.GA6831@sophia>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri 2016-06-03 17:12:44, William Breathitt Gray wrote:
> On Fri, Jun 03, 2016 at 10:57:03PM +0200, Pavel Machek wrote:
> >Hi!
> >
> >> With the introduction of the ISA_BUS_API Kconfig option, ISA-style
> >> drivers may be built for X86_64 architectures. This patch changes the
> >> ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API, thus
> >> allowing them to build for X86_64 as they are expected to.
> >> 
> >> Cc: Guenter Roeck <linux@roeck-us.net>
> >> Cc: Linus Walleij <linus.walleij@linaro.org>
> >> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> >> ---
> >>  drivers/gpio/Kconfig | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> >> index 48da857..dc6da77 100644
> >> --- a/drivers/gpio/Kconfig
> >> +++ b/drivers/gpio/Kconfig
> >> @@ -530,7 +530,7 @@ menu "Port-mapped I/O GPIO drivers"
> >>  
> >>  config GPIO_104_DIO_48E
> >>  	tristate "ACCES 104-DIO-48E GPIO support"
> >> -	depends on ISA
> >> +	depends on ISA_BUS_API
> >>  	select GPIOLIB_IRQCHIP
> >>  	help
> >>  	  Enables GPIO support for the ACCES 104-DIO-48E series
> >
> >Should we do "depends on PC104" here, because that is what it really
> >means, and have PC104 enabled when ISA_BUS_API is enabled or something
> >like that?
> 
> Since the functionality remains the same, I'm a bit indifferent to that
> change; as long as the driver builds for systems in which it's intended
> to be used, I'm satisfied.
> 
> Differentiating between PC/104 and ISA may be a pointless endeavor
> though since both buses appear the same to software. But if it is better
> to differentiate between devices as such, then I see little harm in
> adding a PC104 Kconfig option which follows the ISA_BUS_API Kconfig
> option.

Well, they are same to the software, but not at the hardware. If I
have a development board that has PC104 (but not isa), I'd like to see
prompts for PC104 extensions, not for isa. If PC105 comes out, still
ISA compatible, I will want to see prompts for PC104 boards or PC105
boards, but not neccessarily both...

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
