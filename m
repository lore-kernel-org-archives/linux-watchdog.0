Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.112]:38795 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751406AbdC0KLD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 27 Mar 2017 06:11:03 -0400
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
        Lukasz Luba <lukasz.luba@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: RE: [RESEND PATCH V5 7/8] thermal: da9062/61: Thermal junction
 temperature monitoring driver
Date: Mon, 27 Mar 2017 10:09:35 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CD69BD3@SW-EX-MBX02.diasemi.com>
References: <cover.1486026227.git.stwiss.opensource@diasemi.com>
 <6a1a651530fdaedd3e380aa33749ca5fce1a80a8.1486026227.git.stwiss.opensource@diasemi.com>
 <20170219014007.GA20845@localhost.localdomain>
In-Reply-To: <20170219014007.GA20845@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On 19 February 2017 01:40, Eduardo Valentin wrote:

Hi Eduardo,

My apologies in taking so long to reply.
There were *no* problems with implementing your requests. See below.
I will have sent these changes as PATCH V6.

https://lkml.org/lkml/2017/3/27/253

Regards,
Steve

> To: Steve Twiss
> Subject: Re: [RESEND PATCH V5 7/8] thermal: da9062/61: Thermal junction
> temperature monitoring driver

[...]

> I see no reason why this driver cannot have the COMPILE_TEST flag.
> Tested myself here so:
>=20
> +	depends on MFD_DA9062 || COMPILE_TEST

Added.

> please cleanup the minor issues checkpatch complains:
> /scripts/checkpatch.pl --strict <your patch>

I have fixed all of those for latest checkpatch.pl script, this time usin=
g "--strict".

[...]

> > +static void da9062_thermal_poll_on(struct work_struct *work)
> > +{
> > +	struct da9062_thermal *thermal =3D container_of(work,
> > +						struct da9062_thermal,
> > +						work.work);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	/* clear E_TEMP */
> > +	ret =3D regmap_write(thermal->hw->regmap,
> > +				DA9062AA_EVENT_B,
> > +				DA9062AA_E_TEMP_MASK);
> > +	if (ret < 0) {
> > +		dev_err(thermal->dev,
> > +			"Cannot clear the TJUNC temperature status\n");
> > +		goto err_enable_irq;
> > +	}
> > +
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
> > +			mutex_unlock(&thermal->lock);
> > +			thermal_zone_device_update(thermal->zone,
> > +				THERMAL_EVENT_UNSPECIFIED);
> > +
> > +			schedule_delayed_work(&thermal->work,
> > +				msecs_to_jiffies(thermal->zone->passive_delay));
> > +			return;
> > +		} else {
> > +			mutex_lock(&thermal->lock);
> > +			thermal->temperature =3D DA9062_MILLI_CELSIUS(0);
> > +			mutex_unlock(&thermal->lock);
> > +			thermal_zone_device_update(thermal->zone,
> > +				THERMAL_EVENT_UNSPECIFIED);
> > +		}
> > +	}
>=20
> The above code is a little confusing, can it be maybe, better read like
> this?
>=20
> diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-
> thermal.c
> index 52a095d..6ac8574 100644
> --- a/drivers/thermal/da9062-thermal.c
> +++ b/drivers/thermal/da9062-thermal.c
> @@ -95,26 +95,26 @@ static void da9062_thermal_poll_on(struct work_stru=
ct
> *work)
>  		dev_err(thermal->dev,
>  			"Cannot check the TJUNC temperature status\n");
>  		goto err_enable_irq;
> -	} else {
> -		if (val & DA9062AA_E_TEMP_MASK) {
> -			mutex_lock(&thermal->lock);
> -			thermal->temperature =3D DA9062_MILLI_CELSIUS(125);
> -			mutex_unlock(&thermal->lock);
> -			thermal_zone_device_update(thermal->zone,
> -				THERMAL_EVENT_UNSPECIFIED);
> -
> -			schedule_delayed_work(&thermal->work,
> +	}
> +
> +	if (val & DA9062AA_E_TEMP_MASK) {
> +		mutex_lock(&thermal->lock);
> +		thermal->temperature =3D DA9062_MILLI_CELSIUS(125);
> +		mutex_unlock(&thermal->lock);
> +		thermal_zone_device_update(thermal->zone,
> +				THERMAL_EVENT_UNSPECIFIED);
> +
> +		schedule_delayed_work(&thermal->work,
>  				msecs_to_jiffies(thermal->zone->passive_delay));
> -			return;
> -		} else {
> -			mutex_lock(&thermal->lock);
> -			thermal->temperature =3D DA9062_MILLI_CELSIUS(0);
> -			mutex_unlock(&thermal->lock);
> -			thermal_zone_device_update(thermal->zone,
> -			THERMAL_EVENT_UNSPECIFIED);
> -		}
> +		return;
>  	}
>=20
> +	mutex_lock(&thermal->lock);
> +	thermal->temperature =3D DA9062_MILLI_CELSIUS(0);
> +	mutex_unlock(&thermal->lock);
> +	thermal_zone_device_update(thermal->zone,
> +			THERMAL_EVENT_UNSPECIFIED);
> +
>  err_enable_irq:
>  	enable_irq(thermal->irq);
>  }

That makes more sense getting rid of those else clauses.
Applied that, thanks.

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
