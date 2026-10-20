Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483958;
	b=oBhXjBtluGKMewILIRXWFNKAIRvxGpSPLbj7s/5qfy+ZXp/v910QbzZX02nJniLL7wRm
	 ZmztH5LBVbBV31joMbcFahMnnRAwhsSDAP5+mD9gffagCCmswAiwme/i7X1/vLVIfNAuK
	 CWtgTEd7dGzHMgSN4tgbu6N9oRN6dTs+sYyC9LIw9IPE3D/ErYmmk3rcO6OUMA/TIxBsC
	 W0bv6A/lahh8Je5//5EKWskJvowMzbiLB9BZy6Bh26RTSw7WHSlyDT2yxfp1EIK2EXo4G
	 i37yw+XK8xnSX93k1BkWS7pnyeoWR86dhYdK3opCaRYYrOWPyayPoFkXe41bM7KCWug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483958;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=06LXYNbs6YkcX8KeydxiCrIkGbNxoNp9oAMmsXqyGq4=;
	b=GpqdCECMtKbO8lG/E3aKVkxXGJpDphp6+S5y6IrOgj5H28UeWjIC5/rilQRaa8493l6/
	 XzoiF0OyXG9OQJNts/5vEMbXywhkkMM4sDEI9M62oBy4h/1nkWlcwvyJLcwmwj7DpD091
	 lzEJP+673WDRMxddogSNnSNsB5SrzSbxV0f8yYIbK1LuqE2REonrEYM+UPAMtzko5NkBH
	 4DkJENLAaj3+3WfJgTwZ2uifV6rQiKdkcTNqBoCwKeowIp4DgBRakbdNTEln8K+WwzA7i
	 NOTYO3e7gjI02vlLgmuHQLz25XvK9BNfSx3UJXW6QcZUfx8OwgBd3lo0AGKcjP4rJIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aHav+xPI;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E8606A323
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 08:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A4E8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=aHav+xPI
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 72BC4C63454
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 08:13:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFA3B60393;
	Tue, 20 Oct 2026 08:12:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D9B510328A45;
	Tue, 20 Oct 2026 10:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483955; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=06LXYNbs6YkcX8KeydxiCrIkGbNxoNp9oAMmsXqyGq4=;
	b=aHav+xPIzjSDDZ9Rv4qElOCGGOchBC9J+Oj2jHzoc0cnC0D8vhYWuY3ZLoLyJjmKSppCYz
	rx/8gio8JhsH/QGsAGYLjSwvhR81iKf7lzewWcKoPGDAchBXgL2sqYUc+WInq7flRJU0ij
	kYO6r3Iv2DYYB4J19KX4g0vnY0PS8BaYivx9wVSPW6uNGzyynAN/Y6l0/vEoe+Fv4Q4EJD
	0Z7NkCjQfFoOYYNupdx6TN2dsa+CIwydnpNDTP1FKysR507rjYl94cu+vVCE5OOrKeoTxl
	1QfFWgVGbkSrl02+IekNVaeCR9oQyZzZUxoKWXS/pVSLwNmPNAkRvPoLCVYsOA==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 20 Oct 2026 10:11:57 +0200
Subject: [PATCH v5 4/5] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
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
Message-Id: <20261020-w83627hf_wdt-improvements-v5-4-90b226684fc7@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483947; l=12909;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=d4tzs0KpTM6LVgP4CeBh5FhDGeNP+buGmz4Q2IzvL30=;
 b=l7ziHpXliqJ/fvtDJtYFeGmJgvOpI9b4zy+RyaWoGlj/taGKngXgZIr0+MlLx0SVM280x+85B
 WMOS7rajHibANxRQ7VxDtYF5u0FVALQphqJOqfJyRaDzENZwvwNOKBc
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Instead of using global variables, store Super I/O related
configurations in platform data.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/w83627hf_wdt.c | 161 ++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 74 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index fc3703b38141..3d6f35e79631 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -41,10 +41,6 @@
 #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
 #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
 
-static int wdt_io;
-static int wdt_cfg_enter = 0x87;/* key to unlock configuration space */
-static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
-
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
 	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
@@ -76,9 +72,8 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define SIO_CONF_PORT0		0x2E
 #define SIO_CONF_PORT1		0x4E
 
