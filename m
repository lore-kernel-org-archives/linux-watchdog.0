Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38348 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750835AbaBJHGG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Feb 2014 02:06:06 -0500
Received: by mail-ee0-f46.google.com with SMTP id c13so2698221eek.19
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Feb 2014 23:06:04 -0800 (PST)
Message-ID: <52F87A59.9040600@monstr.eu>
Date: Mon, 10 Feb 2014 08:06:01 +0100
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 10/10] watchdog: xilinx: Enable this driver for Zynq
References: <ed4cb31c9a549343e6b492cf62fc962d39034bd0.1391177880.git.michal.simek@xilinx.com> <f7bdfada576e93eaab8f6dc2ecd881da8f43911c.1391177880.git.michal.simek@xilinx.com> <52F82296.8010804@roeck-us.net>
In-Reply-To: <52F82296.8010804@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GoUWt0HPGtNPS4WPjlX9tM2vAQKSLseXj"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GoUWt0HPGtNPS4WPjlX9tM2vAQKSLseXj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/10/2014 01:51 AM, Guenter Roeck wrote:
> On 01/31/2014 06:18 AM, Michal Simek wrote:
>> Enable this driver for Zynq.
>> Move it to architecture independent Kconfig part.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Build tested by zero day testing system.
>> ---
>=20
> Hi Michal,
>=20
> I tried myself, and I don't see any build failures on any platform.
> So let's assume this works as-is.
>=20
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>=20

Thanks for your review. I have fixed comments from Rob and
also add one more patch which was suggested by Rob.
I will wait for your reactions for 1/10 and then will send
v2.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--GoUWt0HPGtNPS4WPjlX9tM2vAQKSLseXj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlL4elkACgkQykllyylKDCFTxACfXT5/wde7rxM6jwH5FzD62os9
jGgAn0+I6TrYwT7ctdXV9TOAzp/e+9m8
=/W6s
-----END PGP SIGNATURE-----

--GoUWt0HPGtNPS4WPjlX9tM2vAQKSLseXj--
