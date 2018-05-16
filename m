Return-Path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
Return-path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
Date: Wed, 16 May 2018 11:01:29 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: Steve Twiss <stwiss.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
	Support Opensource <Support.Opensource@diasemi.com>,
	"fzuuzf@googlemail.com" <fzuuzf@googlemail.com>,
	Guenter Roeck <groeck7@gmail.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
Message-ID: <20180516090129.qozynkc4cb523nru@pengutronix.de>
References: <20180509123243.21170-1-m.felsch@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7019417EA41@SW-EX-MBX02.diasemi.com>
 <bec3deb4-6163-ff1c-d84c-47a413845445@pengutronix.de>
 <20180515184412.GC16006@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7019418108B@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7019418108B@SW-EX-MBX02.diasemi.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Steve and Guenter,

On Wed, May 16, 2018 at 07:35:13AM +0000, Steve Twiss wrote:
> On 15 May 2018 19:44, Guenter Roeck wrote,
> 
> > Subject: Re: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
> > 
> > On Wed, May 09, 2018 at 04:10:15PM +0200, Marco Felsch wrote:
> > > Hi Steve,
> > >
> > >
> > > That would be great looking forward to hear from you. I will prepare a v3 if it is.
> > >
> > Any updates ?
> > 
> > Guenter
> 
> Hi Guenter and Marco,
> 
> Thank you for your patience.
> The best advice I can give at the moment is:
> 
> Please follow what has been done in the DA9062 and DA9053 device drivers.
> https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/da9062_wdt.c#L90
> https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/da9052_wdt.c#L76
> 
> In these cases:
> "setting TWDSCALE to zero for at least 150 us before writing the new value"

Okay. I tested it without a delay and saw no issues but I will add the
delay to be on the safe side.
Is that okay for you Guenter?

> There will be a longer answer, but that must wait until the formal datasheets have
> been clarified by the hardware engineers.
> 
> Regards,
> Steve
> 

Regards,
Marco
