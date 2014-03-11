Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:58053 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875AbaCKUQo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Mar 2014 16:16:44 -0400
Date: Tue, 11 Mar 2014 17:16:24 -0300
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
Subject: Re: [PATCH v2 4/7] watchdog: orion: Add Armada 375/380 SoC support
Message-ID: <20140311201624.GC8506@arch.cereza>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1393949244-5011-5-git-send-email-ezequiel.garcia@free-electrons.com>
 <531D1F9B.8090804@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <531D1F9B.8090804@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 09, Guenter Roeck wrote:
> On 03/04/2014 08:07 AM, Ezequiel Garcia wrote:
[..]
> >  MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
> >@@ -396,6 +475,25 @@ static int orion_wdt_probe(struct platform_devi=
ce *pdev)
> >  		if (!dev->rstout)
> >  			return -ENOMEM;
> >
> >+	} else if (of_device_is_compatible(node, "marvell,armada-375-wdt")=
 ||
> >+		   of_device_is_compatible(node, "marvell,armada-380-wdt")) {
> >+
> >+		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>=20
> Looks like each supported watchdog needs this call. Might as well do =
it earlier
> and just once, unless you have a good reason for doing it this way.
> To me this just looks like a lot of code replication.
>=20

Well... it seemed to me as cleaner to have one 'if' block per compatibl=
e
group and do all the ioremap'ing in it.

Otherwise, it would be like this (seudo-code):

rstout =3D foo_request_ioremap();
if (!rsout)
	if (compatible(1)) {
		/* Missing RSTOUT! Do backwards compatibility hack */
		rstout =3D fw_bug_fallback();
		if (!rstout)
			return -ENODEV;
	} else
		return -ENODEV;

if (compatible(3))
	rstout_mask =3D foo_request_ioremap();
	if (!rstout_mask)
		return -ENODEV;

Maybe it's a matter of taste, but I think this looks better:

if (compatible(1))
	request_ioremap all registers ...
else if (compatible(2))
	request_ioremap all registers ...
else if (compatible(3))
	request_ioremap all registers ...
else
	return -ENODEV;

At the price of a little code duplication.

> It might also possibly make sense to move all the memory initializati=
ons
> into a separate function; the probe function gets a bit large.
>=20
> >+		if (!res)
> >+			return -ENODEV;
> >+		dev->rstout =3D devm_ioremap(&pdev->dev, res->start,
> >+					   resource_size(res));
> >+		if (!dev->rstout)
> >+			return -ENOMEM;
> >+
> >+		res =3D platform_get_resource(pdev, IORESOURCE_MEM, 2);
> >+		if (!res)
> >+			return -ENODEV;
> >+		dev->rstout_mask =3D devm_ioremap(&pdev->dev, res->start,
> >+						resource_size(res));
>=20
> devm_ioremap_resource() is better here.
>=20

True. We are currently confusing the shared and non-shared registers,
and treating them all as shared. I'll fix that.

Thanks for the review,
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
