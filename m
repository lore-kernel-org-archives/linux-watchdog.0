Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159469;
	b=jYQsMGLvmGJvc2LkiF1XNjaDYsz6HGZQ/FDpqOxi4PS9sD16PKvHLsLT4XL+rvvidVBy
	 TGaXh2RKDOcb+Vh+nE2ESVyWy5ItoiszHOcWI1iCef4M/uDN7u9h6yy0kfjPC6u9aFwOU
	 +KAMU1GUV018PyHfyYDlxCCz2WMbUpKn8k7hhHI2RVxIy/mY7xbwYlKNH7JLruJzoNGCx
	 v5YYkCjd3E4Jv88hX5KTgIsW1jEfIqoBNph2idpEkluENald0tlcbjdaPBFOKYlLNaPmD
	 jqx8skduxvOcOcoSyegMgCZ3ekA4xQTCQLbaPavzyC2jmD7IGBN2su9vwdMHYyCpz0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159469;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=sGG0B+2eCsinK+z+anI9PAK9DV00DeGp6lT4WLn4TAg=;
	b=5inQdTpB0oBRhhV+zJdXco0sI0+d45WQdAS4z9TXXFtst1onRDbG3eGUJc6MRNap34Yi
	 YUIBOZGSQay/yv9g92rRa8YsYsilcqG0Mq6eQ6DMTX3X1+HJSFc5dN3zvvNpTy5ZliG7X
	 jSEzrv9JOb7lJEsh48naMB9dMT3/Zk8OIRHGI4yobIBCHmKPr1GX3Uf8dGwGpZLUlEqwX
	 2Cduzu4GN29HftfB8JJxHSLzCzVvMot4tyYSbAesSU20iiMrkvygkkyhxhSVlCedFJpPK
	 zNzjFigzuGQI2h2SN0JPyeYSnxHqpxc+AiFrKY+Pb/DUEYxoctp6EDME0UYOrTjCPvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Qw0AI9wU;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F177160A2609;
	Fri, 20 Nov 2026 07:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F177160A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Qw0AI9wU
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D61991A173D;
	Fri, 20 Nov 2026 07:24:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AA5996017D;
	Fri, 20 Nov 2026 07:24:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19DF911BC11B0;
	Fri, 20 Nov 2026 08:24:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795159465; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sGG0B+2eCsinK+z+anI9PAK9DV00DeGp6lT4WLn4TAg=;
	b=Qw0AI9wUpUgJKVbaD4jUlCsxQTKvicDdbmKDQKyX8KI63Pa9l5L/W1l86yPxvezq7DPtnG
	6odGheBsgoM6G2LExyCSHkFB4d60iVp3ZotLPKc4AA1qgLurQ/J051xZIoq6fOjSAc8fh5
	n1MhC/ABuVvgUVdGrwRFXrnkrjP7/JAnRCkeFoeGeblAj9vKaQdW+EUTA5Sshy6sk4maEv
	fB9w6RrVy6cO/Ma+aG6ig0ZC6PmUek42Yofu2aPYB7axNv/zz8KIHIS9AH96LvHq1ekiyk
	wGiOOTPDxVt7kmiNkdiPc177XsxPkpnCAssSvmwME+qBwEHDLRgzNZ9g9+h+vQ==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Fri, 20 Nov 2026 08:23:57 +0100
Subject: [PATCH v10 5/5] watchdog: aaeon: Add watchdog driver for SRG-IMX8P
 MCU
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-dev-b4-aaeon-mcu-driver-v10-5-a756687e7997@bootlin.com>
References: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
In-Reply-To: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev, 
 linux-doc@vger.kernel.org, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add watchdog driver for the Aaeon SRG-IMX8P embedded controller,
which exposes the MCU's watchdog timer.

The MCU's hardware heartbeat is fixed at 25 seconds, so the watchdog
core pings the MCU in the background to provide the default timeout
of 240 seconds. The software timeout can be changed via the
WDIOC_SETTIMEOUT ioctl, the DT timeout-sec property of the MCU node,
or the timeout module parameter. As the hardware cannot expire earlier
than its heartbeat, timeouts below 25 seconds are rejected.

CONFIG_WATCHDOG_NOWAYOUT is honoured, so userspace cannot stop the
watchdog once started when it is enabled. The suspend callback still
stops it, as the MCU would reset a system suspended for longer than
its heartbeat.

