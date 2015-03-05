Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:59031 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S964824AbbCEPud (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 5 Mar 2015 10:50:33 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v4 4/9] power: reset: Add AT91RM9200 reset driver
Date: Thu,  5 Mar 2015 16:49:49 +0100
Message-Id: <1425570594-13124-5-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425570594-13124-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

AT91RM9200 uses the watchdog from the system timer to reset.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/power/reset/Kconfig            |  7 ++++
 drivers/power/reset/Makefile           |  1 +
 drivers/power/reset/at91rm9200-reset.c | 72 ++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+)
 create mode 100644 drivers/power/reset/at91rm9200-reset.c

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 27f6646731b0..8d79e45ae754 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -30,6 +30,13 @@ config POWER_RESET_AT91_RESET
 	  This driver supports restart for Atmel AT91SAM9 and SAMA5
 	  SoCs
 
+config POWER_RESET_AT91RM9200_RESET
+	bool "Atmel AT91RM9200 reset driver"
+	depends on ARCH_AT91 && MFD_SYSCON
+	default SOC_AT91RM9200
+	help
+	  This driver supports restart for Atmel AT91RM9200.
+
 config POWER_RESET_AXXIA
 	bool "LSI Axxia reset driver"
 	depends on ARCH_AXXIA
diff --git a/drivers/power/reset/Makefile b/drivers/power/reset/Makefile
index 11de15bae52e..96e972bbb922 100644
--- a/drivers/power/reset/Makefile
+++ b/drivers/power/reset/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_POWER_RESET_AS3722) += as3722-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_POWEROFF) += at91-poweroff.o
 obj-$(CONFIG_POWER_RESET_AT91_RESET) += at91-reset.o
+obj-$(CONFIG_POWER_RESET_AT91RM9200_RESET) += at91rm9200-reset.o
 obj-$(CONFIG_POWER_RESET_AXXIA) += axxia-reset.o
 obj-$(CONFIG_POWER_RESET_BRCMSTB) += brcmstb-reboot.o
 obj-$(CONFIG_POWER_RESET_GPIO) += gpio-poweroff.o
diff --git a/drivers/power/reset/at91rm9200-reset.c b/drivers/power/reset/at91rm9200-reset.c
new file mode 100644
index 000000000000..b739ac82b9c9
--- /dev/null
+++ b/drivers/power/reset/at91rm9200-reset.c
@@ -0,0 +1,72 @@
+/*
+ * Atmel AT91 RM9200 SoCs reset code
+ *
+ * Copyright (C) 2015 Atmel Corporation.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mfd/syscon/atmel-st.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/regmap.h>
+
+static struct regmap *regmap_st;
+
+static int at91rm9200_restart(struct notifier_block *this,
+					unsigned long mode, void *cmd)
+{
+	/*
+	 * Perform a hardware reset with the use of the Watchdog timer.
+	 */
+	regmap_write(regmap_st, AT91_ST_WDMR,
+		     AT91_ST_RSTEN | AT91_ST_EXTEN | 1);
+	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
+
+	mdelay(2000);
+
+	pr_emerg("Unable to restart system\n");
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block at91rm9200_restart_nb = {
+	.notifier_call = at91rm9200_restart,
+	.priority = 192,
+};
+
+static int at91rm9200_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+
+	regmap_st = syscon_node_to_regmap(np);
+	if (!regmap_st)
+		return -ENODEV;
+
+	return register_restart_handler(&at91rm9200_restart_nb);
+}
+
+static const struct of_device_id at91rm9200_reset_of_match[] = {
+	{ .compatible = "atmel,at91rm9200-st" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver at91rm9200_reset_driver = {
+	.probe = at91rm9200_reset_probe,
+	.driver = {
+		.name = "at91rm9200-reset",
+		.of_match_table = at91rm9200_reset_of_match,
+	},
+};
+module_platform_driver(at91rm9200_reset_driver);
+
+MODULE_ALIAS("platform:at91rm9200-reset");
+MODULE_AUTHOR("Alexandre Belloni <alexandre.belloni@free-electrons.com>");
+MODULE_DESCRIPTION("Atmel at91rm9200 System Timer Reset driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.0

