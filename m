Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA253C9EE4;
	Sat, 25 Jul 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784975420; cv=none; b=mHgw+YeJucMC2byIUXUWV8dj7AafCG/HkaDthkNe3qKeBCyjGnS+wH1NsknBsa3G6ZvEh322EjPjD1qWFhcZfWSfIzYO/2tE8Ww3H+zNOrnDXFrPzskwgz2yBZTdNGxMy5tCA+SytpTU/DvpjHKU2gTXNoBgoMIVykfa4jJMVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784975420; c=relaxed/simple;
	bh=3cvtJLUz/dVS56PJIbQWtP0GgrruRgJwRp23g7NxiVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UQthiYjJMYhcZd42j4vGWErDid+vM1r24HbwH6MbKeL8bm8nxjs5+8fXdqPhDsd+WwHOQs6hGaLD2BnQz0UEPeyOOd/QHbD07Q0adVMH2knUbz8tTKZ0cJ/CAbmj9eaifkKiyjetC/7B+lcnGfJgzsT/jryiSU6zM+DBs3IcYPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EEGwn/SE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EEGwn/SE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D21804E40F53;
	Sat, 25 Jul 2026 10:30:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A73A160398;
	Sat, 25 Jul 2026 10:30:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 90CAC11C13101;
	Sat, 25 Jul 2026 12:30:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784975409; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kyFPTjvJH+Vzqv+p5O/W8djJtmPcw2Hk7t5a0qTE/pA=;
	b=EEGwn/SE/uilZOKI6RLx+QEu9+nBt/l/sChh7841u71YeKRchKY+w2R5OUHTX1LQqrpWHf
	g4Br3mvFIXagB4e3Uw6HD84ozWn8ub/lO0Fa0HbiWv2MSDQT3IZC6+ioj0WLtl2r/AnD3J
	o/L1OJ98CQb7WWcle0ebqAIIZR56AvVvjw0QtRmNNTtLJv1HGFa+AJe9cRO7oX891QQ9Di
	nU4bwNK/XdIHiGmLgML6IjfI0moQ+oj9Y+kmAO0UM+bO3i576L+DgBsZjr6fgl6iiTAVNe
	oPAtI2OJ18/VGU4vM20FMVI8pB4yoe00N0jf1sPAi5ADa1pSVeCJJT63Miy9dg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sat, 25 Jul 2026 12:29:33 +0200
Subject: [PATCH 6/9] watchdog: w83627hf_wdt: Store Super I/O unlocking
 sequence in platform data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260725-w83627hf_wdt-improvements-v1-6-4e9a1b4e8297@bootlin.com>
References: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
In-Reply-To: <20260725-w83627hf_wdt-improvements-v1-0-4e9a1b4e8297@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784975401; l=6561;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=3cvtJLUz/dVS56PJIbQWtP0GgrruRgJwRp23g7NxiVY=;
 b=9Wz0p6/dUVDDld0NU8kYDvjXHL7c7k4JsrlzAA9QLOz9TkxpVCmy3Zr7GZUeb3gyL7UkFjw+5
 0EDdVEHV/KfDfM5ruER5GX+vqFDt/AFGxCgPKfole31bsclZg8o022f
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Instead of using two global variable, store the unlocking sequence in the
platform data.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 58 +++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 6363d571182f..fed05fcf82bb 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -41,9 +41,6 @@
 #define WATCHDOG_NAME "w83627hf/thf/hg/dhg WDT"
 #define WATCHDOG_TIMEOUT 60		/* 60 sec default timeout */
 
-static int wdt_cfg_enter = 0x87;/* key to unlock configuration space */
-static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
-
 enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
 	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
 	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
@@ -121,7 +118,10 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
 #define WDT_CTRL_MINUTE_MODE		BIT(3)
 
-struct wdt_pdata {};
+struct wdt_pdata {
+	int siocfg_enter;
+	int siocfg_leave;
+};
 
 struct w83627hf_data {
 	struct watchdog_device wdd;
@@ -132,6 +132,8 @@ struct w83627hf_data {
 		int csr;
 	} reg;
 	int sioaddr;
+	int siocfg_enter;
+	int siocfg_leave;
 };
 
 static void superio_outb(int base, int reg, int val)
@@ -146,13 +148,13 @@ static inline int superio_inb(int base, int reg)
 	return inb(base + 1);
 }
 
-static int superio_enter(int base)
+static int superio_enter(int base, int enter)
 {
 	if (!request_muxed_region(base, 2, WATCHDOG_NAME))
 		return -EBUSY;
 
-	outb_p(wdt_cfg_enter, base); /* Enter extended function mode */
-	outb_p(wdt_cfg_enter, base); /* Again according to manual */
+	outb_p(enter, base); /* Enter extended function mode */
+	outb_p(enter, base); /* Again according to manual */
 
 	return 0;
 }
