Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:44465 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3E3M0O (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 May 2013 08:26:14 -0400
Received: by mail-wi0-f180.google.com with SMTP id hn14so170553wib.13
        for <linux-watchdog@vger.kernel.org>; Thu, 30 May 2013 05:26:13 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org
Cc: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@xilinx.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/3] watchdog: xilinx: Fix driver header
Date: Thu, 30 May 2013 14:26:02 +0200
Message-Id: <b565740967bfa3b3fa867442634f524000c097f8.1369916757.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-8706-1369916764-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-8706-1369916764-0001

- Remove reference for IP version
- Fix header coding style
- Remove notes which are visible from the code
- Fix driver license according to header

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/watchdog/of_xilinx_wdt.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 2761ddb..d4a35ab 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -1,23 +1,13 @@
 /*
-*   of_xilinx_wdt.c  1.01  A Watchdog Device Driver for Xilinx xps_timebase_wdt
-*
-*   (C) Copyright 2011 (Alejandro Cabrera <aldaya@gmail.com>)
-*
-*       -----------------------
-*
-*   This program is free software; you can redistribute it and/or
-*   modify it under the terms of the GNU General Public License
-*   as published by the Free Software Foundation; either version
-*   2 of the License, or (at your option) any later version.
-*
-*       -----------------------
-*	30-May-2011 Alejandro Cabrera <aldaya@gmail.com>
-*		- If "xlnx,wdt-enable-once" wasn't found on device tree the
-*		  module will use CONFIG_WATCHDOG_NOWAYOUT
-*		- If the device tree parameters ("clock-frequency" and
-*		  "xlnx,wdt-interval") wasn't found the driver won't
-*		  know the wdt reset interval
-*/
+ * Watchdog Device Driver for Xilinx axi/xps_timebase_wdt
+ *
+ * (C) Copyright 2011 (Alejandro Cabrera <aldaya@gmail.com>)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

@@ -413,5 +403,5 @@ module_platform_driver(xwdt_driver);

 MODULE_AUTHOR("Alejandro Cabrera <aldaya@gmail.com>");
 MODULE_DESCRIPTION("Xilinx Watchdog driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
--
1.8.2.3


--=_mimegpg-monstr-desktop-8706-1369916764-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlGnRV0ACgkQykllyylKDCEJsACaAuVmUilKJwvkgDJ84poKAa/u
UdUAn0SQRas+3NpUnGvNff8RgcWQiCwY
=FmtY
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-8706-1369916764-0001--
