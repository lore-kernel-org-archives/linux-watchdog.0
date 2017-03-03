Return-path: <wsa-dev@sang-engineering.com>
Date: Fri, 3 Mar 2017 11:17:02 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: Christian Fetzer <fetzer.ch@gmail.com>,
	Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, 853122@bugs.debian.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, Tim Small <tim@seoss.co.uk>,
	Nehal Shah <nehal-bakulchandra.shah@amd.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Brandon <tbrandonau@gmail.com>,
	Eddi De Pieri <eddi@depieri.net>, linux-kernel@vger.kernel.org
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
Message-ID: <20170303101702.GA1669@katana>
References: <1485728348.3220.10.camel@googlemail.com>
 <1488530782.2457.41.camel@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <1488530782.2457.41.camel@users.sourceforge.net>
List-ID: <linux-watchdog@vger.kernel.org>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Unfortunately, commit 2fee61d22e (i2c: piix4: Add support for
> multiplexed main adapter in SB800) [1] caused a regression. Tim
> reported that to the Linux Kernel Bugtracker as bug #170741 last
> September [2], but it looks like the affected subsystems don=E2=80=99t us=
e it.

Jean Delvare pointed out this issue amongst others[1] last year already.
Let me quote:

=3D=3D=3D

5* The I/O ports used for SMBus configuration and port switching are
also needed by a watchdog driver, sp5100_tco. Both drivers request the
region, so the first one wins, and the other driver can't be loaded.
sp5100_tco was there first, so the changes done to the i2c-piix4 driver
recently will cause a regression for some users by preventing them
=66rom using the sp5100_tco and i2c-piix4 drivers at the same time. In
the long run I guess we will need a helper module to handle this shared
resource. Unless IORESOURCE_MUXED can be used for that. Either way,
that's more work than I can put into this before kernel v4.5 is
released. For the time being, I think we should simply make it
non-fatal if the I/O ports can't be requested, and continue without
multiplexing (as before.)

=3D=3D=3D

Seems nobody had the resources, so far. I don't have the HW and not much
experience with non-embedded platforms. I wonder, though, if we really
need to convert the drivers to MFD ones, or if we could use the simpler
MFD_SYSCON mechanism which helps in exactly such cases for embedded
platforms. But I am really lacking details here and am afraid this is
probably all the input I can give currently.

Regards,

   Wolfram

[1] http://www.spinics.net/lists/linux-i2c/msg23437.html


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYuUKeAAoJEBQN5MwUoCm2Or4P/20b2b3/GqmB3oR96CELtrGG
6HLRlYxaF3T/TBDcjevDyD+q20FBWynWl32t+4ZDAwdgtsWj9MyT0G+OzgxwpNCS
/OUWHyYJX1q9wfdlKnRDMA2+qvZaPhujuPLC+/Ny3WiuHA5YhFBY9PAJcUwTJUgP
eAw/zP4oXU31wiLszgxVjIoXEMh7IhvJ+5XvI3NIFjwH8OuUsgWDikvEc43v4d7/
DR+Yy7DPVOXnjlG0oMOAkUJbXzww+rKBbRhay7BfS2oQGt/4tp3LpBdJYN1o2jN9
Ba+kt/Kai+yYXQ3IB9knj+xuLgPoS1a0FnDVSdyGok/KXvjPuvycAxOsRvevNgGT
lnk9pwzURd0fhWsuT7haC07iPl+NUh2dxbuAkK7NwVI7l4TB/7dymaRI2AORjS9J
CH/Fx1nMzUVsvfHcecpgdfWzLH8rs6f7ZHbDpP0AMLsCsJZXmQA934STHBBxhdhr
8a1ep+GdsPF83g8KvNRG4q00rBTAHBDfZTrBLp/+xYiSmqrCtjYrsU7JlyK2Tgon
nIWrp2XeF7gozhKKtL2N9PfLl3cmaXCqwTgzG9iyi4Bks6OruB0RQGDmULBPDN7I
DdkIc0WN752T3WiZdkbqu7Q9oBQNV35SHOfSaz4g257TRLYM46vG8w06Y0+HzOfz
cnBfLqPA8OYVA1Mvhh16
=madV
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
