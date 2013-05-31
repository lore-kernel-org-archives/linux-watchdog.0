Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:54966 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab3EaF4r (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 May 2013 01:56:47 -0400
Received: by mail-ea0-f178.google.com with SMTP id q15so1145367ead.37
        for <linux-watchdog@vger.kernel.org>; Thu, 30 May 2013 22:56:45 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@xilinx.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 2/2] watchdog: xilinx: Setup the origin compatible string
Date: Fri, 31 May 2013 07:56:34 +0200
Message-Id: <88e5677451bf32bb31e99b7d2d5acd7d75bdba0e.1369979787.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1369979787.git.michal.simek@xilinx.com>
References: <cover.1369979787.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1369979787.git.michal.simek@xilinx.com>
References: <cover.1369979787.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-31320-1369979804-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-31320-1369979804-0001

Watchdog 1.01.a is also compatible with 1.00.a.
Add the origin version to compatible list.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v2:
- Extend compatible list with 1.00.a instead of replacing 1.01.a
  reported by Guenter Roeck <linux@roeck-us.net>

 drivers/watchdog/of_xilinx_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index d4a35ab..4dd281f 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -384,6 +384,7 @@ static int xwdt_remove(struct platform_device *dev)

 /* Match table for of_platform binding */
 static struct of_device_id xwdt_of_match[] = {
+	{ .compatible = "xlnx,xps-timebase-wdt-1.00.a", },
 	{ .compatible = "xlnx,xps-timebase-wdt-1.01.a", },
 	{},
 };
--
1.8.2.3


--=_mimegpg-monstr-desktop-31320-1369979804-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGoO5wACgkQykllyylKDCGVAACdEZf0FObMmShU/5hgrwbc3clf
9b0Anidskc+HBaZ/Ypm+t0mLkJbcsTJL
=4tUc
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-31320-1369979804-0001--
