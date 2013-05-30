Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32931 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab3E3M0T (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 May 2013 08:26:19 -0400
Received: by mail-wi0-f171.google.com with SMTP id hq7so4492356wib.16
        for <linux-watchdog@vger.kernel.org>; Thu, 30 May 2013 05:26:18 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@xilinx.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 3/3] watchdog: xilinx: Add WDIOC_SETTIMEOUT ioctl function
Date: Thu, 30 May 2013 14:26:04 +0200
Message-Id: <595eb49b34909318959fe6825c209a7d635ed849.1369916757.git.michal.simek@xilinx.com>
In-Reply-To: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com>
References: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com>
In-Reply-To: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com>
References: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-8734-1369916775-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-8734-1369916775-0001

Standard watchdog programs try to setup timeout
via ioctl and this functionality should be implemented.
Timeout value is hardcoded in the hardware but
based on Documentation/watchdog/watchdog-api.txt
can return the real timeout used in the same variable.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/watchdog/of_xilinx_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 79f358c..a3bbe72 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -253,6 +253,7 @@ static long xwdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		xwdt_keepalive();
 		return 0;

+	case WDIOC_SETTIMEOUT:
 	case WDIOC_GETTIMEOUT:
 		if (no_timeout)
 			return -ENOTTY;
--
1.8.2.3


--=_mimegpg-monstr-desktop-8734-1369916775-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGnRWcACgkQykllyylKDCG5kwCffS9dhsWmPK86EXJ9Ir2UEkyr
SRsAoJBmcNxo2ftS7BQl+8Uk0qtqO6AO
=Ij8C
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-8734-1369916775-0001--
