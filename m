Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38745 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdHDN4L (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Aug 2017 09:56:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id g32so3056685wrd.5
        for <linux-watchdog@vger.kernel.org>; Fri, 04 Aug 2017 06:56:11 -0700 (PDT)
Reply-To: monstr@monstr.eu
Subject: Re: [PATCH 2/2] watchdog: cadence_wdt: Show information when driver
 is probed
To: Guenter Roeck <linux@roeck-us.net>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
 <32d58c86a3afbdfc25fe26a9e51df917ce5da4ac.1501832354.git.michal.simek@xilinx.com>
 <6ad8cad8-e1a4-57ec-d25f-dc6b0935a6fb@roeck-us.net>
From: Michal Simek <monstr@monstr.eu>
Message-ID: <e83dcbe3-a65f-d4d0-2922-5929eca45ea9@monstr.eu>
Date: Fri, 4 Aug 2017 15:56:09 +0200
MIME-Version: 1.0
In-Reply-To: <6ad8cad8-e1a4-57ec-d25f-dc6b0935a6fb@roeck-us.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2rAATc5OPTTmSg8vXd517HaoqUCXaNoWe"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2rAATc5OPTTmSg8vXd517HaoqUCXaNoWe
Content-Type: multipart/mixed; boundary="922Vo4XBeJOOEqgu6p0d5PJW8VXqhf80T";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Guenter Roeck <linux@roeck-us.net>, Michal Simek
 <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Message-ID: <e83dcbe3-a65f-d4d0-2922-5929eca45ea9@monstr.eu>
Subject: Re: [PATCH 2/2] watchdog: cadence_wdt: Show information when driver
 is probed
References: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
 <32d58c86a3afbdfc25fe26a9e51df917ce5da4ac.1501832354.git.michal.simek@xilinx.com>
 <6ad8cad8-e1a4-57ec-d25f-dc6b0935a6fb@roeck-us.net>
In-Reply-To: <6ad8cad8-e1a4-57ec-d25f-dc6b0935a6fb@roeck-us.net>

--922Vo4XBeJOOEqgu6p0d5PJW8VXqhf80T
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4.8.2017 15:47, Guenter Roeck wrote:
> On 08/04/2017 12:39 AM, Michal Simek wrote:
>> Showing message that driver is loaded is common across drivers.
>=20
> Across watchdog drivers, which I am always half-annoyed about.
> Is this really valuable ?

I don't think that this is debug message. We don't have hundreds of
drivers that log explodes and for systems, which I don't know, I do
normally check dmesg logs and I would expect this message to be there to
know that watchdog is enabled.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--922Vo4XBeJOOEqgu6p0d5PJW8VXqhf80T--

--2rAATc5OPTTmSg8vXd517HaoqUCXaNoWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlmEfPkACgkQykllyylKDCHzqACePmggna032yTniz7ZwNjfRYm0
H3kAnjM6vfyaKKeMNMxErnIJrM3wdFJA
=c2cd
-----END PGP SIGNATURE-----

--2rAATc5OPTTmSg8vXd517HaoqUCXaNoWe--
