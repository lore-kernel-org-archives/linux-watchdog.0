Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DA43CEF8;
	Sun,  4 Oct 2026 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116003; cv=none; b=tRbXeA+N16AVCrCLXqGfG7CfKH9K241mO2J4xlY5dZOtIQ4hk0JOStVsKt50sFFQyPfl6Je+Ij5iQQTkMJvnA228Q4MiqYEfSelzYC3SsGsazBvXC2pJKVCnzGSa6mpMQmDRo95KLn6yby5gm07v2TKqELPU4a4eKpmk3cNDaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116003; c=relaxed/simple;
	bh=pPnBwBH7WMyKHTvVMD3cVlnsIcuXKL71WdEv3BqwZZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcvKCER8WFxAxcH43w5N8Xk7skcFrqwotC9GZppWbRY8CaDKpHvm+8VAo0WIqPLsJcKluZtwcddzKqLsOpKTeDb3VpUQt/SgtYrY36JuJ8k+mMNhyeppZGf+Wq/BcLPZF5SSruJ57AwfInJz2z/UzunQbEDPyGOlQeau6fgI4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HSKvrShv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HSKvrShv"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4A85E4E4115A;
	Sun,  4 Oct 2026 12:13:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FC21604FE;
	Sun,  4 Oct 2026 12:13:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4FAA1032820F;
	Sun,  4 Oct 2026 14:13:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791115998; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hWjKDDFEf9/cmSXZw0lrzdeadRh/tBTTwGeiO7x+syg=;
	b=HSKvrShvmcf1hYkBzKtwNWZ9RARARdxJOiie9i39Mdh4wcEoEljugxlexof0AoTg9fN9NL
	uMeeWPOWPyZ2EXDw0kWs5uXHkUPP8szqPYMUcs3XCaHGT7yMsYEYmUkesKGAMhPJZGQYu0
	vlMonGk48bNbhiJ5Q0ejWa6oAhHIedpXJKuu28vQLcd0I9arMduyBcM52dmRgX4fU/YRvA
	VQ0Xlz8l97KQikZ8uhAfM4BhR3TisE3EbF84AaEaUn4fAyTS5Bo/q/3U4CewKzi+hgabN9
	H1/zngpwcHXLLy2T8pr05IqkZeWiskBd+yc2FNufUJ2IlyseAAI9kvgvDz+9dQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 04 Oct 2026 14:12:52 +0200
Subject: [PATCH v3 4/6] watchdog: w83627hf_wdt: Store Super I/O
 configurations in platform data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-w83627hf_wdt-improvements-v3-4-8e27b518595e@bootlin.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791115992; l=12725;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=pPnBwBH7WMyKHTvVMD3cVlnsIcuXKL71WdEv3BqwZZY=;
 b=7HgKng7sfc1MObTbI6gqOfBLdB4tZh7g4asN+vzd9zfwyzZpwCLVfBiVlHlyMAT81RKzNGx7g
 0id9zHIZLSvAS4EObJ4OkrDWYrfZrNIo07Cr0ZSbzRfn5tehpvmgOXm
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Instead of using global variables, store Super I/O related
configurations in platform data.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 156 +++++++++++++++++++++++-----------------
 1 file changed, 89 insertions(+), 67 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 44ec2f2e23ea..1ef7b61d7e55 100644
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
 #define SIO_REG_CONF_ADDR0	0x2E
 #define SIO_REG_CONF_ADDR1	0x4E
 
-#define WDT_EFER (wdt_io+0)   /* Extended Function Enable Registers */
-#define WDT_EFIR (wdt_io+0)   /* Extended Function Index Register
-							(same as EFER) */
+#define WDT_EFER (base+0)   /* Extended Function Enable Registers */
+#define WDT_EFIR (base+0)   /* Extended Function Index Register (same as EFER) */
 #define WDT_EFDR (WDT_EFIR+1) /* Extended Function Data Register */
 
 #define W83627HF_LD_WDT		0x08
@@ -127,6 +122,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
 #define WDT_CTRL_MINUTE_MODE		BIT(3)
 
+struct wdt_pdata {
+	int sioaddr;
+	int siocfg_enter;
+	int siocfg_leave;
+};
+
 struct w83627hf_data {
 	struct watchdog_device wdd;
 	struct watchdog_info info;
@@ -135,40 +136,43 @@ struct w83627hf_data {
 		int timeout;
 		int csr;
 	} reg;
+	int sioaddr;
+	int siocfg_enter;
+	int siocfg_leave;
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
@@ -177,52 +181,52 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	int ret;
 	unsigned char t;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sioaddr, data->siocfg_enter);
 	if (ret)
 		return ret;
 
-	superio_select(W83627HF_LD_WDT);
+	superio_select(data->sioaddr, W83627HF_LD_WDT);
 
 	/* set CR30 bit 0 to activate GPIO2 */
-	t = superio_inb(SIO_REG_ENABLE);
+	t = superio_inb(data->sioaddr, SIO_REG_ENABLE);
 	if (!(t & 0x01))
