Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9477F3F329E
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899951; cv=none; b=Gjjpe41fEQ0rgvPzztZm5iY9zC+Z9EPx/SlaBVBNptjODLwQ/QFbPpdsfJssXUlhCqEKIFgNUyWr8FkriK06h9sBOboEOp5cPi6mmL4ecsLAUnPOaWsmbxfv8fQOIf3D29dxzg0Jk/CKu2d+AYUuI0fe1MvgpigkMC35pQgczgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899951; c=relaxed/simple;
	bh=ONKXnjQ7LOEi4YtPA+SuITekJAP1XLJiXHyANzQkji0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbBdNnDNe/arml+EDkCwl0VrThZD/sqF8AQSk6QLtIip57jGB0I0ycpV2p6IqUAjjF0TjhRQl6hRGYNM7T8qEiLLYzhC3tT66kFaPkDWy+ly+t0b5PVCK3e7tnS75DaSgQIZbVK6/tgj3sB6Z8vJqK1OgVYt/6tpuenRyx7+Dgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=brmFPgmr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="brmFPgmr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3D7C74E4120E;
	Tue, 13 Oct 2026 13:59:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 12D2460362;
	Tue, 13 Oct 2026 13:59:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84F4111D71517;
	Tue, 13 Oct 2026 15:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791899947; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3naTdv8J2w3QVFJ0P3DJL71WRHqpQ7Xlou2dLmTy5mI=;
	b=brmFPgmr6ktaWO0CxTHIk5rp02Zhzw9jWOd91g1M30RcDURhsl8zssoCfFuStElykYNgPL
	MlPszHmz6sl2Pk2we49z5ZJTsvoUPf3oZrJDjK3atfxRtnI+wiHA/SO9ER3dtj2MHdGV+k
	nIe6Quj2gqZbybOFor2jpqDb5hzMuiYBzhCwTTeNr1VLdtsX5Wx6j+2Q2Zt8JaUUFdSWeW
	oiOnDu9DH/+p4ujMLZlTZSqvev7i/asfUgw6y+QkvX+fmwCx5hsTahlxPCP9NX8YsV/+6I
	w/wnLrJ/CqZRsdouD/NwTnqC7CFMynXNiQWf1Zk7xS5EeN/A0SbK6aVSw6jANw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 13 Oct 2026 15:58:48 +0200
Subject: [PATCH v4 4/6] watchdog: w83627hf_wdt: Move register offsets into
 driver data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-w83627hf_wdt-improvements-v4-4-b6f6b60a9566@bootlin.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791899939; l=7623;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=ONKXnjQ7LOEi4YtPA+SuITekJAP1XLJiXHyANzQkji0=;
 b=1eM/bFm+2sgyLhr4JRBUc7iy2UIGZag7RordKaRlqeizHfm+uCs4Yya5MsGg51yRdHmEoyjJX
 dFVFoF+Pu7fBJp53+0ydk4qIXQmLPqvBBVUaTjtGxPD4yXUSER20tQo
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
index cc72d2f5e56a..4943ae164771 100644
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
+	.control = W83627HF_WDT_CONTROL,
+	.timeout = W83627HF_WDT_TIMEOUT,
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
+	};
+
 	watchdog_set_drvdata(wdd, data);
 	watchdog_init_timeout(wdd, timeout, NULL);
 	watchdog_set_nowayout(wdd, nowayout);

-- 
2.56.0

