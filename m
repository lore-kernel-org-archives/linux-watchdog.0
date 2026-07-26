Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389E3E316B;
	Sun, 26 Jul 2026 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091513; cv=none; b=SlRxYVxded/hJIaevfNHQuybeXUSwBzfngVznxQ4oDfHuBm9hGJlFeobcggocBZdERqXXJQ9TyCfMQ687Bz2BqhQOaZK9j2Xn0B32LB7sTXNsWoGIG7IoP7nb7VxXKYHYyqwDoNFGIkhn6/hVt8vqKYLBfwLTRlkxivzHl0UN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091513; c=relaxed/simple;
	bh=PHRe+zyt0BNe7jDfJhYpFzokzm+c5uEvVSBnzAFJzig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptIEBtL6LiaCYuDyl1zNjzOcRiCQczp3aySthqElyA1Vk14rJIHfzYTh/1J/i3f3ZXhHuGkp/7okGjO94/uUemEKcYxarUbX+VGwTckeXKviwSqiTN1fTDl+kqe8ScFyWHDKu+PwzYJOArwBebKQP+vpebK5NA6ToM33m6HQhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dbkfXlXw; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dbkfXlXw"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 46DD94E40F87;
	Sun, 26 Jul 2026 18:45:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 15CE6601BE;
	Sun, 26 Jul 2026 18:45:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E476411C10AAF;
	Sun, 26 Jul 2026 20:45:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785091503; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Wn/PGPQMJBN3v+hrh5rRESkZZULZt/QVeQyGKu7BXvk=;
	b=dbkfXlXwtxaHQQbZXcsdm/96MfiVyJqDlhvyRS8jlZPSteTdcl566cYKfW9jIJSao4DLIA
	P05srGVCpLQXjzLJnU7Nsxfz+Enq1LqeYw+pb5SwnXDx4eMekOfvB0W/GIzBsNxBt3r3U6
	GEd1DsZE9bpv5JVFu6PSfoIaK5jjxhbZMz0KRwVkNmkw4wNozXV9Go8xbranBaOmvBDiee
	Pqi/qLHvvJ1dTSYclLYLFc0Tn7AGVlBvZVskrovu/Q1F8HeHUp9+T+gugvggynS6FI8JjZ
	QItfaXXOcLSwlX0F/J/28cJay9rciwctAQrNcTHK9xMVwtngXLrEYlqxC9f+GQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Sun, 26 Jul 2026 20:44:28 +0200
Subject: [PATCH v2 1/8] watchdog: w83627hf_wdt: Replace magic numbers with
 descriptive macros
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-w83627hf_wdt-improvements-v2-1-3645a2a6c022@bootlin.com>
References: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
In-Reply-To: <20260726-w83627hf_wdt-improvements-v2-0-3645a2a6c022@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785091497; l=4273;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=PHRe+zyt0BNe7jDfJhYpFzokzm+c5uEvVSBnzAFJzig=;
 b=plmTjsd4Y2DlJ9ZTSoSbl++msZvUyqEbdgFOiImt9+lfWmSobBxwz1hSiGJhh9VwRt0F4XBfi
 J0OxG+mUZrMAKNQsueVqwRcC7MNFW8I8Xji2yNGU0HbZ0BFFS8J5aJa
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

