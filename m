Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48213 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752043AbcLKJkU (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 11 Dec 2016 04:40:20 -0500
Date: Sun, 11 Dec 2016 10:40:18 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC PATCH 2/2] ARM: i.MX: dts: add fsl, imx25-wdt compatible to
 all relevant watchdog nodes
Message-ID: <20161211094018.zechblje3pburxx3@pengutronix.de>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
 <1474850361-20884-3-git-send-email-vz@mleia.com>
 <20160926062759.3eoezyezog6clz6x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20160926062759.3eoezyezog6clz6x@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Sep 26, 2016 at 08:27:59AM +0200, Uwe Kleine-K=F6nig wrote:
> On Mon, Sep 26, 2016 at 03:39:21AM +0300, Vladimir Zapolskiy wrote:
> > Watchdog device controller found on all modern SoCs from i.MX series
> > and firstly introduced in i.MX25 is not one in one compatible with th=
e
> > watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
> > controlles don't have WICR (and pretimeout notification support) and
> > WMCR registers. To get benefit from the more advanced watchdog device
> > and to avoid operations over non-existing registers on legacy SoCs ad=
d
> > fsl,imx25-wdt compatible to descriptions of all i.MX25 compatible
> > watchdog controllers.
> >=20
> > Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> > ---
> >  arch/arm/boot/dts/imx35.dtsi   |  3 ++-
> >  arch/arm/boot/dts/imx50.dtsi   |  3 ++-
> >  arch/arm/boot/dts/imx51.dtsi   |  6 ++++--
> >  arch/arm/boot/dts/imx53.dtsi   |  6 ++++--
> >  arch/arm/boot/dts/imx6qdl.dtsi |  6 ++++--
> >  arch/arm/boot/dts/imx6sl.dtsi  |  6 ++++--
> >  arch/arm/boot/dts/imx6sx.dtsi  |  9 ++++++---
> >  arch/arm/boot/dts/imx6ul.dtsi  |  6 ++++--
> >  arch/arm/boot/dts/imx7s.dtsi   | 12 ++++++++----
> >  arch/arm/boot/dts/ls1021a.dtsi |  2 +-
> >  arch/arm/boot/dts/vfxxx.dtsi   |  3 ++-
> >  11 files changed, 41 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.d=
tsi
> > index 490b7b4..8fd4482 100644
> > --- a/arch/arm/boot/dts/imx35.dtsi
> > +++ b/arch/arm/boot/dts/imx35.dtsi
> > @@ -284,7 +284,8 @@
> >  			};
> > =20
> >  			wdog: wdog@53fdc000 {
> > -				compatible =3D "fsl,imx35-wdt", "fsl,imx21-wdt";
> > +				compatible =3D "fsl,imx35-wdt", "fsl,imx25-wdt",
> > +					     "fsl,imx21-wdt";
>=20
> When this is used on an old kernel that doesn't know about fsl,imx25-wd=
t
> this picks up the imx21 driver logic. As this is wrong I think you
> should drop imx21-wdt here. Can one of the dt-people comfirm?

I forgot in the mail at the other end of this thread that the dti were
already addressed. I (implicitly) wrote there that fsl,imx35-wdt should
be the new compatible describing the wdt with misc register. Picking
imx25 (as you did) works, too, but e.g. the CSPI device has

	compatible =3D "fsl,imx25-cspi", "fsl,imx35-cspi";

on the i.MX25 and

	compatible =3D "fsl,imx35-cspi";

on the i.MX35. So I think we should pick i.MX35 here, too, as the one
giving its name.

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