@@ -162,9 +164,9 @@ static void superio_select(int base, int ld)
 	superio_outb(base, SIO_REG_LDSEL, ld);
 }
 
-static void superio_exit(int base)
+static void superio_exit(int base, int leave)
 {
-	outb_p(wdt_cfg_leave, base); /* Leave extended function mode */
+	outb_p(leave, base); /* Leave extended function mode */
 	release_region(base, 2);
 }
 
@@ -174,7 +176,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	int ret;
 	unsigned char t;
 
-	ret = superio_enter(data->sioaddr);
+	ret = superio_enter(data->sioaddr, data->siocfg_enter);
 	if (ret)
 		return ret;
 
@@ -277,7 +279,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD_INT_RESET | WDT_CSR_MOUSE_INT_RESET);
 	superio_outb(data->sioaddr, data->reg.csr, t);
 
-	superio_exit(data->sioaddr);
+	superio_exit(data->sioaddr, data->siocfg_leave);
 
 	return 0;
 }
@@ -287,13 +289,13 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
 	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 
-	ret = superio_enter(data->sioaddr);
+	ret = superio_enter(data->sioaddr, data->siocfg_enter);
 	if (ret)
 		return ret;
 
 	superio_select(data->sioaddr, W83627HF_LD_WDT);
 	superio_outb(data->sioaddr, data->reg.timeout, timeout);
-	superio_exit(data->sioaddr);
+	superio_exit(data->sioaddr, data->siocfg_leave);
 
 	return 0;
 }
@@ -321,13 +323,13 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 	unsigned int timeleft;
 	int ret;
 
-	ret = superio_enter(data->sioaddr);
+	ret = superio_enter(data->sioaddr, data->siocfg_enter);
 	if (ret)
 		return 0;
 
 	superio_select(data->sioaddr, W83627HF_LD_WDT);
 	timeleft = superio_inb(data->sioaddr, data->reg.timeout);
-	superio_exit(data->sioaddr);
+	superio_exit(data->sioaddr, data->siocfg_leave);
 
 	return timeleft;
 }
@@ -349,12 +351,12 @@ static const struct watchdog_ops wdt_ops = {
  *	turn the timebomb registers off.
  */
 
-static int wdt_find(int addr)
+static int wdt_find(int addr, int enter, int leave)
 {
 	u8 val;
 	int ret;
 
-	ret = superio_enter(addr);
+	ret = superio_enter(addr, enter);
 	if (ret)
 		return ret;
 	superio_select(addr, W83627HF_LD_WDT);
@@ -441,13 +443,14 @@ static int wdt_find(int addr)
 		pr_err("Unsupported chip ID: 0x%02x\n", val);
 		break;
 	}
-	superio_exit(addr);
+	superio_exit(addr, leave);
 	return ret;
 }
 
 static int wdt_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
+	const struct wdt_pdata *pdata = pdev->dev.platform_data;
 	enum chips chip = id->driver_data;
 	struct watchdog_device *wdd;
 	struct w83627hf_data *data;
@@ -477,6 +480,8 @@ static int wdt_probe(struct platform_device *pdev)
 	wdd->max_timeout = 255;
 
 	data->sioaddr = res->start;
+	data->siocfg_enter = pdata->siocfg_enter;
+	data->siocfg_leave = pdata->siocfg_leave;
 	data->reg.timeout = W83627HF_WDT_TIMEOUT;
 	data->reg.control = W83627HF_WDT_CONTROL;
 	data->reg.csr = W836X7HF_WDT_CSR;
@@ -520,12 +525,16 @@ static int wdt_probe(struct platform_device *pdev)
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
@@ -535,6 +544,7 @@ static const struct dmi_system_id wdt_dmi_table[] __initconst = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SHARKBAY"),
 		},
 		.callback = wdt_use_alt_key,
+		.driver_data = &pdata,
 	},
 	{}
 };
@@ -579,20 +589,22 @@ static struct platform_device *wdt_pdev;
 
 static int __init wdt_init(void)
 {
-	struct wdt_pdata pdata;
 	struct resource res;
 	int sioaddr;
 	int ret;
 	int chip;
 
+	pdata.siocfg_enter = 0x87;
+	pdata.siocfg_leave = 0xAA;
+
 	/* Apply system-specific quirks */
 	dmi_check_system(wdt_dmi_table);
 
 	sioaddr = SIO_REG_CONF_ADDR0;
-	chip = wdt_find(sioaddr);
+	chip = wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
 	if (chip < 0) {
 		sioaddr = SIO_REG_CONF_ADDR1;
-		chip = wdt_find(sioaddr);
+		chip = wdt_find(sioaddr, pdata.siocfg_enter, pdata.siocfg_leave);
 		if (chip < 0)
 			return chip;
 	}

-- 
2.55.0

