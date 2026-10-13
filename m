Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8D83F5BF5
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899955; cv=none; b=qQ3XS6G2MG1jppE+4SMPjLhDXZ9Sg7UvzraNl8KPhQGz29U+QtUAOcq37fajVPZJTG5qslGTJrQLTDZCD2bxdTU6AcB60F9nUNukb+bXGsiH2E1yqLleHXdsy8/uzU3V4neq0nxXGBiIT7BoYi/l98e4Kohwkz/XmboyFRM40hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899955; c=relaxed/simple;
	bh=JPH8A8h3BBAc0FhIvF0Nfu13xPKiXk9TzlEOfUfVr2g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ewhqQnSkWkFAFs3Quu5DA9R/DemMt6JDkTwf3YeymrOZfXM2I8GCILebrihbk+YLC0BpbCkfkIu6saFsx9vFxQOg5OomwtnSCkkQew63ykdmcQeM5A/dYk2NyJD44tF71JuD7+vLkZouHPdmjizLCyV67yvx/5uJZc8DNVd+Ris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=i0S9Wgxv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="i0S9Wgxv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E4976C653F4
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:00:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6001160362;
	Tue, 13 Oct 2026 13:59:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CA60811D715F4;
	Tue, 13 Oct 2026 15:59:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791899948; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9fCRha84mSxkO2PX9Nk5ZMVG9KUTUIcMcymGSyQwqN0=;
	b=i0S9WgxvqrN6sZXpeCzsJgmhQbTmglhIhllY9Z67Xr5m1nLGc4aPaClnfCwtvxzxPTyhe3
	qbTOIomf6RNhOIYaCDjCXGlaqBQ7luRqeNckVUqWtRc5Hdw1XYg+4qh3siXqVrINB4G4/4
	tIK6EaduJEduiBm1itEyCjH8GpA3XkBV6DbFFuRIdo4xI7q8sGvCWpG2r0YMfHqNcTzLIS
	oqt4xIukwhY0f7khV5QQMqQhhyZ1QHmdIHxaaIZYgBlKslZ9SW4zgSNXfHx0tzhm8QTUmV
	Y5Uzx4p8ln2C9GRqwA19DYWc59RrhnfjusQvTLRY3ONhPHjo1tkIiTr+dKuqrg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 13 Oct 2026 15:58:49 +0200
Subject: [PATCH v4 5/6] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-w83627hf_wdt-improvements-v4-5-b6f6b60a9566@bootlin.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791899939; l=12903;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=JPH8A8h3BBAc0FhIvF0Nfu13xPKiXk9TzlEOfUfVr2g=;
 b=WMhMm7oKe8OMcefJxCQxkPWwAPLIfxV6w9P+2UC8+7X5y12dQy9Q6A9ly/j4RZoUMOdJEx7M3
 UzuK+d5Y3iED8i4jVn1+h1ryeWy6TTlvJe7A/RiPVMwfQANE2RaGwke
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Instead of using global variables, store Super I/O related
configurations in platform data.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 160 ++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 73 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 4943ae164771..0b9195e7e95e 100644
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
 		return dev_err_probe(dev, -ENOMEM, "failed to allocate memory\n");
 
+	data->sio = pdata;
 	data->info.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE;
 	snprintf(data->info.identity, sizeof(data->info.identity), "%s",
 		 id->name);
@@ -533,18 +540,21 @@ static int wdt_probe(struct platform_device *pdev)
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
 
-	return 0;
-}
+static const struct w83627hf_sio_pdata w83627hf_sio_pdata_alt = {
+	.cfg_enter = 0x88,
+	.cfg_leave = 0xBB
+};
 
 static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 	{
@@ -554,7 +564,7 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "INVES"),
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
 		},
-		.callback = wdt_use_alt_key,
+		.driver_data = (void *) &w83627hf_sio_pdata_alt
 	},
 	{}
 };
@@ -599,17 +609,21 @@ static struct platform_device *wdt_pdev;
 
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
@@ -619,7 +633,7 @@ static int __init wdt_init(void)
 		return ret;
 
 	wdt_pdev = platform_device_register_data(NULL, wdt_ids[chip].name,
-						 PLATFORM_DEVID_NONE, NULL, 0);
+						 PLATFORM_DEVID_NONE, &pdata, sizeof(pdata));
 	if (IS_ERR(wdt_pdev)) {
 		platform_driver_unregister(&wdt_driver);
 		return PTR_ERR(wdt_pdev);

-- 
2.56.0

