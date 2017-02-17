Return-path: <Chris.Brandt@renesas.com>
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Sebastian Reichel <sre@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Simon
 Horman" <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] power: reset: Add Renesas reset driver
Date: Fri, 17 Feb 2017 02:00:48 +0000
Message-ID: <PS1PR06MB11622077DE4673C1879C05278A5D0@PS1PR06MB1162.apcprd06.prod.outlook.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-2-chris.brandt@renesas.com>
 <20170216182644.GA17814@roeck-us.net>
 <PS1PR06MB1162A4C12D144C321379E3028A5A0@PS1PR06MB1162.apcprd06.prod.outlook.com>
 <20170216222014.GA29672@roeck-us.net>
In-Reply-To: <20170216222014.GA29672@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday, February 16, 2017, Guenter Roeck wrote:
> Hmm, ok. Guess I don't have to understand that you can not use the
> watchdog driver because of the above, but implementing exactly the same
> functionality in a separate driver is ok.
>=20
> [ I am sure I am missing something here, so just ignore what I am saying =
]

Honestly, I don't have a handle on all the latest 'policies and procedures'
for all the various subsystems. All I know is that I want to figure out how
to execute my 5 lines of code to reset the system when the user types "rebo=
ot"
on the command line.

If this WDT had a timeout longer than 125ms, I would make a real watchdog d=
river
out of it. But at the moment, it just serves as the only way to reset the c=
hip.
Historically, this was the only way to reset a SH4 device...and we just liv=
ed
with that fact. When Renesas moved from SH4 to ARM, a lot of the design tea=
ms
just kept the same philosophy (and copied the HW blocks they knew already w=
orked)


> > > > v2: * changed DT bindings from 'wdt-reset' to 'rza-wdt' * changed
> > > > hard coded register values to defines * added msleep to while(1)
> > > > loop
> > >
> > > Sure you can sleep here ?
> >
> > As per Geert's review:
> >
> > On Wednesday, February 15, 2017, Geert Uytterhoeven wrote:
> > > > + +       /* Wait for WDT overflow */ +       while (1)
> +               ;
> > >
> > > This burns CPU, and thus power, albeit for a very short time.
> > > Perhaps add an msleep() to the loop body?
> >
> > Note that you only have 7.7us before the restart occurs, so probably
> > not much sleeping will be going on.
> >
> Let me rephrase my question. Is it guaranteed that you _can_ sleep in thi=
s
> function, or in other words that it is guaranteed that interrupts are
> enabled ?

Hmm, I'm not sure if will actually 'sleep' or not. Regardless, interrupts o=
r not,
in 7.7us, the internal reset circuit is going to get triggered and the whol=
e system
is going to reboot not matter what is going on.

I know Geert's suggestion was in reference to saving power...but in reality=
 it's
probably negligible when we are talking about 7.7us. The reboot is going to
automatically shut off all the peripherals clocks as well.


Chris
