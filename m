Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36051 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbdDDIfD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Apr 2017 04:35:03 -0400
Received: by mail-wr0-f182.google.com with SMTP id w11so202611567wrc.3
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Apr 2017 01:35:01 -0700 (PDT)
Date: Tue, 4 Apr 2017 09:34:57 +0100
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
Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
Message-ID: <20170404083457.bcpqw6gv6rzhevrp@dell>
References: <cover.1490712213.git.stwiss.opensource@diasemi.com>
 <8987877cc54940358c5b7a65ca003cedc5586f0d.1490712213.git.stwiss.opensource@diasemi.com>
 <20170403141214.q6ndii6c47pqfqx6@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD6B183@SW-EX-MBX02.diasemi.com>
 <20170403143049.qyi4dagwi4cdenok@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD6B207@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD6B207@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Apr 2017, Steve Twiss wrote:

> On 03 April 2017 15:31, Lee Jones wrote:
>=20
> > Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
> >=20
> > On Mon, 03 Apr 2017, Steve Twiss wrote:
> > > On 03 April 2017 15:12, Lee Jones wrote:
> > >
> > > > > @@ -475,7 +855,25 @@ static int da9062_i2c_probe(struct i2c_cli=
ent *i2c,
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >
> > > > > -	chip->regmap =3D devm_regmap_init_i2c(i2c, &da9062_regmap_con=
fig);
> > > > > +	switch (chip->chip_type) {
> > > > > +	case(COMPAT_TYPE_DA9061):
> > > >
> > > > Brackets around the case value?
> > > >
> > > > That's a new one on me.
> > >
> > > Hm. Do you want me to resend it without braces?
> >=20
> > Yes please.  And a space after the 'case'.
>=20
> Hi Lee,
>=20
> I have resent PATCH V7 to change "case(X):" to be "case X:".
> - Removed brackets surrounding case statements for
>     case COMPAT_TYPE_DA9061:
>     case COMPAT_TYPE_DA9062:

Okay, good.

> New patch is here:
> https://lkml.org/lkml/2017/4/3/462
>=20
> The patch it is called by the same title "[PATCH V7 4/7] mfd: da9061: M=
FD core support".
> I've not updated the whole patch-set or changed the patch version numbe=
r from V7.

I don't see it in my inbox?

You should always change the version, or things get confusing.

Even if it's a small change, you can differentiate by v7.1 or similar.

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
