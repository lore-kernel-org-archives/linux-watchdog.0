Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBA3AE18D;
	Sat, 25 Jul 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975415; cv=none; b=HnmBm1jLAQ+OhFUSF9r+1j00hCPvLqGsutKc/Vknl5E6dX2hbUpHbFyGfLXaZpLWRW3sMW+yytPQ3p4pkE70nrog4FETL1ACq00gjhvg1QxiwAbXABe9pfwOt1i8wWyvSFCNIkMFJPmPBopFG+zbfaCBWlhWMrji8JclzfAuIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975415; c=relaxed/simple;
	bh=5ME2ZmnwNMeLCB+iGWcCeBEmq4Nn5wlbmL+SlMJfOTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A2lrYl3j2L4b8QMEzOU6YDDfQCGs/FZKABc0BW2DCvSy4mQXWYZPe5cG8uMdNWVwAE7hcvZltPfPyptN2HDXTU7ZP19CEKQkexqFETAQw1R5NNKIU4z5y8F0glqJwSGSa0OZx9YQmIlEEWFYDVleYKfAIRYhtmjQIIK1p9KkT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HJKPSmR8; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HJKPSmR8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 03FA64E40F51;
	Sat, 25 Jul 2026 10:30:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD5B260398;
	Sat, 25 Jul 2026 10:30:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A78DE11C13100;
	Sat, 25 Jul 2026 12:30:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975408; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=47KE1V0qn2e4jO9/9XvXrTFGh3ijmHTDpYc275Pj8Y8=;
	b=HJKPSmR8MM1o8UenjDgRSh9mTX7J8Bv9uMac67MITODseSTQhWcejmHV3cUKWmsNmI3jci
	+xu1srBG5bcjAw0Ol/EESZUSXJOywZmo5K2HCpmh/ki7eRjPzF5jUoO2DV3+5sCWthzabr
	q5VO+lO5SsVE+s5oPgFxv2C498TZ/fmHwE1gZTe6mHn/ivvwQekTdnmovG8c/N7toMOcED
	Wmy5Ujfug/PN/AsvK8FaIKlVfU0WCpsGDGzl55TOspW5YA4CFjUTdoZtpt90/TiFCrJ81P
	AFLLw5tdz42gjNVNqsKLNjQEZNmuqQDr6hmSDUz/Yu5MggzDO+ciNE/vjTAJPQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sat, 25 Jul 2026 12:29:32 +0200
Subject: [PATCH 5/9] watchdog: w83627hf_wdt: Add Super I/O configuration
 port as a platform device resource
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-w83627hf_wdt-improvements-v1-5-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=10978;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=5ME2ZmnwNMeLCB+iGWcCeBEmq4Nn5wlbmL+SlMJfOTE=;
 b=Yh3988/n1nMCP2UmxiIsEQ81gvwqIM9RSRVX6rWPABo3B6lIt1kiH6BWCzttcAGp/dyd1Fdpe
 scauZ7biretB7/VOgVdt1ge00cJkSEzN9HNh6mfBx685AmPAZRQgDz7
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

The Super I/O configuration port address is a global variable.
Instead, use a platform device resource.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 146 +++++++++++++++++++++-------------------
 1 file changed, 77 insertions(+), 69 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index f5333c432198..6363d571182f 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -41,7 +41,6 @@
 #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
 #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
 
-static int wdt_io;
 static int wdt_cfg_enter = 0x87;/* key to unlock configuration space */
 static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
 
@@ -76,11 +75,6 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define SIO_REG_CONF_ADDR0	0x2E
 #define SIO_REG_CONF_ADDR1	0x4E
 
-#define WDT_EFER (wdt_io+0)   /* Extended Function Enable Registers */
-#define WDT_EFIR (wdt_io+0)   /* Extended Function Index Register
-							(same as EFER) */
-#define WDT_EFDR (WDT_EFIR+1) /* Extended Function Data Register */
-
 #define W83627HF_LD_WDT		0x08
 
 #define W83627HF_ID		0x52
@@ -137,40 +131,41 @@ struct w83627hf_data {
 		int timeout;
 		int csr;
 	} reg;
+	int sioaddr;
 };
 
-static void superio_outb(int reg, int val)
+static void superio_outb(int base, int reg, int val)
 {
-	outb(reg, WDT_EFER);
-	outb(val, WDT_EFDR);
+	outb(reg, base);
+	outb(val, base + 1);
 }
 
-static inline int superio_inb(int reg)
+static inline int superio_inb(int base, int reg)
 {
-	outb(reg, WDT_EFER);
-	return inb(WDT_EFDR);
+	outb(reg, base);
+	return inb(base + 1);
 }
 
-static int superio_enter(void)
+static int superio_enter(int base)
 {
-	if (!request_muxed_region(wdt_io, 2, WATCHDOG_NAME))
+	if (!request_muxed_region(base, 2, WATCHDOG_NAME))
 		return -EBUSY;
 
-	outb_p(wdt_cfg_enter, WDT_EFER); /* Enter extended function mode */
-	outb_p(wdt_cfg_enter, WDT_EFER); /* Again according to manual */
+	outb_p(wdt_cfg_enter, base); /* Enter extended function mode */
+	outb_p(wdt_cfg_enter, base); /* Again according to manual */
 
 	return 0;
 }
 
