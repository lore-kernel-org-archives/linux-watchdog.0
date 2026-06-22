Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427182D77F5;
	Mon, 22 Jun 2026 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139538; cv=none; b=Y6TDT+ybLb0qgloibafAPAu6Z9OASrS83LWLXaafF03Pt8uqrjWvbDY3vqRKtOUzx7y/eZwY9g+PFVv25FmHic5Gw5nSZJNg500VRrI7DWZ5UmRhGH4sQAwWzPKzWF43/UdHlR97KzI+WoowRAP7maTpDvTBwnips54Y71g8ZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139538; c=relaxed/simple;
	bh=Og/7wzu7nxEeP0k0n8Qm03U5QgVly7xO4bX4tm7JKjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUnvlr4uUhrBHCpe240V5u93zSs4ImdEl9nkcMLBhANsUBUAlHFXGxNiyEL23XQvN1RJzm6u27+XHd8Ajvyl0DAGSyv39BfcRkisnKpCo4wGIYJis9PVt1xjfLt2Kuh1purJbZDN7/xzTTFaqkcgDAOqokV+laysaINp353cNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=I+F0KzBX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmWfUV9e; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="I+F0KzBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmWfUV9e"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 494781D00063;
	Mon, 22 Jun 2026 10:45:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 22 Jun 2026 10:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1782139534; x=
	1782225934; bh=iBA+VHC7mJwV1ImlZcpHebThX4761Ta+jnrntMcwk/I=; b=I
	+F0KzBXs6fz8ijwPXCm+WACXc0QWfTRZXkX1Gzytj481U/EbRLbZ3101Igd1sJK1
	9zYddxhtcaXIKGao3CEgGYVKqPKxxhnTMChLE3cZMXvV1WwehIAWard0XWvMZ4s+
	A8cWAdE3ikUCgpbvMDStoHMay8FqVN20fRccai6dngAqwaISbLblZFZMqZO0ADOH
	J/0EafGJtfi9nnJ0lotp9jAqv/reL02dbAF7OyebFXIU6gv0FvSi2rLhmWljjUt5
	75wLEZbBFc6+6aEa4hbFe21optku0BV1WThLu8wvf5YWcyV5XGf71FGGFFc8B6Ny
	dp3sHlYHy5/rn6IaSt2CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782139534; x=1782225934; bh=i
	BA+VHC7mJwV1ImlZcpHebThX4761Ta+jnrntMcwk/I=; b=AmWfUV9eFe9mDfDYl
	UM3OCxAo1fnw05FtOIWCTlqhjJ7VcVqrjk+cH+XDtYEoUXsVsXpjPifFKRitAc1j
	AIvOrgQV0Fks//fZeoBri0WoxbY2ZpoOe75/J0wxJfx/qP/1qimb14HEfOtQRTEu
	J6bAO68Faf/nDDmKOphm1hkC75l1ttOAvgwI83h6jzw5EzJ7TOk9acPBJa10o/qe
	/szPLIADV8TamtKMWE7LDyLFblnNx8OYpZ8vILWYMe2/a9qRRiK8gjfJYb03V1Lh
	MLuDfxT+eTaGtLGA3oimKDuntabmp2Zw5taktWg6lyyVZDRhHkS4clTkmOtgLQ1i
	Ey5aQ==
X-ME-Sender: <xms:jko5aoSsFPYpv284QMq35SVNZ7_1AYZlWP7MdNHiF_d7vQukC-8upg>
    <xme:jko5anQ2HWFQyEh98XdQQsCJId2qKX6TBk2E6NnkcyyYGT1iBG2kXnTIRYArSsRL7
    nrOClamp5haPOejwqIVhWs9r2JmFSN-xYSaPu-IXEi8GQ-Wo1sSRs0>
