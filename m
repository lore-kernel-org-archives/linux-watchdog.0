Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wj0-f172.google.com ([209.85.210.172]:35410 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757445AbdADMOs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 4 Jan 2017 07:14:48 -0500
Received: by mail-wj0-f172.google.com with SMTP id i20so8567908wjn.2
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Jan 2017 04:14:48 -0800 (PST)
Date: Wed, 4 Jan 2017 12:18:30 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH V5 4/8] mfd: da9061: MFD core support
Message-ID: <20170104121830.GB24225@dell>
References: <cover.1481828921.git.stwiss.opensource@diasemi.com>
 <ad649a91daa6191f2385dfe79c6ec8ca339f597c.1481828921.git.stwiss.opensource@diasemi.com>
 <20170104101221.GT27589@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD3BBC9@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD3BBC9@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Jan 2017, Steve Twiss wrote:

> Hi Lee,
>=20
> On 04 January 2017 10:12, Lee Jones wrote:
>=20
> > Subject: Re: [PATCH V5 4/8] mfd: da9061: MFD core support
> > On Thu, 15 Dec 2016, Steve Twiss wrote:
> > > From: Steve Twiss <stwiss.opensource@diasemi.com>
>=20
> [...]
>=20
> > > +static const struct of_device_id da9062_dt_ids[] =3D {
> > > +	{ .compatible =3D "dlg,da9061", .data =3D (void *)COMPAT_TYPE_DA9=
061,
> > },
> > > +	{ .compatible =3D "dlg,da9062", .data =3D (void *)COMPAT_TYPE_DA9=
062,
> > },
> >=20
> > It looks like this device can dynamically obtain this information fro=
m
> > the device.  Please use that method instead.
>=20
> As I mentioned in an earlier post,
> https://lkml.org/lkml/2016/11/7/418
>=20
> The 61/62 device type has been defined by the device tree in this case,=
 and
> that definition is used to set the register map. With the regmap define=
d,
> access to the registers is then possible.
>=20
> It is not possible to detect the device type automatically in this case=
 because
> it suggests a predefined regmap.
>=20
> This is the reason I define the chip type (DA9061 or DA9062) in the dev=
ice
> tree and then assign the correct regmap first before accessing any regi=
sters.

Well at least I'm consistent. :D

> > > +	if (i2c->dev.of_node) {
> > > +		match =3D of_match_node(da9062_dt_ids, i2c->dev.of_node);
> > > +		if (!match)
> > > +			return -EINVAL;
> > > +
> > > +		chip->chip_type =3D (int)match->data;
> > > +	} else
> > > +		chip->chip_type =3D id->driver_data;
> >=20
> > Please obtain this information from DA9062AA_VARIANT_ID.
>=20
> The variant ID does contain the information about whether it is a 61 or=
 62, but
> in order to read the register the regmap definition needs to be defined
> first.
>=20
> [...]
>=20
> > >  static const struct i2c_device_id da9062_i2c_id[] =3D {
> > > -	{ "da9062", 0 },
> > > +	{ "da9061", COMPAT_TYPE_DA9061 },
> > > +	{ "da9062", COMPAT_TYPE_DA9062 },
> >=20
> > This too.
>=20
> Regards,
> Steve

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