-		superio_outb(SIO_REG_ENABLE, t | 0x01);
+		superio_outb(data->sioaddr, SIO_REG_ENABLE, t | 0x01);
 
 	switch (chip) {
 	case w83627hf:
 	case w83627s:
-		t = superio_inb(0x2B) & ~0x10;
-		superio_outb(0x2B, t); /* set GPIO24 to WDT0 */
+		t = superio_inb(data->sioaddr, 0x2B) & ~0x10;
+		superio_outb(data->sioaddr, 0x2B, t); /* set GPIO24 to WDT0 */
 		break;
 	case w83697hf:
 		/* Set pin 119 to WDTO# mode (= CR29, WDT0) */
-		t = superio_inb(0x29) & ~0x60;
+		t = superio_inb(data->sioaddr, 0x29) & ~0x60;
 		t |= 0x20;
-		superio_outb(0x29, t);
+		superio_outb(data->sioaddr, 0x29, t);
 		break;
 	case w83697ug:
 		/* Set pin 118 to WDTO# mode */
-		t = superio_inb(0x2b) & ~0x04;
-		superio_outb(0x2b, t);
+		t = superio_inb(data->sioaddr, 0x2b) & ~0x04;
+		superio_outb(data->sioaddr, 0x2b, t);
 		break;
 	case w83627thf:
-		t = (superio_inb(0x2B) & ~0x08) | 0x04;
-		superio_outb(0x2B, t); /* set GPIO3 to WDT0 */
+		t = (superio_inb(data->sioaddr, 0x2B) & ~0x08) | 0x04;
+		superio_outb(data->sioaddr, 0x2B, t); /* set GPIO3 to WDT0 */
 		break;
 	case w83627dhg:
 	case w83627dhg_p:
-		t = superio_inb(0x2D) & ~0x01; /* PIN77 -> WDT0# */
-		superio_outb(0x2D, t); /* set GPIO5 to WDT0 */
-		t = superio_inb(data->reg.control);
+		t = superio_inb(data->sioaddr, 0x2D) & ~0x01; /* PIN77 -> WDT0# */
+		superio_outb(data->sioaddr, 0x2D, t); /* set GPIO5 to WDT0 */
+		t = superio_inb(data->sioaddr, data->reg.control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(data->reg.control, t);
+		superio_outb(data->sioaddr, data->reg.control, t);
 		break;
 	case w83637hf:
 		break;
 	case w83687thf:
-		t = superio_inb(0x2C) & ~0x80; /* PIN47 -> WDT0# */
-		superio_outb(0x2C, t);
+		t = superio_inb(data->sioaddr, 0x2C) & ~0x80; /* PIN47 -> WDT0# */
+		superio_outb(data->sioaddr, 0x2C, t);
 		break;
 	case w83627ehf:
 	case w83627uhg:
@@ -245,42 +249,42 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		 * Don't touch its configuration, and hope the BIOS
 		 * does the right thing.
 		 */
-		t = superio_inb(data->reg.control);
+		t = superio_inb(data->sioaddr, data->reg.control);
 		t |= 0x02;	/* enable the WDTO# output low pulse
 				 * to the KBRST# pin */
-		superio_outb(data->reg.control, t);
+		superio_outb(data->sioaddr, data->reg.control, t);
 		break;
 	default:
 		break;
 	}
 
-	t = superio_inb(data->reg.timeout);
+	t = superio_inb(data->sioaddr, data->reg.timeout);
 	if (t != 0) {
 		if (early_disable) {
 			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
-			superio_outb(data->reg.timeout, 0);
+			superio_outb(data->sioaddr, data->reg.timeout, 0);
 		} else {
 			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
 				wdog->timeout);
-			superio_outb(data->reg.timeout, wdog->timeout);
+			superio_outb(data->sioaddr, data->reg.timeout, wdog->timeout);
 			set_bit(WDOG_HW_RUNNING, &wdog->status);
 		}
 	}
 
 	/* set second mode & disable keyboard reset turning off watchdog */
-	t = superio_inb(data->reg.control) &
+	t = superio_inb(data->sioaddr, data->reg.control) &
 	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
-	superio_outb(data->reg.control, t);
+	superio_outb(data->sioaddr, data->reg.control, t);
 
-	t = superio_inb(data->reg.csr);
+	t = superio_inb(data->sioaddr, data->reg.csr);
 	if (t & WDT_CSR_STATUS)
 		wdog->bootstatus |= WDIOF_CARDRESET;
 
 	/* reset status, disable keyboard & mouse interrupt turning off watchdog */
 	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD_INT_RESET | WDT_CSR_MOUSE_INT_RESET);
-	superio_outb(data->reg.csr, t);
+	superio_outb(data->sioaddr, data->reg.csr, t);
 
-	superio_exit();
+	superio_exit(data->sioaddr, data->siocfg_leave);
 
 	return 0;
 }
@@ -290,13 +294,13 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sioaddr, data->siocfg_enter);
 	if (ret)
 		return ret;
 