X-ME-Received: <xmr:jko5al4kYpjeyfZYYT7f0b2EZ6zbdobbbHLNHtcocvB4uhoPpVPrpOEc4XaGG9dZThZS7gRDLp7ZgIRJXoHXAGniv78>
X-ME-Proxy-Cause: dmFkZTG0rMpNiTxgzR5sfruzcNflA1Yk/8wZFsxHYxQ+LzahrqpiMx86FExWDr9b/UUNyL
    jsxOQ1U2aroMXvRsAURIt9LA2lDIFXRtCQ4lrkK7Sey8ZFZ6k7nEYi0QLl4NkSMc5dgxEQ
    OqGE8yOQmAfiFk36Lz/i//SCKZVbrelJ5VIXX9pH+PxMovWRZ9YRpCosUm0evaiIrvfdaf
    m7Md6o8HQHRpI+QW3GAuyQKrLBEX1LnDE2ynALLaVY5qRyd5Mc4e1zPgXKPIOG8xDu/+A2
    CM6qlatBtPxD0qzQubWBoaJFVxCbuvsXuKt+TXmMCTAUnAhMyH8i5FoyfRqlO6jDTolKkb
    yNcdfuxaaN/c1yjSJ8f9X7Y6nXZ5CVmMDDwJgO4JisfWgW/96QS4Oeom8C7rfrArhpDtus
    VcoT5+vTg0Sa3cs0jPefr6p6+RXzUvfZ3giaVjlBFPBwP2Vgw/mGDG9L4Un+MFXVMCINJP
    lg8gMZh8JgvcufJTY4XvE+RiGYv9cD/eWdw/Q1/MxU3ieXDIeru8d0d4y5TmsycfsSzgYC
    OcRM2aMMA5rUa4AS5sZCxCvXuypM8adF25krRU85PbwkUZKwYqrOMJ7SYzQMLmMDpzaV9F
    8PluR8g4vYMx8maopTtydeHCsW3iptyv8EsG57Gh8PF0SbmgU5uVhDptOjUQ
X-ME-Proxy: <xmx:jko5ar1JGh2XEnTAe4K5Qj-AEnabyY_6ESR4hPsG0MJZ6G9C84cPbQ>
    <xmx:jko5aoB75jiqbra66dIdVGqLTsWszSwOM2r7hGy3mhp--N1TkiXm9w>
    <xmx:jko5auPWiB7VPzEyIiBUe_UaFHwLWMq0IkSxwtA_suARyRThALcXhw>
    <xmx:jko5albLWi1HUk2ms-gDYLXgS0DDA7yyhezm8HEK_nUMTWr_tk1wuw>
    <xmx:jko5asD-GebzFspJuv0U7Gd4ZYKjAkRmntSMhBGIushaKtq0BkT2mJ3x>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 10:45:33 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60
Date: Mon, 22 Jun 2026 10:45:20 -0400
Message-ID: <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Watchdog driver implementation for Lenovo SE30G2 and SE60 platforms.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/watchdog/Kconfig                  |  12 +
 drivers/watchdog/Makefile                 |   1 +
 drivers/watchdog/lenovo_se30g2_se60_wdt.c | 274 ++++++++++++++++++++++
 3 files changed, 287 insertions(+)
 create mode 100644 drivers/watchdog/lenovo_se30g2_se60_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5..8e2d81b943e8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -291,6 +291,18 @@ config LENOVO_SE30_WDT
 	  This driver can also be built as a module. If so, the module
 	  will be called lenovo-se30-wdt.
 
+config LENOVO_SE30G2_SE60_WDT
+	tristate "Lenovo SE30 Gen 2, SE60 Watchdog"
+	depends on (X86 && DMI) || COMPILE_TEST
+	depends on HAS_IOPORT
+	select WATCHDOG_CORE
+	help
+	  If you say yes here you get support for the watchdog
+	  functionality for the Lenovo SE30 Gen2 and SE60 platforms.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called lenovo-se30g2-se60-wdt.
+
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
 	depends on MFD_MENF21BMC || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index d2fb16b9f9ce..f466e497916a 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -127,6 +127,7 @@ obj-$(CONFIG_IE6XX_WDT) += ie6xx_wdt.o
 obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
 obj-$(CONFIG_LENOVO_SE10_WDT) += lenovo_se10_wdt.o
 obj-$(CONFIG_LENOVO_SE30_WDT) += lenovo_se30_wdt.o
