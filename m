Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911DF3CBE9C;
	Fri, 31 Jul 2026 09:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491544; cv=none; b=EWZ6/YQVBk4ibLV8YBNwwlwv0Qz/FLRDn1isoesI7uAIdB468OHtwvcfOtDSZXCFBF0UUzm6X+161du+sZezANtcu9miK/IdnsFfqqJ1Pj/7CqTQyekSTBhSNg/sLuWF70/MKRxTl+FkyMwHFahZi2C7g5GBD1kutXfHAPHywZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491544; c=relaxed/simple;
	bh=CvctG6QbAgTHiuEU0Fn1/DNfcUx25lCQVUYfmic5994=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5/5JpplsVvl/TmbW4YLg42QND4jAytR7f4Yr9boTA8mq8jYLIgtYTcmloAWaUhuMiI17muK2R6ZNMjjre+K9K1IcXJ6r3wiZETAIk+sLZN8PA97354Ap25DOcUIxu4BNSrqjTEK/KkXTa+NhlbofwR1Yb4MIU6VyHduPfT94Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uTYR8iB7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uTYR8iB7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 26EDD1A1354;
	Fri, 31 Jul 2026 09:52:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EEACA6039A;
	Fri, 31 Jul 2026 09:52:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D517C11C16653;
	Fri, 31 Jul 2026 11:52:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785491535; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6tzTwtIzcwNOGYqYYE5OkMxf/iAPgArnZ5FvnJjna6Q=;
	b=uTYR8iB7jFeWw7kdAcGrp3RNuxdIaqvrHiOwjjk7Q08w7c3CegBaRjkS436uJeE2phJhgi
	qV+X5Rxfa3Kg9+D8ZZRC72J/ki6dBFqI4uPLLn1Kjud/MdGkvPm+1rqbhHypUDcec1jpHK
	fJZrsmt7wC3P2U6/+EU1+8W+gPj/vVleD90cYCQjvR6AQ9RJvpqz9UTTwj+1K5lBL+QyB1
	z+xRrtppTikqrb4oPvtkddM936qUkF6Lfb3zB3TLnWvQXA+s+6gQNcZhHsA1ltwu7EECDs
	G02pTGxR0BHJfvqj6CRhGJbjAEJ2XWrzrTlSPPDU6IV6dji0qvQlMFumFg90MA==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Fri, 31 Jul 2026 11:51:45 +0200
Subject: [PATCH v8 5/5] watchdog: aaeon: Add watchdog driver for SRG-IMX8P
 MCU
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-dev-b4-aaeon-mcu-driver-v8-5-9ab00e80df2a@bootlin.com>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
In-Reply-To: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add watchdog driver for the Aaeon SRG-IMX8P embedded controller.
This driver provides system monitoring and recovery capabilities
through the MCU's watchdog timer.

The watchdog supports start, stop, and ping operations with a maximum
hardware heartbeat of 25 seconds and a default timeout of 240 seconds.
The software timeout can be changed via the WDIOC_SETTIMEOUT ioctl,
the DT timeout-sec property, or the watchdog_timeout kernel boot
parameter.

Co-developed-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS                      |   1 +
 drivers/watchdog/Kconfig         |  10 +++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/aaeon_mcu_wdt.c | 168 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 180 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2538f8c4bc14..7b92af42c9fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -193,6 +193,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
 F:	drivers/gpio/gpio-aaeon-mcu.c
 F:	drivers/mfd/aaeon-mcu.c
+F:	drivers/watchdog/aaeon_mcu_wdt.c
 F:	include/linux/mfd/aaeon-mcu.h
 
 AAEON UPBOARD FPGA MFD DRIVER
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index d3b9df7d466b..f67a0b453316 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -420,6 +420,16 @@ config SL28CPLD_WATCHDOG
 
 # ARM Architecture
 
+config AAEON_MCU_WATCHDOG
+	tristate "Aaeon MCU Watchdog"
+	depends on MFD_AAEON_MCU
+	select WATCHDOG_CORE
+	help
+	  Select this option to enable watchdog timer support for the Aaeon
+	  SRG-IMX8P onboard microcontroller (MCU). This driver provides
+	  watchdog functionality through the MCU, allowing system monitoring
+	  and automatic recovery from system hangs.
+
 config AIROHA_WATCHDOG
 	tristate "Airoha EN7581 Watchdog"
 	depends on ARCH_AIROHA || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index ba52099b1253..2deec425d3ea 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 # ALPHA Architecture
 
 # ARM Architecture
+obj-$(CONFIG_AAEON_MCU_WATCHDOG) += aaeon_mcu_wdt.o
 obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
 obj-$(CONFIG_ARM_SBSA_WATCHDOG) += sbsa_gwdt.o
 obj-$(CONFIG_ARMADA_37XX_WATCHDOG) += armada_37xx_wdt.o
diff --git a/drivers/watchdog/aaeon_mcu_wdt.c b/drivers/watchdog/aaeon_mcu_wdt.c
new file mode 100644
index 000000000000..661d14393c6e
--- /dev/null
+++ b/drivers/watchdog/aaeon_mcu_wdt.c
@@ -0,0 +1,168 @@
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
+#define AAEON_MCU_PING_WDT	0x73
+
+#define AAEON_MCU_WDT_TIMEOUT         240
+#define AAEON_MCU_WDT_HEARTBEAT_MS    25000
+#define AAEON_MCU_WDT_MIN_TIMEOUT     1
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
+static int aaeon_mcu_wdt_cmd(struct aaeon_mcu_wdt *data, u8 opcode, u8 arg)
+{
+	return regmap_write(data->regmap, AAEON_MCU_REG(opcode, arg), 0);
+}
+
+static int aaeon_mcu_wdt_start(struct watchdog_device *wdt)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+
+	return aaeon_mcu_wdt_cmd(data, AAEON_MCU_CONTROL_WDT_OPCODE, 0x01);
+}
+
+static int aaeon_mcu_wdt_status(struct watchdog_device *wdt, bool *enabled)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+	unsigned int rsp;
+	int ret;
+
+	ret = regmap_read(data->regmap,
+			  AAEON_MCU_REG(AAEON_MCU_CONTROL_WDT_OPCODE, 0x02),
+			  &rsp);
+	if (ret)
+		return ret;
+
+	*enabled = rsp == 0x01;
+	return 0;
+}
+
+static int aaeon_mcu_wdt_stop(struct watchdog_device *wdt)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+
+	return aaeon_mcu_wdt_cmd(data, AAEON_MCU_CONTROL_WDT_OPCODE, 0x00);
+}
+
+static int aaeon_mcu_wdt_ping(struct watchdog_device *wdt)
+{
+	struct aaeon_mcu_wdt *data = watchdog_get_drvdata(wdt);
+
+	return aaeon_mcu_wdt_cmd(data, AAEON_MCU_PING_WDT, 0x00);
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
+	 * timeout-sec property or the watchdog_timeout kernel boot parameter.
+	 */
+	wdt->timeout = AAEON_MCU_WDT_TIMEOUT;
+	wdt->min_timeout = AAEON_MCU_WDT_MIN_TIMEOUT;
+	wdt->max_hw_heartbeat_ms = AAEON_MCU_WDT_HEARTBEAT_MS;
+	watchdog_init_timeout(wdt, timeout, dev->parent);
+
+	watchdog_set_drvdata(wdt, data);
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
2.55.0

