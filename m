Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, Lee Jones <lee.jones@linaro.org>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>, Eduardo Valentin
	<edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, DEVICETREE
	<devicetree@vger.kernel.org>, LINUX-INPUT <linux-input@vger.kernel.org>,
	LINUX-PM <linux-pm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob
 Herring <robh+dt@kernel.org>, Support Opensource
	<Support.Opensource@diasemi.com>, LINUX-KERNEL
	<linux-kernel@vger.kernel.org>, LINUX-WATCHDOG
	<linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH V1 04/10] watchdog: da9061: watchdog driver (RFC)
Date: Fri, 7 Oct 2016 18:01:23 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE282C@SW-EX-MBX02.diasemi.com>
References: <6ED8E3B22081A4459DAC7699F3695FB7018CCE242C@SW-EX-MBX02.diasemi.com>
 <20161006184927.GB11915@roeck-us.net>
 <6ED8E3B22081A4459DAC7699F3695FB7018CCE2732@SW-EX-MBX02.diasemi.com>
 <20161007170214.GA21349@roeck-us.net>
In-Reply-To: <20161007170214.GA21349@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 07 October 2016 18:02, Guenter Roeck wrote:

> > On 06 October 2016 19:49, Guenter Roeck wrote:
> > > On Thu, Oct 06, 2016 at 04:28:14PM +0000, Steve Twiss wrote:
> > > > I am using the compatible string to pick a different configuration =
.data block:
> > > > { .compatible =3D "dlg,da9062-watchdog", .data =3D &da9062_watchdog=
_info },
> > > > { .compatible =3D "dlg,da9061-watchdog", .data =3D &da9061_watchdog=
_info },
> > > >
> > > > But, it is just my opinion to keep the "name" different.
> > > > This will not be my decision if accepted into the Linux kernel, but=
 I would like to
> > > > at least be consistent for DA9061 and DA9062 so ... is this an issu=
e?
> > >
> > > FWIW the driver doesn't really need to be updated in the first place.
> > > A compatible statement listing both da9061 and da9062 would do it.
> >
> > I will make the changes you requested: deprecate the existing compatibi=
lity
> > for da9062-watchdog and make a new compatibility string which combines =
both
> > da9061 and da9062.
> >
> That is not what I asked for.

Ok. Did you mean separate compatible statements with data sections pointing=
 at=20
the same structure?

Like this:
{ .compatible =3D "dlg,da9062-watchdog", .data =3D &da9062_watchdog_info },
{ .compatible =3D "dlg,da9061-watchdog", .data =3D &da9062_watchdog_info },

So this would be the only change needed in the device driver.
