Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:41671 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdKIQpD (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 9 Nov 2017 11:45:03 -0500
Date: Thu, 9 Nov 2017 16:43:43 +0000
From: James Hogan <james.hogan@mips.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
Message-ID: <20171109164342.GR15235@jhogan-linux>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
 <20171109074718.GR15260@jhogan-linux>
 <20171109160147.GB19959@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hI0HXimLkvfVxAyB"
Content-Disposition: inline
In-Reply-To: <20171109160147.GB19959@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

--hI0HXimLkvfVxAyB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 08:01:47AM -0800, Guenter Roeck wrote:
> On Thu, Nov 09, 2017 at 07:47:19AM +0000, James Hogan wrote:
> > Hi Wim,
> >=20
> > On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> > > This driver works for jz4740 & jz4780
> > >=20
> > > Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> > > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> >=20
> > I just noticed that though Ralf applied the other two patches in this
> > series (defconfig + dt), he hadn't applied this patch.
> >=20
> > Please can we have an ack from a watchdog maintainer so this can get
> > into 4.15 via the MIPS tree? It could alternatively go via the watchdog
> > tree if you prefer.
> >=20
>=20
> FWIW, according to my logs I did send out a Reviewed-by: some time ago,
> which normally means that I expect it to go through the watchdog tree.
> I wasn't aware that you wanted the patch to go through the mips tree.
> Sorry if I missed that earlier. For the record,
>=20
> Acked-by: Guenter Roeck <linux@roeck-us.net>
>=20
> since I don't care one way or another.

Okay thanks, I wasn't sure and don't much mind which way it goes.

>=20
> I assume you want me to drop this and the related patches from my own
> watchdpog-next tree to prevent it from showing up in Wim's tree (if
> it isn't already there). Is that correct ?

I haven't seen this patch in linux-next, or I wouldn't have mentioned
it. If its already in some staging tree for 4.15 that I've missed then
it may as well stay there, otherwise I'll just take it through the MIPS
tree with your ack.

Cheers
James

--hI0HXimLkvfVxAyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAloEhb4ACgkQbAtpk944
dnrSKQ/9HFjsZh9YkvycI/pPI2bSCk7IU7lI9rU73J99fBKu5sImGtJTfwT3icOX
S1Qd4jjs9M4ue7TGLtgFYIs/5adVYLEFkb14BvEneHJZt87thDqcLIdNlaMWf4dZ
oGBmeazdmEmHAUfb63AU2/jmEOewHqvoLl2Q5FWzHLGsMrQzgiyHUveiBeEup/6E
G3bX5PheTVxKjiEzV+4KY1Vvz7uef/v9mgXjbxDuqsGdaZlP94SKpBgaIuTrpLZA
LXx2+kFrLRKVyhB/S8NfyB09rAgw61R8TVOX9crThaT86qywtzwWkG/LIyvM71+y
ULtgDGutbDsA0XUftinxSnn9YlDg/UN7tJoXcYWKj5Ne7o73zP0Ug1CnYO632aLO
moeiNTBWlkD7LLc4cPi3E+x5/lAfgwCm2yvczkblu8Y/sDVp+YgpNXIuv1bkTX6T
4exB46T30d6gFj3/p032c7LjcD2JVY0D0118qgeIwHEPSEp/gZ9a5+oR4eVCoyZw
6ss40CNP84ofuhfOUAYL3nwYOkFPKlPZYkliB3C6iQ5e9+BJNen36EZQzr0rTVOx
rP0JyCXs/2ZLOnl+f5/dlFDYArar95eYLdDWObdnzVF+h22Si2GvLylgbE2rsJaV
FkjvYOipD3kMmD/WFwO0DuEk3V/VPaXaD4qctV32CDT+sFTq0VE=
=h0L4
-----END PGP SIGNATURE-----

--hI0HXimLkvfVxAyB--
