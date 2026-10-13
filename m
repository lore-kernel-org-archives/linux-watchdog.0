Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E93F0AB8
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899949; cv=none; b=FrQUwrt3V1lpqd+bBbs3/0Sshw9FfL/YRuh2LwxONwRJ1XXgse88f+iYzKVW49jzuScrHCIMIIFuTcPp4vN6IAakUlm0GKf2vujZQZPK+k/RlF7Hz0iCRFEepvBY9jXk8MhY2I0Z7hiaERVvKLxzFpplhgBbqVO9fRYGbZWFZ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899949; c=relaxed/simple;
	bh=zvfr26pt0jsTpS7l7NPPqQdSVDDrFXlZ68wj+qX9Sog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUtLPGZu35oHZc+Me6iXh7tH/4Dpidg4ok/VVhV6mJ96dqta95CTLR0j2kPjYwiaMIfmEpdJcYAC9mPiqyQmNG0B+nQDj0CGHdGWFjOMCYmV+SB0iXAaiiP53XtXuq6w1tWXRN1NES5+M3BjXSsx0NFxaYaMk9tMfG788/XfWsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W07lJBrI; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W07lJBrI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 303ADC653F1
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:00:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9E9D860362;
	Tue, 13 Oct 2026 13:59:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4EB4511D71654;
	Tue, 13 Oct 2026 15:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791899944; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zSoisR4mN6hD6AM9+ZRJhH+HAJPFY9LvXHh3oWUr5Ew=;
	b=W07lJBrI/Y1KZYXPM03zwHubZpimcslkdh6qNxoYIiqgkembQHJL1GQEsVBn9i4LMV1yBV
	iM9Y4un+akuk7pkikSaatXcHeqGem/siYkiipcFxAcxKRUJIdRi2ZVw5KHwAEIxklm+VuU
	BHU33p/s2yWLyH5+qiv3MkRSW98VYoUhVkhAk2Ys/XgrOz43DZkZCGYjx7iLWDisbAgUOr
	Zl7gcoecMntPyQ9vEaPm3HzLIZt4rZOvCEAmcYNWXvz8QJtOoTYwQZAcoKM4TMY02f3eIg
	IMBqHN5cJJcSRd7Pnzlu0TB9OJqeJ4Q/TEqmPrWTQVNdTvNbrrvWZjvvALTvOw==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Tue, 13 Oct 2026 15:58:46 +0200
Subject: [PATCH v4 2/6] watchdog: w83627hf_wdt: Replace magic numbers with
 descriptive macros
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-w83627hf_wdt-improvements-v4-2-b6f6b60a9566@bootlin.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, linux-watchdog@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791899939; l=4161;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=zvfr26pt0jsTpS7l7NPPqQdSVDDrFXlZ68wj+qX9Sog=;
 b=EUT9bEo+MDDl/Lbuzg/WyBV09BIyGnCN3DLzsnyiHz4+byYz60fjVT2Ag6YqeEqsYrt2hgWBE
 S5Sj86l60JYBq3v8OHaUEd5pIAfIggnEF5xUiecv8cod5XejRSChDTs
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3

Raw hex values for Super I/O register addresses are difficult to
understand
without constantly consulting the datasheet. Use named macros instead.
Also, replace macros value that contains bit position with the BIT()
macro.
Remove comments that doesn't help understanding the code.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/watchdog/w83627hf_wdt.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 0fc7648ef337..c9ad1545d525 100644
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

