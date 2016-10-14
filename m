Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.112]:54913 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754498AbcJNM0V (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Oct 2016 08:26:21 -0400
From: Steve Twiss <stwiss.opensource@diasemi.com>
To: Rob Herring <robh@kernel.org>
CC: DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Guenter Roeck" <linux@roeck-us.net>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH V1 09/10] Documentation: dt: mfd: da9062/61 MFD binding
Date: Fri, 14 Oct 2016 12:26:07 +0000
Message-ID: <6ED8E3B22081A4459DAC7699F3695FB7018CCE342A@SW-EX-MBX02.diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <7a21f22bd62817b63ba64e11eecadfb78338ee46.1475743411.git.stwiss.opensource@diasemi.com>
 <20161010134235.GA20577@rob-hp-laptop>
In-Reply-To: <20161010134235.GA20577@rob-hp-laptop>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On 10 October 2016 14:43, Rob Herring wrote:
> On Thu, Oct 06, 2016 at 09:43:31AM +0100, Steve Twiss wrote:
[...]
> > @@ -64,10 +89,6 @@ Example:
> >  			compatible =3D "dlg,da9062-rtc";
> >  		};
> >
> > -		watchdog {
> > -			compatible =3D "dlg,da9062-watchdog";
> > -		};
> > -
>=20
> I don't understand why this is removed?

This MFD binding file now contains a link to a separate watchdog binding =
file.
I moved the example and the binding information into this new watchdog bi=
nding
document. I also updated it for DA9061.

+- watchdog: See ../watchdog/da9062-watchdog.txt

I will add this information into the patch description for V2 to make thi=
ngs clearer.

Regards,
Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
