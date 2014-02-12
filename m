Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:60907 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbaBLNfS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Feb 2014 08:35:18 -0500
Received: by mail-ee0-f44.google.com with SMTP id c13so4339751eek.17
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Feb 2014 05:35:17 -0800 (PST)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 02/11] watchdog: xilinx: Move control_status_reg to functions
Date: Wed, 12 Feb 2014 14:34:33 +0100
Message-Id: <edb974b379ad91a5736d95133ac5dc6de882f5a6.1392212059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1392212059.git.michal.simek@xilinx.com>
References: <cover.1392212059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1392212059.git.michal.simek@xilinx.com>
References: <cover.1392212059.git.michal.simek@xilinx.com>
Content-Type: multipart/signed;
    boundary="=_mimegpg-monstr-desktop-11848-1392212113-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.
The Internet standard for MIME PGP messages, RFC 2015, was published in 1996.
To open this message correctly you will need to install E-mail or Usenet
software that supports modern Internet standards.

--=_mimegpg-monstr-desktop-11848-1392212113-0001

control_status_reg is temp variables and should be
used locally by specific function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v3: None
Changes in v2: None

 drivers/watchdog/of_xilinx_wdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 8c2814e..aca9bab 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -52,13 +52,14 @@ struct xwdt_device {
 static struct xwdt_device xdev;

 static  u32 timeout;
-static  u32 control_status_reg;
 static  u8  no_timeout;

 static  DEFINE_SPINLOCK(spinlock);

 static int xilinx_wdt_start(struct watchdog_device *wdd)
 {
+	u32 control_status_reg;
+
 	spin_lock(&spinlock);

 	/* Clean previous status and enable the watchdog timer */
@@ -77,6 +78,8 @@ static int xilinx_wdt_start(struct watchdog_device *wdd)

 static int xilinx_wdt_stop(struct watchdog_device *wdd)
 {
+	u32 control_status_reg;
+
 	spin_lock(&spinlock);

 	control_status_reg = ioread32(xdev.base + XWT_TWCSR0_OFFSET);
@@ -94,6 +97,8 @@ static int xilinx_wdt_stop(struct watchdog_device *wdd)

 static int xilinx_wdt_keepalive(struct watchdog_device *wdd)
 {
+	u32 control_status_reg;
+
 	spin_lock(&spinlock);

 	control_status_reg = ioread32(xdev.base + XWT_TWCSR0_OFFSET);
--
1.8.2.3


--=_mimegpg-monstr-desktop-11848-1392212113-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAlL7eJEACgkQykllyylKDCGUGgCbBAR8wU8QAaet0R/IUKD63muE
E8YAn1RQddRt+T3FAY2JMCh9FHE8e0Dy
=G+MO
-----END PGP SIGNATURE-----

--=_mimegpg-monstr-desktop-11848-1392212113-0001--
