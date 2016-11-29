Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.164]:17348 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756536AbcK2LML (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Nov 2016 06:12:11 -0500
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Eduardo Valentin <edubezval@gmail.com>
CC: LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: RE: [PATCH V2 09/10] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Tue, 29 Nov 2016 11:11:59 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCEC2F8@SW-EX-MBX02.diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <20fefc922818ab0511101f73b1a4d3468c9a8ed3.1477501000.git.stwiss.opensource@diasemi.com>
 <20161129012409.GA2813@localhost.localdomain>
In-Reply-To: <20161129012409.GA2813@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Eduardo,

Thanks for your response.

On 29 November 2016 01:24, Eduardo Valentin, wrote:

> On Wed, Oct 26, 2016 at 05:56:39PM +0100, Steve Twiss wrote:
> > +config DA9062_THERMAL
> > +	tristate "DA9062/DA9061 Dialog Semiconductor thermal driver"
> > +	depends on MFD_DA9062
> > +	depends on OF
> > +	help
> > +	  Enable this for the Dialog Semiconductor thermal sensor driver.
> > +	  This will report PMIC junction over-temperature for one thermal t=
rip
> > +	  zone.
> > +	  Compatible with the DA9062 and DA9061 PMICs.
>=20
> Is there any hardware documentation available for this chip that can be
> pointed out?

As part of this patch set, I added a link to the the datasheet into the t=
op-level MFD
component of the device tree binding: https://patchwork.kernel.org/patch/=
9426791/
You can get all the information for DA9062 and DA9061 from the patch upda=
te in that
link.

[...]
> > +	/* Now read E_TEMP again: it is acting like a status bit.
> > +	 * If over-temperature, then this status will be true.
> > +	 * If not over-temperature, this status will be false.
> > +	 */
> > +	ret =3D regmap_read(thermal->hw->regmap,
> > +			  DA9062AA_EVENT_B,
> > +			  &val);
> > +	if (ret < 0) {
> > +		dev_err(thermal->dev,
> > +			"Cannot check the TJUNC temperature status\n");
> > +		goto err_enable_irq;
> > +	} else {
> > +		if (val & DA9062AA_E_TEMP_MASK) {
> > +			mutex_lock(&thermal->lock);
> > +			thermal->temperature =3D DA9062_MILLI_CELSIUS(125);
>=20
> Does this mean that the chip temperature is above or equal to 125C, is
> this really a safe temperature to keep it running?

There is more information in the datasheet under the section titles "Junc=
tion
temperature supervision". The value of 125 degC comes from the "warning
temperature threshold" and the event is triggered when "the junction temp=
erature
rises above the first threshold (TEMP_WARN), the event E_TEMP is asserted=
".

This suggests strictly greater than 125. However, there is no way for the=
 chip to
know the exact temperature. The mechanism is interrupt based and triggeri=
ng
only happens when the temperature rises above the threshold level.

[...]
> > +static irqreturn_t da9062_thermal_irq_handler(int irq, void *data)
> > +{
> > +	struct da9062_thermal *thermal =3D data;
> > +
> > +	disable_irq_nosync(thermal->irq);
> > +	schedule_delayed_work(&thermal->work, 0);
>=20
> Can you please elaborate a little on why you have an one shot threaded =
IRQ
> handler that is only disabling the IRQ then, scheduling a work with del=
ay of 0?
>=20
> To my understanding, this is exactly what you get when you run your
> threaded IRQ handler, when you configure it as one shot.
>=20
> Have you tried simply handling the same work done in your workqueue
> handler in your threaded IRQ? That should simplify your code and get th=
e
> same result you are expecting.
>=20
> If you are not getting the IRQ disabled on the threaded IRQ when
> configured as one shot, something else seams to be broken.

Over-temperature triggering is event based: an interrupt happens when the
temperature rises above 125 degC. However, this event based system change=
s into
a polling operation to detect when the temperature falls below the thresh=
old
level again. This asymmetry in the chip's behaviour is the reasoning behi=
nd
why I am not using the thermal core's built-in polling functionality.

When over-temperature is reached, the interrupt from the DA9061/2 will be
repeatedly triggered. The IRQ is disabled when the first over-temperature=
 event
happens and the status bit is polled using the work-queue until it become=
s false.
After that, the IRQ is re-enabled again so a new critical temperature eve=
nt can
be detected.

After the interrupt has happened, event bit for the interrupt switches in=
to a status
bit and is used for polling and detecting when the temperature drops belo=
w the
threshold.

https://lkml.org/lkml/2016/10/20/372
https://lkml.org/lkml/2016/10/20/433

[...]
> > +	thermal->zone =3D thermal_zone_device_register(thermal->config->nam=
e,
> > +					1, 0, thermal,
> > +					&da9062_thermal_ops, NULL, 0,
> > +					0);
>=20
> Did you try using of-thermal?
>=20
> So you would avoid having specific DT properties for something that
> there is already a defined property?

In an earlier RFC, I examined a work-around by hijacking and toggling the
thermal core's built-in polling function when I needed to poll the temper=
ature
through get_temp(). However I thought this was quite dangerous, since it =
would
not be using a formal thermal core interface.

https://patchwork.kernel.org/patch/9387241/

[...]
> > +	ret =3D request_threaded_irq(thermal->irq, NULL,
> > +				   da9062_thermal_irq_handler,
> > +				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > +				   "THERMAL", thermal);
>=20
> How about using the devm_ version?

I wanted to explicitly free_irq() before calling thermal_zone_device_unre=
gister()
in the remove function.

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
