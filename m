Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1F371D05;
	Mon,  6 Jul 2026 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349659; cv=none; b=j7qJIkTbTx85qk5TlbZApvCduar6Gws66e6cH+IAEtkjyfEva+pCP/zFUJ9B0XZ3/LmCjCnNWgfzvqnz34zE2pxlRd11ve06nFFJ2HriXguoBCuKc5c9ohJLZJc9If1yqCefhV6x2ueUHvQr1oNu1HLW31kY6Y2+Mn0xYIoxN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349659; c=relaxed/simple;
	bh=iydWiQ1vPG3V5QxzFvs2qqb/JV63bcHWH8CznYl+9AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJnSnCIzbOTTKJL6cDCLmcKpD/vX9ZIwKL+nYyX9Pge8HbRy1qhyKL3VXlM0x2uk84MHnAGum3S2hdaLwA6YCaGHqnYTG+Sj76LXIvb/YBuy3eezIbzE0U/sjV+9fHZ1WcKT4jD6mkDkMhZuhGGUu9T7tPXO23LwCfLSDYOLY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=A9t1+xfc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXwGTgMl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="A9t1+xfc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXwGTgMl"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B8A47A0109;
	Mon,  6 Jul 2026 10:54:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jul 2026 10:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783349656; x=
	1783436056; bh=16AK//ozyGKcvVo2zCfMukm53V9OIuC45kBBe9d7/oQ=; b=A
	9t1+xfcW5YoRr77yP1LGDvvaPppcMLq4A9jVbzdaAwzRijv2tAeNu7iETVX1vfoS
	ZtdyehD2pkd5R9H4qNtUueiirvY2lzpylmhPIrdyS2EQAx75UBx9dssdI2GtWO0y
	U//SMVJNoMTEGxcj6BY6PLIXCuhQxyWZEHSt3Ea7wjRU+VUMtneltzkIgUXJkI8M
	eJvCNZpiAn1jEeueJWywTBr8rsRSn/JxGrAotNNjOlLqMd7XRnIX9MMIl6UvopTY
	ZGKWEk91JgGovoSQnvBCYhhXNAXwZRFEJkUp6Iqs7ktnNY9Kdz/+554nlqWRY9LE
	N0TOulZOCcJWm9pF8xwWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783349656; x=1783436056; bh=1
	6AK//ozyGKcvVo2zCfMukm53V9OIuC45kBBe9d7/oQ=; b=RXwGTgMlZep6oY/Km
	Gvs+xNVD8wBpjGH+NDogxpQxrIZzu7/TkUcrPdp/y3R9/nyuxNqqcpibGhZ4Irl+
	Amd7PugrFBZdsIcaEiLxjkVxVnKGlcQeGeIpGZX36A6i6qWEW7cdxoohn4h33gIh
	TDwXiCUYkbhga21JQflVahpy9TdNq5y4CluID0YXErxlxM1Z060AkIQHVt5Y+yT1
	Ul3mpoqNIXOGrq7WHBhz+udnbmpQ5PJMeGItd4RNBl4blHF3rwLA6g6XK/Nd95z3
	YlpxBfM3RbGrBEjxzFRCdiQwqDiftg8VmBVj3vfzhTxA+EH7qpdv4ea/9NHfGxpQ
	qHp9w==
X-ME-Sender: <xms:l8FLatGGca0SCGsokvS8V4K1LwCSx3XICUDoRKgFaZwv94sIIfJTEA>
    <xme:l8FLaj1Xw-RyN8yG3eakxUc6BkZ-pWCYCX2OrxVkCDJ3y3iyHW3ow8jouPzHEg8FC
    cyquBRiPO4aDPY8coImnGTxS9JkAgHrtbJtbDt2kohc-qMFYEP4D0I>
X-ME-Received: <xmr:l8FLavOv3m5eNaniIkNB62aWtGOiUAki_ktaY8Pf3ql02uoqnH3USwnGGLzXs0eDHcdAkHGvG58_HKFmtNBDYG-s2rY>
X-ME-Proxy-Cause: dmFkZTF+sb3qErPX2r92q2n39iPAwdTyEHnQOF0FIwTXVzPBxwM61A0sxhFkN6G1BwUvV6
    n8KZFLQ7L6RnUN9TNI2EewZJbsRfj92JCC69b5brWCy2/EQZmjIUN0yxaiAvMvYDClVa8r
    8eEfF94Tkcu7un7rewGMG8xdqXDXWaZXA5OUM8oiSFc0F0QmfuzYcK29pFJT7Kj5fWqJaO
    PgeDrC7s8xkJkI4reTXMKn98U1hV0xv9SA4x9indk2FLmycDKIqhsBY+6TICU1aYDdIq3i
    tC646h/rN1V+s2mty6MfnR0ULaCyExq+nKcRL2O/1zbYnKDpvvtqsVJigqbTbaT6fFX/eC
    cQNWWWz8VHVqNcfax+GL0OR7xW7pOjFSVq6sG2Bqg90EmjVdmKhvUwvvSpO3C3p+kB8JG3
    BE7fjADGEZQx5/p/7Rgv5kMBe9idNvP8QsEyRAogac+3yQ+KVDNKx1XRA47NhnFWejvlsE
    CjeS90vMxKF6tr8hr/NP0q9VQnM8aoZp+TAYpAYpe7HtTOun5LZdo/oQleA3+HPe4NfIez
    kRfG56V+/k/rxuY5Kqufo3Bhq/KTbO5t6mNE/Bw7ZXLmRWdW8ZHvRmjAfWLHp9NoWajFFH
    HlfyDTOZNXAdu9nFdnok2UpZO/L14zlbFx7abhOLTVOE6AGakXx4oi19NXyw