-#define WDT_EFER (wdt_io+0)   /* Extended Function Enable Registers */
-#define WDT_EFIR (wdt_io+0)   /* Extended Function Index Register
-							(same as EFER) */
+#define WDT_EFER (base+0)   /* Extended Function Enable Registers */
+#define WDT_EFIR (base+0)   /* Extended Function Index Register (same as EFER) */
 #define WDT_EFDR (WDT_EFIR+1) /* Extended Function Data Register */
 
 #define W83627HF_LD_WDT		0x08
@@ -133,44 +128,51 @@ struct w83627hf_reg {
 	int csr;
 };
 
+struct w83627hf_sio_pdata {
+	int addr;
+	int cfg_enter;
+	int cfg_leave;
+};
+
 struct w83627hf_data {
 	struct watchdog_device wdd;
 	struct watchdog_info info;
 	const struct w83627hf_reg *reg;
+	const struct w83627hf_sio_pdata *sio;
 };
 
-static void superio_outb(int reg, int val)
+static void superio_outb(int base, int reg, int val)
 {
 	outb(reg, WDT_EFER);
 	outb(val, WDT_EFDR);
 }
 
-static inline int superio_inb(int reg)
+static inline int superio_inb(int base, int reg)
 {
 	outb(reg, WDT_EFER);
 	return inb(WDT_EFDR);
 }
 
-static int superio_enter(void)
+static int superio_enter(int base, int enter)
 {
-	if (!request_muxed_region(wdt_io, 2, WATCHDOG_NAME))
+	if (!request_muxed_region(base, 2, WATCHDOG_NAME))
 		return -EBUSY;
 
-	outb_p(wdt_cfg_enter, WDT_EFER); /* Enter extended function mode */
-	outb_p(wdt_cfg_enter, WDT_EFER); /* Again according to manual */
+	outb_p(enter, WDT_EFER); /* Enter extended function mode */
+	outb_p(enter, WDT_EFER); /* Again according to manual */
 
 	return 0;
 }
 
-static void superio_select(int ld)
+static void superio_select(int base, int ld)
 {
-	superio_outb(SIO_REG_LDSEL, ld);
+	superio_outb(base, SIO_REG_LDSEL, ld);
 }
 
-static void superio_exit(void)
+static void superio_exit(int base, int leave)
 {
-	outb_p(wdt_cfg_leave, WDT_EFER); /* Leave extended function mode */
-	release_region(wdt_io, 2);
+	outb_p(leave, WDT_EFER); /* Leave extended function mode */
+	release_region(base, 2);
 }
 
 static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
@@ -179,52 +181,52 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	int ret;
 	unsigned char t;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sio->addr, data->sio->cfg_enter);
 	if (ret)
 		return ret;
 
-	superio_select(W83627HF_LD_WDT);
+	superio_select(data->sio->addr, W83627HF_LD_WDT);
 
 	/* set CR30 bit 0 to activate GPIO2 */
-	t = superio_inb(SIO_REG_ENABLE);
+	t = superio_inb(data->sio->addr, SIO_REG_ENABLE);
 	if (!(t & 0x01))