Co-developed-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-parameters.rst |   8 ++
 MAINTAINERS                                    |   1 +
 drivers/watchdog/Kconfig                       |  11 ++
 drivers/watchdog/Makefile                      |   1 +
 drivers/watchdog/aaeon_mcu_wdt.c               | 174 +++++++++++++++++++++++++
 5 files changed, 195 insertions(+)

diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentation/watchdog/watchdog-parameters.rst
index 348229ffcb43..0672ea641ad8 100644
--- a/Documentation/watchdog/watchdog-parameters.rst
+++ b/Documentation/watchdog/watchdog-parameters.rst
@@ -33,6 +33,14 @@ watchdog core:
 
 -------------------------------------------------
 
+aaeon_mcu_wdt:
+    timeout:
+	Watchdog timeout in seconds. The MCU has a fixed 25 second hardware
+	heartbeat, so the minimum is 25 seconds and longer timeouts are
+	provided by the watchdog core pinging the MCU (default=240)
+
+-------------------------------------------------
+
 acquirewdt:
     wdt_stop:
 	Acquire WDT 'stop' io port (default 0x43)
diff --git a/MAINTAINERS b/MAINTAINERS
index 5cc24f875e36..0968e2e61585 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -194,6 +194,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
 F:	drivers/gpio/gpio-aaeon-mcu.c
 F:	drivers/mfd/aaeon-mcu.c
+F:	drivers/watchdog/aaeon_mcu_wdt.c
 F:	include/linux/mfd/aaeon-mcu.h
 
 AAEON UPBOARD FPGA MFD DRIVER
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f7d0a0c2c0ef..ef807389ccb0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -449,6 +449,17 @@ config SL28CPLD_WATCHDOG
 
 # ARM Architecture
 
+config AAEON_MCU_WATCHDOG
+	tristate "Aaeon MCU Watchdog"
+	depends on MFD_AAEON_MCU
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer of the Aaeon
+	  SRG-IMX8P onboard microcontroller (MCU).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called aaeon_mcu_wdt.
+
 config AIROHA_WATCHDOG
 	tristate "Airoha EN7581 Watchdog"
 	depends on ARCH_AIROHA || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 9ac406677aba..09c07a29a2f4 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 # ALPHA Architecture
 
 # ARM Architecture
+obj-$(CONFIG_AAEON_MCU_WATCHDOG) += aaeon_mcu_wdt.o
 obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
 obj-$(CONFIG_ARM_SBSA_WATCHDOG) += sbsa_gwdt.o
 obj-$(CONFIG_ARMADA_37XX_WATCHDOG) += armada_37xx_wdt.o
