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
Date: Thu, 16 Feb 2017 18:40:05 +0000
Message-ID: <PS1PR06MB1162A4C12D144C321379E3028A5A0@PS1PR06MB1162.apcprd06.prod.outlook.com>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-2-chris.brandt@renesas.com>
 <20170216182644.GA17814@roeck-us.net>
In-Reply-To: <20170216182644.GA17814@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday, February 16, 2017, Guenter Roeck wrote:
> On Thu, Feb 16, 2017 at 12:23:18PM -0500, Chris Brandt wrote:
> > Some Renesas SoCs do not have a reset register and the only way to do
> > a SW controlled reset is to use the watchdog timer. Additionally,
> > since all the WDT timeout options are so quick, a system reset is
> > about the only thing it's good for.
> >
> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Wondering - why not use the watchdog driver and the infrastructure
> provided by the watchdog core (ie the restart callback) instead ?

That was Geert's first suggestion, but then he said:

On Friday, February 10, 2017, Geert Uytterhoeven wrote:
> On Fri, Feb 10, 2017 at 3:59 PM, Chris Brandt <Chris.Brandt@renesas.com>
> wrote:
> > On Friday, February 10, 2017, Geert Uytterhoeven wrote:
> >> >  static const char *const r7s72100_boards_compat_dt[] __initconst =
=3D {
> >> >         "renesas,r7s72100",
> >> >         NULL,
> >> > @@ -29,4 +58,5 @@ DT_MACHINE_START(R7S72100_DT, "Generic R7S72100
> >> (Flattened Device Tree)")
> >> >         .init_early     =3D shmobile_init_delay,
> >> >         .init_late      =3D shmobile_init_late,
> >> >         .dt_compat      =3D r7s72100_boards_compat_dt,
> >> > +       .restart        =3D r7s72100_restart,
> >> >  MACHINE_END
> >>
> >> Perhaps unsurprisingly, I'd recommend writing a watchdog driver instea=
d.
> >> drivers/watchdog/renesas_wdt.c (currently supporting R-Car Gen3 only)
> >> may serve as an example.
> >
> > Why do you guys always make things more difficult for me... ;)
> >
> > To be clear, you are recommending I make a WDT timer driver (and not
> > use .restart) and that will reset the system?
> >
> > Or, make a WDT driver just so I can steal the base address?
>=20
> I meant a WDT timer driver. If the watchdog driver provides a .restart
> callback, it will be used for system reset (hmm, renesas_wdt.c no longer
> has the .restart callback, as per arm64 "system reset must be implemented
> using PSCI"-policy).



> > v2:
> > * changed DT bindings from 'wdt-reset' to 'rza-wdt'
> > * changed hard coded register values to defines
> > * added msleep to while(1) loop
>=20
> Sure you can sleep here ?

As per Geert's review:

On Wednesday, February 15, 2017, Geert Uytterhoeven wrote:
> > +
> > +       /* Wait for WDT overflow */
> > +       while (1)
> > +               ;
>=20
> This burns CPU, and thus power, albeit for a very short time.
> Perhaps add an msleep() to the loop body?

Note that you only have 7.7us before the restart occurs, so probably
not much sleeping will be going on.


Chris