-		superio_outb(SIO_REG_ENABLE, t | 0x01);
+		superio_outb(data->sio->addr, SIO_REG_ENABLE, t | 0x01);
 
 	switch (chip) {
 	case w83627hf:
 	case w83627s:
-		t = superio_inb(0x2B) & ~0x10;
-		superio_outb(0x2B, t); /* set GPIO24 to WDT0 */
+		t = superio_inb(data->sio->addr, 0x2B) & ~0x10;
+		superio_outb(data->sio->addr, 0x2B, t); /* set GPIO24 to WDT0 */
 		break;
 	case w83697hf:
 		/* Set pin 119 to WDTO# mode (= CR29, WDT0) */
-		t = superio_inb(0x29) & ~0x60;
+		t = superio_inb(data->sio->addr, 0x29) & ~0x60;
 		t |= 0x20;
-		superio_outb(0x29, t);
+		superio_outb(data->sio->addr, 0x29, t);
 		break;
 	case w83697ug:
 		/* Set pin 118 to WDTO# mode */
-		t = superio_inb(0x2b) & ~0x04;
-		superio_outb(0x2b, t);
+		t = superio_inb(data->sio->addr, 0x2b) & ~0x04;
+		superio_outb(data->sio->addr, 0x2b, t);
 		break;
 	case w83627thf:
-		t = (superio_inb(0x2B) & ~0x08) | 0x04;
-		superio_outb(0x2B, t); /* set GPIO3 to WDT0 */
+		t = (superio_inb(data->sio->addr, 0x2B) & ~0x08) | 0x04;
+		superio_outb(data->sio->addr, 0x2B, t); /* set GPIO3 to WDT0 */
 		break;
 	case w83627dhg:
 	case w83627dhg_p:
-		t = superio_inb(0x2D) & ~0x01; /* PIN77 -> WDT0# */
-		superio_outb(0x2D, t); /* set GPIO5 to WDT0 */
-		t = superio_inb(data->reg->control);
+		t = superio_inb(data->sio->addr, 0x2D) & ~0x01; /* PIN77 -> WDT0# */
+		superio_outb(data->sio->addr, 0x2D, t); /* set GPIO5 to WDT0 */
+		t = superio_inb(data->sio->addr, data->reg->control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(data->reg->control, t);
+		superio_outb(data->sio->addr, data->reg->control, t);
 		break;
 	case w83637hf:
 		break;
 	case w83687thf:
-		t = superio_inb(0x2C) & ~0x80; /* PIN47 -> WDT0# */
-		superio_outb(0x2C, t);
+		t = superio_inb(data->sio->addr, 0x2C) & ~0x80; /* PIN47 -> WDT0# */
+		superio_outb(data->sio->addr, 0x2C, t);
 		break;
 	case w83627ehf:
 	case w83627uhg:
@@ -247,40 +249,40 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		 * Don't touch its configuration, and hope the BIOS
 		 * does the right thing.
 		 */
-		t = superio_inb(data->reg->control);
+		t = superio_inb(data->sio->addr, data->reg->control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(data->reg->control, t);
+		superio_outb(data->sio->addr, data->reg->control, t);
 		break;
 	default:
 		break;
 	}
 
-	t = superio_inb(data->reg->timeout);
+	t = superio_inb(data->sio->addr, data->reg->timeout);
 	if (t != 0) {
 		if (early_disable) {
 			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
-			superio_outb(data->reg->timeout, 0);
+			superio_outb(data->sio->addr, data->reg->timeout, 0);
 		} else {
 			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
 				wdog->timeout);
-			superio_outb(data->reg->timeout, wdog->timeout);
+			superio_outb(data->sio->addr, data->reg->timeout, wdog->timeout);
 			set_bit(WDOG_HW_RUNNING, &wdog->status);
 		}
 	}
 
-	t = superio_inb(data->reg->control) &
+	t = superio_inb(data->sio->addr, data->reg->control) &
 	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
-	superio_outb(data->reg->control, t);
+	superio_outb(data->sio->addr, data->reg->control, t);
 
-	t = superio_inb(data->reg->csr);
+	t = superio_inb(data->sio->addr, data->reg->csr);
 	if (t & WDT_CSR_STATUS)
 		wdog->bootstatus |= WDIOF_CARDRESET;
 
 	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD_INT_RESET | WDT_CSR_MOUSE_INT_RESET);
-	superio_outb(data->reg->csr, t);
+	superio_outb(data->sio->addr, data->reg->csr, t);
 
-	superio_exit();
+	superio_exit(data->sio->addr, data->sio->cfg_leave);
 
 	return 0;
 }
@@ -290,13 +292,13 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sio->addr, data->sio->cfg_enter);
 	if (ret)
 		return ret;
 
-	superio_select(W83627HF_LD_WDT);
-	superio_outb(data->reg->timeout, timeout);
-	superio_exit();
+	superio_select(data->sio->addr, W83627HF_LD_WDT);
+	superio_outb(data->sio->addr, data->reg->timeout, timeout);
+	superio_exit(data->sio->addr, data->sio->cfg_leave);
 
 	return 0;
 }
@@ -324,13 +326,13 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 	unsigned int timeleft;
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sio->addr, data->sio->cfg_enter);
 	if (ret)
 		return 0;
 
-	superio_select(W83627HF_LD_WDT);
-	timeleft = superio_inb(data->reg->timeout);
-	superio_exit();
+	superio_select(data->sio->addr, W83627HF_LD_WDT);
+	timeleft = superio_inb(data->sio->addr, data->reg->timeout);
+	superio_exit(data->sio->addr, data->sio->cfg_leave);
 
 	return timeleft;
 }
