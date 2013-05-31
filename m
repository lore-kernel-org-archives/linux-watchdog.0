Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:64856 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823Ab3EaF4n (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 May 2013 01:56:43 -0400
Received: by mail-ee0-f52.google.com with SMTP id c13so67557eek.11
        for <linux-watchdog@vger.kernel.org>; Thu, 30 May 2013 22:56:42 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH v2 0/2] Xilinx watchdog changes
Date: Fri, 31 May 2013 07:56:32 +0200
Message-Id: <cover.1369979787.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-31295-1369979794-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-31295-1369979794-0001

The patchset fixes license header and add 1.00.a IP to compatible
list.

Thanks for your review,
Michal

Remove the 3rd patch from this series which incorrectly
tried to support set timeout feature.

Changes in v2:
- Extend compatible list with 1.00.a instead of replacing 1.01.a
  reported by Guenter Roeck <linux@roeck-us.net>

Michal Simek (2):
  watchdog: xilinx: Fix driver header
  watchdog: xilinx: Setup the origin compatible string

 drivers/watchdog/of_xilinx_wdt.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

--
1.8.2.3


--=_mimegpg-monstr-desktop-31295-1369979794-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGoO5IACgkQykllyylKDCFuDACgjLl3k6oFIncJ0S4QlwTxuUzH
20AAnindce++LfHwWTgCi00UcLMT67ZS
=r/Ew
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-31295-1369979794-0001--
