Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mleia.com ([178.79.152.223]:59124 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbcLKKBP (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Dec 2016 05:01:15 -0500
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
Date: Sun, 11 Dec 2016 12:01:08 +0200
MIME-Version: 1.0
In-Reply-To: <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hello Uwe,

On 12/11/2016 11:35 AM, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Dec 11, 2016 at 03:06:48AM +0200, Vladimir Zapolskiy wrote:
>> Power down counter enable/disable bit switch is located in WMCR
>> register, but watchdog controllers found on legacy i.MX21, i.MX27 and
>> i.MX31 SoCs don't have this register. As a result of writing data to
>> the non-existing register on driver probe the SoC hangs up, to fix the
>> problem add more OF compatible strings and on this basis get
>> information about availability of the WMCR register.
>>
>> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter o=
n boot")
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---

[snip]

>> =20
>>  static const struct of_device_id imx2_wdt_dt_ids[] =3D {
>> -	{ .compatible =3D "fsl,imx21-wdt", },
>> +	{ .compatible =3D "fsl,imx21-wdt", .data =3D IMX2_WDT_NO_WMCR },
>> +	{ .compatible =3D "fsl,imx25-wdt",  },
>> +	{ .compatible =3D "fsl,imx27-wdt", .data =3D IMX2_WDT_NO_WMCR },
>> +	{ .compatible =3D "fsl,imx31-wdt", .data =3D IMX2_WDT_NO_WMCR },
>> +	{ .compatible =3D "fsl,imx35-wdt",  },
>> +	{ .compatible =3D "fsl,imx50-wdt",  },
>> +	{ .compatible =3D "fsl,imx51-wdt",  },
>> +	{ .compatible =3D "fsl,imx53-wdt",  },
>> +	{ .compatible =3D "fsl,imx6q-wdt",  },
>> +	{ .compatible =3D "fsl,imx6sl-wdt", },
>> +	{ .compatible =3D "fsl,imx6sx-wdt", },
>> +	{ .compatible =3D "fsl,imx6ul-wdt", },
>> +	{ .compatible =3D "fsl,imx7d-wdt",  },
>> +	{ .compatible =3D "fsl,vf610-wdt",  },
>=20
> Up to now we only had fsl,imx21-wdt, now it seems that iMX31, i.MX27 an=
d
> i.MX21 form a group of equal watchdog IPs and the others form another
> group, right?
>=20
> So conceptually we should differenciate between
>=20
> 	fsl,imx21-wdt (which is used on i.MX21, i.MX27 and i.MX31)
> 	fsl,imx35-wdt (which is used on all others)
>=20

The problem is that "fsl,imx35-wdt" is not used on all others in the
existing DTS, i.e. in the old firmware, which shall be compatible with
new changes.

$ grep -H 'fsl,imx.*-wdt' arch/arm/boot/dts/*.dtsi
arch/arm/boot/dts/imx25.dtsi:				compatible =3D "fsl,imx25-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx27.dtsi:				compatible =3D "fsl,imx27-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx35.dtsi:				compatible =3D "fsl,imx35-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx50.dtsi:				compatible =3D "fsl,imx50-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx51.dtsi:				compatible =3D "fsl,imx51-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx51.dtsi:				compatible =3D "fsl,imx51-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx53.dtsi:				compatible =3D "fsl,imx53-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx53.dtsi:				compatible =3D "fsl,imx53-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx6qdl.dtsi:				compatible =3D "fsl,imx6q-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6qdl.dtsi:				compatible =3D "fsl,imx6q-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6sl.dtsi:				compatible =3D "fsl,imx6sl-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6sl.dtsi:				compatible =3D "fsl,imx6sl-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6ul.dtsi:				compatible =3D "fsl,imx6ul-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx6ul.dtsi:				compatible =3D "fsl,imx6ul-wdt", "fsl,i=
mx21-wdt";
arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,imx=
21-wdt";
arch/arm/boot/dts/ls1021a.dtsi:			compatible =3D "fsl,imx21-wdt";
arch/arm/boot/dts/vfxxx.dtsi:				compatible =3D "fsl,vf610-wdt", "fsl,imx=
21-wdt";

I don't see a confirmation of the fact that "fsl,imx35-wdt" is the best
selection, hence definitely "fsl,imx25-wdt" overscores it.

> A reason to add e.g. fsl,imx6sl-wdt is that dtbs in the wild use
>=20
> 	"fsl,imx6sl-wdt", "fsl,imx21-wdt"
>=20
> . But then I wonder if=20
>=20
> 	5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boot"=
)
>=20
> is that important to justify to add these all.

About this comment I don't know, you may have better insight about the or=
iginal
change. By the way, in barebox you may want to fix the same hang-up, beca=
use
you touch WMCR unconditionally.

>=20
> Independant of this I'd like to have all dtsi for the newer SoCs change=
d
> to get
>=20
> 	"fsl,imx6sl-wdt", "fsl,imx35-wdt"
>=20
> and if you really want to add all these compatibles, add a comment that
> these are really fsl,imx35-wdt and were added to work around broken
> dtbs.

No objections, but

1) I'd like to see "fsl,imx25-wdt" as a new common compatible, and that's
what have been proposed and shared in RFC 2/2.

2) Please remind me, why do you ask to drop "fsl,imx21-wdt" from the list=
?

     compatible =3D "fsl,imx6sx-wdt", "fsl,imx25-wdt", "fsl,imx21-wdt";

The list of compatibles above is valid (from the most specific on the lef=
t
to the most generic on the right), and that compatible property is rightl=
y
handled in the driver with this change applied. I don't see a need to
drop "fsl,imx21-wdt".

As a reminder while changing the source code new (updated) kernel must be
compatible with the old (not updated) DTB firmware, and not the other way
round.

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
