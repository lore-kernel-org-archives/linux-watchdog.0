Return-Path: <lee.jones@linaro.org>
Return-path: <lee.jones@linaro.org>
Date: Tue, 24 Oct 2017 13:24:06 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux@roeck-us.net" <linux@roeck-us.net>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Stefan Christ <s.christ@phytec.de>
Subject: Re: [PATCH 2/6] mfd: da9062: make register CONFIG_I writable
Message-ID: <20171024122406.qrdjz7frxyvnkwkb@dell>
References: <20171017153027.24665-1-m.grzeschik@pengutronix.de>
 <20171017153027.24665-3-m.grzeschik@pengutronix.de>
 <20171024102431.n5isgkgi4ltcynqz@dell>
 <6ED8E3B22081A4459DAC7699F3695FB70194133B76@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB70194133B76@SW-EX-MBX02.diasemi.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, 24 Oct 2017, Steve Twiss wrote:

> Hi Lee,
> 
> On 24 October 2017 11:25, Lee Jones wrote:
> 
> > Subject: Re: [PATCH 2/6] mfd: da9062: make register CONFIG_I writable
> > 
> > On Tue, 17 Oct 2017, Michael Grzeschik wrote:
> > > From: Stefan Christ <s.christ@phytec.de>
> > >
> > > Make the config register CONFIG_I writable to change the watchdog mode.
> > > The datasheet does not mention exactly whether these registers should be
> > > read-only or writeable. But writing to those registers works at runtime.
> > > Only on reset they are reseted.
> > >
> > > Signed-off-by: Stefan Christ <s.christ@phytec.de>
> > > Signed-off-by: Christian Hemp <c.hemp@phytec.de>
> > > ---
> > >  drivers/mfd/da9062-core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Setting CONFIG_I to be writable (and allowing WATCHDOG_SD bit changes to that register)
> is probably not a great idea. On the face of it, the change is fairly innocuous but it will
> allow the PMIC's behaviour to be modified during kernel run-time.
> 
> That change can be done, but making it a permanent change in the general Linux kernel driver
> would indicate it is okay to change the CONFIG_I registers during normal run-time operation,
> and generally I do not think this is okay.
> 
> - [PATCH 3/6] watchdog: da9062: reset board on watchdog timeout
>   https://www.spinics.net/lists/linux-watchdog/msg12680.html
> 
> I suggested if CONFIG_I is to be altered, then this register could be modified before the
> Linux kernel driver has started, e.g. early in the bootloader; or the change chould be done
> in hardware by writing the persistent OTP in the device. If necessary, the Linux kernel driver
> can read the CONFIG_I register and modify its behaviour accordingly. In both cases, a write
> access change to CONFIG_I would not be needed.

Understood.  Thanks Steve.

Ack revoked.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
