Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44403 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S969013AbdDSSnZ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Apr 2017 14:43:25 -0400
Date: Wed, 19 Apr 2017 20:43:22 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Zoltan Boszormenyi <zboszor@pr.hu>
Cc: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Tim Small <tim@seoss.co.uk>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3 v2] i2c: i2c-piix4: Use the common mutex
Message-ID: <20170419184322.nefp5hms4rhhqjt5@ninjato>
References: <20170401110223.12056-1-zboszor@pr.hu>
 <20170403075133.12343-1-zboszor@pr.hu>
 <20170403075133.12343-3-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aw4rpnvhfhxpacml"
Content-Disposition: inline
In-Reply-To: <20170403075133.12343-3-zboszor@pr.hu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--aw4rpnvhfhxpacml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2017 at 09:51:32AM +0200, Zoltan Boszormenyi wrote:
> Use the common mutex from driver/usb/host/pci-quirks.c in the
> i2c-piix4 driver to synchronize access to the I/O port pair
> 0xcd6 / 0xcd7.
>=20
> At the same time, remove the request_region() call to reserve
> these I/O ports, so the sp5100_tco watchdog driver can also
> load. The mutex is enough to protect the I/O port accesses.
> This is an old regression in Linux 4.4-rc4, caused by:
>=20
> v2: Explicit extern reference for sb800_mutex
>=20
> commit 2fee61d22e606fc99ade9079fda15fdee83ec33e
> Author: Christian Fetzer <fetzer.ch@gmail.com>
> Date:   Thu Nov 19 20:13:48 2015 +0100
>=20
>     i2c: piix4: Add support for multiplexed main adapter in SB800
>=20
> Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>

Given the global mutex approach is accepted, the actual changes here
look okay to me. I'd really like a tag from Jean here, still. He is the
expert for this hardware which I barely know.


--aw4rpnvhfhxpacml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlj3r8YACgkQFA3kzBSg
KbYbXg//b5c1AeWxZ9kISS1x2Ao/PTSdMV03+dBDfxTzDFmbI5aRI2HHHxlSFFne
YmWAMX8/UrUaxctAWVTLNZbxsvMsHl+uqP2yLz/Zjz82uPZZYV1y4BUijreR7c91
E8Ha6qXXIZwz6UAC4tMgvNqUgJ0RmHUWVo2iGvSv1zYNrgFnfYpHtRuQuSlm20R/
9fY7J2eA5iEXEIEs/FiZm+rAavAP79iHH6s6QixnvpQ/moStZNO8S4uDQV1DTra0
5FsVd77seicAp0N60lnZskNht1imPFvv0qOUC7dWlRqF4qMI5t/AoieoQq1kGWFG
tT07hR29xjMtpQa8tGX0MwS5r9ETxaNbE9mTRdGk9x3Csj8Di7PrEPbgqeO62WSs
jNwFNBdID8l3BV71DnqnUAiaik+TRjC6zKLjOXLSfmF1cBJ+mMIdpM9sB6i59bZL
jjKLEqGdqeRGuapXl+UY6sdoEOBtctVXtJ4qWADH8J9+D5CGILH09W8z67i3+d8D
jRCXkJyM6NoIXNu9oxfo/e2H8dBVD6qbVNKhgXdpsDpdEvxIgoq9U/MKCYqwPSY3
cm8trRVTX+AuCTW7lWtNWkbe0VYQnxl2KvR6to74Nd353uaf1GlHHDM8g7aN6mMt
q3xwMLl+/pH7iB2ihJwVbzX/KIb3It1/80zJoGVA5F4pzio4CVw=
=anpN
-----END PGP SIGNATURE-----

--aw4rpnvhfhxpacml--
