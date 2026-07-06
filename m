Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F803F8EBE
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333195; cv=none; b=QsZejbRHfNct5AK+LdZ/Ls4kJMCHREmpP5QtawFwi4Mrs5fWax5Pp/AVe1fts6N2VUqEekGXDFNSlppYfWCVi0Q8CHq2ZjkMcpIlrJLmkZ+I75e02HhTgtHtu0ulIN9sZcjfza8P6WF9m8IwciCJBueKiNT9SUb5KiTTG7okb+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333195; c=relaxed/simple;
	bh=4Hr1mQCqtFDpBPpCNrV6yTUlKcDc2PoPipvWTwhozFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s95u9aufK7+EVE/7fID/W1MPQyL835JGC6Il2hytELFMJPRrtshi4fnORPokOQsz7zDq9HMHkm1gEkhE8xITuxPWS/Qri2dJ2QXMxxh5qc4le/8HKYwonM/M3hX3+XTEkcGArLTkhgtHIuKJGrFSjYgo64c0vFwmQR8yW6gIe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uuPo53k6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uuPo53k6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 653E64E40CAA
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 10:19:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3AF69601A2;
	Mon,  6 Jul 2026 10:19:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A39E811BBA020;
	Mon,  6 Jul 2026 12:19:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783333191; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+MBAhDJG7XccE7llgYvWP96a8T05xfWUC6S9d4FeozU=;
	b=uuPo53k6cdyBrIx01Nrb6ieE6MqozBGuESCqhaNXUlKFgho9w6COQPMb+Smppe0dACozP2
	8utd4m/m0VNSDfAMJ9KHFQtci8Retr4v/Tc9mUW6IEkPlBC6nyMeSFDzIjZHtyGWd5HYpf
	GSkJUkoDIVGtinz8gEbwUgAFqdipfkqG+xHP2UIwHT6N9QqTpl+DNhNGKLavt+aBESpMZk
	1zratwmcmZILCqRrIWH4IICbGXbFBuZWRf0yyr+hxfm9zLgWtdyioAr0FxxihYL1sxqAnH
	o4wGxEHh2qKGXASpwHvJOR4EbSCQI8PXvE0BH1dpmxcQrMob8nNJoxhr7b5w5Q==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Mon, 06 Jul 2026 12:19:32 +0200
Subject: [PATCH v2 1/2] watchdog: w83627hf_wdt: Add support for Nuvoton
 NCT6126
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-w83627hf_wdt-nct6126d-v2-1-77af74af88ae@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com>
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v2-0-77af74af88ae@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783333189; l=2298;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=4Hr1mQCqtFDpBPpCNrV6yTUlKcDc2PoPipvWTwhozFU=;
 b=ixtTYzgCH3P7o8LRv5RADHxdeuriqIfnQQ6Jjt6Afg9Em3dHQ99MbJVm1+O6dWHWoZzVhkoua
 BmqGFWu2yGuAovxjQ5m/XkFd8W757yTH+N/E1hKmFXSX6VgMS7BPxww
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
 drivers/watchdog/w83627hf_wdt.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index bc33b63c5a5d..1f649fda8a81 100644
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
@@ -428,7 +430,12 @@ static int wdt_find(int addr)
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
@@ -499,6 +506,7 @@ static int __init wdt_init(void)
 		"NCT6796",
 		"NCT6102",
 		"NCT6116",
+		"NCT6126"
 	};
 
 	/* Apply system-specific quirks */

-- 
2.55.0

