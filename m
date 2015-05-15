Return-path: <stwiss.opensource@diasemi.com>
From: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
To: Guenter Roeck <linux@roeck-us.net>, "Opensource [Steve Twiss]"
	<stwiss.opensource@diasemi.com>, LINUXKERNEL <linux-kernel@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck
	<wim@iguana.be>
CC: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE
	<devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX
	<rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz
	<sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
Date: Fri, 15 May 2015 08:13:27 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7014B22B63A@SW-EX-MBX02.diasemi.com>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com>
 <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
 <55555639.8090505@roeck-us.net>
In-Reply-To: <55555639.8090505@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter,

Thank you for your comments again,
Here are my responses.

Regards,
Steve

On 15 May 2015 03:13, Guenter Roeck=20
> Subject: Re: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
>=20

[...]

> > +static void da9062_apply_window_protection(struct da9062_watchdog
> *wdt)
> > +{
> > +	unsigned long delay =3D
> msecs_to_jiffies(DA9062_RESET_PROTECTION_MS);
> > +	unsigned long timeout =3D wdt->j_time_stamp + delay;
> > +	unsigned long now =3D jiffies;
> > +	unsigned int diff_ms;
> > +
> > +	/* if time-limit has not elapsed then wait for remainder */
> > +	if (time_before(now, timeout)) {
> > +		diff_ms =3D jiffies_to_msecs(timeout-now);
> > +		dev_dbg(wdt->hw->dev,
> > +			"Kicked too quickly. Delaying %u msecs\n", diff_ms);
> > +		msleep(diff_ms);
> > +	}
> > +
> > +	return;
>=20
> Unnecessary return statement.
>=20

Deleted.

> > +static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D DA9062_TWDSCALE_MIN; i <=3D DA9062_TWDSCALE_MAX; i++) {
> > +		if (wdt_timeout[i] >=3D secs)
> > +			return i;
> > +	}
> > +
> > +	return DA9062_TWDSCALE_MAX;
> > +}
> > +
> > +static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
> > +{
> > +	int ret;
> > +
> > +	da9062_apply_window_protection(wdt);
> > +
> > +	ret =3D regmap_update_bits(wdt->hw->regmap,
> > +			   DA9062AA_CONTROL_F,
> > +			   DA9062AA_WATCHDOG_MASK,
> > +			   DA9062AA_WATCHDOG_MASK);
> > +
> > +	da9062_set_window_start(wdt);
> > +
> > +	return ret;
> > +}
> > +
> > +static int da9062_wdt_update_timeout_register(struct da9062_watchdog *=
wdt,
> > +					      unsigned int regval)
> > +{
> > +	struct da9062 *chip =3D wdt->hw;
> > +	int ret;
> > +
> > +	ret =3D da9062_reset_watchdog_timer(wdt);
> > +	if (ret) {
> > +		dev_err(chip->dev, "Failed to ping the watchdog (err =3D %d)\n",
> > +			ret);
>=20
> I am kind of torn about all this noisiness on error. Personally I would t=
end to
> ask people to let user space handle it, and not be that noisy in the kern=
el.
>=20
> Wim, any guidance ?

At the time I thought it would be a really good idea to keep a debug messag=
e in.=20
But -- this has been questioned several times and so I will remove.

> > +		return ret;
> > +	}
> > +
> > +	return regmap_update_bits(chip->regmap,
> > +				  DA9062AA_CONTROL_D,
> > +				  DA9062AA_TWDSCALE_MASK,
> > +				  regval);
>=20
> ... and it is inconsistent - no error message here.
>=20

Removed the dev_err() defined previously and therefore this makes this retu=
rn
without an error message more consistent with the earlier parts of the func=
tion.
(no change needed)

 [...]

> > +static int da9062_wdt_stop(struct watchdog_device *wdd)
> > +{
> > +	struct da9062_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	ret =3D da9062_reset_watchdog_timer(wdt);
> > +	if (ret) {
> > +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err =3D
> %d)\n",
> > +			ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D regmap_update_bits(wdt->hw->regmap,
> > +				 DA9062AA_CONTROL_D,
> > +				 DA9062AA_TWDSCALE_MASK,
> > +				 DA9062_TWDSCALE_DISABLE);
> > +	if (ret)
> > +		dev_alert(wdt->hw->dev, "Watchdog failed to stop (err =3D
> %d)\n",
> > +			  ret);
>=20
> .. and now we have an alert. Hmm..

.. I've replaced it with a dev_err()

> > +
> > +	return ret;
> > +}
> > +
> > +static int da9062_wdt_ping(struct watchdog_device *wdd)
> > +{
> > +	struct da9062_watchdog *wdt =3D watchdog_get_drvdata(wdd);
> > +	int ret;
> > +
> > +	dev_dbg(wdt->hw->dev, "watchdog ping\n");
> > +
>=20
> Is this really valuable enough to keep in the code ?
>=20

Removed also.

> > +	ret =3D da9062_reset_watchdog_timer(wdt);
> > +	if (ret)
> > +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err =3D
> %d)\n",
> > +			ret);
> > +
> > +	return ret;
> > +}
> > +

