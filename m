Return-path: <stwiss.opensource@diasemi.com>
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, LINUXKERNEL
	<linux-kernel@vger.kernel.org>, LINUXWATCHDOG
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
CC: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Wed, 6 May 2015 14:54:37 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B21924A@SW-EX-MBX02.diasemi.com>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
 <55327DDA.4080003@roeck-us.net>
In-Reply-To: <55327DDA.4080003@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

On 18 April 2015 16:53 Guenter Roeck wrote:

Hi Guenter,

Thanks for your comments.

> On 04/17/2015 07:23 AM, S Twiss wrote:
> > From: S Twiss <stwiss.opensource@diasemi.com>
> >
> > Add watchdog driver support for DA9062
> >
> > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >
> Hi Steve,
>=20
> Key question here is if the da9062 is really so much different to the da9=
062
> that you can not use the same driver.

The DA9062 watchdog driver does have some similarities with the DA9063 watc=
hdog=20
base functionality -- however the watchdog component in the DA9062 chip has=
 more
features yet to be added in software. I do intend to add these other featur=
es ...
however, if "not adding them here" is a problem I can drop the DA9062 watch=
dog
driver from this patch-set until I have time to write in the newer changes.

> I am especially concerned about the added da9062_reset_watchdog_timer(),
> given the delay it introduces.

After giving this some thought, I am going to remove this 300ms delay from =
the
reset_watchdog_timer() function for my next submission attempt.  However
I am adding a 300ms delay into the stop() and update_timeout_register() fun=
ctions
instead.

The DA9062 watchdog ping (register CONTROL_F) is "windowed" for protection
against spurious writes -- i.e. the ping function cannot be called within a=
 250ms
time limit or the PMIC will reset. This windowing protection also extends t=
o altering
the timeout scale in the CONTROL_D register -- in which case if the timeout
register is altered and the ping() function is called within the 250ms limi=
t, the
PMIC will reset. The delay is there to stop that from happening.

I realised my previous patch was over-sanitised: by putting the time delay =
into the
ping() function I was protecting CONTROL_D in stop() and  update_timeout_re=
gister(),
but I was being too over-protective of the ping() function. Therefore if th=
ere was an=20
"incorrect trigger signal", the watchdog would not be allowed to fail becau=
se the
driver would have filtered out the errors.

> > +static int da9062_reset_watchdog_timer(struct da9062 *hw)
> > +{
> > +	int ret;
> > +
> > +	ret =3D regmap_update_bits(hw->regmap,
> > +			   DA9062AA_CONTROL_F,
> > +			   DA9062AA_WATCHDOG_MASK,
> > +			   DA9062AA_WATCHDOG_MASK);
> > +
> > +	mdelay(300);
>=20
> Really ? That seems to be excessive, especially given how often
> this function is called (for each ping!).
>=20

Please see above.

> > +
> > +	return ret;
> > +}
> > +
> > +static int da9062_wdt_update_timeout_register(struct da9062 *chip,
> > +					      unsigned int regval)
> > +{
> > +	int ret;
> > +
> > +	ret =3D da9062_reset_watchdog_timer(chip);
> > +	if (ret)
> > +		dev_err(chip->dev, "Failed to ping the watchdog (err =3D
> %d)\n",
> > +			ret);
> > +
> And no impact, so this doesn't really matter ?
>=20

I really want to send an error so the user can be notified their ping()
has failed. As it stands, allowing thing to fail is not the best error path=
.

> > +	return regmap_update_bits(chip->regmap,
> > +				  DA9062AA_CONTROL_D,
> > +				  DA9062AA_TWDSCALE_MASK,
> > +				  regval);
> > +}
> > +

[...]

> > +static int da9062_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct da9062_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	ret =3D da9062_reset_watchdog_timer(wdt->hw);
> > +	if (ret)
> > +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err =3D
> %d)\n",
> > +			ret);
> > +
> ping or reset ? And no impact, ie you just ignore the error ?
>=20

Same again -- I will add an error path to this

[...]

> > +	wdt->wdtdev.info =3D &da9062_watchdog_info;
> > +	wdt->wdtdev.ops =3D &da9062_watchdog_ops;
> > +	wdt->wdtdev.min_timeout =3D DA9062_WDT_MIN_TIMEOUT;
> > +	wdt->wdtdev.max_timeout =3D DA9062_WDT_MAX_TIMEOUT;
> > +	wdt->wdtdev.timeout =3D DA9062_WDG_DEFAULT_TIMEOUT;
> > +	wdt->wdtdev.status =3D WATCHDOG_NOWAYOUT_INIT_STATUS;
> > +
> > +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> > +	dev_set_drvdata(&pdev->dev, wdt);
> > +
> > +	irq =3D platform_get_irq_byname(pdev, "WDG_WARN");
> > +	if (irq < 0)
> > +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
>=20
> But you still request the negative irq.
>=20
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +			   da9062_wdt_wdg_warn_irq_handler,
> > +			    IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> IRQF_SHARED,
> > +			   "WDG_WARN", wdt);
> > +	if (ret) {
> > +		dev_err(wdt->hw->dev,
> > +			"Failed to request watchdog device IRQ.\n");
>=20
> Either this is an error, or it isn't. If it is, I would expect the driver
> to abort loading. If not, please don't use dev_err.
>=20

I will put error paths in here also.

> > +	}
> > +
> > +	ret =3D watchdog_register_device(&wdt->wdtdev);
> > +	if (ret < 0)
> > +		dev_err(wdt->hw->dev,
> > +			"watchdog registration incomplete (%d)\n", ret);
>=20
> incomplete ?
>=20

Will fix this with an error path

> > +	else
> > +		dev_info(wdt->hw->dev, "installed DA9062 watchdog\n");
>=20
> Please rop this message.
>=20

Will do this.

> > +
> > +	da9062_wdt_ping(&wdt->wdtdev);
> > +	if (ret < 0)
> > +		dev_err(wdt->hw->dev,
> > +			"failed to ping the watchdog (%d)\n", ret);
> > +
> That ping is asking for an explanation. Does it imply that the watchdog i=
s
> known to be running
> and can not be stopped ?
>=20
> Also, the ping function already creates an error message. Please be less =
noisy
> with
> your messages.
>=20
> > +	return ret;
>=20
> If the above ping fails, this will return an error without unregistering
> the watchdog device.
>=20

I will refactor this piece.

[...]

Regards,
Steve