-static void superio_select(int ld)
+static void superio_select(int base, int ld)
 {
-	superio_outb(SIO_REG_LDSEL, ld);
+	superio_outb(base, SIO_REG_LDSEL, ld);
 }
 
-static void superio_exit(void)
+static void superio_exit(int base)
 {
-	outb_p(wdt_cfg_leave, WDT_EFER); /* Leave extended function mode */
-	release_region(wdt_io, 2);
+	outb_p(wdt_cfg_leave, base); /* Leave extended function mode */
+	release_region(base, 2);
 }
 
 static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
@@ -179,52 +174,52 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	int ret;
 	unsigned char t;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sioaddr);
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
@@ -247,42 +242,42 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
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
+	superio_exit(data->sioaddr);
 
 	return 0;
 }
@@ -292,13 +287,13 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sioaddr);
 	if (ret)
 		return ret;
 
-	superio_select(W83627HF_LD_WDT);
-	superio_outb(data->reg.timeout, timeout);
-	superio_exit();
+	superio_select(data->sioaddr, W83627HF_LD_WDT);
+	superio_outb(data->sioaddr, data->reg.timeout, timeout);
+	superio_exit(data->sioaddr);
 
 	return 0;
 }
@@ -326,13 +321,13 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 	unsigned int timeleft;
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(data->sioaddr);
 	if (ret)
 		return 0;
 
-	superio_select(W83627HF_LD_WDT);
-	timeleft = superio_inb(data->reg.timeout);
-	superio_exit();
+	superio_select(data->sioaddr, W83627HF_LD_WDT);
+	timeleft = superio_inb(data->sioaddr, data->reg.timeout);
+	superio_exit(data->sioaddr);
 
 	return timeleft;
 }
@@ -359,11 +354,11 @@ static int wdt_find(int addr)
 	u8 val;
 	int ret;
 
-	ret = superio_enter();
+	ret = superio_enter(addr);
 	if (ret)
 		return ret;
-	superio_select(W83627HF_LD_WDT);
-	val = superio_inb(SIO_REG_DEVID);
+	superio_select(addr, W83627HF_LD_WDT);
+	val = superio_inb(addr, SIO_REG_DEVID);
 	switch (val) {
 	case W83627HF_ID:
 		ret = w83627hf;
@@ -432,7 +427,7 @@ static int wdt_find(int addr)
 		ret = nct6102;
 		break;
 	case NCT6116_ID:
-		val = superio_inb(SIO_REG_DEVID + 1);
+		val = superio_inb(addr, SIO_REG_DEVID + 1);
 		if (val == NCT6126_VER_A_LOW_ID || val == NCT6126_VER_B_LOW_ID)
 			ret = nct6126;
 		else
@@ -446,7 +441,7 @@ static int wdt_find(int addr)
 		pr_err("Unsupported chip ID: 0x%02x\n", val);
 		break;
 	}
-	superio_exit();
+	superio_exit(addr);
 	return ret;
 }
 
@@ -456,10 +451,15 @@ static int wdt_probe(struct platform_device *pdev)
 	enum chips chip = id->driver_data;
 	struct watchdog_device *wdd;
 	struct w83627hf_data *data;
+	struct resource *res;
 	int ret;
 
 	pr_info("WDT driver for %s Super I/O chip initialising\n", id->name);
 
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (!res)
+		return -ENXIO;
+
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
@@ -476,6 +476,7 @@ static int wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout = 1;
 	wdd->max_timeout = 255;
 
+	data->sioaddr = res->start;
 	data->reg.timeout = W83627HF_WDT_TIMEOUT;
 	data->reg.control = W83627HF_WDT_CONTROL;
 	data->reg.csr = W836X7HF_WDT_CSR;
@@ -579,17 +580,19 @@ static struct platform_device *wdt_pdev;
 static int __init wdt_init(void)
 {
 	struct wdt_pdata pdata;
+	struct resource res;
+	int sioaddr;
 	int ret;
 	int chip;
 
 	/* Apply system-specific quirks */
 	dmi_check_system(wdt_dmi_table);
 
-	wdt_io = SIO_REG_CONF_ADDR0;
-	chip = wdt_find(SIO_REG_CONF_ADDR0);
+	sioaddr = SIO_REG_CONF_ADDR0;
+	chip = wdt_find(sioaddr);
 	if (chip < 0) {
-		wdt_io = SIO_REG_CONF_ADDR1;
-		chip = wdt_find(SIO_REG_CONF_ADDR1);
+		sioaddr = SIO_REG_CONF_ADDR1;
+		chip = wdt_find(sioaddr);
 		if (chip < 0)
 			return chip;
 	}
@@ -598,9 +601,14 @@ static int __init wdt_init(void)
 	if (ret)
 		return ret;
 
-	wdt_pdev = platform_device_register_data(NULL, wdt_ids[chip].name,
-						 PLATFORM_DEVID_NONE, &pdata,
-						 sizeof(pdata));
+	res.name = "Super I/O port";
+	res.flags = IORESOURCE_IO;
+	res.start = sioaddr;
+	res.end = sioaddr + 1;
+
+	wdt_pdev = platform_device_register_resndata(NULL, wdt_ids[chip].name,
+						     PLATFORM_DEVID_NONE, &res,
+						     1, &pdata, sizeof(pdata));
 	if (IS_ERR(wdt_pdev)) {
 		platform_driver_unregister(&wdt_driver);
 		return PTR_ERR(wdt_pdev);

-- 
2.55.0

