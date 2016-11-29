Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.172]:43561 "EHLO
        mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752706AbcK2LPn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Nov 2016 06:15:43 -0500
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Eduardo Valentin <edubezval@gmail.com>
CC: DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: RE: [PATCH V2 03/10] Documentation: devicetree: thermal: da9062/61
 TJUNC temperature binding
Date: Tue, 29 Nov 2016 11:15:38 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCEC304@SW-EX-MBX02.diasemi.com>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <d8c986e39bafc2b8a1c5c23e722f61cdd021e9be.1477501000.git.stwiss.opensource@diasemi.com>
 <20161129005927.GA1848@localhost.localdomain>
In-Reply-To: <20161129005927.GA1848@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Eduardo,

On 29 November 2016 00:59, Eduardo Valentin, wrote:
> On Wed, Oct 26, 2016 at 05:56:37PM +0100, Steve Twiss wrote:
> > +Optional properties:
> > +
> > +- dlg,tjunc-temp-polling-period-ms : Specify the polling period, mea=
sured
> > +    in milliseconds, between thermal zone device update checks.
>=20
> Can you please elaborate on why you need this chip manufacture specific
> property?
>=20
> Can we use the polling property of already existing in the
> Documentation/devicetree/bindings/thermal/thermal.txt
>=20
> See the polling properties.

[...]
> > +			dlg,tjunc-temp-polling-period-ms =3D <3000>;

Agreed. There is a polling period built into the thermal core. I've discu=
ssed my
reasoning for this decision in answer to your other e-mail. Please refer =
to the
other discussion thread: https://lkml.org/lkml/2016/11/29/262

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
