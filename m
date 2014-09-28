Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:62796 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbaI1Sb0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Sep 2014 14:31:26 -0400
Received: by mail-la0-f43.google.com with SMTP id gb8so7295689lab.16
        for <linux-watchdog@vger.kernel.org>; Sun, 28 Sep 2014 11:31:25 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux MIPS <linux-mips@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 12/16] watchdog: add Atheros AR2315 watchdog driver
Date: Sun, 28 Sep 2014 22:33:11 +0400
Message-Id: <1411929195-23775-13-git-send-email-ryazanov.s.a@gmail.com>
In-Reply-To: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
References: <1411929195-23775-1-git-send-email-ryazanov.s.a@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---

Changes since RFC:
  - use watchdog infrastructure
  - remove deprecated IRQF_DISABLED flag
  - move device registration to separate patch

 drivers/watchdog/Kconfig      |   8 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/ar2315-wtd.c | 167 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+)
 create mode 100644 drivers/watchdog/ar2315-wtd.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f57312f..dbace99 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1186,6 +1186,14 @@ config RALINK_WDT
 	help
 	  Hardware driver for the Ralink SoC Watchdog Timer.
 
+config AR2315_WDT
+	tristate "Atheros AR2315+ WiSoCs Watchdog Timer"
+	select WATCHDOG_CORE
+	depends on SOC_AR2315
+	help
+	  Hardware driver for the built-in watchdog timer on the Atheros
+	  AR2315/AR2316 WiSoCs.
+
 # PARISC Architecture
 
 # POWERPC Architecture
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 468c320..ef7f83b 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_WDT_MTX1) += mtx-1_wdt.o
 obj-$(CONFIG_PNX833X_WDT) += pnx833x_wdt.o
 obj-$(CONFIG_SIBYTE_WDOG) += sb_wdog.o
 obj-$(CONFIG_AR7_WDT) += ar7_wdt.o
+obj-$(CONFIG_AR2315_WDT) += ar2315-wtd.o
 obj-$(CONFIG_TXX9_WDT) += txx9wdt.o
 obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
diff --git a/drivers/watchdog/ar2315-wtd.c b/drivers/watchdog/ar2315-wtd.c
new file mode 100644
index 0000000..4fd34d2
--- /dev/null
+++ b/drivers/watchdog/ar2315-wtd.c
@@ -0,0 +1,167 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ *
+ * Copyright (C) 2008 John Crispin <blogic@openwrt.org>
+ * Based on EP93xx and ifxmips wdt driver
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+
+#define DRIVER_NAME	"ar2315-wdt"
+
+#define CLOCK_RATE 40000000
+
+#define WDT_REG_TIMER		0x00
+#define WDT_REG_CTRL		0x04
+
+#define WDT_CTRL_ACT_NONE	0x00000000	/* No action */
+#define WDT_CTRL_ACT_NMI	0x00000001	/* NMI on watchdog */
+#define WDT_CTRL_ACT_RESET	0x00000002	/* reset on watchdog */
+
+static int started;
+static void __iomem *wdt_base;
+
+static inline void ar2315_wdt_wr(unsigned reg, u32 val)
+{
+	iowrite32(val, wdt_base + reg);
+}
+
+static void ar2315_wdt_enable(struct watchdog_device *wdd)
+{
+	ar2315_wdt_wr(WDT_REG_TIMER, wdd->timeout * CLOCK_RATE);
+}
+
+static int ar2315_wdt_start(struct watchdog_device *wdd)
+{
+	ar2315_wdt_enable(wdd);
+	started = 1;
+	return 0;
+}
+
+static int ar2315_wdt_stop(struct watchdog_device *wdd)
+{
+	return 0;
+}
+
+static int ar2315_wdt_ping(struct watchdog_device *wdd)
+{
+	ar2315_wdt_enable(wdd);
+	return 0;
+}
+
+static int ar2315_wdt_set_timeout(struct watchdog_device *wdd, unsigned val)
+{
+	wdd->timeout = val;
+	return 0;
+}
+
+static irqreturn_t ar2315_wdt_interrupt(int irq, void *dev)
+{
+	struct platform_device *pdev = (struct platform_device *)dev;
+
+	if (started) {
+		dev_crit(&pdev->dev, "watchdog expired, rebooting system\n");
+		emergency_restart();
+	} else {
+		ar2315_wdt_wr(WDT_REG_CTRL, 0);
+		ar2315_wdt_wr(WDT_REG_TIMER, 0);
+	}
+	return IRQ_HANDLED;
+}
+
+static const struct watchdog_info ar2315_wdt_info = {
+	.identity = "ar2315 Watchdog",
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+};
+
+static const struct watchdog_ops ar2315_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = ar2315_wdt_start,
+	.stop = ar2315_wdt_stop,
+	.ping = ar2315_wdt_ping,
+	.set_timeout = ar2315_wdt_set_timeout,
+};
+
+static struct watchdog_device ar2315_wdt_dev = {
+	.info = &ar2315_wdt_info,
+	.ops = &ar2315_wdt_ops,
+	.min_timeout = 1,
+	.max_timeout = 90,
+	.timeout = 20,
+};
+
+static int ar2315_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret = 0;
+
+	if (wdt_base)
+		return -EBUSY;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(wdt_base))
+		return PTR_ERR(wdt_base);
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res) {
+		dev_err(dev, "no IRQ resource\n");
+		return -ENOENT;
+	}
+
+	ret = devm_request_irq(dev, res->start, ar2315_wdt_interrupt, 0,
+			       DRIVER_NAME, pdev);
+	if (ret) {
+		dev_err(dev, "failed to register inetrrupt\n");
+		return ret;
+	}
+
+	ar2315_wdt_dev.parent = dev;
+	ret = watchdog_register_device(&ar2315_wdt_dev);
+	if (ret) {
+		dev_err(dev, "failed to register watchdog device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ar2315_wdt_remove(struct platform_device *pdev)
+{
+	watchdog_unregister_device(&ar2315_wdt_dev);
+	return 0;
+}
+
+static struct platform_driver ar2315_wdt_driver = {
+	.probe = ar2315_wdt_probe,
+	.remove = ar2315_wdt_remove,
+	.driver = {
+		.name = DRIVER_NAME,
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(ar2315_wdt_driver);
+
+MODULE_DESCRIPTION("Atheros AR2315 hardware watchdog driver");
+MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
1.8.5.5

