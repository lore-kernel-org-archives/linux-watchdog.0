Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:39756 "EHLO mail.gw90.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750992AbdDCGgR (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 3 Apr 2017 02:36:17 -0400
Message-ID: <1491201299.2321.42.camel@users.sourceforge.net>
Subject: Re: [Regression] Changes to i2c-piix4.c initialisation prevent
 loading of sp5100_tco watchdog driver on AMD SB800 chipset
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: =?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?= <zboszor@pr.hu>,
        Guenter Roeck <linux@roeck-us.net>
Cc: Wolfram Sang <wsa@the-dreams.de>,
        Christian Fetzer <fetzer.ch@gmail.com>,
        Jean Delvare <jdelvare@suse.com>, linux-i2c@vger.kernel.org,
        linux-watchdog@vger.kernel.org, 853122@bugs.debian.org,
        Wim Van Sebroeck <wim@iguana.be>,
        Tim Small <tim@seoss.co.uk>,
        Nehal Shah <nehal-bakulchandra.shah@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Brandon <tbrandonau@gmail.com>,
        Eddi De Pieri <eddi@depieri.net>,
        linux-kernel@vger.kernel.org
Date: Mon, 03 Apr 2017 08:34:59 +0200
In-Reply-To: <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
References: <1485728348.3220.10.camel@googlemail.com>
         <1488530782.2457.41.camel@users.sourceforge.net>
         <20170303101702.GA1669@katana>
         <1490944639.2653.182.camel@users.sourceforge.net>
         <585a27fb-be15-df9f-00a9-bd4c3a654142@roeck-us.net>
         <d1152062-77c5-f1b7-6be9-d24ee221ada9@pr.hu>
         <20170331150524.GA31555@roeck-us.net>
         <efce69fc-3899-43f4-c8ee-12b78a571e5a@pr.hu>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-65UZwX1dGrqwEkOLVk09"
Mime-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--=-65UZwX1dGrqwEkOLVk09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Zolt=C3=A1n,


Am Samstag, den 01.04.2017, 12:13 +0200 schrieb Boszormenyi Zoltan:

[=E2=80=A6]

> and=C2=A0have split the patch into three pieces now (USB quirks, i2c-piix=
4=20
> and sp5100_tco) and they were sent to the relevant mailing lists.

Could you please add me to the receiver list of these patches, so that
I can test them? Maybe also Christian (the commit author introducing
the regression), Tim (bug reporter), and Nehal from AMD?

If you uploaded them to the Kernel.org Bugtracker, that=E2=80=99d also work=
 for
me.


Thanks,

Paul
--=-65UZwX1dGrqwEkOLVk09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWOHtFQAKCRA9fVorbA4d
WOb+AJ9T1znwYSdGilYWI3hXU+uLQUdoOACcDog6LbaDLWGNZkV2tAhnhXkNuEw=
=Q2Bn
-----END PGP SIGNATURE-----

--=-65UZwX1dGrqwEkOLVk09--

