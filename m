Return-path: <paulepanter@users.sourceforge.net>
Message-ID: <1488530782.2457.41.camel@users.sourceforge.net>
Subject: [Regression] Changes to i2c-piix4.c initialisation prevent loading
 of sp5100_tco watchdog driver on AMD SB800 chipset
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: Christian Fetzer <fetzer.ch@gmail.com>, Wolfram Sang
 <wsa@the-dreams.de>,  Jean Delvare <jdelvare@suse.com>
Cc: linux-i2c@vger.kernel.org, linux-watchdog@vger.kernel.org,
 853122@bugs.debian.org, Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck
 <linux@roeck-us.net>, Tim Small <tim@seoss.co.uk>, Nehal Shah
 <nehal-bakulchandra.shah@amd.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Thomas Brandon <tbrandonau@gmail.com>,
  Eddi De Pieri <eddi@depieri.net>, linux-kernel@vger.kernel.org
Date: Fri, 03 Mar 2017 09:46:22 +0100
In-Reply-To: <1485728348.3220.10.camel@googlemail.com>
References: <1485728348.3220.10.camel@googlemail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mmt13+zOfwcCCiWk4eSL"
Mime-Version: 1.0
List-ID: <linux-watchdog@vger.kernel.org>


--=-mmt13+zOfwcCCiWk4eSL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


Unfortunately, commit 2fee61d22e (i2c: piix4: Add support for
multiplexed main adapter in SB800) [1] caused a regression. Tim
reported that to the Linux Kernel Bugtracker as bug #170741 last
September [2], but it looks like the affected subsystems don=E2=80=99t use =
it.

So I just copy his report in here, and put all the people in CC
mentioned in the commit, the bug report, and in the subsystems
I2C/SMBUS CONTROLLER DRIVERS FOR PC and WATCHDOG DEVICE DRIVERS
mentioned in the file `MAINTAINERS`.

> On the AMD Turion N40L=C2=A0and other related SoCs, the i2c-piix4 driver
> now claims the 0xcd6 ioport, preventing the sp5100_tco watchdog
> driver from loading:
>=20
> piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, revision 0
> piix4_smbus 0000:00:14.0: Using register 0x2c for SMBus port selection
> piix4_smbus 0000:00:14.0: Auxiliary SMBus Host Controller at 0xb20
> sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver v0.05
> sp5100_tco: PCI Vendor ID: 0x1002, Device ID: 0x4385, Revision ID: 0x42
> sp5100_tco: I/O address 0x0cd6 already in use
>=20
>=20
> This breaks watchdog operation on existing systems on upgrade and new
> deployments unless the i2c-piix4 driver is blacklisted.
>=20
> See:
>=20
> drivers/watchdog/sp5100_tco.c
>=20
> tco_timer_enable(void)
>=20
> (SB800_IO_PM_INDEX_REG is defined in drivers/watchdog/sp5100_tco.h)
>=20
> This is the commit which prevents the watchdog driver from loading:
>=20
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=3D2fee61d22e606fc99ade9079fda15fdee83ec33e
>=20
> See also AMD docs
>=20
> 45483_sb800_bdg_pub_3.03
>=20
> Perhaps a fix is to switch both drivers from static to dynamic
> allocation of the IO ports in question, since the watchdog driver
> only accesses the port during initialisation (with backoff/retry
> maybe to avoid races?).

Is there somebody having the resources to implement the dynamic
allocation to solve this regression?


Thanks,

Paul


[1]=C2=A0https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D2fee61d22e606fc99ade9079fda15fdee83ec33e
[2] https://bugzilla.kernel.org/show_bug.cgi?id=3D170741
--=-mmt13+zOfwcCCiWk4eSL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWLktXgAKCRA9fVorbA4d
WJTMAJ40jPI3iFzRipsVE44CxmNK+1ZwEACfWTrG/DtJW6a0SbQZNPNkIxl6kIQ=
=kK2P
-----END PGP SIGNATURE-----

--=-mmt13+zOfwcCCiWk4eSL--
