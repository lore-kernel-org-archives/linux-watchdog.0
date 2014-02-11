Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:48515 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbaBKG4J (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:56:09 -0500
Received: by mail-ee0-f41.google.com with SMTP id e51so2885405eek.14
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Feb 2014 22:56:08 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/11] watchdog: xilinx: Move no_timeout to probe function
Date: Tue, 11 Feb 2014 07:55:47 +0100
Message-Id: <e1b370a86bbc9b389cfccfccce94014ff0d03788.1392101734.git.michal.simek@xilinx.com>
In-Reply-To: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
In-Reply-To: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
References: <f298edd222c57b0ce1ebad3ae50c3f715406c631.1392101734.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-9513-1392101765-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-9513-1392101765-0001

no_timeout should be local variable because it is used
only in probe function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v2: None

 drivers/watchdog/of_xilinx_wdt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 7f371ed..1f7ad91 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -52,7 +52,6 @@ struct xwdt_device {
 static struct xwdt_device xdev;

 static  u32 timeout;
-static  u8  no_timeout;

 static  DEFINE_SPINLOCK(spinlock);

@@ -160,8 +159,7 @@ static int xwdt_probe(struct platform_device *pdev)
 	u32 *tmptr;
 	u32 *pfreq;
 	struct resource *res;
-
-	no_timeout = 0;
+	bool no_timeout = false;

 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	xdev.base = devm_ioremap_resource(&pdev->dev, res);
@@ -173,14 +171,14 @@ static int xwdt_probe(struct platform_device *pdev)

 	if (pfreq == NULL) {
 		pr_warn("The watchdog clock frequency cannot be obtained!\n");
-		no_timeout = 1;
+		no_timeout = true;
 	}

 	tmptr = (u32 *)of_get_property(pdev->dev.of_node,
 					"xlnx,wdt-interval", NULL);
 	if (tmptr == NULL) {
 		pr_warn("Parameter \"xlnx,wdt-interval\" not found in device tree!\n");
-		no_timeout = 1;
+		no_timeout = true;
 	} else {
 		xdev.wdt_interval = *tmptr;
 	}
--
1.8.2.3


--=_mimegpg-monstr-desktop-9513-1392101765-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlL5yYUACgkQykllyylKDCEHPACfRkQMkIHQJcUKsKp5wAgF66VG
KKIAnRlDbsz5wyyz0boNYib1BiYHWauy
=IRp+
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-9513-1392101765-0001--
