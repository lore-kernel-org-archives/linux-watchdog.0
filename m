Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35119 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1169943AbdDXMip (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Apr 2017 08:38:45 -0400
Received: by mail-wr0-f172.google.com with SMTP id z52so49408964wrc.2
        for <linux-watchdog@vger.kernel.org>; Mon, 24 Apr 2017 05:38:44 -0700 (PDT)
Date: Mon, 24 Apr 2017 13:38:39 +0100
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
Message-ID: <20170424123839.pjgbmz36nwcgfvn4@dell>
References: <cover.1491230802.git.stwiss.opensource@diasemi.com>
 <b39c8c3f42a01a00f93292c569e8d30ce69ff3ab.1491230802.git.stwiss.opensource@diasemi.com>
 <20170404083902.ywo3pdxptgfcqvga@dell>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD71434@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD71434@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Apr 2017, Steve Twiss wrote:

> On 04 April 2017 09:39, Lee Jones wrote:
> > Subject: Re: [PATCH V7 4/7] mfd: da9061: MFD core support
> >=20
> > On Mon, 03 Apr 2017, Steve Twiss wrote:
> > > From: Steve Twiss <stwiss.opensource@diasemi.com>
> > > MFD support for DA9061 is provided as part of the DA9062 device dri=
ver.
> > >
> > > The registers header file adds two new chip variant IDs defined in =
DA9061
> > > and DA9062 hardware. The core header file adds new software enumera=
tions
> > > for listing the valid DA9061 IRQs and a da9062_compatible_types enu=
meration
> > > for distinguishing between DA9061/62 devices in software.
> > >
> > > The core source code adds a new .compatible of_device_id entry. Thi=
s is
> > > extended from DA9062 to support both "dlg,da9061" and "dlg,da9062".=
 The
> > > .data entry now holds a reference to the enumerated device type.
> > >
> > > A new regmap_irq_chip model is added for DA9061 and this supports t=
he new
> > > list of regmap_irq entries. A new mfd_cell da9061_devs[] array list=
s the
> > > new sub system components for DA9061. Support is added for a new DA=
9061
> > > regmap_config which lists the correct readable, writable and volati=
le
> > > ranges for this chip.
> > >
> > > The probe function uses the device tree compatible string to switch=
 on the
> > > da9062_compatible_types and configure the correct mfd cells, irq ch=
ip and
> > > regmap config.
> > >
> > > Kconfig is updated to reflect support for DA9061 and DA9062 PMICs.
> > >
> > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> >=20
> > Ah, here it is.
> >=20
> > Applied, thanks.
>=20
> Hi Lee,
>=20
> I noticed the DA9061 core support has been added into linux-next, howev=
er
> the commit message was changed from the original title:
>=20
> "mfd: da9061: MFD core support"
>=20
> to add the mistake:
>=20
> "mfd: Add suppfor for DA9061"
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/com=
mit/?id=3Dd3fe0806025cacdab1462d5704e1c98ab9db4564
>=20
> Can this be fixed please?
> This patch has not been upstreamed into linux-mainline and is still in =
linux-next.

You're right, thanks for pointing that out.

Now fixed.

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