-	superio_select(W83627HF_LD_WDT);
-	superio_outb(data->reg.timeout, timeout);
-	superio_exit();
+	superio_select(data->sioaddr, W83627HF_LD_WDT);
+	superio_outb(data->sioaddr, data->reg.timeout, timeout);
+	superio_exit(data->sioaddr, data->siocfg_leave);
 
 	return 0;
 }
@@ -324,13 +328,13 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 	unsigned int timeleft;
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sioaddr, data->siocfg_enter);
 	if (ret)
 		return 0;
 
-	superio_select(W83627HF_LD_WDT);
-	timeleft = superio_inb(data->reg.timeout);
-	superio_exit();
+	superio_select(data->sioaddr, W83627HF_LD_WDT);
+	timeleft = superio_inb(data->sioaddr, data->reg.timeout);
+	superio_exit(data->sioaddr, data->siocfg_leave);
 
 	return timeleft;
 }
@@ -352,16 +356,16 @@ static const struct watchdog_ops wdt_ops = {
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
@@ -430,7 +434,7 @@ static int wdt_find(int addr)
 		ret = nct6102;
 		break;
 	case NCT6116_ID:
-		val = superio_inb(SIO_REG_DEVID + 1);
+		val = superio_inb(addr, SIO_REG_DEVID + 1);
 		if (val == NCT6126_VER_A_LOW_ID || val == NCT6126_VER_B_LOW_ID)
 			ret = nct6126;
 		else
@@ -444,13 +448,14 @@ static int wdt_find(int addr)
 		pr_err("Unsupported chip ID: 0x%02x\n", val);
 		break;
 	}
-	superio_exit();
+	superio_exit(addr, leave);
 	return ret;
 }
 
 static int wdt_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
+	const struct wdt_pdata *pdata = pdev->dev.platform_data;
 	struct device *dev = &pdev->dev;
 	struct watchdog_device *wdd;
 	struct w83627hf_data *data;
@@ -462,6 +467,9 @@ static int wdt_probe(struct platform_device *pdev)
 	if (!id)
 		return dev_err_probe(dev, -EINVAL, "failed to get chip id\n");
 
+	if (!pdata)
+		return dev_err_probe(dev, -EINVAL, "failed to get pdata\n");
+
 	chip = id->driver_data;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
@@ -481,6 +489,9 @@ static int wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout = 1;
 	wdd->max_timeout = 255;
 
+	data->sioaddr = pdata->sioaddr;
+	data->siocfg_enter = pdata->siocfg_enter;
+	data->siocfg_leave = pdata->siocfg_leave;
 	data->reg.timeout = W83627HF_WDT_TIMEOUT;
 	data->reg.control = W83627HF_WDT_CONTROL;
 	data->reg.csr = W836X7HF_WDT_CSR;
@@ -522,12 +533,16 @@ static int wdt_probe(struct platform_device *pdev)
  */
 static int __init wdt_use_alt_key(const struct dmi_system_id *d)
 {
-	wdt_cfg_enter = 0x88;
-	wdt_cfg_leave = 0xBB;
+	struct wdt_pdata *pdata = d->driver_data;
+
+	pdata->siocfg_enter = 0x88;
+	pdata->siocfg_leave = 0xBB;
 
 	return 0;
 }
 
+static struct wdt_pdata pdata;
+
 static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 	{
 		.matches = {
@@ -537,6 +552,7 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
 		},
 		.callback = wdt_use_alt_key,
+		.driver_data = &pdata,
 	},
 	{}
 };
@@ -581,27 +597,33 @@ static struct platform_device *wdt_pdev;
 
 static int __init wdt_init(void)
 {
+	int sioaddr;
 	int ret;
 	int chip;
 
+	pdata.siocfg_enter = 0x87;
+	pdata.siocfg_leave = 0xAA;
+
 	/* Apply system-specific quirks */
 	dmi_check_system(wdt_dmi_table);
 
-	wdt_io = SIO_REG_CONF_ADDR0;
-	chip = wdt_find(SIO_REG_CONF_ADDR0);
+	sioaddr = SIO_REG_CONF_ADDR0;
+	chip = wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
 	if (chip < 0) {
-		wdt_io = SIO_REG_CONF_ADDR1;
-		chip = wdt_find(SIO_REG_CONF_ADDR1);
+		sioaddr = SIO_REG_CONF_ADDR1;
+		chip = wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
 		if (chip < 0)
 			return chip;
 	}
 
+	pdata.sioaddr = sioaddr;
+
 	ret = platform_driver_register(&wdt_driver);
 	if (ret)
 		return ret;
 
 	wdt_pdev = platform_device_register_data(NULL, wdt_ids[chip].name,
-						 PLATFORM_DEVID_NONE, NULL, 0);
+						 PLATFORM_DEVID_NONE, &pdata, sizeof(pdata));
 	if (IS_ERR(wdt_pdev)) {
 		platform_driver_unregister(&wdt_driver);
 		return PTR_ERR(wdt_pdev);

-- 
2.55.0

