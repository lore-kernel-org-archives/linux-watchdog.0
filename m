Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37799 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaBLINc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Feb 2014 03:13:32 -0500
Received: by mail-wi0-f177.google.com with SMTP id e4so6350696wiv.10
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Feb 2014 00:13:31 -0800 (PST)
Message-ID: <52FB2D23.7090200@monstr.eu>
Date: Wed, 12 Feb 2014 09:13:23 +0100
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 07/11] watchdog: xilinx: Use of_property_read_u32
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com> <7aa6e41032ebad0ffb2e1df20beb4f00e38d29e2.1392101734.git.michal.simek@xilinx.com> <20140211202038.GC11798@roeck-us.net>
In-Reply-To: <20140211202038.GC11798@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FC9rTOcBtukJF2R0DJH4SUcsiQpC7Fssh"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FC9rTOcBtukJF2R0DJH4SUcsiQpC7Fssh
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/11/2014 09:20 PM, Guenter Roeck wrote:
> On Tue, Feb 11, 2014 at 07:55:50AM +0100, Michal Simek wrote:
>> Use of_property_read_u32 functions to clean probe function.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
> [ ... ]
>=20
>> +
>> +	if (enable_once)
>>  		watchdog_set_nowayout(xilinx_wdt_wdd, true);
>> -	}
>=20
> 	watchdog_set_nowayout(xilinx_wdt_wdd, enable_once);
>=20
> would probably do as well (the function checks the flag as well).
>=20
> Nitpick, so
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

I will change it and send v3.

Thanks,
Michal



--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--FC9rTOcBtukJF2R0DJH4SUcsiQpC7Fssh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlL7LSQACgkQykllyylKDCHdtQCeNe4fMKfE2zFqqsifu+IKjyI6
dS4An3VrBPlzGIJc7Wa7nUfehqGGKjRa
=sh52
-----END PGP SIGNATURE-----

--FC9rTOcBtukJF2R0DJH4SUcsiQpC7Fssh--
