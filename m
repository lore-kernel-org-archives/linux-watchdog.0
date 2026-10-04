Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F373429CD2;
	Sun,  4 Oct 2026 12:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116001; cv=none; b=hb7kNipVLX+Z4N9jcbPna8Oq2ON/8nlJGMLuS7SolC19PlQVRI0/jxgt13JGnnBWbozT8x9cievwcIbBokfz/K63YGKMue7N70AspYk6RtS6XcnAJ3etJxq2BpFPzzJljjNXl7briH+zvGn/+3Tk1VCdyQKYYrFX2NNzOMP5zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116001; c=relaxed/simple;
	bh=4gK/fOFuxLXC/7umhlpruAqomG7lEm8nMcpP8hretlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gdr4OKvQOnQkE4HDjbeOhTc9ITXv2L2AQ7SbjCGP0Ox6VxNBx+xRZtlEQxyDoZ5bgty0C2Vf+2YQ5beZCLel2nc+L7vdBB0b0+ab+gvdT8cngVD13KeEubSFQo0O5CIec0K3B8uqlriK9RNNZsDEZPZaT95epmY/ltDLnOUOnpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pUJobdid; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pUJobdid"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E40691A10F1;
	Sun,  4 Oct 2026 12:13:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B9F52604FE;
	Sun,  4 Oct 2026 12:13:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D2E2103281F4;
	Sun,  4 Oct 2026 14:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791115997; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ur/0p1Mzsm58fvk7TxPDDHvz4BGDQwdZHyw6H+hLngM=;
	b=pUJobdidwnOPs2QDpqMGl2FrnJ6kmWF5jfi3SGsFrhh9c+KK7ZmqZ/8ExAuxbELf1rfmBG
	OxnH6B9adQSTRJ3NEyQtIM4uYOcOf+QUkcjMvkIA5cOVZSorlDuI0nzcZJKCsAwh9W7KW8
	z3+RODgCdykB/H+XYziSfrwBd46QkhMJwkhGgVkdujMyrUT1CFHI2URrZrrFl3XqDj0Ds4
	KR12WP90RHLn/gb2u02wB8Y0neoVl34oT0LzURIqUTIxW4o6dNM0PQDb3hChD8TpLo5ibR
	uKEiiTw+0bmfox8/FtsEzTEqSCUOwYdHAv4IDshXUmBxmfqMR0p5Hf7Enr3wzg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 04 Oct 2026 14:12:51 +0200
Subject: [PATCH v3 3/6] watchdog: w83627hf_wdt: Move register offsets into
 driver data
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-w83627hf_wdt-improvements-v3-3-8e27b518595e@bootlin.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791115992; l=7119;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=4gK/fOFuxLXC/7umhlpruAqomG7lEm8nMcpP8hretlg=;
 b=tHk095M2rKKyUGp4CuwrUEzyMqh3x1P7/hb+zHje7vdbtBvQ9HIptRjBIW0PEFjK7jlCWvE9P
 JgNo8QOR0OFBKBv6lhmu5Ysfzm5YgBZU6dXMMKJ3JkIWdlLgFU+t+OS
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
index 57f5c000f276..44ec2f2e23ea 100644
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
 
@@ -133,6 +130,11 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
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
@@ -171,6 +173,7 @@ static void superio_exit(void)
 
 static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	int ret;
 	unsigned char t;
 
@@ -210,10 +213,10 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
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
@@ -242,48 +245,49 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
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
@@ -291,7 +295,7 @@ static int wdt_set_time(unsigned int timeout)
 		return ret;
 
 	superio_select(W83627HF_LD_WDT);
-	superio_outb(cr_wdt_timeout, timeout);
+	superio_outb(data->reg.timeout, timeout);
 	superio_exit();
 
 	return 0;
@@ -299,12 +303,12 @@ static int wdt_set_time(unsigned int timeout)
 
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
@@ -316,6 +320,7 @@ static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
 
 static unsigned int wdt_get_time(struct watchdog_device *wdog)
 {
+	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
 	unsigned int timeleft;
 	int ret;
 
@@ -324,7 +329,7 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
 		return 0;
 
 	superio_select(W83627HF_LD_WDT);
-	timeleft = superio_inb(cr_wdt_timeout);
+	timeleft = superio_inb(data->reg.timeout);
 	superio_exit();
 
 	return timeleft;
@@ -352,10 +357,6 @@ static int wdt_find(int addr)
 	u8 val;
 	int ret;
 
-	cr_wdt_timeout = W83627HF_WDT_TIMEOUT;
-	cr_wdt_control = W83627HF_WDT_CONTROL;
-	cr_wdt_csr = W836X7HF_WDT_CSR;
-
 	ret = superio_enter();
 	if (ret)
 		return ret;
@@ -370,13 +371,9 @@ static int wdt_find(int addr)
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
@@ -431,9 +428,6 @@ static int wdt_find(int addr)
 		break;
 	case NCT6102_ID:
 		ret = nct6102;
-		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
-		cr_wdt_control = NCT6102D_WDT_CONTROL;
-		cr_wdt_csr = NCT6102D_WDT_CSR;
 		break;
 	case NCT6116_ID:
 		val = superio_inb(SIO_REG_DEVID + 1);
@@ -441,10 +435,6 @@ static int wdt_find(int addr)
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
@@ -491,6 +481,21 @@ static int wdt_probe(struct platform_device *pdev)
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

