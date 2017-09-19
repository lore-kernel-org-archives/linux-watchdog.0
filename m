Return-Path: <andrew@aj.id.au>
Return-path: <andrew@aj.id.au>
Message-ID: <1505788097.4080.22.camel@aj.id.au>
Subject: Re: [PATCH 4/4] watchdog: aspeed: Move init to arch_initcall
From: Andrew Jeffery <andrew@aj.id.au>
To: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
Cc: wim@iguana.be, joel@jms.id.au, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
	ryan_chen@aspeedtech.com
Date: Tue, 19 Sep 2017 11:58:17 +0930
In-Reply-To: <b7524108-1927-95a5-e5d6-ade0a8b9ab47@roeck-us.net>
References: <20170918054905.16470-1-andrew@aj.id.au>
	 <20170918054905.16470-5-andrew@aj.id.au>
	 <b7524108-1927-95a5-e5d6-ade0a8b9ab47@roeck-us.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9nFddokobLpOtoUJGtV2"
Mime-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


--=-9nFddokobLpOtoUJGtV2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-09-18 at 06:32 -0700, Guenter Roeck wrote:
> On 09/17/2017 10:49 PM, Andrew Jeffery wrote:
> > Probing at device_initcall time lead to perverse cases where the
> > watchdog was probed after, say, I2C, which then leaves a potentially
> > running watchdog at the mercy of I2C device behaviour and bus
> > conditions.
> >=20
> > Load the watchdog driver early to ensure that the kernel is patting it
> > well before initialising peripherals.
> >=20
>=20
> But you are doing a bit more.=20

True.

> You are making it bool, and you are enabling it
> by default. Both isn't needed for the intended goal (arch_initcall is con=
verted
> to module_initcall if a driver is built as module).

Okay, my understanding on this small point was fuzzy and was something=20
I should have chased up. Thanks for the feedback.

>  Your change focuses on
> and optimizes the case where the watchdog is already running. That may no=
t
> always be the case, and there may be systems where the driver is not load=
ed
> on purpose.

Is this a general comment, or regarding a specific Aspeed BMC-based
system? Currently selecting ARCH_ASPEED will force select WATCHDOG and
ASPEED_WATCHDOG. Thus "default y if ARCH_ASPEED" doesn't actually
change the resulting configuration, but removes the need for the
explicit select in arch/arm/mach-aspeed/Kconfig. I don't know what's
better, but I felt that if we moved from tristate to boolean then
changing the default in the watchdog Kconfig was the right way to go.

The way to reboot the Aspeed SoC is to trip the watchdog. Perhaps
wanting to build without the driver isn't unreasonable, but it would
produce a system that you couldn't reboot. However, that's independent
of whether or not to build as a module so it can remain a tristate. I
think I'll just drop the Kconfig changes and add the exit handler. Sing
out if I should do anything different.

Cheers,

Andrew

>=20
> Guenter
>=20
> > > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> > =C2=A0 drivers/watchdog/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 6 =
++----
> > =C2=A0 drivers/watchdog/aspeed_wdt.c | 7 ++++++-
> > =C2=A0 2 files changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index a1b92ebe74b6..6103185983ed 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -741,8 +741,9 @@ config RENESAS_RZAWDT
> > > > =C2=A0=C2=A0	=C2=A0=C2=A0Renesas RZ/A SoCs. These watchdogs can be =
used to reset a system.
> > =C2=A0=C2=A0
> > =C2=A0 config ASPEED_WATCHDOG
> > > > -	tristate "Aspeed BMC watchdog support"
> > > > +	bool "Aspeed BMC watchdog support"
> > > > =C2=A0=C2=A0	depends on ARCH_ASPEED || COMPILE_TEST
> > > > +	default y if ARCH_ASPEED
> > > > =C2=A0=C2=A0	select WATCHDOG_CORE
> > > > =C2=A0=C2=A0	help
> > > > =C2=A0=C2=A0	=C2=A0=C2=A0Say Y here to include support for the watc=
hdog timer
> > @@ -750,9 +751,6 @@ config ASPEED_WATCHDOG
> > =C2=A0=C2=A0
> > > > =C2=A0=C2=A0	=C2=A0=C2=A0This driver is required to reboot the SoC.
> > =C2=A0=C2=A0
> > > > -	=C2=A0=C2=A0To compile this driver as a module, choose M here: th=
e
> > > > -	=C2=A0=C2=A0module will be called aspeed_wdt.
> > -
> > =C2=A0 config ZX2967_WATCHDOG
> > > > =C2=A0=C2=A0	tristate "ZTE zx2967 SoCs watchdog support"
> > > > =C2=A0=C2=A0	depends on ARCH_ZX
> > diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wd=
t.c
> > index 99bc6fbd8852..679c35abadc4 100644
> > --- a/drivers/watchdog/aspeed_wdt.c
> > +++ b/drivers/watchdog/aspeed_wdt.c
> > @@ -313,7 +313,12 @@ static struct platform_driver aspeed_watchdog_driv=
er =3D {
> > > > =C2=A0=C2=A0		.of_match_table =3D of_match_ptr(aspeed_wdt_of_table)=
,
> > > > =C2=A0=C2=A0	},
> > =C2=A0 };
> > -module_platform_driver(aspeed_watchdog_driver);
> > +
> > +static int __init aspeed_wdt_init(void)
> > +{
> > > > +	return platform_driver_register(&aspeed_watchdog_driver);
> > +}
> > +arch_initcall(aspeed_wdt_init);
> > =C2=A0=C2=A0
> > =C2=A0 MODULE_DESCRIPTION("Aspeed Watchdog Driver");
> > =C2=A0 MODULE_LICENSE("GPL");
> >=20
>=20
>=20
--=-9nFddokobLpOtoUJGtV2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJZwIDBAAoJEJ0dnzgO5LT5vmEP/iOkEt2K/NAsLXUzeqdY4VR2
M9EbqcfFRXEm/NzS7+7O/z/agdsY4uFSXvBu/4LXki/LDsTPbZwngyJgqfmyTLgf
IvPR1AHu+chItJCT8MYjzYN4Y8/MvsYpcOKYE34Xl/+HzPeQYduJGXW9k6RXS12G
SfIsMYbEaYTSf6G5p5OUco+gV6SfmOMuHGIKEsTjgN5TS1DFbY2cyiYLN5XkSmw9
CTDl/LlxFAYq/t7f2DEwWpimEgIYplASQRCmg7wKV2QiXAu2sEFbswZvP9jD21Ii
HZTn/nDCTDw3jk3fPhFgXly6+e4DA6IURSYilbUAv/xty4147Lxee8Dh80IJJ+6I
E/RauXJO21uvIYARCvSrxxi+6sVCf3R1xeiKgQsImriTeDHjjjaVF8YuUoibqtpA
CT678atftz72WG6X3DLclMhYkJcZbOJIeDGE3q/P/ksZrtre2VponpjfHrBJl2rL
+7dAE6rEo55GQBBeGPGpuutkcWCBtp08IvZJv3lumaLVqPa2L80PW0hVpniCwN2/
eInHDqVdPihUJxIguxoWwgO2hrqqY2ixfnrHp22Ztk4XfdrVSiE5ye5NHUe/uuHA
TRc8P3ttjnHQ5XTXP3C7iiE+m1RA6cui0+rJRWuZLHbHmowQMm1PDQZ2/1MWRnMD
ADW4tEMMygqre1+2VR54
=D+/v
-----END PGP SIGNATURE-----

--=-9nFddokobLpOtoUJGtV2--
