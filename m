Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483957;
	b=NzSB0gUwaGYEtaApkGcVRicrPcwabzeF6H0WEoNeTvk93zRNmVY9XbbH6IUmzSapO7op
	 DciSdQrkWGVKzRxSnk1IIO9sn86FohUGZO1amFIeiKG87YpzaAoCT6XJLrvnSL1VGhyPZ
	 qA+ZKF5cMvRjnLMkG0LPenj2l08QMGuVNTtT50dCS49areW0/QEk8dyTLqDHfDeR3EPF9
	 BSA/pDmEOK5iEn93p3OkGO1ELYxjuCKHzrnHWeWXiPQEofXs5ERR2vsS71T5QOqZrVL8Q
	 4avfrgZmX2KETeIbOlmgktRuKjZznWk3DTpBuaS8e/RVrJiGVtDDFuiYV3LHsKpIUBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483957;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=RNRx0riMbeM9k1Kn5zrja41pd23PbmLr63xJ7MfKDoI=;
	b=ojxY61iMSDysP7xF7chefGmMxoLnxu4Tp3xjT17MShm3wis9w8/MbONwCKiBlQx1huY0
	 R00pkceGkmrhMZOsLI3mDSh2OpT+ApLeeZikjRzLwNDmCt8tB4Tup0DJSCB/TgivfxWIm
	 vM0bQ6n9S/4Ly6TmGkwJz7wkaSaN0l3q0HjTLaSSNM8yMV0pwFIueq3rMlpSq0NdFlbxy
	 vKRcDSdWfXHhmEKGs9+OyjzVCYWxmS8y/r4Y1ZH0FP3PiDwocYNu20sRuS69FL8TG+nfO
	 4hrWV9EuW9nfgl8TK+FDLjb8IBJDo9gqfZvD0Z4cLYyuQaLmTg3Ki1SnmOXkDCl/2uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FGzJk2LP;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E651606A32C
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 08:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E651606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=FGzJk2LP
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0AAA61A12A3;
	Tue, 20 Oct 2026 08:12:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D344B60393;
	Tue, 20 Oct 2026 08:12:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EFE110328DBA;
	Tue, 20 Oct 2026 10:12:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483954; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RNRx0riMbeM9k1Kn5zrja41pd23PbmLr63xJ7MfKDoI=;
	b=FGzJk2LPuKJF+kJMlz3gEV6gs/CorBOAqXL3hGwwr1wUJWZ+C/NERdfhcWQ3lPN5JZKUZ9
	daKplQtgHotPi96nWteSaMHFwYZ/NXTwlAm7C48A8FOP5c8TcObkmeQy2+LMDJ1qIdHBnu
	MDvBDqtB4ribcHyR2a630ENHjwwUKorL5oFBtC927Y/3qMk/Mdwc85oIo0qYHv7ASMVXKh
	JtLWTDHaDJbB1Hfa0HiFELs0F/7L/kWLk76kdEUqc0Rq5hvqnhKq/ffj73IbGD05WsZRYl
	lZrmRd/t6JQBEw4XFIKTAfn63EvRuHmCEmyLGPy5Hem3w4MUftp2vpnFqvF54g==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 20 Oct 2026 10:11:56 +0200
Subject: [PATCH v5 3/5] watchdog: w83627hf_wdt: Move register offsets into
 driver data
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-w83627hf_wdt-improvements-v5-3-90b226684fc7@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483947; l=7622;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=FWiKcL8xDEfaMSpUH9JlS0pvdRo8Ym5WAfX87zDLPGA=;
 b=saZcWkGGTU5m2RolY8z/e5JKiCqlSkxnsyLojLppeypxvi5rENplzuXgeKSND4y09CyUs7rCp
 NfWzOBiLljYApfJxrp7W4n2KCBEUufB4/AWig0tOnOj7NzVMW9Kfbum
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Register offsets for the watchdog timer, control, and status registers
differ across Super I/O chip variants. Store them in the driver data
instead of global variables.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 93 ++++++++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 96ea278e45c4..fc3703b38141 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -42,9 +42,6 @@
 #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
 
 static int wdt_io;
