Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59861 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752772AbcLKM2O (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Dec 2016 07:28:14 -0500
Date: Sun, 11 Dec 2016 13:28:06 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Magnus Lilja <lilja.magnus@gmail.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161211122806.vee7e7fmkpt4xj77@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 11, 2016 at 01:21:16PM +0200, Vladimir Zapolskiy wrote:
> On 12/11/2016 12:26 PM, Uwe Kleine-K=F6nig wrote:
> > . With the change to the driver it's like using the watchdog driver i=
n
> > it's pre-5fe65ce7ccbb4-state on it. If this is bad, we must indeed ma=
ke
> > fsl,imx53-wdt known to the driver. If not, just adding a single new
> > compatible to the driver is just fine.

<sarcasm>You can also add "marvell,armada-xp-wdt" to the end of the
list. If your kernel is configured correctly still the right thing will
happen.</sarcasm>

> The change under discussion preserves the current runtime behaviour for
> i.MX53 and its friends, the watchdog power down counter in WMCR is
> disabled on boot (you may want to confirm it by testing though), anothe=
r
> question is if it is wanted for e.g. i.MX53 right from the beginning.
>=20
> To keep the runtime compatibility of a newer kernel with old DTBs such
> a long list of device compatibles has to be inserted.
>=20
> >=20
> > If you want to call it imx25 or imx35 doesn't matter much. The reason=
 I
> > picked imx35 is that this one was already picked before for cspi. Thi=
s
> > suggests that i.MX35 is older than i.MX25 and so this is the canonica=
l
> > choice.
>=20
> Accepted, from the Wikipedia both i.MX25 and i.MX35 are released in 200=
9,
> which one is the first I don't know for sure, I supposed it could be
> i.MX25 as a SoC with a weaker core.
>=20
> >=20
> >> $ grep -H 'fsl,imx.*-wdt' arch/arm/boot/dts/*.dtsi
> >> arch/arm/boot/dts/imx25.dtsi:				compatible =3D "fsl,imx25-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx27.dtsi:				compatible =3D "fsl,imx27-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx35.dtsi:				compatible =3D "fsl,imx35-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx50.dtsi:				compatible =3D "fsl,imx50-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx51.dtsi:				compatible =3D "fsl,imx51-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx51.dtsi:				compatible =3D "fsl,imx51-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx53.dtsi:				compatible =3D "fsl,imx53-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx53.dtsi:				compatible =3D "fsl,imx53-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx6qdl.dtsi:				compatible =3D "fsl,imx6q-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6qdl.dtsi:				compatible =3D "fsl,imx6q-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sl.dtsi:				compatible =3D "fsl,imx6sl-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sl.dtsi:				compatible =3D "fsl,imx6sl-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6ul.dtsi:				compatible =3D "fsl,imx6ul-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx6ul.dtsi:				compatible =3D "fsl,imx6ul-wdt", "=
fsl,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fs=
l,imx21-wdt";
> >> arch/arm/boot/dts/ls1021a.dtsi:			compatible =3D "fsl,imx21-wdt";
> >> arch/arm/boot/dts/vfxxx.dtsi:				compatible =3D "fsl,vf610-wdt", "fs=
l,imx21-wdt";
> >>
> >> I don't see a confirmation of the fact that "fsl,imx35-wdt" is the b=
est
> >> selection, hence definitely "fsl,imx25-wdt" overscores it.
> >=20
> > I stated my reason to pick imx35 over imx25 above. Why do yo prefer
> > imx25?
>=20
> As you said right now and until it is added into DTS files "fsl,imx25-w=
dt" and
> "fsl,imx35-wdt" are equal as a compatible representation of WMCR-aware =
watchdogs.
>=20
> I may be wrong, if I assume that i.MX25 is released before i.MX35 (look=
s like
> they are released in parallel), but "imx25" precedes in alphanumericall=
y sorted
> list of SoC names.

I'm sure Shawn could say something here, but I would be surprised if the
i.MX25 came first.

> >>> A reason to add e.g. fsl,imx6sl-wdt is that dtbs in the wild use
> >>>
> >>> 	"fsl,imx6sl-wdt", "fsl,imx21-wdt"
> >>>
> >>> . But then I wonder if=20
> >>>
> >>> 	5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on b=
oot")
> >>>
> >>> is that important to justify to add these all.
> >>
> >> About this comment I don't know, you may have better insight about t=
he original
> >> change. By the way, in barebox you may want to fix the same hang-up,=
 because
> >> you touch WMCR unconditionally.
> >=20
> > Sure.
> > =20
> >>> Independant of this I'd like to have all dtsi for the newer SoCs ch=
anged
> >>> to get
> >>>
> >>> 	"fsl,imx6sl-wdt", "fsl,imx35-wdt"
> >>>
> >>> and if you really want to add all these compatibles, add a comment =
that
> >>> these are really fsl,imx35-wdt and were added to work around broken
> >>> dtbs.
> >>
> >> No objections, but
> >>
> >> 1) I'd like to see "fsl,imx25-wdt" as a new common compatible, and t=
hat's
> >> what have been proposed and shared in RFC 2/2.
> >=20
> > Yeah, I missed that other patch (which was not part of this series).
> >=20
> >> 2) Please remind me, why do you ask to drop "fsl,imx21-wdt" from the=
 list?
> >>
> >>      compatible =3D "fsl,imx6sx-wdt", "fsl,imx25-wdt", "fsl,imx21-wd=
t";
> >>
> >> The list of compatibles above is valid (from the most specific on th=
e left
> >> to the most generic on the right), and that compatible property is r=
ightly
> >> handled in the driver with this change applied. I don't see a need t=
o
> >> drop "fsl,imx21-wdt".
> >=20
> > If the wdt in the i.MX6SX can be operated by the watchdog driver in i=
t's
> > imx21 mode, you should keep the imx21 entry. If not, you shouldn't.
>=20
> The DTS description shall be rather independent from any particular sof=
tware
> implementation, someone may want to reuse the same DTB in bootloaders a=
nd OS
> kernels of different versions.

Full ack.

> Assuming that I have a bootloader/kernel with a pure i.MX21 watchdog
> driver and run it on i.MX6SX, I'd prefer to match
> "fsl,imx21-wdt" compatible.

I'd prefer to notice that the i.MX6SX has a (maybe only slightly)
different watchdog and so the i.MX21 aware driver should not bind to the
i.MX6SX hardware. So (as you said above) the compatible should be
independent from already existing i.MX21 wdt support in a driver.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig          =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
