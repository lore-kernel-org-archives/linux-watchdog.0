Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47659 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752310AbaAVRGI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 12:06:08 -0500
Date: Wed, 22 Jan 2014 14:06:22 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3 08/15] watchdog: orion: Introduce per-compatible
 of_device_id data
Message-ID: <20140122170621.GC27273@localhost>
References: <1390310774-20781-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390310774-20781-9-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121163547.GB3311@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140121163547.GB3311@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 08:35:47AM -0800, Guenter Roeck wrote:
> On Tue, Jan 21, 2014 at 10:26:07AM -0300, Ezequiel Garcia wrote:
> > This commit adds an orion_watchdog_data structure to holda compatib=
le-data
>=20
> 	s/holda/hold/
>=20

Yup.

> > information. This allows to remove the driver-wide definition and t=
o
> > future add support for multiple compatible-strings.
>=20
> Maybe "and to be able to add support for multiple compatible-strings =
in the
> future" ?
>=20

Yes, sounds better.

[..]
> > =20
> >  #define WDT_MAX_CYCLE_COUNT	0xffffffff
> >  #define WDT_IN_USE		0
> >  #define WDT_OK_TO_CLOSE		1
> > =20
> While looking at the new defines below, I noticed that WDT_IN_USE and
> WDT_OK_TO_CLOSE are not used (anymore ?) and thus should be removed
> (separate patch, though).
>=20

OK, let's clean this.

> > -#define WDT_RESET_OUT_EN	BIT(1)
> > +#define WDT_A370_RATIO_MASK(v)	((v) << 16)
> > +#define WDT_A370_RATIO_SHIFT	5
> > +#define WDT_A370_RATIO		(1 << WDT_A370_RATIO_SHIFT)
> > +
> > +#define WDT_AXP_FIXED_ENABLE_BIT BIT(10)
> > =20
> Those new defines are not used. They should be introduced if and when=
 used.
>=20

Hm... maybe after dozens and dozens of rebases these macros sneaked her=
e?

[..]
> > =20
> > +	match =3D of_match_device(orion_wdt_of_match_table, &pdev->dev);
> > +	if (!match)
> > +		/* Default legacy match */
> > +		match =3D &orion_wdt_of_match_table[0];
> > +
> >  	dev->wdt.info =3D &orion_wdt_info;
> >  	dev->wdt.ops =3D &orion_wdt_ops;
> >  	dev->wdt.min_timeout =3D 1;
> > +	dev->data =3D (struct orion_watchdog_data *)match->data;
>=20
> match->data is a void *, so the typecast should not be needed here.
> You might want to declare 'data' to be of type
> 'const struct orion_watchdog_data *' because otherwise you loose the
> 'const' attribute of match->data (which may be the reason for the typ=
ecast ?).
>=20

Done.

Thanks a lot for reviewing!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