X-ME-Proxy: <xmx:l8FLai6W5Tgc4YVHfva2_udcIivbWuSHGBIWJf_P2f7gIeW4awNzyQ>
    <xmx:l8FLap2NTysv-mfTbj3rUNJZS_A83qcR0HaFat41HywBp4xidL9j7A>
    <xmx:l8FLajybR5TlasGSf8tdf1K7SwVKUbrD-YIJdK9IW1pQwNlrEnMGGA>
    <xmx:l8FLajtbCOQ0MC69d3qTP8axyn2WkQ6AnbJKrb5Uw7lwH54JaVOu0w>
    <xmx:mMFLauHUfT5EDJgUFzPhRjYspW-tjdxVF2rSS6cixCU1K38AZcZbU7Mj>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 10:54:15 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: linux@roeck-us.net,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60
Date: Mon,  6 Jul 2026 10:54:00 -0400
Message-ID: <20260706145412.3833185-1-mpearson-lenovo@squebb.ca>
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
Changes in v2:
 - Set se_30g2_60_pdev to null on free in create_device
 - Enter/Exit PNP mode correctly in init function
 - Improved error handling in wdt read/write
 - Release se_30g2_60_pdev if driver registration fails
 - Removed not needed set_timeout function. Covered in watchdog_dev.c
Changes in v3:
 - Unregister device on exit (fix stupid mistake I made in v2)

 drivers/watchdog/Kconfig                  |  12 +
 drivers/watchdog/Makefile                 |   1 +
 drivers/watchdog/lenovo_se30g2_se60_wdt.c | 289 ++++++++++++++++++++++
 3 files changed, 302 insertions(+)
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
index 000000000000..f31ecdb82ad0
--- /dev/null
+++ b/drivers/watchdog/lenovo_se30g2_se60_wdt.c
@@ -0,0 +1,289 @@
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
+static void enter_pnp_mode(void)
+{
+	outb(0x87, CFG_PORT);
+	outb(0x01, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	outb(0x55, CFG_PORT);
+}
+
+static void exit_pnp_mode(void)
+{
+	outb(0x2, CFG_PORT);
+	outb(0x2, CFG_PORT + 1);
+}
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
+	msb = lpc_read(0x20);
+	lsb = lpc_read(0x21);
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
+static int wdt_read(unsigned short *val)
+{
+	if (!request_muxed_region(bram_base, BRAM_SIZE, DRVNAME))
+		return -EACCES;
+
+	*val = ((bram_read(BRAM_WDT_REG) & 0xFF) << 8);
+	*val |= bram_read(BRAM_WDT_REG + 1) & 0xFF;
+	release_region(bram_base, BRAM_SIZE);
+
+	return 0;
+}
+
+static int wdt_write(unsigned short val)
+{
+	if (!request_muxed_region(bram_base, BRAM_SIZE, DRVNAME))
+		return -EACCES;
+
+	bram_write(BRAM_WDT_REG, (val >> 8) & 0xFF);
+	bram_write(BRAM_WDT_REG + 1, val & 0xFF);
+	release_region(bram_base, BRAM_SIZE);
+
+	return 0;
+}
+
+static int wdt_start(struct watchdog_device *wdog)
+{
+	return wdt_write(wdog->timeout);
+}
+
+static int wdt_stop(struct watchdog_device *wdog)
+{
+	return wdt_write(0);
+}
+
+static int wdt_ping(struct watchdog_device *wdog)
+{
+	return wdt_write(wdog->timeout);
+}
+
+static unsigned int wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	unsigned short val;
+	int err;
+
+	err = wdt_read(&val);
+	return err ? 0 : val;
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
+	enter_pnp_mode();
+	chip_id = lpc_chip_id();
+	if (chip_id != 0x5782) {
+		exit_pnp_mode();
+		release_region(CFG_PORT, CFG_SIZE);
+		return -ENODEV;
+	}
+
+	/* probe the BRAM base address */
+	lpc_write(CFG_LDN, CFG_BRAM_LDN);
+	bram_base = (lpc_read(0x60) << 8) | lpc_read(0x61);
+	exit_pnp_mode();
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
+	if (err) {
+		platform_device_put(se_30g2_60_pdev);
+		se_30g2_60_pdev = NULL;
+	}
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
+	int err;
+
+	if (!dmi_check_system(se_30g2_60))
+		return -ENODEV;
+
+	err = platform_driver_register(&se_30g2_60_wdt_driver);
+	if (err && se_30g2_60_pdev) {
+		platform_device_unregister(se_30g2_60_pdev);
+		se_30g2_60_pdev = NULL;
+	}
+
+	return err;
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

