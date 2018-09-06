Return-Path: <Chris.Brandt@renesas.com>
Return-path: <Chris.Brandt@renesas.com>
From: Chris Brandt <Chris.Brandt@renesas.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Simon Horman
	<horms+renesas@verge.net.au>
Subject: RE: [PATCH v2 1/2] watchdog: rza_wdt: Support longer timeouts
Date: Thu, 6 Sep 2018 19:40:59 +0000
Message-ID: 
 <TY1PR01MB15621632D4B8A445937C62518A010@TY1PR01MB1562.jpnprd01.prod.outlook.com>
References: <20180906183738.81238-1-chris.brandt@renesas.com>
 <20180906183738.81238-2-chris.brandt@renesas.com>
 <20180906185247.GA25433@roeck-us.net> <20180906185643.GA25704@roeck-us.net>
In-Reply-To: <20180906185643.GA25704@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On Thursday, September 06, 2018, Guenter Roeck wrote:
> > > +		if (counter > 255)
> > > +			counter =3D 0;
> >
> > This is difficult to understand.
> >
> > > +
> > > +		priv->count =3D 256 - counter;
> >
> > It sets priv->count to 256, meaning that 0x5B00 instead of
> > 0x5Axx will be written into the counter register. That really
> > asks for some explanation.
> >
>=20
> No, wait, priv->count is an 8-bit variable, so this really sets
> priv->counter to 0. I am getting more and more confused. Why
> not just set "counter =3D 256" above to make it obvious if that
> is what is supposed to happen ?

That's a good point.

The math is supposed to be:

  256 - [number of ticks you want] =3D [register value]

Where [number of ticks you want] must be <=3D 256

Of course it's 8-bit variable so it will work...but that's not obvious=20
at first.

I'll change it to:

	if (counter > 256)
		counter =3D 256;


Chris