+obj-$(CONFIG_LENOVO_SE30G2_SE60_WDT) += lenovo_se30g2_se60_wdt.o
 obj-$(CONFIG_IT8712F_WDT) += it8712f_wdt.o
 obj-$(CONFIG_IT87_WDT) += it87_wdt.o
 obj-$(CONFIG_HP_WATCHDOG) += hpwdt.o
diff --git a/drivers/watchdog/lenovo_se30g2_se60_wdt.c b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
new file mode 100644
index 000000000000..56e0e9ef8462
--- /dev/null
+++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * WDT driver for Lenovo SE30G2 & SE60.
+ */
+
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define CFG_PORT 0x2E
+#define CFG_SIZE 2
+
+#define CFG_LDN	     0x07
+#define CFG_BRAM_LDN 0x10
+
+#define BRAM_SIZE 2
+
+#define BRAM_WDT_REG 0x48
+
+#define DRVNAME "lenovo-se30g2-se60-wdt"
+
+/*The timeout range is 1-255 seconds*/
+#define MIN_TIMEOUT 1
+#define MAX_TIMEOUT 255
+#define WATCHDOG_TIMEOUT 60 /* 60 sec default timeout */
+
+static unsigned short bram_base;
+static struct platform_device *se_30g2_60_pdev;
+
+static int timeout; /* in seconds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+struct se_30g2_60_wdt {
+	struct watchdog_device wdd;
+};
+
+static void lpc_write(unsigned char index, unsigned char data)
+{
+	outb(index, CFG_PORT);
+	outb(data, CFG_PORT + 1);
+}
+
+static unsigned char lpc_read(unsigned char index)
+{
+	outb(index, CFG_PORT);
+	return inb(CFG_PORT + 1);
+}
+
+static unsigned short lpc_chip_id(void)
+{
+	unsigned char msb, lsb;
+
+	outb(0x87, CFG_PORT);
+	outb(0x01, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	msb = lpc_read(0x20);
+	lsb = lpc_read(0x21);
+	lpc_write(0x2, 0x2);
+
+	return (msb << 8 | lsb);
+}
+
+static void bram_write(unsigned char reg, unsigned char val)
+{
+	outb(reg | 0x80, bram_base);
+	outb(val, bram_base + 1);
+}
+
+static unsigned char bram_read(unsigned char reg)
+{
+	unsigned char val;
+
+	outb(reg | 0x80, bram_base);
+	val = inb(bram_base + 1);
+	return val;
+}
+
+static unsigned short wdt_read(void)
+{
+	unsigned short val;
+
+	if (!request_muxed_region(bram_base, BRAM_SIZE, DRVNAME))
+		return 0;
+	val = ((bram_read(BRAM_WDT_REG) & 0xFF) << 8);
+	val |= bram_read(BRAM_WDT_REG + 1) & 0xFF;
+	release_region(bram_base, BRAM_SIZE);
+	return val;
+}
+
+static void wdt_write(unsigned short val)
+{
+	if (!request_muxed_region(bram_base, BRAM_SIZE, DRVNAME))
+		return;
+	bram_write(BRAM_WDT_REG, (val >> 8) & 0xFF);
+	bram_write(BRAM_WDT_REG + 1, val & 0xFF);
+	release_region(bram_base, BRAM_SIZE);
+}
+
+static int wdt_start(struct watchdog_device *wdog)
+{
+	wdt_write(wdog->timeout);
+	return 0;
+}
+
+static int wdt_stop(struct watchdog_device *wdog)
+{
+	wdt_write(0);
+	return 0;
+}
+
+static int wdt_ping(struct watchdog_device *wdog)
+{
+	wdt_write(wdog->timeout);
+	return 0;
+}
+
+static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
+{
+	if (timeout < MIN_TIMEOUT || timeout > MAX_TIMEOUT)
+		return -EINVAL;
+
+	wdog->timeout = timeout;
+	return 0;
+}
+
+static unsigned int wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	unsigned short val = wdt_read();
+	return val;
+}
+
+static const struct watchdog_info wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "Lenovo SE30G2 SE60 WDOG",
+};
+
+static const struct watchdog_ops se_30g2_60_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = wdt_start,
+	.stop = wdt_stop,
+	.ping = wdt_ping,
+	.set_timeout = wdt_set_timeout,
+	.get_timeleft = wdt_get_timeleft,
+};
+
+static int se_30g2_60_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct se_30g2_60_wdt *priv;
+	unsigned int chip_id;
+	int ret;
+
+	if (!request_muxed_region(CFG_PORT, CFG_SIZE, DRVNAME))
+		return -EBUSY;
+
+	/* identify the chip */
+	chip_id = lpc_chip_id();
+	if (chip_id != 0x5782) {
+		release_region(CFG_PORT, CFG_SIZE);
+		return -ENODEV;
+	}
+
+	/* probe the BRAM base address */
+	lpc_write(CFG_LDN, CFG_BRAM_LDN);
+	bram_base = (lpc_read(0x60) << 8) | lpc_read(0x61);
+	release_region(CFG_PORT, CFG_SIZE);
+	dev_info(dev, "Found Lenovo SE30G2 SE60 0x%x\n", chip_id);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	watchdog_set_drvdata(&priv->wdd, priv);
+
+	priv->wdd.parent = dev;
+	priv->wdd.info = &wdt_info;
+	priv->wdd.ops = &se_30g2_60_wdt_ops;
+	priv->wdd.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
+	priv->wdd.min_timeout = MIN_TIMEOUT;
+	priv->wdd.max_timeout = MAX_TIMEOUT;
+
+	watchdog_init_timeout(&priv->wdd, timeout, dev);
+	watchdog_set_nowayout(&priv->wdd, nowayout);
+	watchdog_stop_on_reboot(&priv->wdd);
+	watchdog_stop_on_unregister(&priv->wdd);
+
+	ret = devm_watchdog_register_device(dev, &priv->wdd);
+
+	dev_dbg(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
+		priv->wdd.timeout, nowayout);
+
+	return ret;
+}
+
+static struct platform_driver se_30g2_60_wdt_driver = {
+	.driver = {
+		.name = DRVNAME,
+	},
+	.probe = se_30g2_60_wdt_probe,
+};
+
+static int se_30g2_60_create_device(const struct dmi_system_id *id)
+{
+	int err;
+
+	se_30g2_60_pdev = platform_device_alloc("lenovo-se30g2-se60-wdt", -1);
+	if (!se_30g2_60_pdev)
+		return -ENOMEM;
+
+	err = platform_device_add(se_30g2_60_pdev);
+	if (err)
+		platform_device_put(se_30g2_60_pdev);
+
+	return err;
+}
+
+static const struct dmi_system_id se_30g2_60[] __initconst = {
+	{
+		.ident = "LENOVO-SE30G2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "33BD"),
+		},
+		.callback = se_30g2_60_create_device,
+	},
+	{
+		.ident = "LENOVO-SE60",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_BOARD_NAME, "33BF"),
+		},
+		.callback = se_30g2_60_create_device,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, se_30g2_60);
+
+static int __init se_30g2_60_wdt_init(void)
+{
+	if (!dmi_check_system(se_30g2_60))
+		return -ENODEV;
+
+	return platform_driver_register(&se_30g2_60_wdt_driver);
+}
+
+static void __exit se_30g2_60_wdt_exit(void)
+{
+	if (se_30g2_60_pdev)
+		platform_device_unregister(se_30g2_60_pdev);
+	platform_driver_unregister(&se_30g2_60_wdt_driver);
+}
+
+module_init(se_30g2_60_wdt_init);
+module_exit(se_30g2_60_wdt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Mark Pearson <mpearson-lenovo@squebb.ca>");
+MODULE_DESCRIPTION("WDT driver for Lenovo SE30G2 & SE60");
-- 
2.43.0

