Return-path: <stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Michael Tretter <m.tretter@pengutronix.de>, Guenter Roeck
	<linux@roeck-us.net>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"Support Opensource" <Support.Opensource@diasemi.com>, "wim@iguana.be"
	<wim@iguana.be>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] watchdog: da9063: Disable watchdog before changing
 timeout
Date: Thu, 16 Mar 2017 11:34:44 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD686BA@SW-EX-MBX02.diasemi.com>
References: <20170315181701.28430-1-m.tretter@pengutronix.de>
	<20170315185446.GA5479@roeck-us.net>
 <20170316103417.17abac1d@litschi.hi.pengutronix.de>
In-Reply-To: <20170316103417.17abac1d@litschi.hi.pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 16 March 2017 09:34, Michael Tretter wrote:

> Subject: Re: [PATCH] watchdog: da9063: Disable watchdog before changing t=
imeout
>=20
> On Wed, 15 Mar 2017 11:54:46 -0700, Guenter Roeck wrote:
> > On Wed, Mar 15, 2017 at 07:17:01PM +0100, Michael Tretter wrote:
> > > The DA9063 watchdog always resets the system when systemd changes
> > > the timeout value after Barebox already set a timeout value.
> > >
> > > If the watchdog is disabled before setting a new timeout, the
> > > system is not reset and the watchdog is still enabled.
> > >
> > > This patch is based on a previous patch by Philipp Zabel [1], but
> > > does not wait for 150 us, because the DA9063 does not require a
> > > delay after disabling the watchdog.
> > >
> > > [1] https://www.spinics.net/lists/linux-watchdog/msg07143.html
> > >
> > > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > > ---
> > >  drivers/watchdog/da9063_wdt.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/watchdog/da9063_wdt.c
> > > b/drivers/watchdog/da9063_wdt.c index 4691c5509129..fcdc12d14d03
> > > 100644 --- a/drivers/watchdog/da9063_wdt.c
> > > +++ b/drivers/watchdog/da9063_wdt.c
> > > @@ -55,8 +55,19 @@ static unsigned int
> > > da9063_wdt_timeout_to_sel(unsigned int secs)
> > >  static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned i=
nt regval) {
> > > -	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > > -				  DA9063_TWDSCALE_MASK, regval);
> > > +	int ret;
> > > +
> > > +	ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
> > > +			         DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
> > > +	if (ret)
> > > +		dev_warn(da9063->dev,
> > > +			 "Failed to disable watchdog before setting new timeout\n"); +
> > > +	if (regval)
> >
> > Why this if() ? Even if needed (and I think it isn't), this would be
> > an unrelated change.
>=20
> I added the if() to avoid a duplicate disable, if regval is
> DA9063_TWDSCALE_DISABLE. The duplication is a direct consequence
> of the overall patch and therefore related. However, it's not really
> needed, because _da9063_wdt_set_timeout() is never called with a
> timeout 0.
>=20
> > On a side note, unless I am missing something,
> > da9063_wdt_set_timeout() unconditionally enables the watchdog as a
> > side effect. It should not do that.
>=20
> What would be the correct behavior? Caching the timeout value and only
> enabling the watchdog when da9063_wdt_start() is called?

According to the datasheet: DA9063-00-PDS2N, 17-Sep-2015,
http://www.dialog-semiconductor.com/products/DA9063
"The time window has a minimum time TWDMIN fixed at 256 ms"

There is little information on this in the datasheet, but ...
If the TWDSCALE is set consecutively multiple times in a period less than
this TWDMIN minimum time period, is this causing the watchdog to reset?
Protection against that could be the solution.

@Guenter, if this is the case, the DA9063 watchdog starts to look similar
to the DA9062 watchdog, and ... it was my original recommendation
they should be kept separate (https://lkml.org/lkml/2015/5/6/505).

Regards,
Steve
