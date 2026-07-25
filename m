Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0553C9454;
	Sat, 25 Jul 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975414; cv=none; b=prdjRDPSKhevErxYI7LNVuW/09DCyb0KahhigbK5TqTqHPtJ/UjslT6i0YKV9G1/1/WXu2s+LF+QRD3hHR9HSay14k/tlcAACTKKNqp3voioM67yzIWlPG67M9qDdUGRWjtoeq/WUV/WeT4WoM/RczOMZ7OSM7Y/GVLkx9jji4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975414; c=relaxed/simple;
	bh=E4UoCEjOgX7zwc33YxycKZlQkTAEeRl40cy8Pd2bnAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h/zU8NsJVJkh7kKADeP+Fydkx30rqWvXdcfT5NHKlAqjut9sdePEhRzekgCzl5qr6guxg9fl0xRn4IA+GTYC4Aa94z4Ek5cZ4Hm0CII0nouCbS/x1L712koSAGvzNEDY7JCr5epaPO0+5jC/QPG02l4A1pgizFs6mx3E8/P39D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U9hHs3rV; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U9hHs3rV"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EFFE91A121E;
	Sat, 25 Jul 2026 10:30:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C48EF60398;
	Sat, 25 Jul 2026 10:30:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBE0411C1252A;
	Sat, 25 Jul 2026 12:30:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975407; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n3k4bAbB/Mj+q2xQl935UTg5ABDHayjLnwlDDQtvp+w=;
	b=U9hHs3rVomZI01z60geK/Y1/u/SBYMtNGiqlMMpMymg2IPb338bgQGvOSuc1N+imsxzNkK
	1Qief+IShAhha+jZ5a7kIC1aEe5P5IYk1CR8VfaFp/VqnP5E+40/aNTnkePTcf334O+AZ5
	GTVVoEKFF+ndQIjDGecegwQ6FUiSWu4ActveQL569UPOIUiU3yxzcgdzGSOaHDoc2BHfrX
	VoRaJux0/dAwE7xqBIkVWyM1c8RCYDeGUUKcmm1fgZoPnWbqipeE2aRWiADJ8PXXQdex1R
	wGSY80BZXMvKIe/FiMH22SKz25JMfy3TNsla61AOF/UD7LpJPVr568XiMR/BEg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sat, 25 Jul 2026 12:29:31 +0200
Subject: [PATCH 4/9] watchdog: w83627hf_wdt: Move register offsets into
 driver data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-w83627hf_wdt-improvements-v1-4-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=7062;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=E4UoCEjOgX7zwc33YxycKZlQkTAEeRl40cy8Pd2bnAI=;
 b=qDctRb10HsvBpGNw4XkyT43j1E8ME7U6JIimPPaKyqkXxEgsyND1/oTzW0S2Maeh3KKXFlDOm
 run0iOAW2g0BX4rR8/rXKOUNySZwhur2UOD3pwOJyFGKI/t3DobrE7p
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Register offsets for the watchdog timer, control, and status registers
differ across Super I/O chip variants. Store them in the driver data
instead of global variables.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 73 ++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 34 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 72e167f37885..f5333c432198 100644
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
 
@@ -135,6 +132,11 @@ struct wdt_pdata {};
 struct w83627hf_data {
 	struct watchdog_device wdd;
 	struct watchdog_info info;
+	struct {
+		int control;
+		int timeout;
+		int csr;
+	} reg;
 };
 
 static void superio_outb(int reg, int val)
@@ -173,6 +175,7 @@ static void superio_exit(void)
 
 static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 	unsigned char t;
 
@@ -212,10 +215,10 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	case w83627dhg_p:
 		t = superio_inb(0x2D) & ~0x01; /* PIN77 -> WDT0# */
 		superio_outb(0x2D, t); /* set GPIO5 to WDT0 */
