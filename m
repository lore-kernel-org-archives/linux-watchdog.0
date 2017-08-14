Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:56857 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752237AbdHNDQ2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 13 Aug 2017 23:16:28 -0400
Message-ID: <1502680096.14932.8.camel@aj.id.au>
Subject: Re: [PATCH 00/11] watchdog: Consolidate FTWDT010 derivatives
From: Andrew Jeffery <andrew@aj.id.au>
To: Joel Stanley <joel@jms.id.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org,
        Ryan Chen <ryan_chen@aspeedtech.com>, robh+dt@kernel.org
Date: Mon, 14 Aug 2017 12:38:16 +0930
In-Reply-To: <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
         <CACPK8XetQJ_=CD4TPOmyigQZv2pRankWYew31Yf_ep4fai6X-g@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-A2DFF59g24ddwxdH0eLD"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--=-A2DFF59g24ddwxdH0eLD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-08-14 at 10:54 +0930, Joel Stanley wrote:
> Hi Linus,
>=C2=A0
> On Sun, Aug 13, 2017 at 4:13 AM, Linus Walleij <linus.walleij@linaro.org>=
 wrote:
> > The MOXA ART and Aspeed watchdogs are clearly based on the
> > Faraday Technology FTWDT010 IP block.
>=C2=A0
> They have a similar register interface, but I'm told they are not the sam=
e IP.
>=C2=A0
> We've got some patches on the list that add some extra registers to
> the driver for the ast2500. If we decide to merge the drivers, that
> support will need to be included.
>=C2=A0
> Andrew was working on that, I'll let him follow up on the details.

There are two series on the lists expanding driver support for the Aspeed
watchdog, one from Chris Bostic and another from myself:

1. [PATCH v5 0/2] Add ASPEED watchdog device tree properties:

	https://lkml.org/lkml/2017/7/17/777=C2=A0

2. [PATCH 0/2] watchdog: aspeed: External reset signal properties:

	https://www.spinics.net/lists/kernel/msg2570666.html=C2=A0

I don't have the datasheets for either the Moxa or Faraday SoCs, so I can't
assess how the support I've added for the external pulse properties on Aspe=
ed
hardware impacts/is impacted by the merge. Chris' changes on the otherhand =
look
like they could be generalised. At least, the vendor prefix on the devicetr=
ee
properties he defined could perhaps be changed from aspeed to faraday.

Cheers,

Andrew

PS: Patch 10/11 failed to apply for me against several trees, failing on th=
e
hunk for arch/arm/boot/dts/gemini.dtsi. Is there an unmentioned dependency?

>=C2=A0
> > This series consolidates the drivers into one by extending
> > the Gemini driver to be as generic as possible, renaming it
> > to ftwdt010_wdt and merging the two other drivers into it.
> >=C2=A0
> > As similar approach was used for the FTTMR010 driver in the
> > past.
> >=C2=A0
> > The series ends with two patches that will be applied to
> > the ARM SoC tree to fix up the PCLK annotations, but these
> > are not needed to make the consolidation, patches 1-9 can
> > be applied directly to the watchdog tree to perform the
> > consolidation.
>=C2=A0
> The clock isn't called PCLK in the Aspeed documentation (similarly for
> the timer, but I was too slow to speak up in that case).
>=C2=A0
> I'm trying to find some time to write a proper clock driver so it's
> clear how the clocks are set out in the Aspeed.
>=C2=A0
> Cheers,
>=C2=A0
> Joel
--=-A2DFF59g24ddwxdH0eLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZkRQgAAoJEJ0dnzgO5LT529AP/1wq2MynrA2n36JsbdcBE13u
2YvqDjn1eMnNgivw9NeYI17+wKct+83WW5a8kBAkmjvh8tOR4kNHGHd8LpBWZfcl
QP9qiFIl5boVGDQhWwFBZzIYsy649HK4RW9DuNiZGQBXB/YoqVZCNr/pCAmfBEJd
vP94D0HR2QC9xDVEzXHUCgvNmImQ1T9xm86IBEj2PYq8USfcUq4zhogKOXPOW2OZ
fJOT4KO7Pm88kuEPL51aMm+Tf7fU6cT3q3WvKEIlPutd53UgZs15gxHykNA7Bmji
APbC2a9XhblE2hknxGViuUrTRFfCdedl7PnqEJcQQNGJPw0YJvXnNa2+eraduOEG
2yMnfSgpm4vkERTNVwnEE20oTNYimNa3/di9zJOeqzf6JNiWQazOofMn2eTpZcHz
bqLD87ZCkeV+21tTumom7aZDfFKB+0OMO7+w6mk6uDPKgFRRNXxLqhAvsSe7BU4x
kwOH24p6M0mTCEHOzxswDe8vgQu1tvJdJ3nPHkm2cqIDVFpxC34kHPzjzrzDsEjP
25k33zuc1zTfZzZcYknRM0EdRVYc7MiwIkEbRQqUTmhoqJQ6iCeRdfA0Td3S690u
mw+uy/PFWpgaCB44n/w5W5xlXE/wY7yGcbbVMypKqZRl6aIknJRiQm5Zx5+YUjaH
JHRr918vJBjsTpDnwvGk
=2NAu
-----END PGP SIGNATURE-----

--=-A2DFF59g24ddwxdH0eLD--