[...]

> > +
> > +/* E_WDG_WARN interrupt handler */
> > +static irqreturn_t da9062_wdt_wdg_warn_irq_handler(int irq, void *data=
)
> > +{
> > +	struct da9062_watchdog *wdt =3D data;
> > +
> > +	dev_notice(wdt->hw->dev, "Watchdog timeout warning trigger.\n");
> > +	return IRQ_HANDLED;
> > +}
> > +

[...]

> > +static int da9062_wdt_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct da9062 *chip;
> > +	struct da9062_watchdog *wdt;
> > +	int irq;
> > +
> > +	chip =3D dev_get_drvdata(pdev->dev.parent);
> > +	if (!chip)
> > +		return -EINVAL;
> > +
> > +	wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> > +	if (!wdt)
> > +		return -ENOMEM;
> > +
> > +	wdt->hw =3D chip;
> > +
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
> > +	if (irq < 0) {
> > +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> > +		ret =3D irq;
> > +		goto error;
>=20
> Just return; the label does not serve a useful purpose. Same for the othe=
r
> goto statements below.

Agreed. This is changed now.

> Also, is the interrupt mandatory ? All it does is to display a message.
> Looks very optional to me.

It is a place holder for something more application specific.=20
I could remove it, but I figured it would just get re-added when somebody t=
akes the
driver and modifies it for their needs.

If this is a problem however, it can go.
Please advise ..

>=20
> > +	}
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> > +			   da9062_wdt_wdg_warn_irq_handler,
> > +			    IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> IRQF_SHARED,
> > +			   "WDG_WARN", wdt);
> > +	if (ret) {
> > +		dev_err(wdt->hw->dev,
> > +			"Failed to request watchdog device IRQ.\n");
> > +		goto error;
> > +	}
> > +
> > +	ret =3D watchdog_register_device(&wdt->wdtdev);
> > +	if (ret < 0) {
> > +		dev_err(wdt->hw->dev,
> > +			"watchdog registration incomplete (%d)\n", ret);
>=20
> incomplete ? Should that be "failed" ?

Sure. Changed the dev_err()

[...]

> > +static struct platform_driver da9062_wdt_driver =3D {
> > +	.probe =3D da9062_wdt_probe,
> > +	.remove =3D da9062_wdt_remove,
> > +	.driver =3D {
> > +		.name =3D "da9062-watchdog",
> > +	},
> > +};
> > +module_platform_driver(da9062_wdt_driver);
> > +
> > +MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> > +MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform: da9062-watchdog");
> >
> Normally I don't see a space between "platform" and the driver name.
> Does this work ?

Removed the space

Regards,
Steve