-		t = superio_inb(cr_wdt_control);
+		t = superio_inb(data->reg.control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(cr_wdt_control, t);
+		superio_outb(data->reg.control, t);
 		break;
 	case w83637hf:
 		break;
@@ -244,48 +247,49 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		 * Don't touch its configuration, and hope the BIOS
 		 * does the right thing.
 		 */
-		t = superio_inb(cr_wdt_control);
+		t = superio_inb(data->reg.control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(cr_wdt_control, t);
+		superio_outb(data->reg.control, t);
 		break;
 	default:
 		break;
 	}
 
-	t = superio_inb(cr_wdt_timeout);
+	t = superio_inb(data->reg.timeout);
 	if (t != 0) {
 		if (early_disable) {
 			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
-			superio_outb(cr_wdt_timeout, 0);
+			superio_outb(data->reg.timeout, 0);
 		} else {
 			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
 				wdog->timeout);
-			superio_outb(cr_wdt_timeout, wdog->timeout);
+			superio_outb(data->reg.timeout, wdog->timeout);
 			set_bit(WDOG_HW_RUNNING, &wdog->status);
 		}
 	}
 
 	/* set second mode & disable keyboard reset turning off watchdog */
-	t = superio_inb(cr_wdt_control) &
+	t = superio_inb(data->reg.control) &
 	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
-	superio_outb(cr_wdt_control, t);
+	superio_outb(data->reg.control, t);
 
-	t = superio_inb(cr_wdt_csr);
+	t = superio_inb(data->reg.csr);
 	if (t & WDT_CSR_STATUS)
 		wdog->bootstatus |= WDIOF_CARDRESET;
 
 	/* reset status, disable keyboard & mouse interrupt turning off watchdog */
 	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD_INT_RESET | WDT_CSR_MOUSE_INT_RESET);
-	superio_outb(cr_wdt_csr, t);
+	superio_outb(data->reg.csr, t);
 
 	superio_exit();
 
 	return 0;
 }
 
-static int wdt_set_time(unsigned int timeout)
+static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 
 	ret = superio_enter();
@@ -293,7 +297,7 @@ static int wdt_set_time(unsigned int timeout)
 		return ret;
 
 	superio_select(W83627HF_LD_WDT);
-	superio_outb(cr_wdt_timeout, timeout);
+	superio_outb(data->reg.timeout, timeout);
 	superio_exit();
 
 	return 0;
@@ -301,12 +305,12 @@ static int wdt_set_time(unsigned int timeout)
 
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
@@ -318,6 +322,7 @@ static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
 
 static unsigned int wdt_get_time(struct watchdog_device *wdog)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	unsigned int timeleft;
 	int ret;
 
@@ -326,7 +331,7 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 		return 0;
 
 	superio_select(W83627HF_LD_WDT);
-	timeleft = superio_inb(cr_wdt_timeout);
+	timeleft = superio_inb(data->reg.timeout);
 	superio_exit();
 
 	return timeleft;
@@ -354,10 +359,6 @@ static int wdt_find(int addr)
 	u8 val;
 	int ret;
 
-	cr_wdt_timeout = W83627HF_WDT_TIMEOUT;
-	cr_wdt_control = W83627HF_WDT_CONTROL;
-	cr_wdt_csr = W836X7HF_WDT_CSR;
-
 	ret = superio_enter();
 	if (ret)
 		return ret;
@@ -372,13 +373,9 @@ static int wdt_find(int addr)
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
@@ -433,9 +430,6 @@ static int wdt_find(int addr)
 		break;
 	case NCT6102_ID:
 		ret = nct6102;
-		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
-		cr_wdt_control = NCT6102D_WDT_CONTROL;
-		cr_wdt_csr = NCT6102D_WDT_CSR;
 		break;
 	case NCT6116_ID:
 		val = superio_inb(SIO_REG_DEVID + 1);
@@ -443,10 +437,6 @@ static int wdt_find(int addr)
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
@@ -486,6 +476,21 @@ static int wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout = 1;
 	wdd->max_timeout = 255;
 
+	data->reg.timeout = W83627HF_WDT_TIMEOUT;
+	data->reg.control = W83627HF_WDT_CONTROL;
+	data->reg.csr = W836X7HF_WDT_CSR;
+
+	if (chip == nct6102 || chip == nct6116 || chip == nct6126) {
+		data->reg.timeout = NCT6102D_WDT_TIMEOUT;
+		data->reg.control = NCT6102D_WDT_CONTROL;
+		data->reg.csr = NCT6102D_WDT_CSR;
+	}
+
+	if (chip == w83697hf || chip == w83697ug) {
+		data->reg.timeout = W83697HF_WDT_TIMEOUT;
+		data->reg.control = W83697HF_WDT_CONTROL;
+	}
+
 	watchdog_set_drvdata(wdd, data);
 	watchdog_init_timeout(wdd, timeout, NULL);
 	watchdog_set_nowayout(wdd, nowayout);

-- 
2.55.0