-static int cr_wdt_timeout;	/* WDT timeout register */
-static int cr_wdt_control;	/* WDT control register */
-static int cr_wdt_csr;		/* WDT control & status register */
 static int wdt_cfg_enter = 0x87;/* key to unlock configuration space */
 static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
 
@@ -130,9 +127,16 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
 #define WDT_CTRL_MINUTE_MODE		BIT(3)
 
+struct w83627hf_reg {
+	int control;
+	int timeout;
+	int csr;
+};
+
 struct w83627hf_data {
 	struct watchdog_device wdd;
 	struct watchdog_info info;
+	const struct w83627hf_reg *reg;
 };
 
 static void superio_outb(int reg, int val)
@@ -171,6 +175,7 @@ static void superio_exit(void)
 
 static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 	unsigned char t;
 
@@ -210,10 +215,10 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	case w83627dhg_p:
 		t = superio_inb(0x2D) & ~0x01; /* PIN77 -> WDT0# */
 		superio_outb(0x2D, t); /* set GPIO5 to WDT0 */
-		t = superio_inb(cr_wdt_control);
+		t = superio_inb(data->reg->control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(cr_wdt_control, t);
+		superio_outb(data->reg->control, t);
 		break;
 	case w83637hf:
 		break;
@@ -242,46 +247,47 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		 * Don't touch its configuration, and hope the BIOS
 		 * does the right thing.
 		 */
-		t = superio_inb(cr_wdt_control);
+		t = superio_inb(data->reg->control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(cr_wdt_control, t);
+		superio_outb(data->reg->control, t);
 		break;
 	default:
 		break;
 	}
 
-	t = superio_inb(cr_wdt_timeout);
+	t = superio_inb(data->reg->timeout);
 	if (t != 0) {
 		if (early_disable) {
 			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
-			superio_outb(cr_wdt_timeout, 0);
+			superio_outb(data->reg->timeout, 0);
 		} else {
 			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
 				wdog->timeout);
-			superio_outb(cr_wdt_timeout, wdog->timeout);
+			superio_outb(data->reg->timeout, wdog->timeout);
 			set_bit(WDOG_HW_RUNNING, &wdog->status);
 		}
 	}
 
-	t = superio_inb(cr_wdt_control) &
+	t = superio_inb(data->reg->control) &
 	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
-	superio_outb(cr_wdt_control, t);
+	superio_outb(data->reg->control, t);
 
-	t = superio_inb(cr_wdt_csr);
+	t = superio_inb(data->reg->csr);
 	if (t & WDT_CSR_STATUS)
 		wdog->bootstatus |= WDIOF_CARDRESET;
 
 	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD_INT_RESET | WDT_CSR_MOUSE_INT_RESET);
-	superio_outb(cr_wdt_csr, t);
+	superio_outb(data->reg->csr, t);
 
 	superio_exit();
 
 	return 0;
 }
 
-static int wdt_set_time(unsigned int timeout)
+static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 
 	ret = superio_enter();
@@ -289,7 +295,7 @@ static int wdt_set_time(unsigned int timeout)
 		return ret;
 
 	superio_select(W83627HF_LD_WDT);
-	superio_outb(cr_wdt_timeout, timeout);
+	superio_outb(data->reg->timeout, timeout);
 	superio_exit();
 
 	return 0;
@@ -297,12 +303,12 @@ static int wdt_set_time(unsigned int timeout)
 
 static int wdt_start(struct watchdog_device *wdog)
 {
-	return wdt_set_time(wdog->timeout);
+	return wdt_set_time(wdog, wdog->timeout);
 }
 
 static int wdt_stop(struct watchdog_device *wdog)
 {
-	return wdt_set_time(0);
+	return wdt_set_time(wdog, 0);
 }
 
 static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
