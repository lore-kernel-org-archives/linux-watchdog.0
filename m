Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39835 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750985AbdHBE2f (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Aug 2017 00:28:35 -0400
Message-ID: <1501648105.29409.1.camel@aj.id.au>
Subject: Re: [PATCH v5 1/2] drivers/watchdog: Add optional ASPEED device
 tree properties
From: Andrew Jeffery <andrew@aj.id.au>
To: Christopher Bostic <cbostic@linux.vnet.ibm.com>, wim@iguana.be,
        linux@roeck-us.net, robh+dt@kernel.org, mark.rutland@arm.com,
        joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 02 Aug 2017 13:58:25 +0930
In-Reply-To: <20170717192539.7950-2-cbostic@linux.vnet.ibm.com>
References: <20170717192539.7950-1-cbostic@linux.vnet.ibm.com>
         <20170717192539.7950-2-cbostic@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Dr2FYtSncrw5R+vjynQB"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--=-Dr2FYtSncrw5R+vjynQB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-07-17 at 14:25 -0500, Christopher Bostic wrote:
> Describe device tree optional properties:
>=20
> =C2=A0 * aspeed,reset-type =3D "cpu|soc|system|none"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0One of three different, mutually exclusive,=
 values
>=20
> 	"cpu" : ARM CPU reset on signal
> 	"soc" : 'System on chip' reset
> 	"system" : Full system reset
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0The value can also be set to "none" which i=
ndicates that no
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reset of any kind is to be done via this wa=
tchdog.=C2=A0=C2=A0This assumes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0another watchdog on the chip is to take car=
e of resets.
>=20
> =C2=A0 * aspeed,external-signal - Generate external signal (WDT1 and WDT2=
 only)
> =C2=A0 * aspeed,alt-boot - Boot from alternate block on signal
>=20
> > Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
> ---
> v5 - Removed aspeed,interrupt property - no plans at this point to
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0need this functionality in the driver.
> v4 - Add aspeed-reset-type and assign one of four values,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpu, soc, system, none.
> v3 - Invert soc and sys reset to 'no' to preserve backwards
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0compatibility.=C2=A0=C2=A0SOC and SYS reset=
 will be set by default
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0without any optional parameters set
> v2 - Add 'aspeed,' prefix to all optional properties
> =C2=A0=C2=A0=C2=A0- Add arm-reset, soc-reset, interrupt, alt-boot propert=
ies
> ---
> =C2=A0.../devicetree/bindings/watchdog/aspeed-wdt.txt=C2=A0=C2=A0=C2=A0=
=C2=A0| 32 ++++++++++++++++++++++
> =C2=A01 file changed, 32 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/=
Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> index c5e74d7..2b34ce9 100644
> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -8,9 +8,41 @@ Required properties:
> =C2=A0 - reg: physical base address of the controller and length of memor=
y mapped
> =C2=A0=C2=A0=C2=A0=C2=A0region
> =C2=A0
> +Optional properties:
> +
> + - aspeed,reset-type =3D "cpu|soc|system|none"
> +
> +=C2=A0=C2=A0=C2=A0Reset behavior - Whenever a timeout occurs the watchdo=
g can be programmed
> +=C2=A0=C2=A0=C2=A0to generate one of three different, mutually exclusive=
, types of resets.
> +
> +=C2=A0=C2=A0=C2=A0Type "none" can be specified to indicate that no reset=
s are to be done.
> +=C2=A0=C2=A0=C2=A0This is useful in situations where another watchdog en=
gine on chip is
> +=C2=A0=C2=A0=C2=A0to perform the reset.
> +
> +=C2=A0=C2=A0=C2=A0If 'aspeed,reset-type=3D' is not specfied the default =
is to enable system
> +=C2=A0=C2=A0=C2=A0reset.
> +
> +=C2=A0=C2=A0=C2=A0Reset types:
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- cpu: Reset CPU on watc=
hdog timeout
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- soc: Reset 'System on =
Chip' on watchdog timeout
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- system: Reset system o=
n watchdog timeout
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- none: No reset is perf=
ormed on timeout. Assumes another watchdog
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0engine is responsible for this.
> +
> + - aspeed,external-signal: If property is present then signal is sent to
> > +			external reset counter (only WDT1 and WDT2). If not
> +			specified no external signal is sent.

Sorry I'm a little late on this one, but we should probably also add
some words to the effect that if you specify aspeed,external-signal,
then you also need to ensure the pinmux is configured for this to work.
For example in the devicetree we need to add:

    pinctrl-names =3D "default";
    pinctrl-0 =3D <&pinctrl_wdtrst1_default>;

Now the name of the pinctrl node isn't set in stone, so I don't think
we should mention it directly. However this is the essence of what we
want to describe.

Cheers,

Andrew

> + - aspeed,alt-boot:=C2=A0=C2=A0=C2=A0=C2=A0If property is present then b=
oot from alternate block.
> +
> =C2=A0Example:
> =C2=A0
> > > =C2=A0	wdt1: watchdog@1e785000 {
> > =C2=A0		compatible =3D "aspeed,ast2400-wdt";
> > =C2=A0		reg =3D <0x1e785000 0x1c>;
> > +		aspeed,reset-type =3D "system";
> > +		aspeed,external-signal;
> > =C2=A0	};
--=-Dr2FYtSncrw5R+vjynQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZgVTpAAoJEJ0dnzgO5LT5eSYP+gLHNgL+aMLX2ZWeGtRUnd/M
WkX2ML7G1MQgwk6mRcIx+CJcKCCrN2JcS2Um60K3d60xeYvRSS3eOWRt1uEqsbez
/C5dKwmxTiZl+vwbKCt4z+tWoAhL3LTk+7AZYmrbDC24EXIFSRfYeFNfHRkYab3Y
VxkbSeLNQzXpfYRXijQ1Tuq1+rCN7adOVLfeQ3M+2HmHi/v8sHl2FZ0ggoDi5Gdp
uQJdeSpa3cXSh+E3CLB/6OBuH1oLkFzutmLiV3nKz6oW7gT6YMGBDZiZnMD1urCy
duBMgnimuasyA4ufZ7lNfpZj656K7KD6dXjiXMNqc4MnZAycNh1U3hZpEQNcczqH
uExNVYl0SU3HqLEaFPEZVWI6zY0M+uf9Dw+4M8p79c8na3hLNx8xcaIjBekBbpBp
b2iUenYAT3Zac2fyagQyNGCx5UHqFWhcS9aDxOxcKL+OopUK/vXFLu0nJMbjub4n
kHKswwAHwuMEOO4VOPrQh2c7rXFxvgV0M6uP/PZGXlkkpxSsVNYq25zA+HvkIlDy
q2hziRuD2nLvDisCGUN6kzB42TfGN+kyamKadFP+6+3kQzN1wvieG262kDb/pfRr
PKBkWlgcWh88MA8dLFWBpSU6eXYeWiS4sC2GRveSNrdz2lx/BMBAUnmZK48Ei2Wh
aVA/SOcEQN+gMoFHKiGI
=hPce
-----END PGP SIGNATURE-----

--=-Dr2FYtSncrw5R+vjynQB--

