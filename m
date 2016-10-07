Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
CC: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, "Zhang
 Rui" <rui.zhang@intel.com>, DEVICETREE <devicetree@vger.kernel.org>,
	LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM
	<linux-pm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring
	<robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>,
	LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG
	<linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
Date: Fri, 7 Oct 2016 14:56:17 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE2732@SW-EX-MBX02.diasemi.com>
References: <6ED8E3B22081A4459DAC7699F3695FB7018CCE242C@SW-EX-MBX02.diasemi.com>
 <20161006184927.GB11915@roeck-us.net>
In-Reply-To: <20161006184927.GB11915@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 06 October 2016 19:49, Guenter Roeck wrote:
> Subject: Re: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
>=20
> Hi Steve,

[...]

> On Thu, Oct 06, 2016 at 04:28:14PM +0000, Steve Twiss wrote:
> > I am using the compatible string to pick a different configuration .dat=
a block:
> >
> > { .compatible =3D "dlg,da9062-watchdog", .data =3D &da9062_watchdog_inf=
o },
> > { .compatible =3D "dlg,da9061-watchdog", .data =3D &da9061_watchdog_inf=
o },
> >
> > when the only real difference between the DA9061 and DA9062 watchdog dr=
iver
> > is the name. Functionally they are identical in this case.
[...]
> > This exact same thing would happen with da9063-onkey and da9062-thermal=
 also.
> > For the ONKEY it is marginally confused by needing to support 63, but f=
or 62 and 61
> > it is the same thing. Only the name is different.
> >
[...]
> > But, it is just my opinion to keep the "name" different.
> > This will not be my decision if accepted into the Linux kernel, but I w=
ould like to
> > at least be consistent for DA9061 and DA9062 so ... is this an issue?
>=20
>=20
> Yes, for me it is. The driver is still the same, and I don't see the poin=
t
> of increasing code size and making the driver less readable just to be ab=
le
> to report a slightly different driver identification string. And each tim=
e
> a similar HW is added we would go through the same effort, again for no
> good reason.
>=20

My reason for doing this was to report the hardware identification, not the
driver name. But, there would certainly be a lot less to do if I was to mak=
e
DA9061 core use the DA9062 watchdog.
=20
> FWIW the driver doesn't really need to be updated in the first place.
> A compatible statement listing both da9061 and da9062 would do it.

I will make the changes you requested: deprecate the existing compatibility
for da9062-watchdog and make a new compatibility string which combines both
da9061 and da9062.

Regards,
Stephen
