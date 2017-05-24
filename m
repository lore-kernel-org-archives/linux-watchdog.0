Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37833 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763780AbdEXIk7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 04:40:59 -0400
Received: by mail-wm0-f47.google.com with SMTP id d127so58826306wmf.0
        for <linux-watchdog@vger.kernel.org>; Wed, 24 May 2017 01:40:53 -0700 (PDT)
Date: Wed, 24 May 2017 09:40:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Message-ID: <20170524084049.iy4dlrbmkzsqjvav@dell>
References: <cover.1495546845.git.stwiss.opensource@diasemi.com>
 <ac0c9c0edf9a3a48d8de7a5c07b16b771871796e.1495546845.git.stwiss.opensource@diasemi.com>
 <20170523171721.lpqjhakaawnz4prz@sirena.org.uk>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD8D651@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD8D651@SW-EX-MBX02.diasemi.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, 24 May 2017, Steve Twiss wrote:

> On 23 May 2017 18:17 Mark Brown
> > To: Steve Twiss
> > Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO re=
gulator driver
> >=20
> > On Tue, May 23, 2017 at 02:40:45PM +0100, Steve Twiss wrote:
> >=20
> > > This patch was Acked by Mark Brown, a long time ago, way back in Oc=
t 2016
> > > (https://patchwork.kernel.org/patch/9397787/).
> > > I have kept Mark Brown's Ack attached because there have been no re=
al
> > > code changes since then, but I have recently updated the copyright =
header
> > > slightly, rebased the code (no changes necessary) and compile teste=
d it
> > > against x86_64.
> >=20
> > > The MFD files which this patch depended on were accepted into linux=
-next
> > > by Lee Jones last week. If there is anything in the way of this pat=
ch
> > > acceptance, could you please let me know?
> >=20
> > Given that I've acked this and it depends on the MFD changes I'd have
> > expected Lee to apply it.  If nothing else happens I can apply it aft=
er
> > the next merge window, otherwise either Lee needs to send me a pull
> > request for the MFD change so I've got the dependency or he needs to
> > apply this.
>=20
> Hi Mark,
>=20
> Thanks,
> No problem, just some minor administration.
>=20
> @Lee
> Could you please send Mark a pull request for the regulator component t=
o the
> DA9062/61 changes [PATCH V7 5/7] regulator: da9061: BUCK and LDO regula=
tor
> driver.

That wasn't one of the options. ;)

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
