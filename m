Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792483955;
	b=mrED9NRPO+uMFGgwX4yfC/znAj+OnoIUP/AhA0C0tMDT9imSQg1TiEPZYVNzoCTE1RxU
	 /HnLIid2lU0MK1tWOKi4irT+i4DblZkPfv35TMYeWiDoC8ktq8zSJP4gV//nN+6SgkSZb
	 IffKaM+pQRWMxtL7uDYUNc+yHwiAw1qCm0e2rOA9zPDvz3z5R1si58q+RaPxN/vYGXC40
	 aPsNJxUWQ4L/4siaIbCRkEqmA2ByZWsXEBAc4FDEsffS+7ByIkIi0KHUwAodg9KAiKB3j
	 Sqq/I4I/wKQ6lBYFSFYUF79SlZNZPkZfsj1iafe3U6Ud8YklFbf09GpneJHU0PBgebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792483955;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Last-TLS-Session-Version;
	bh=B3uMwlL2e0WwbW2iwPu4EXtN34mpgk+5/6RVJb8Z1iM=;
	b=Vly3GJdwFD+fGva76+YPRO1lfq00YXUmgKHOjgtyegPXcm4LCZsSYAT7rvkn+KFRaLpC
	 9Cc+6sKb0+o9DsGm4YLE7f0ByjgXagNL9oDKvtEqA1mAQB5vw6L9gLvrO7kfUO4+wkwG+
	 3PdYGd89nwfU6Ksbmpmkdnt9yePGSN4aG7DNM4SbE1pXLXk4GoPxARBWMKnTRR2qqjEV/
	 CA8DojTyySMQA21k1lnoNone2lM44n+ls7V9Sy5K6DJrK0Ra8ssrofKXaOUXSGeMcz35I
	 ekpyTg4p984VZZKYa3y5hzLFHvM4Dj6a1vjzpdCJoDr8jFU5b5hu8rqe0FiMvKXnuaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TdE8rrpb;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24FA606A31F
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 08:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D24FA606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TdE8rrpb
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 55F034E4128E;
	Tue, 20 Oct 2026 08:12:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2B36E60393;
	Tue, 20 Oct 2026 08:12:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4D6FC10328D80;
	Tue, 20 Oct 2026 10:12:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792483951; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B3uMwlL2e0WwbW2iwPu4EXtN34mpgk+5/6RVJb8Z1iM=;
	b=TdE8rrpbke2FBHPaslAw6LNrUoOpOAViXV9YzO25cJAB9uFQ2dbVIm09AIhTh0mehyedJ5
	DTS2i0PX6C9tPdF6pp9JCC7rfrR2snnIqXX0QM5A4q6rNuFZYlhi7oJvB5FW20j5mNeUvd
	Erd7H7yH1e6LLPrger7ErkARig8j1Mh3RlGxGAHjw0RqciDHXdh3w8T5/1hAhSsYqxOs5q
	3YhUHxzdiBKXKfXjRyn40c7qy6lDfDdaEaZfuA8zgcZFsFR0N8o1XCzLQZOrG6J/otZjHQ
	/dU+vk8/B8nUC6dTd9baT5QH7UfrSGcx+8Qkq4BnNLgygInMocIfEi4P+l2fUg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 20 Oct 2026 10:11:54 +0200
Subject: [PATCH v5 1/5] watchdog: w83627hf_wdt: Replace magic numbers with
 descriptive macros
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
Message-Id: <20261020-w83627hf_wdt-improvements-v5-1-90b226684fc7@bootlin.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792483947; l=4210;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=qXG1MXzCoF7pMSNABWaRFVOFzBpOTIDybA96c/TBmq0=;
 b=Qz7sLZo5luW4dCh12Lo4D4MDLAo0TgJWjfos4ZoCMzsuh2STgZjkMIKymp7TiSF30lz39SMs0
 WiSsfkBrI7FCHmuXy3IMKxzmqhQbNUKyeC1AfTMLirTRoPlbCCxE7zz
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Raw hex values for Super I/O register addresses are difficult to
understand without constantly consulting the datasheet. Use named macros
instead.
Also, replace macros value that contains bit position with the BIT()
macro.
Remove comments that doesn't help understanding the code.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/watchdog/w83627hf_wdt.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index db77599e43a0..fa1808a4c6c8 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -27,6 +27,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -71,6 +72,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
  *	Kernel methods.
  */
 
