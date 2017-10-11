Return-Path: <andrew@aj.id.au>
Return-path: <andrew@aj.id.au>
Message-ID: <1507693686.5452.174.camel@aj.id.au>
Subject: Re: [PATCH 11/11] ARM: dts: Add PCLK to the Aspeed watchdogs
From: Andrew Jeffery <andrew@aj.id.au>
To: Linus Walleij <linus.walleij@linaro.org>, Wim Van Sebroeck
 <wim@iguana.be>,  Guenter Roeck <linux@roeck-us.net>, Jonas Jensen
 <jonas.jensen@gmail.com>, Joel Stanley <joel@jms.id.au>
Cc: linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
Date: Wed, 11 Oct 2017 14:18:06 +1030
In-Reply-To: <20170812184318.10144-12-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
	 <20170812184318.10144-12-linus.walleij@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-mnz8tb/RuYobThjvM9DZ"
Mime-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


--=-mnz8tb/RuYobThjvM9DZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2017-08-12 at 20:43 +0200, Linus Walleij wrote:
> This adds the PCLK clock to the Aspeed watchdog blocks.
> I am not directly familiar with the Aspeed clocking, but
> since the IP is derived from Faraday FTWDT010 it probably
> has the ability to run the watchdog on the PCLK if
> desired

This is true for the AST2400, but not the AST2500 where the only option
is EXTCLK (1MHz).

>  so to obtain the frequency from it, it needs to
> be present in the device tree, and for completeness the
> PCLK should also be referenced and enabled anyways.
>=20
> Take this opportunity to add the "faraday,ftwdt010"
> compatible as fallback to the watchdog IP blocks.
>=20
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> =C2=A0arch/arm/boot/dts/aspeed-g4.dtsi |=C2=A0=C2=A07 +++++--
> =C2=A0arch/arm/boot/dts/aspeed-g5.dtsi | 12 +++++++++---
> =C2=A02 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-=
g4.dtsi
> index 8a04c7e2d818..23b100383c15 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -895,16 +895,19 @@
> > =C2=A0			};
> =C2=A0
> > > =C2=A0			wdt1: wdt@1e785000 {
> > -				compatible =3D "aspeed,ast2400-wdt";
> > +				compatible =3D "aspeed,ast2400-wdt", "faraday,ftwdt010";
> > =C2=A0				reg =3D <0x1e785000 0x1c>;
> > =C2=A0				interrupts =3D <27>;
> > +				clocks =3D <&clk_apb>;
> > +				clock-names =3D "PCLK";
> > =C2=A0			};
> =C2=A0
> > > =C2=A0			wdt2: wdt@1e785020 {
> > -				compatible =3D "aspeed,ast2400-wdt";
> > +				compatible =3D "aspeed,ast2400-wdt", "faraday,ftwdt010";
> > =C2=A0				reg =3D <0x1e785020 0x1c>;
> > =C2=A0				interrupts =3D <27>;
> > =C2=A0				clocks =3D <&clk_apb>;
> > +				clock-names =3D "PCLK";
> > =C2=A0				status =3D "disabled";
> > =C2=A0			};
> =C2=A0
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-=
g5.dtsi
> index 9cffe347b828..2322d72cd8a9 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -1003,21 +1003,27 @@
> =C2=A0
> =C2=A0
> > > =C2=A0			wdt1: wdt@1e785000 {
> > -				compatible =3D "aspeed,ast2500-wdt";
> > +				compatible =3D "aspeed,ast2500-wdt", "faraday,ftwdt010";
> > =C2=A0				reg =3D <0x1e785000 0x20>;
> > =C2=A0				interrupts =3D <27>;
> > +				clocks =3D <&clk_apb>;
> +				clock-names =3D "PCLK";

Given the comment above, shouldn't we be doing something like the
following instead for each of the watchdogs?

+				faraday,use-extclk;
+				clock-names =3D "EXTCLK";

Andrew

> =C2=A0			};
> =C2=A0
> > > =C2=A0			wdt2: wdt@1e785020 {
> > -				compatible =3D "aspeed,ast2500-wdt";
> > +				compatible =3D "aspeed,ast2500-wdt", "faraday,ftwdt010";
> > =C2=A0				reg =3D <0x1e785020 0x20>;
> > =C2=A0				interrupts =3D <27>;
> > +				clocks =3D <&clk_apb>;
> > +				clock-names =3D "PCLK";
> > =C2=A0				status =3D "disabled";
> > =C2=A0			};
> =C2=A0
> > > =C2=A0			wdt3: wdt@1e785040 {
> > -				compatible =3D "aspeed,ast2500-wdt";
> > +				compatible =3D "aspeed,ast2500-wdt", "faraday,ftwdt010";
> > =C2=A0				reg =3D <0x1e785040 0x20>;
> > +				clocks =3D <&clk_apb>;
> > +				clock-names =3D "PCLK";
> > =C2=A0				status =3D "disabled";
> > =C2=A0			};
> =C2=A0
--=-mnz8tb/RuYobThjvM9DZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZ3ZR2AAoJEJ0dnzgO5LT5OhoQAJ36gu4L+smUO9k3EYgjxn00
SST//z/723r0OuiP9j8uci16bBYN1ESnGeRG4GsL73/HQtuQOuyoWgE7RJYQ0h/M
QlHgdJBotV9qo9mYWKZeZRDPrb7knyST2Ko+MuMGz5s3YkfhPuZ4NL1VD8fTBk+I
/V1NRHTN+F54f2Ej//TM8GVNkfW5wy3Xp9DUWNznn3GSdBAptuEfv7iC6YzTQ4FQ
b6oxoPNVIEiLUDBwBrQ/kDdfvc6XQViGl9duH7vfXKWwbm+boCEUzjzPAAUg7Ptc
00Vq8/oh4376FFoirGPXeE7S/mg2Uf84CRH5Ify2zs+M9laUnM2O8vPo28yrpcXV
+VKxtxhgYP6DW+HkPCh3lg39Kprpka/o3o5Cub3TVb7nylKR7p8UqbrjH5oTNiQs
Bh9ktGK12weI+sj2oKeZ/XUU8hAXzFcLTzuYjku+FrGCJeuZZ59g7AefLt4EHxTm
iAiDTINQe4YZn0s4BXQ3PpuMJg6XMriOUsK5J8eKOS3QPy8HvblDg/zlvmmEwqdb
xSO3ki4E7vdBTiszp/L1sPFH3RINverKZSqCXiRaxjnEKq4Dn2J/EZH2WOIMmqgH
torY8cmNtAm7KsbokTcWJQKL0pvIOteGOcDyrxaxroOBxPCSWE5eSfhURzYCzOwG
vqUZcOiNnI7PKWnQDAnP
=H35X
-----END PGP SIGNATURE-----

--=-mnz8tb/RuYobThjvM9DZ--
