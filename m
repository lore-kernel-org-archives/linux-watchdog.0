Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B63A7595;
	Mon,  6 Jul 2026 10:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333786; cv=none; b=ovxZPppyD7UrKuI9dGPYlIW150g9JNOyuswt7aVwbysAaY0b994dBevKbVhoxZkkKiBVHL0oNmLzkz8o9fPzXtJVA1iAwLOEqGCtMU60p3iVPDjKAVwNjWyjVKWMgVQr1aSVfiyfHYOgWZw/MwfkFZbDTb2RucEaQHnDpEUlnLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333786; c=relaxed/simple;
	bh=erLw3t58wJf/yV5MjzbhY79iMMMfP3hUrCplJVFjUEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHcLWMvYqYNhHsKf+A1V3bcCuf81DGak8O2DEjhZ+9smZN3Fo9zr8zJXZCFdFZ7dYN8RDUkhnbo6jjG/ojEWnJca52BXlLrVT3shheedSvDHABfMjunyefUhQL20lQ5kL7gUUTJpeu0bx2kKtphiOYLWzvs60bq3Pj+Ro4soYKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nJybf179; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nJybf179"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6D6B61A0E8F;
	Mon,  6 Jul 2026 10:29:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43C1C601A2;
	Mon,  6 Jul 2026 10:29:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5226A11BBA051;
	Mon,  6 Jul 2026 12:29:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783333781; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qSpCdXG1kT1yBeim33c3HhUDLzV5UUe9+AvDMsxGqqM=;
	b=nJybf179VQUmY4y4TwECG3tLrWDKAemFJebSCFXHPs+ERA6CdHZjkSOBAMI99Ww6Jc8EUA
	PqYwPam4ZwdLu1HGTFpJnMUCwMIgwqoW/8wjfen/6BZkYBvuODnssP0y49ZkaxqvM8amWI
	LV7jo3PDsHmQjN5/Vy+eL0BacPllyHu10L3j3oXQpQarf94Ska2N9TNxYCI0JNKgwm4rD0
	WdI19m+KRHQUysTIdthuVtLpJofNM6GOLZWVaaLQ7iIWGhocEsWPeIvzZjT/KTq65E3gpw
	TdJsec8hebnNvr6I5cBDKIPjf3MCBcDRr/iJ39+WC7kYXhVPKLD1qv52nplu3w==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 06 Jul 2026 12:29:36 +0200
Subject: [PATCH v3 1/2] watchdog: w83627hf_wdt: Add support for Nuvoton
 NCT6126
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-w83627hf_wdt-nct6126d-v3-1-fa5ad8d486bc@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783333779; l=2579;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=erLw3t58wJf/yV5MjzbhY79iMMMfP3hUrCplJVFjUEw=;
 b=6m0SIC5I+wyd7Tri7YqLKLShxIi09dzpArR2QKN+4oZLv8mqJ4cH3zYwATsWn8GQzI34bxHE1
 RkH5AE8RH7eA2nNmWHP0V/wsSLfu4tXQ8dzIk5+tOC4Q1t2fkF5uVaO
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Add support for the hardware watchdog integrated in the Nuvoton NCT6126
Super I/O chip. This device is used on a number of x86 single-board
computers and is compatible with the w83627hf_wdt driver.

Unlike most supported chips, the NCT6126 shares the same high-byte chip
ID as the NCT6116. Read the low byte of the chip ID as well to
distinguish between the two devices and identify the NCT6126 correctly.

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

