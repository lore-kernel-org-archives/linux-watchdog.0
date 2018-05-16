Return-Path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
Return-path: <groeck7+caf_=guenter=roeck-us.net@gmail.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, Marco Felsch <mfe@pengutronix.de>,
	Marco Felsch <m.felsch@pengutronix.de>
CC: "wim@linux-watchdog.org" <wim@linux-watchdog.org>, Support Opensource
	<Support.Opensource@diasemi.com>, "fzuuzf@googlemail.com"
	<fzuuzf@googlemail.com>, Guenter Roeck <groeck7@gmail.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: RE: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
Date: Wed, 16 May 2018 07:35:13 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7019418108B@SW-EX-MBX02.diasemi.com>
References: <20180509123243.21170-1-m.felsch@pengutronix.de>
 <6ED8E3B22081A4459DAC7699F3695FB7019417EA41@SW-EX-MBX02.diasemi.com>
 <bec3deb4-6163-ff1c-d84c-47a413845445@pengutronix.de>
 <20180515184412.GC16006@roeck-us.net>
In-Reply-To: <20180515184412.GC16006@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 15 May 2018 19:44, Guenter Roeck wrote,

> Subject: Re: [PATCH v2] watchdog: da9063: Fix setting/changing timeout
>=20
> On Wed, May 09, 2018 at 04:10:15PM +0200, Marco Felsch wrote:
> > Hi Steve,
> >
> > On 05/09/2018 03:50 PM, Steve Twiss wrote:
> > >On 09 May 2018 13:33, Marco Felsch wrote:
> > >
> > >>
> > >>The DA9063 watchdog always resets the system when it changes the time=
out
> > >>value after the bootloader (e.g. Barebox) has it already set.
> > >>
> > >>To update the timeout value we have to disable the watchdog, clear th=
e
> > >>watchdog counter value and write the new timeout value to the watchdo=
g.
> > >>Clearing the counter value is a feature to be on the safe side, becau=
se the
> > >>data sheet doesn't describe the behaviour of the watchdog counter val=
ue
> > >>after a watchdog disabling-enable-sequence.
> > >>
> > >>The patch is based on Philipp Zabel's <p.zabel@pengutronix.de>previou=
s
> > >>patch but doesn't wait 150us because the DA9063 doesn't need this del=
ay.
> > >>https://www.dialog-semiconductor.com/products/DA9063
> > >
> > >Yes, according to the Dialog datasheet DA9063_2v1, there is no 150us m=
inimum
> > >assert time limit. But ... that doesn't seem correct to me, because th=
e DA9062
> > >driver and DA9062 datasheet both show a minimum assertion time, like y=
ou
> > >said.
> > >
> > >https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.gi=
t/tree/drivers/watchdog/da9062_wdt.c?h=3Dv4.17-rc3#n67
> > >
> > >So let me check with the hardware engineers.
> >
> > That would be great looking forward to hear from you. I will prepare a =
v3 if it is.
> >
> Any updates ?
>=20
> Guenter

Hi Guenter and Marco,

Thank you for your patience.
The best advice I can give at the moment is:

Please follow what has been done in the DA9062 and DA9053 device drivers.
https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/da9062_wdt.=
c#L90
https://elixir.bootlin.com/linux/latest/source/drivers/watchdog/da9052_wdt.=
c#L76

In these cases:
"setting TWDSCALE to zero for at least 150 us before writing the new value"

There will be a longer answer, but that must wait until the formal datashee=
ts have
been clarified by the hardware engineers.

Regards,
Steve

>=20
> > >>+
> > >>=A0 static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigne=
d int regval)
> > >>=A0 {
> > >>+=A0=A0=A0 int ret;
> > >>+
> > >>+=A0=A0=A0 /*
> > >>+=A0=A0=A0=A0 * The watchdog trigger a reboot if a timeout value is a=
lready
> > >>+=A0=A0=A0=A0 * programmed. Because the timeout value combines two fu=
nctions in
> > >>+=A0=A0=A0=A0 * one: indicating the counter limit and starting the wa=
tchdog. To be
> > >>+=A0=A0=A0=A0 * able to set the watchdog a second time (first time wa=
s done by the
> > >>+=A0=A0=A0=A0 * bootloader) disable the watchdog clear the counter va=
lue manually and
> > >>+=A0=A0=A0=A0 * set the new timeout value.
> > >>+=A0=A0=A0=A0 */
> > >>+=A0=A0=A0 ret =3D regmap_update_bits(da9063->regmap, DA9063_REG_CONT=
ROL_D,
> > >>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DA9063_TWDSCALE_MAS=
K, DA9063_TWDSCALE_DISABLE);
> > >>+=A0=A0=A0 if (ret)
> > >>+=A0=A0=A0=A0=A0=A0=A0 dev_warn(da9063->dev,
> > >>+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Failed to disable watchdog bef=
ore setting new timeout\n");
> > >>+
> > >>+=A0=A0=A0 ret =3D _da9063_wdt_reset_timer(da9063);
> > >>+=A0=A0=A0 if (ret)
> > >>+=A0=A0=A0=A0=A0=A0=A0 dev_warn(da9063->dev, "Failed to reset watchdo=
g counter\n");
> >
> > BTW. can you ask them if it is necessary to reset the counter value reg=
ister
> > manually or if this is done by disabling the watchdog.
> >
> > Regards,
> > Marco
