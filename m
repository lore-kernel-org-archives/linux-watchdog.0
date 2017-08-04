Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35339 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbdHDNwt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Aug 2017 09:52:49 -0400
Received: by mail-wr0-f193.google.com with SMTP id c24so3048165wra.2
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Aug 2017 06:52:48 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 1/2] watchdog: cadence_wdt: Enable access to module
 parameters
To: Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
 <c25ea869-55fe-dde9-4004-cb49bb5553c2@roeck-us.net>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <54da75b5-aff9-84e8-1e3e-f311b358f77a@monstr.eu>
Date: Fri, 4 Aug 2017 15:52:46 +0200
MIME-Version: 1.0
In-Reply-To: <c25ea869-55fe-dde9-4004-cb49bb5553c2@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="54ejLHervruK8DqiLj8HvATkLN9Lpx3om"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--54ejLHervruK8DqiLj8HvATkLN9Lpx3om
Content-Type: multipart/mixed; boundary="bR6s38jc9LO6GXnvhrVod1cpwkukBAR57";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Guenter Roeck <linux@roeck-us.net>, Michal Simek
 <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Message-ID: <54da75b5-aff9-84e8-1e3e-f311b358f77a@monstr.eu>
Subject: Re: [PATCH 1/2] watchdog: cadence_wdt: Enable access to module
 parameters
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
 <c25ea869-55fe-dde9-4004-cb49bb5553c2@roeck-us.net>
In-Reply-To: <c25ea869-55fe-dde9-4004-cb49bb5553c2@roeck-us.net>

--bR6s38jc9LO6GXnvhrVod1cpwkukBAR57
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4.8.2017 15:45, Guenter Roeck wrote:
> On 08/04/2017 12:39 AM, Michal Simek wrote:
>> Give read access to module parameters to all and write access to root.=

>> This change also improves driver error path testing.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Please let me know what you think - I can use macros from stat.h if
>> required
>>
>=20
> Seems to be quite pointless and misleading, since the values are only r=
ead
> at probe time. Am I missing something ?

You can unbind device and bind that device again. If you want to use it
or test with different parameters you need to have an access to these
module parameters.
For testing purpose if you setup for example timeout to 1000s which is
more than CDNS_WDT_MAX_TIMEOUT probe will fail and you have better
driver coverage.

I see that a lot of watchdog drivers are using 0 there - means no sysfs
access to these modules parameters. Some of them are using 0644 or 0444
that's why I want to know if there is any for example security reason to
disable access to these parameters.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--bR6s38jc9LO6GXnvhrVod1cpwkukBAR57--

--54ejLHervruK8DqiLj8HvATkLN9Lpx3om
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlmEfC4ACgkQykllyylKDCHasgCffdKwBYs+UEblkwvocSLeyVUO
6aQAn0X0qltdKNvwijyAN8YEAxjaE3ne
=GFLi
-----END PGP SIGNATURE-----

--54ejLHervruK8DqiLj8HvATkLN9Lpx3om--
