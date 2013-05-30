Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:47875 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754944Ab3E3OEJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 May 2013 10:04:09 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so275136wib.2
        for <linux-watchdog@vger.kernel.org>; Thu, 30 May 2013 07:04:08 -0700 (PDT)
Message-ID: <51A75C56.3070704@monstr.eu>
Date: Thu, 30 May 2013 16:04:06 +0200
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: Michal Simek <michal.simek@xilinx.com>,
	linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: xilinx: Setup the origin compatible string
References: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com> <eef4939944768b2d8cbed2bcb4cf75954b86fc27.1369916757.git.michal.simek@xilinx.com> <20130530140041.GA28232@roeck-us.net>
In-Reply-To: <20130530140041.GA28232@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2ORRIGTWBHLEINMNBDLUK"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2ORRIGTWBHLEINMNBDLUK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/30/2013 04:00 PM, Guenter Roeck wrote:
> On Thu, May 30, 2013 at 02:26:03PM +0200, Michal Simek wrote:
>> Watchdog 1.01.a is also compatible with 1.00.a.
>> Setup the origin version to compatible list.
>> If you want to use newer watchdog version, please
>> extend your compatible list.
>>
>> For example:
>> compatible =3D "xlnx,xps-timebase-wdt-1.02.a", "xlnx,xps-timebase-wdt-=
1.00.a";
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>  drivers/watchdog/of_xilinx_wdt.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xi=
linx_wdt.c
>> index d4a35ab..79f358c 100644
>> --- a/drivers/watchdog/of_xilinx_wdt.c
>> +++ b/drivers/watchdog/of_xilinx_wdt.c
>> @@ -384,7 +384,7 @@ static int xwdt_remove(struct platform_device *dev=
)
>>
>>  /* Match table for of_platform binding */
>>  static struct of_device_id xwdt_of_match[] =3D {
>> -	{ .compatible =3D "xlnx,xps-timebase-wdt-1.01.a", },
>> +	{ .compatible =3D "xlnx,xps-timebase-wdt-1.00.a", },
>=20
> Is this really a good idea ? It means every existing device tree bindin=
g which
> specifies 1.01a will now fail. If the code is compatible to 1.00a, I th=
ink it
> would make more sense to add that to the driver as additional entry ins=
tead of
> deleting the existing entry for 1.01a.

The most of users/I believe all of them are using device-tree generator
which generate DTS directly from Xilinx design tools because it is almost=

impossible to write DTS for any xilinx fpga plaform and
1.00.a is setup as backward compatible property.
But if you think that it is worth to keep there 1.01.a I have no problem
with that I will keep there 1.01.a and add 1.00.a.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



------enig2ORRIGTWBHLEINMNBDLUK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGnXFYACgkQykllyylKDCH+fgCdE5WiRVzzYXOLikF5cDQqfpdu
KW8An34MARbnqYUboW/6YIUUjuY+Gt8O
=xb4H
-----END PGP SIGNATURE-----

------enig2ORRIGTWBHLEINMNBDLUK--
