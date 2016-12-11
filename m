Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47429 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751795AbcLKK0o (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Dec 2016 05:26:44 -0500
Date: Sun, 11 Dec 2016 11:26:34 +0100
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
Message-ID: <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
References: <20161211010648.6591-1-vz@mleia.com>
 <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hello Vladimir,

On Sun, Dec 11, 2016 at 12:01:08PM +0200, Vladimir Zapolskiy wrote:
> On 12/11/2016 11:35 AM, Uwe Kleine-K=F6nig wrote:
> > On Sun, Dec 11, 2016 at 03:06:48AM +0200, Vladimir Zapolskiy wrote:
> >> Power down counter enable/disable bit switch is located in WMCR
> >> register, but watchdog controllers found on legacy i.MX21, i.MX27 an=
d
> >> i.MX31 SoCs don't have this register. As a result of writing data to
> >> the non-existing register on driver probe the SoC hangs up, to fix t=
he
> >> problem add more OF compatible strings and on this basis get
> >> information about availability of the WMCR register.
> >>
> >> Fixes: 5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter=
 on boot")
> >> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> >> ---
>=20
> [snip]
>=20
> >> =20
> >>  static const struct of_device_id imx2_wdt_dt_ids[] =3D {
> >> -	{ .compatible =3D "fsl,imx21-wdt", },
> >> +	{ .compatible =3D "fsl,imx21-wdt", .data =3D IMX2_WDT_NO_WMCR },
> >> +	{ .compatible =3D "fsl,imx25-wdt",  },
> >> +	{ .compatible =3D "fsl,imx27-wdt", .data =3D IMX2_WDT_NO_WMCR },
> >> +	{ .compatible =3D "fsl,imx31-wdt", .data =3D IMX2_WDT_NO_WMCR },
> >> +	{ .compatible =3D "fsl,imx35-wdt",  },
> >> +	{ .compatible =3D "fsl,imx50-wdt",  },
> >> +	{ .compatible =3D "fsl,imx51-wdt",  },
> >> +	{ .compatible =3D "fsl,imx53-wdt",  },
> >> +	{ .compatible =3D "fsl,imx6q-wdt",  },
> >> +	{ .compatible =3D "fsl,imx6sl-wdt", },
> >> +	{ .compatible =3D "fsl,imx6sx-wdt", },
> >> +	{ .compatible =3D "fsl,imx6ul-wdt", },
> >> +	{ .compatible =3D "fsl,imx7d-wdt",  },
> >> +	{ .compatible =3D "fsl,vf610-wdt",  },
> >=20
> > Up to now we only had fsl,imx21-wdt, now it seems that iMX31, i.MX27 =
and
> > i.MX21 form a group of equal watchdog IPs and the others form another
> > group, right?
> >=20
> > So conceptually we should differenciate between
> >=20
> > 	fsl,imx21-wdt (which is used on i.MX21, i.MX27 and i.MX31)
> > 	fsl,imx35-wdt (which is used on all others)
> >=20
>=20
> The problem is that "fsl,imx35-wdt" is not used on all others in the
> existing DTS, i.e. in the old firmware, which shall be compatible with
> new changes.

So old i.MX53 has

	compatible =3D "fsl,imx53-wdt", "fsl,imx21-wdt";

. With the change to the driver it's like using the watchdog driver in
it's pre-5fe65ce7ccbb4-state on it. If this is bad, we must indeed make
fsl,imx53-wdt known to the driver. If not, just adding a single new
compatible to the driver is just fine.

If you want to call it imx25 or imx35 doesn't matter much. The reason I
picked imx35 is that this one was already picked before for cspi. This
suggests that i.MX35 is older than i.MX25 and so this is the canonical
choice.

> $ grep -H 'fsl,imx.*-wdt' arch/arm/boot/dts/*.dtsi
> arch/arm/boot/dts/imx25.dtsi:				compatible =3D "fsl,imx25-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx27.dtsi:				compatible =3D "fsl,imx27-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx35.dtsi:				compatible =3D "fsl,imx35-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx50.dtsi:				compatible =3D "fsl,imx50-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx51.dtsi:				compatible =3D "fsl,imx51-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx51.dtsi:				compatible =3D "fsl,imx51-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx53.dtsi:				compatible =3D "fsl,imx53-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx53.dtsi:				compatible =3D "fsl,imx53-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx6qdl.dtsi:				compatible =3D "fsl,imx6q-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6qdl.dtsi:				compatible =3D "fsl,imx6q-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6sl.dtsi:				compatible =3D "fsl,imx6sl-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6sl.dtsi:				compatible =3D "fsl,imx6sl-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6sx.dtsi:				compatible =3D "fsl,imx6sx-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6ul.dtsi:				compatible =3D "fsl,imx6ul-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx6ul.dtsi:				compatible =3D "fsl,imx6ul-wdt", "fsl=
,imx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/imx7s.dtsi:				compatible =3D "fsl,imx7d-wdt", "fsl,i=
mx21-wdt";
> arch/arm/boot/dts/ls1021a.dtsi:			compatible =3D "fsl,imx21-wdt";
> arch/arm/boot/dts/vfxxx.dtsi:				compatible =3D "fsl,vf610-wdt", "fsl,i=
mx21-wdt";
>=20
> I don't see a confirmation of the fact that "fsl,imx35-wdt" is the best
> selection, hence definitely "fsl,imx25-wdt" overscores it.

I stated my reason to pick imx35 over imx25 above. Why do yo prefer
imx25?

> > A reason to add e.g. fsl,imx6sl-wdt is that dtbs in the wild use
> >=20
> > 	"fsl,imx6sl-wdt", "fsl,imx21-wdt"
> >=20
> > . But then I wonder if=20
> >=20
> > 	5fe65ce7ccbb ("watchdog: imx2_wdt: Disable power down counter on boo=
t")
> >=20
> > is that important to justify to add these all.
>=20
> About this comment I don't know, you may have better insight about the =
original
> change. By the way, in barebox you may want to fix the same hang-up, be=
cause
> you touch WMCR unconditionally.

Sure.
=20
> > Independant of this I'd like to have all dtsi for the newer SoCs chan=
ged
> > to get
> >=20
> > 	"fsl,imx6sl-wdt", "fsl,imx35-wdt"
> >=20
> > and if you really want to add all these compatibles, add a comment th=
at
> > these are really fsl,imx35-wdt and were added to work around broken
> > dtbs.
>=20
> No objections, but
>=20
> 1) I'd like to see "fsl,imx25-wdt" as a new common compatible, and that=
's
> what have been proposed and shared in RFC 2/2.

Yeah, I missed that other patch (which was not part of this series).

> 2) Please remind me, why do you ask to drop "fsl,imx21-wdt" from the li=
st?
>=20
>      compatible =3D "fsl,imx6sx-wdt", "fsl,imx25-wdt", "fsl,imx21-wdt";
>=20
> The list of compatibles above is valid (from the most specific on the l=
eft
> to the most generic on the right), and that compatible property is righ=
tly
> handled in the driver with this change applied. I don't see a need to
> drop "fsl,imx21-wdt".

If the wdt in the i.MX6SX can be operated by the watchdog driver in it's
imx21 mode, you should keep the imx21 entry. If not, you shouldn't.

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
