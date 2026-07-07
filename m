Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3492442CAEF
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 15:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783439158; cv=none; b=tvKJQxbH/QV7VPnhLr0+KUN1cPOnzl/SvEhWZlhIRgzIuTwxfwqqeGurp4rUiqhqa6XodeiZUEgRMMvd6UlG+WiV5I3mxeOHevyrB8XRMmnKSsZzslJ7UmLkHakBS5tIx5CAwgMSM+8zeegocvIsNnguGUIwsISsxtdg5tAR5aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783439158; c=relaxed/simple;
	bh=1/TyDildY6wNqrrckSsammoN0GSTrbgWqPKkwhjsnUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXNzWpw6Ltfy4PCoCLIbqyq8zIfvZwsYy+iufDsxsj51Hd048lojJxuY7TRqA0feXvMLfUCPz+daChLE8Yor+ZCSenyqtMf9HB6VTTo4B6AB5zGDCD07EAETxf+XVlHx404zlZ56tkarniiw/MXf1WtoxMISCXFzK6wnS63D5M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wMeBw8fW; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wMeBw8fW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BB25BC8F1F0
	for <linux-watchdog@vger.kernel.org>; Tue,  7 Jul 2026 15:46:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3513760333;
	Tue,  7 Jul 2026 15:45:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 44D7711BC2864;
	Tue,  7 Jul 2026 17:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783439148; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+A7OQHG4PqWuSWPHzN5kY8gCHVNEi3odo5W8vLoOoj0=;
	b=wMeBw8fW5FmSMjCYptILlfkMsLk9QI5g6McNs1mOJZqAXtEQThDRuiFjTC1mgHenu25deE
	wcO6LZMZCfawPpi4rjXPmvgqRPpyPXXMoIgickneGl7dYkBO7xw15Itq2usiBFirjGOaZS
	COdYUxMTVMC+mKxDh7b75FRPGy7xlRHIC0uyoqPY02Wcndn5+t2H5bwSiCvGG1rjsOMJsC
	a1QKLFK5xfOiJqlH4hZ4CoohllLCnhiBLMYARRkfQOuKxzaO5Hx5Asb234PkZLaKpBi1Tc
	eWw9rXzVqLcm85sORlMLnIXQgrTGHLYhHv06+OAfArjnc3ILoTS8A4Af8EvvBQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 07 Jul 2026 17:45:01 +0200
Subject: [PATCH v4 1/3] watchdog: w83627hf_wdt: Correctly identify Nuvoton
 NCT6126 chip
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-w83627hf_wdt-nct6126d-v4-1-829e5f63d548@bootlin.com>
References: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
In-Reply-To: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783439146; l=2404;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=1/TyDildY6wNqrrckSsammoN0GSTrbgWqPKkwhjsnUs=;
 b=Z2HQEKSLeouQGNOZ9RlyxMKwD1KjlsYvWUd6XkWmg0s+h9WqZDkcrMCsY24E3Xiahp0H4HS3w
 SS8Ps/UrhpFDBLdWa7/HSXFljaxeRY9+kBQPu0r275cVVgHep86GQgW
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Currently, the NCT6126 is probed as a NCT6116 because the NCT6126 shares
the same high-byte chip ID as the NCT6116.

Read the low byte of the chip ID as well to distinguish between the two
devices and identify the NCT6126 correctly.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index bc33b63c5a5d..a6dfa9d01702 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -49,7 +49,7 @@ static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
 	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
-	     nct6795, nct6796, nct6102, nct6116 };
+	     nct6795, nct6796, nct6102, nct6116, nct6126 };
 
 static int timeout;			/* in seconds */
 module_param(timeout, int, 0);
@@ -94,7 +94,9 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define NCT6775_ID		0xb4
 #define NCT6776_ID		0xc3
 #define NCT6102_ID		0xc4
-#define NCT6116_ID		0xd2
+#define NCT6116_ID		0xd2	/* also NCT6126D */
+#define NCT6126_VER_A_LOW_ID	0x83	/* ... version A */
+#define NCT6126_VER_B_LOW_ID	0x84	/* ... version B */
 #define NCT6779_ID		0xc5
 #define NCT6791_ID		0xc8
 #define NCT6792_ID		0xc9
@@ -217,6 +219,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	case nct6796:
 	case nct6102:
 	case nct6116:
+	case nct6126:
 		/*
 		 * These chips have a fixed WDTO# output pin (W83627UHG),
 		 * or support more than one WDTO# output pin.
@@ -428,7 +431,12 @@ static int wdt_find(int addr)
 		cr_wdt_csr = NCT6102D_WDT_CSR;
 		break;
 	case NCT6116_ID:
-		ret = nct6116;
+		val = superio_inb(0x21);
+		if (val == NCT6126_VER_A_LOW_ID || val == NCT6126_VER_B_LOW_ID)
+			ret = nct6126;
+		else
+			ret = nct6116;
+
 		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
 		cr_wdt_control = NCT6102D_WDT_CONTROL;
 		cr_wdt_csr = NCT6102D_WDT_CSR;
@@ -499,6 +507,7 @@ static int __init wdt_init(void)
 		"NCT6796",
 		"NCT6102",
 		"NCT6116",
+		"NCT6126"
 	};
 
 	/* Apply system-specific quirks */

-- 
2.55.0

