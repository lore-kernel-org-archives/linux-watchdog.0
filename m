Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49076 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750895AbaA0HSz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jan 2014 02:18:55 -0500
Date: Mon, 27 Jan 2014 04:18:59 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 04/15] watchdog: orion: Handle IRQ
Message-ID: <20140127071858.GB17506@localhost>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE84A6.6090909@roeck-us.net>
 <20140127063040.GA17506@localhost>
 <52E5FFCB.5000802@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <52E5FFCB.5000802@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Jan 26, 2014 at 10:42:19PM -0800, Guenter Roeck wrote:
> On 01/26/2014 10:30 PM, Ezequiel Garcia wrote:
> > Hi Guenter,
> >
> > On Tue, Jan 21, 2014 at 06:31:02AM -0800, Guenter Roeck wrote:
> > [..]
> >>> @@ -131,6 +138,19 @@ static int orion_wdt_probe(struct platform_d=
evice *pdev)
> >>>    	if (!wdt_reg)
> >>>    		return -ENOMEM;
> >>>
> >>> +	irq =3D platform_get_irq(pdev, 0);
> >>> +	if (irq > 0) {
> >>
> >> 0 is a valid interrupt number, and platform_get_irq returns an err=
or code on errors.
> >> Should be >=3D 0.
> >>
> >
> > I'm revisiting this one. I believe this is not the hardware interru=
pt
> > number, but the one mapped into virq space. So, 0 is not a valid
> > interrupt number.
> >
> > Right?
> >
>=20
> If so, the entire interrupt numbering scheme appears broken. Conceptu=
ally it should
> not make a difference where the interrupt is coming from. If the virq=
 system
> returns 0 for invalid (non-configured) interrupts, and non-configured=
 'real'
> interrupts are reported as -ENXIO, all bets are off. How would a driv=
er know
> what to expect ? And how would one be expected to review such non-det=
erministic
> code ?
>=20

I wouldn't know that much. I'm just pointing out that '0' doesn't seem
to be a valid IRQ number in this context (i.e. virq space).

> FWIW, platform_get_irq() does return -ENXIO for invalid interrupts. I=
f there
> is an independent notion of "0 is an invalid interrupt", it is well h=
idden.
>=20

Yes, AFAICS platform_get_irq() returns a negative error or a positive
irq number. I fail to see how it's able return '0' (of course, I can be
wrong).

> Anyway, if you think the driver should treat 0 as invalid interrupt, =
go ahead.
> Who am I to know. Just please don't use my Reviewed-by in this case.
>=20

Quite frankly not sure how to handle this best. A quick grep through th=
e
code doesn't help either: lots of drivers treat 0 as a valid interrupt
and lots treat it as invalid. So I guess it doesn't really matter...

Can someone shed a light on this?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