diff --git a/drivers/watchdog/aaeon_mcu_wdt.c b/drivers/watchdog/aaeon_mcu_wdt.c
new file mode 100644
index 000000000000..62f005a019ff
--- /dev/null
+++ b/drivers/watchdog/aaeon_mcu_wdt.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Aaeon MCU Watchdog driver
+ *
+ * Copyright (C) 2026 Bootlin
+ * Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+ * Author: Thomas Perrot <thomas.perrot@bootlin.com>
+ */
+
+#include <linux/mfd/aaeon-mcu.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/watchdog.h>
+
+#define AAEON_MCU_WDT_PING_REG		AAEON_MCU_REG(0x73, 0x00)
+#define AAEON_MCU_WDT_STATUS_RUNNING	0x01
+
+#define AAEON_MCU_WDT_TIMEOUT		240
+#define AAEON_MCU_WDT_HEARTBEAT_MS	25000
+/* The MCU cannot expire earlier than its fixed heartbeat. */
+#define AAEON_MCU_WDT_MIN_TIMEOUT	(AAEON_MCU_WDT_HEARTBEAT_MS / 1000)
+
+static unsigned int timeout;
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
+
+struct aaeon_mcu_wdt {
+	struct watchdog_device wdt;
+	struct regmap *regmap;
+};
+
+static int aaeon_mcu_wdt_cmd(struct aaeon_mcu_wdt *data, unsigned int reg)
+{
+	return regmap_write(data->regmap, reg, 0);
+}
+
+static int aaeon_mcu_wdt_start(struct watchdog_device *wdt)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+
+	return aaeon_mcu_wdt_cmd(data, AAEON_MCU_WDT_START_REG);
+}
+
+static int aaeon_mcu_wdt_status(struct watchdog_device *wdt, bool *enabled)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+	unsigned int rsp;
+	int ret;
+
+	ret = regmap_read(data->regmap, AAEON_MCU_WDT_STATUS_REG, &rsp);
+	if (ret)
+		return ret;
+
+	*enabled = rsp == AAEON_MCU_WDT_STATUS_RUNNING;
+	return 0;
+}
+
+static int aaeon_mcu_wdt_stop(struct watchdog_device *wdt)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+
+	return aaeon_mcu_wdt_cmd(data, AAEON_MCU_WDT_STOP_REG);
+}
+
+static int aaeon_mcu_wdt_ping(struct watchdog_device *wdt)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+
+	return aaeon_mcu_wdt_cmd(data, AAEON_MCU_WDT_PING_REG);
+}
+
+static const struct watchdog_info aaeon_mcu_wdt_info = {
+	.identity	= "Aaeon MCU Watchdog",
+	.options	= WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE | WDIOF_SETTIMEOUT
+};
+
+static const struct watchdog_ops aaeon_mcu_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= aaeon_mcu_wdt_start,
+	.stop		= aaeon_mcu_wdt_stop,
+	.ping		= aaeon_mcu_wdt_ping,
+};
+
+static int aaeon_mcu_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct watchdog_device *wdt;
+	struct aaeon_mcu_wdt *data;
+	bool enabled;
+	int ret;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!data->regmap)
+		return -ENODEV;
+
+	wdt = &data->wdt;
+	wdt->parent = dev;
+	wdt->info = &aaeon_mcu_wdt_info;
+	wdt->ops = &aaeon_mcu_wdt_ops;
+	/*
+	 * The MCU firmware has a fixed hardware timeout of 25 seconds that
+	 * cannot be changed. The watchdog core handles automatic pinging to
+	 * support software timeouts longer than the hardware limit. The default
+	 * software timeout of 240 seconds can be overridden via the DT
+	 * timeout-sec property of the MCU node or the timeout module
+	 * parameter.
+	 */
+	wdt->timeout = AAEON_MCU_WDT_TIMEOUT;
+	wdt->min_timeout = AAEON_MCU_WDT_MIN_TIMEOUT;
+	wdt->max_hw_heartbeat_ms = AAEON_MCU_WDT_HEARTBEAT_MS;
+	watchdog_init_timeout(wdt, timeout, dev->parent);
+
+	watchdog_set_drvdata(wdt, data);
+	watchdog_set_nowayout(wdt, WATCHDOG_NOWAYOUT);
+	watchdog_stop_on_reboot(wdt);
+	watchdog_stop_ping_on_suspend(wdt);
+	dev_set_drvdata(dev, wdt);
+
+	ret = aaeon_mcu_wdt_status(wdt, &enabled);
+	if (ret)
+		return ret;
+
+	if (enabled)
+		set_bit(WDOG_HW_RUNNING, &wdt->status);
+
+	return devm_watchdog_register_device(dev, wdt);
+}
+
+static int aaeon_mcu_wdt_suspend(struct device *dev)
+{
+	struct watchdog_device *wdt = dev_get_drvdata(dev);
+
+	/*
+	 * The MCU would reset a system suspended for longer than its 25 second
+	 * heartbeat, so stop it here even if nowayout is set.
+	 */
+	if (watchdog_active(wdt) || watchdog_hw_running(wdt))
+		return aaeon_mcu_wdt_stop(wdt);
+
+	return 0;
+}
+
+static int aaeon_mcu_wdt_resume(struct device *dev)
+{
+	struct watchdog_device *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(wdt) || watchdog_hw_running(wdt))
+		return aaeon_mcu_wdt_start(wdt);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(aaeon_mcu_wdt_pm_ops,
+				aaeon_mcu_wdt_suspend, aaeon_mcu_wdt_resume);
+
+static struct platform_driver aaeon_mcu_wdt_driver = {
+	.driver		= {
+		.name	= "aaeon-mcu-wdt",
+		.pm	= pm_sleep_ptr(&aaeon_mcu_wdt_pm_ops),
+	},
+	.probe		= aaeon_mcu_wdt_probe,
+};
+
+module_platform_driver(aaeon_mcu_wdt_driver);
+
+MODULE_ALIAS("platform:aaeon-mcu-wdt");
+MODULE_DESCRIPTION("Aaeon MCU Watchdog Driver");
+MODULE_AUTHOR("Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.56.0