+#define SIO_REG_LDSEL		0x07	/* Logical device select */
+#define SIO_REG_DEVID		0x20	/* Device ID (1 or 2 bytes) */
+#define SIO_REG_ENABLE		0x30	/* Logical device enable */
+#define SIO_CONF_PORT0		0x2E
+#define SIO_CONF_PORT1		0x4E
+
 #define WDT_EFER (wdt_io+0)   /* Extended Function Enable Registers */
 #define WDT_EFIR (wdt_io+0)   /* Extended Function Index Register
 							(same as EFER) */
@@ -115,9 +122,12 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
 #define W836X7HF_WDT_CSR	0xf7
 #define NCT6102D_WDT_CSR	0xf2
 
-#define WDT_CSR_STATUS		0x10
-#define WDT_CSR_KBD		0x40
-#define WDT_CSR_MOUSE		0x80
+#define WDT_CSR_STATUS		BIT(4)
+#define WDT_CSR_KBD_INT_RESET	BIT(6)
+#define WDT_CSR_MOUSE_INT_RESET	BIT(7)
+
+#define WDT_CTRL_RISING_EDGE_KBD_RESET	BIT(2)
+#define WDT_CTRL_MINUTE_MODE		BIT(3)
 
 static void superio_outb(int reg, int val)
 {
@@ -144,7 +154,7 @@ static int superio_enter(void)
 
 static void superio_select(int ld)
 {
-	superio_outb(0x07, ld);
+	superio_outb(SIO_REG_LDSEL, ld);
 }
 
 static void superio_exit(void)
@@ -165,9 +175,9 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 	superio_select(W83627HF_LD_WDT);
 
 	/* set CR30 bit 0 to activate GPIO2 */
-	t = superio_inb(0x30);
+	t = superio_inb(SIO_REG_ENABLE);
 	if (!(t & 0x01))
-		superio_outb(0x30, t | 0x01);
+		superio_outb(SIO_REG_ENABLE, t | 0x01);
 
 	switch (chip) {
 	case w83627hf:
@@ -248,16 +258,15 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		}
 	}
 
-	/* set second mode & disable keyboard turning off watchdog */
-	t = superio_inb(cr_wdt_control) & ~0x0C;
+	t = superio_inb(cr_wdt_control) &
+	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
 	superio_outb(cr_wdt_control, t);
 
 	t = superio_inb(cr_wdt_csr);
 	if (t & WDT_CSR_STATUS)
 		wdog->bootstatus |= WDIOF_CARDRESET;
 
-	/* reset status, disable keyboard & mouse turning off watchdog */
-	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
+	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD_INT_RESET | WDT_CSR_MOUSE_INT_RESET);
 	superio_outb(cr_wdt_csr, t);
 
 	superio_exit();
@@ -355,7 +364,7 @@ static int wdt_find(int addr)
 	if (ret)
 		return ret;
 	superio_select(W83627HF_LD_WDT);
-	val = superio_inb(0x20);
+	val = superio_inb(SIO_REG_DEVID);
 	switch (val) {
 	case W83627HF_ID:
 		ret = w83627hf;
@@ -431,7 +440,7 @@ static int wdt_find(int addr)
 		cr_wdt_csr = NCT6102D_WDT_CSR;
 		break;
 	case NCT6116_ID:
-		val = superio_inb(0x21);
+		val = superio_inb(SIO_REG_DEVID + 1);
 		if (val == NCT6126_VER_A_LOW_ID || val == NCT6126_VER_B_LOW_ID)
 			ret = nct6126;
 		else
@@ -513,11 +522,11 @@ static int __init wdt_init(void)
 	/* Apply system-specific quirks */
 	dmi_check_system(wdt_dmi_table);
 
-	wdt_io = 0x2e;
-	chip = wdt_find(0x2e);
+	wdt_io = SIO_CONF_PORT0;
+	chip = wdt_find(SIO_CONF_PORT0);
 	if (chip < 0) {
-		wdt_io = 0x4e;
-		chip = wdt_find(0x4e);
+		wdt_io = SIO_CONF_PORT1;
+		chip = wdt_find(SIO_CONF_PORT1);
 		if (chip < 0)
 			return chip;
 	}

-- 
2.56.0