@@ -352,16 +354,16 @@ static const struct watchdog_ops wdt_ops = {
  *	turn the timebomb registers off.
  */
 
-static int wdt_find(int addr)
+static int wdt_find(int addr, int enter, int leave)
 {
 	u8 val;
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(addr, enter);
 	if (ret)
 		return ret;
-	superio_select(W83627HF_LD_WDT);
-	val = superio_inb(SIO_REG_DEVID);
+	superio_select(addr, W83627HF_LD_WDT);
+	val = superio_inb(addr, SIO_REG_DEVID);
 	switch (val) {
 	case W83627HF_ID:
 		ret = w83627hf;
@@ -430,7 +432,7 @@ static int wdt_find(int addr)
 		ret = nct6102;
 		break;
 	case NCT6116_ID:
-		val = superio_inb(SIO_REG_DEVID + 1);
+		val = superio_inb(addr, SIO_REG_DEVID + 1);
 		if (val == NCT6126_VER_A_LOW_ID || val == NCT6126_VER_B_LOW_ID)
 			ret = nct6126;
 		else
@@ -444,7 +446,7 @@ static int wdt_find(int addr)
 		pr_err("Unsupported chip ID: 0x%02x\n", val);
 		break;
 	}
-	superio_exit();
+	superio_exit(addr, leave);
 	return ret;
 }
 
@@ -468,6 +470,7 @@ static const struct w83627hf_reg w83627hf_w83697xx_regs = {
 
 static int wdt_probe(struct platform_device *pdev)
 {
+	const struct w83627hf_sio_pdata *pdata = dev_get_platdata(&pdev->dev);
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
@@ -480,12 +483,16 @@ static int wdt_probe(struct platform_device *pdev)
 	if (!id)
 		return dev_err_probe(dev, -EINVAL, "failed to get chip id\n");
 
+	if (!pdata)
+		return dev_err_probe(dev, -EINVAL, "failed to get pdata\n");
+
 	chip = id->driver_data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->sio = pdata;
 	data->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
 	snprintf(data->info.identity, sizeof(data->info.identity), "%s Watchdog",
 		 id->name);
@@ -533,18 +540,20 @@ static int wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct w83627hf_sio_pdata w83627hf_sio_pdata_default = {
+	.cfg_enter = 0x87,
+	.cfg_leave = 0xAA
+};
+
 /*
  * On some systems, the NCT6791D comes with a companion chip and the
  * watchdog function is in this companion chip. We must use a different
  * unlocking sequence to access the companion chip.
  */
-static int __init wdt_use_alt_key(const struct dmi_system_id *d)
-{
-	wdt_cfg_enter = 0x88;
-	wdt_cfg_leave = 0xBB;
-
-	return 0;
-}
+static const struct w83627hf_sio_pdata w83627hf_sio_pdata_alt = {
+	.cfg_enter = 0x88,
+	.cfg_leave = 0xBB
+};
 
 static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 	{
@@ -554,7 +563,7 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "INVES"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
 		},
-		.callback = wdt_use_alt_key,
+		.driver_data = (void *)&w83627hf_sio_pdata_alt
 	},
 	{}
 };
@@ -599,17 +608,21 @@ static struct platform_device *wdt_pdev;
 
 static int __init wdt_init(void)
 {
+	struct w83627hf_sio_pdata pdata = w83627hf_sio_pdata_default;
+	const struct dmi_system_id *match;
 	int ret;
 	int chip;
 
 	/* Apply system-specific quirks */
-	dmi_check_system(wdt_dmi_table);
+	match = dmi_first_match(wdt_dmi_table);
+	if (match)
+		pdata = *(const struct w83627hf_sio_pdata *)match->driver_data;
 
-	wdt_io = SIO_CONF_PORT0;
-	chip = wdt_find(SIO_CONF_PORT0);
+	pdata.addr = SIO_CONF_PORT0;
+	chip = wdt_find(pdata.addr, pdata.cfg_enter, pdata.cfg_leave);
 	if (chip < 0) {
-		wdt_io = SIO_CONF_PORT1;
-		chip = wdt_find(SIO_CONF_PORT1);
+		pdata.addr = SIO_CONF_PORT1;
+		chip = wdt_find(pdata.addr, pdata.cfg_enter, pdata.cfg_leave);
 		if (chip < 0)
 			return chip;
 	}
@@ -619,7 +632,7 @@ static int __init wdt_init(void)
 		return ret;
 
 	wdt_pdev = platform_device_register_data(NULL, wdt_ids[chip].name,
-						 PLATFORM_DEVID_NONE, NULL, 0);
+						 PLATFORM_DEVID_NONE, &pdata, sizeof(pdata));
 	if (IS_ERR(wdt_pdev)) {
 		platform_driver_unregister(&wdt_driver);
 		return PTR_ERR(wdt_pdev);

-- 
2.56.0

