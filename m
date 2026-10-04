Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873F41A919
	for <linux-watchdog@vger.kernel.org>; Sun,  4 Oct 2026 12:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116000; cv=none; b=P/8hOzkZtMZfI26rlB+JYMuk4ReK907n/2O/vtNaXdD96zuJk5wz/B5ur6z6/14pZTXbyB5IBPzH4HIzpTa2ZWZkUrIGqPrwL+bGzo7JFHRu3M8aG/isbhPDVZx/dNUUixuDMpSuFnhs7LCOIKfEBWDSRW1irVSyW7JEvMpgy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116000; c=relaxed/simple;
	bh=PHRe+zyt0BNe7jDfJhYpFzokzm+c5uEvVSBnzAFJzig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luBTjTbVaBI5TPZi1de6OS+0a3ClVi/130w8AD9rfZ4/rgqvoWm24Io1Es/F+VWU5Qcw1d/cR6YiS4DoKkQIxCg9Mo77nZ7NzKr4eQHxbPn0t1t4Wc2x3rlMYVkSBFqc8Ejyg6cS3+M7ec9t6CggUAZgvFtVtsm220PpiGhM5Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lgNxSClu; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lgNxSClu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1199F1A10CD
	for <linux-watchdog@vger.kernel.org>; Sun,  4 Oct 2026 12:13:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA06B604FE;
	Sun,  4 Oct 2026 12:13:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEBFF1032817F;
	Sun,  4 Oct 2026 14:13:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791115995; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wn/PGPQMJBN3v+hrh5rRESkZZULZt/QVeQyGKu7BXvk=;
	b=lgNxSClu8loQ4gk/YB8p3mB9F+WPgO2bnsFfpREfHyj2ftvwPzBKNYRI7EPEKrBI2O/nLL
	IbkYwgifOWK5XQ3W2Iiml/yBGfHMni6KxWXa0AyAepCpKMDkSYcfos73HVJ5SUxMTOhxel
	x8VqXMxt2C5Vu7k9PyOpOVWF8BZDS/N/g4phyTY6yJwHoEDyZzdtk32KjAlOCo2x5XH0EY
	4Zmw+ZVu+S8b/4wDNKJGsvU6MJtAKKPSr3/GKHUiUELdNPHP7eDDe0q5iWXX3FR8Bkr0XF
	qTaWMqlc8yUXslA/wAIO7fs978pZKLyTOjd/ZE0syvLN/+w2aKRH7hB4zYVCEQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 04 Oct 2026 14:12:49 +0200
Subject: [PATCH v3 1/6] watchdog: w83627hf_wdt: Replace magic numbers with
 descriptive macros
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-w83627hf_wdt-improvements-v3-1-8e27b518595e@bootlin.com>
References: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
In-Reply-To: <20261004-w83627hf_wdt-improvements-v3-0-8e27b518595e@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791115992; l=4273;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=PHRe+zyt0BNe7jDfJhYpFzokzm+c5uEvVSBnzAFJzig=;
 b=dlk2YaGEAAwGyLhNa6vxOvAHWIbSW70HTlusgsZ7B49+jQ4+wXMv7pIVmut0J0F2U2cwBHheK
 bLq+NLmimMnCjEjF20cX9RUIUZKTOt655x6yrkeI9uJugnQ0DRj/WRO
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Raw hex values for Super I/O register addresses are difficult to understand
without constantly consulting the datasheet. Use named macros instead.
Also, replace macros value that contains bit position with the BIT()
macro.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 43 ++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index db77599e43a0..1529a4e16820 100644
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
+#define SIO_REG_CONF_ADDR0	0x2E
+#define SIO_REG_CONF_ADDR1	0x4E
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
@@ -248,16 +258,17 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
 		}
 	}
 
-	/* set second mode & disable keyboard turning off watchdog */
-	t = superio_inb(cr_wdt_control) & ~0x0C;
+	/* set second mode & disable keyboard reset turning off watchdog */
+	t = superio_inb(cr_wdt_control) &
+	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
 	superio_outb(cr_wdt_control, t);
 
 	t = superio_inb(cr_wdt_csr);
 	if (t & WDT_CSR_STATUS)
 		wdog->bootstatus |= WDIOF_CARDRESET;
 
-	/* reset status, disable keyboard & mouse turning off watchdog */
-	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD | WDT_CSR_MOUSE);
+	/* reset status, disable keyboard & mouse interrupt turning off watchdog */
+	t &= ~(WDT_CSR_STATUS | WDT_CSR_KBD_INT_RESET | WDT_CSR_MOUSE_INT_RESET);
 	superio_outb(cr_wdt_csr, t);
 
 	superio_exit();
@@ -355,7 +366,7 @@ static int wdt_find(int addr)
 	if (ret)
 		return ret;
 	superio_select(W83627HF_LD_WDT);
-	val = superio_inb(0x20);
+	val = superio_inb(SIO_REG_DEVID);
 	switch (val) {
 	case W83627HF_ID:
 		ret = w83627hf;
@@ -431,7 +442,7 @@ static int wdt_find(int addr)
 		cr_wdt_csr = NCT6102D_WDT_CSR;
 		break;
 	case NCT6116_ID:
-		val = superio_inb(0x21);
+		val = superio_inb(SIO_REG_DEVID + 1);
 		if (val == NCT6126_VER_A_LOW_ID || val == NCT6126_VER_B_LOW_ID)
 			ret = nct6126;
 		else
@@ -513,11 +524,11 @@ static int __init wdt_init(void)
 	/* Apply system-specific quirks */
 	dmi_check_system(wdt_dmi_table);
 
-	wdt_io = 0x2e;
-	chip = wdt_find(0x2e);
+	wdt_io = SIO_REG_CONF_ADDR0;
+	chip = wdt_find(SIO_REG_CONF_ADDR0);
 	if (chip < 0) {
-		wdt_io = 0x4e;
-		chip = wdt_find(0x4e);
+		wdt_io = SIO_REG_CONF_ADDR1;
+		chip = wdt_find(SIO_REG_CONF_ADDR1);
 		if (chip < 0)
 			return chip;
 	}

-- 
2.55.0