@@ -314,6 +320,7 @@ static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
 
 static unsigned int wdt_get_time(struct watchdog_device *wdog)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	unsigned int timeleft;
 	int ret;
 
@@ -322,7 +329,7 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 		return 0;
 
 	superio_select(W83627HF_LD_WDT);
-	timeleft = superio_inb(cr_wdt_timeout);
+	timeleft = superio_inb(data->reg->timeout);
 	superio_exit();
 
 	return timeleft;
@@ -350,10 +357,6 @@ static int wdt_find(int addr)
 	u8 val;
 	int ret;
 
-	cr_wdt_timeout = W83627HF_WDT_TIMEOUT;
-	cr_wdt_control = W83627HF_WDT_CONTROL;
-	cr_wdt_csr = W836X7HF_WDT_CSR;
-
 	ret = superio_enter();
 	if (ret)
 		return ret;
@@ -368,13 +371,9 @@ static int wdt_find(int addr)
 		break;
 	case W83697HF_ID:
 		ret = w83697hf;
-		cr_wdt_timeout = W83697HF_WDT_TIMEOUT;
-		cr_wdt_control = W83697HF_WDT_CONTROL;
 		break;
 	case W83697UG_ID:
 		ret = w83697ug;
-		cr_wdt_timeout = W83697HF_WDT_TIMEOUT;
-		cr_wdt_control = W83697HF_WDT_CONTROL;
 		break;
 	case W83637HF_ID:
 		ret = w83637hf;
@@ -429,9 +428,6 @@ static int wdt_find(int addr)
 		break;
 	case NCT6102_ID:
 		ret = nct6102;
-		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
-		cr_wdt_control = NCT6102D_WDT_CONTROL;
-		cr_wdt_csr = NCT6102D_WDT_CSR;
 		break;
 	case NCT6116_ID:
 		val = superio_inb(SIO_REG_DEVID + 1);
@@ -439,10 +435,6 @@ static int wdt_find(int addr)
 			ret = nct6126;
 		else
 			ret = nct6116;
-
-		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
-		cr_wdt_control = NCT6102D_WDT_CONTROL;
-		cr_wdt_csr = NCT6102D_WDT_CSR;
 		break;
 	case 0xff:
 		ret = -ENODEV;
@@ -456,6 +448,24 @@ static int wdt_find(int addr)
 	return ret;
 }
 
+static const struct w83627hf_reg w83627hf_default_regs = {
+	.timeout = W83627HF_WDT_TIMEOUT,
+	.control = W83627HF_WDT_CONTROL,
+	.csr = W836X7HF_WDT_CSR
+};
+
+static const struct w83627hf_reg w83627hf_nct61xx_regs = {
+	.timeout = NCT6102D_WDT_TIMEOUT,
+	.control = NCT6102D_WDT_CONTROL,
+	.csr = NCT6102D_WDT_CSR
+};
+
+static const struct w83627hf_reg w83627hf_w83697xx_regs = {
+	.timeout = W83697HF_WDT_TIMEOUT,
+	.control = W83697HF_WDT_CONTROL,
+	.csr = W836X7HF_WDT_CSR
+};
+
 static int wdt_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
@@ -489,6 +499,21 @@ static int wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout = 1;
 	wdd->max_timeout = 255;
 
+	switch (chip) {
+	case nct6102:
+	case nct6116:
+	case nct6126:
+		data->reg = &w83627hf_nct61xx_regs;
+		break;
+	case w83697hf:
+	case w83697ug:
+		data->reg = &w83627hf_w83697xx_regs;
+		break;
+	default:
+		data->reg = &w83627hf_default_regs;
+		break;
+	}
+
 	watchdog_set_drvdata(wdd, data);
 	watchdog_init_timeout(wdd, timeout, NULL);
 	watchdog_set_nowayout(wdd, nowayout);

-- 
2.56.0

