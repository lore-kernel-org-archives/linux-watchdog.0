Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB223E25B;
	Thu, 25 Jun 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409415; cv=none; b=HXRUMOskrb82MWXV1/PdEIitbaKra6sLY0mV65U2ouKI4841orqTMYzeyOXV2xK10UulWIcdn4jYtPK7yRazz4WrxUpixpETspUytEP1AKwRAexPERSQjfRYmYWbtZHRATKVtPjdd/1X9v7kA4PpD4MWHMj2c8/YQhDaLZ6/Jfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409415; c=relaxed/simple;
	bh=yi0CUiE/GopJtvVlELkS4DbTZmAYfT6KdJXPRG5+51g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Avexrir05HIgslo3hN6/rF1+TqUSBromrUj+2vHaudJxIOXugl/88WfamHf4KUXAEaUlZAPTAkRHmqBlwZ8YPy/pFjhIq7VVAPEo+6j4K9aRyKGOpSDJf0efB9hmpia9lHH//MMwI8iJbzEdRXlvYvzoR1W3BF5eZkvei0QxKtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=prbIXu8C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPsRuRNX; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="prbIXu8C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPsRuRNX"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 777471D000C7;
	Thu, 25 Jun 2026 13:43:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 25 Jun 2026 13:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1782409412; x=
	1782495812; bh=/NF5KVq1KWcacyf1D5bPRS0rpTukBzKPo6h3zZN0OA0=; b=p
	rbIXu8CYlendFJohbKoMhpOlM2p81s8+zWOoZeW8LKqLLkFUuRZYVgr62FBBsBnb
	9/Nzf9H6AQTvwCyFSm/qsZmrUAM5qa3XuSgrdM93TRcmn7Oi+Ah+ZnNUF6sxTSll
	rvsb4wKZz52lCYIp25v3qObgEeUVaZLr1j+ggKjDratLQ6gut6s2JyJvs5QNai3+
	d073YTZReB1oFzo3zGGRVsQKMjzTCdmLUwQQpQvxjizDthGd5Wa+bI3d1Brgm3Y1
	D2zbClAmjLSrSMX4kXeWra12MMwLkvNzi+yeoDis8AR4I2tJwW5DssWCgsk9qrpJ
	r2TYbp04+5ikB9Y+nuk7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1782409412; x=1782495812; bh=/
	NF5KVq1KWcacyf1D5bPRS0rpTukBzKPo6h3zZN0OA0=; b=UPsRuRNX953MKi1If
	IResIj8tSFRyEvvUZIIoB0NxUcSo9QuEtv+l/IyOYh7mad2xlU87mw0ZbZZfwksV
	RyZYbGaNmivL53I5HvcQ5ew9+6KLd5vT5V9+7mHJ/LQRtbg3CQrgawDlafS56Tjx
	W+31DmqFou2Zq1W3F5yvKJJik52PhBiF162dyVGWgMxuPVyCzxxG2iLU3KNIdihq
	AiOu0Kt81UualpJzdFXW94y1cTRovWwN0daIpUuFWI5/wsaKpEhqsimqwazT/fjS
	aOdUZWjHLSpKKq9TWPcjIlBcjvMZxMVzniKDjrxDXQzmhaIRfiwDVcK6yLMgajRi
	XBbXQ==
X-ME-Sender: <xms:w2g9apc7rLQ6djbMpoPwl6WMBkrHKvM5Z56Wl9AS4HH5Uc8H2zBS1A>
    <xme:w2g9aosztBGP6GJIV0q_KiDdyKQae3wBFLtnU0U7rOlw95vtcjpeSTbh4slC4R5T_
    anCxCMOQNylhFa988a-Sif75lpvDwQYGDcIFJ0snyPaLwgKwbdaog>
X-ME-Received: <xmr:w2g9aimRQrMMcQ1G6dvgNds9-U7onJB3bgzDxUpM0jcGYhP-pWGjUgMxGcJbgI1XECtqy0i2UoxXL20a907-6jorkBM>
X-ME-Proxy-Cause: dmFkZTFNVIHEEsWu5PB5WrbW8nBCgQXTM9VraPlcoioXHjpzsO3LDAGr5pECwKUcyNFndC
    +/DVEckjXZPc8MSR9wYnzvXWXV65t2OYOzqu4PestlESuCHb4cBMXLAqgan6Zysbm1Fn8S
    Bt0F4DY1oHpwqvBH6DeTyydYrlKEcVkr47YGbTloQn+JWmj6UQ3faNgXhqDHlJawl5Y1c6
    IAOIXXrNMoKxzJAk7ch5KUZYqymxUZ4Uv6j7q6wZjL6lizbB/8pGmvdS8rnjRk9jV5yejo
    G01q+rfQ54AMVKSDY/SGqItDe6yYfTd6EudlAJr2HjQuwPAIi3NjKlSwDut173/8b2WsWm
    aQH12ShK/TDmBV8nX+kq1NJPQFVo6CFhHvvSoCHf1+ovTa3UvsQVoV1EWaKCN2hopT7ELP
    e4MxvEQga5jsI8qTwRZfW1phucUYaYQLiP4Sk8r00HJ3XYKz4VkFEMsySQYEH/erZD5Kwi
    +lCRLb/wI+nkwzIKjspP/JtoSNSm8sQ9QvlZufL9tI1Q3D7uUB5q2iY9WJwPXToaxoKeTe
    lGoKdg0TNf4ZF4ET7XBVjaSDoiDnOrlMKxjnf9zeKNoHtdu53GlxQoNXyu2ZLY42adufNh
    kvrXQ57Vc5qmRYoaXwZGyiI5GcoXi6yRcOEdwiRq2AIS7lagVOp2OimIhdTw
X-ME-Proxy: <xmx:w2g9aiz-ioXUaEZB5lrEJ0fMPVAbrbIW0R_fqgH4CdviUsKxNu5JLg>
    <xmx:w2g9asMIU4tAnyKdJh1vIrqmn67m4BqmewAdkRNzARl4kvGzdM5QaQ>
    <xmx:w2g9amoubxHTnqFyI_AdSG9nN9wN8Ka80q6415nbp4XR70WbTA-Bmg>
    <xmx:w2g9atFZhU75y-h0pv_0USKR9bhQMYu1xmSegkNiVnbeMyhrhOYSsw>
    <xmx:xGg9an9Dt8TyUwWPpqwt19t0n5QHOyIA0jJDlxjR01YhNgdzBRKz3d7b>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 13:43:31 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: linux@roeck-us.net,
	wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo SE30G2 and SE60
Date: Thu, 25 Jun 2026 13:43:14 -0400
Message-ID: <20260625174328.3339996-1-mpearson-lenovo@squebb.ca>
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
index 000000000000..69fcc431ab59
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
+		platform_device_put(se_30g2_60_pdev);
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

