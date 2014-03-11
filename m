Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:57999 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755257AbaCKUGV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Mar 2014 16:06:21 -0400
Date: Tue, 11 Mar 2014 17:06:03 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 1/7] watchdog: orion: Introduce a SoC-specific RSTOUT
 mapping
Message-ID: <20140311200603.GB8506@arch.cereza>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1393949244-5011-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <531D1EC7.4090701@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <531D1EC7.4090701@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

Thanks for reviewing this patchset.

On Mar 09, Guenter Roeck wrote:
[..]
> >@@ -317,6 +313,7 @@ MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table=
);
> >  static int orion_wdt_probe(struct platform_device *pdev)
> >  {
> >  	struct orion_watchdog *dev;
> >+	struct device_node *node =3D pdev->dev.of_node;
> >  	const struct of_device_id *match;
> >  	unsigned int wdt_max_duration;	/* (seconds) */
> >  	struct resource *res;
> >@@ -346,10 +343,27 @@ static int orion_wdt_probe(struct platform_dev=
ice *pdev)
> >  	if (!dev->reg)
> >  		return -ENOMEM;
> >
> >-	dev->rstout =3D orion_wdt_ioremap_rstout(pdev, res->start &
> >-						     INTERNAL_REGS_MASK);
> >-	if (!dev->rstout)
> >+	if (of_device_is_compatible(node, "marvell,orion-wdt")) {
> >+
> >+		dev->rstout =3D orion_wdt_ioremap_rstout(pdev, res->start &
> >+						       INTERNAL_REGS_MASK);
> >+		if (!dev->rstout)
> >+			return -ENODEV;
> >+
> >+	} else if (of_device_is_compatible(node, "marvell,armada-370-wdt")=
 ||
> >+		   of_device_is_compatible(node, "marvell,armada-xp-wdt")) {
> >+
> >+		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> >+		if (!res)
> >+			return -ENODEV;
> >+		dev->rstout =3D devm_ioremap(&pdev->dev, res->start,
> >+					   resource_size(res));
>=20
> Better use devm_ioremap_resource, and then you don't have to check fo=
r
> the error from platform_get_resource() since devm_ioremap_resource()
> takes care of it.
>=20
> The same change should be made for the other calls call to devm_iorem=
ap;
> different patch though.
>=20

Hm... well, could be. However it's not that simple! devm_ioremap_resour=
ce()
calls request_region() and since the RSTOUT register is shared, we can'=
t
request it for this driver. This applies on orion-wdt only, though,
and not on armada-{370,xp}-wdt, so we can do it as long as we keep two
different paths.

> On a side note, the resource is always assigned, only a workaround ex=
ists
> for "marvell,orion-wdt" if it isn't. Wonder if it would make sense
> to move the calls to platform_get_resource and devm_ioremap[_resource=
]
> further up and have it just in this function.
>=20

Aside from the above discussion about requesting the resource, I think =
it's
more readable this way, hiding the complexity of the firmware bug fallb=
ack
on a function, and use different paths.

> >+		if (!dev->rstout)
> >+			return -ENOMEM;
> >+
> >+	} else {
> >  		return -ENODEV;
>=20
> Is this stricter than the original code on purpose ?
>=20
> Previously the driver would instantiate successfully in this case
> as long as IORESOURCE_MEM, 1 was defined.
>=20

Uh? This patch is not changing that. We're just splitting the way we
ioremap the RSTOUT register, as preparation work to add another compati=
ble
string. Unless I've done something wrong, this is not *stricter* in any
way.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
