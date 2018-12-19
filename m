Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([185.16.172.187]:52998 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbeLSPSq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Dec 2018 10:18:46 -0500
From: Andrew Lunn <andrew@lunn.ch>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v4] watchdog: tqmx86: Add watchdog driver for the IO controller
Date: Wed, 19 Dec 2018 16:18:20 +0100
Message-Id: <1545232700-24462-1-git-send-email-andrew@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some TQ-Systems ComExpress modules have an IO controller with a
watchdog timer.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
v4:
Fix SPDX and MODULE_LICENSE() mismatch
Change MODULE_AUTHOR to me
Give credit to original author in header

v3:
Fix more typos
Don't overwrite the global timeout module parameter
Drop unnecessary platform_set_drvdata()
Call tqmx86_wdt_set_timeout() later, one module parameter has been validated

v2:
Fix various typos
Sort header files
Use watchdog_init_timeout(() to handle module parameter
Get core to validate timeout
Remove redundant ping function
Remove redundant stop function
Use devm_watchdog_register_device allowing release to be removed
Use WATCHDOG_NOWAYOUT
---
 drivers/watchdog/Kconfig      |  12 ++++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/tqmx86_wdt.c | 126 ++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/watchdog/tqmx86_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2d64333f4782..45f0c5e34ce1 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1308,6 +1308,18 @@ config SMSC37B787_WDT
 
 	  Most people will say N.
 
+config TQMX86_WDT
+	tristate "TQ-Systems TQMX86 Watchdog Timer"
+	depends on X86
+	help
+	This is the driver for the hardware watchdog timer in the TQMX86 IO
+	controller found on some of their ComExpress Modules.
+
+	To compile this driver as a module, choose M here; the module
+	will be called tqmx86_wdt.
+
+	Most people will say N.
+
 config VIA_WDT
 	tristate "VIA Watchdog Timer"
 	depends on X86 && PCI
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index f69cdff5ad7f..b077e35414e2 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_SBC7240_WDT) += sbc7240_wdt.o
 obj-$(CONFIG_CPU5_WDT) += cpu5wdt.o
 obj-$(CONFIG_SMSC_SCH311X_WDT) += sch311x_wdt.o
 obj-$(CONFIG_SMSC37B787_WDT) += smsc37b787_wdt.o
+obj-$(CONFIG_TQMX86_WDT) += tqmx86_wdt.o
 obj-$(CONFIG_VIA_WDT) += via_wdt.o
 obj-$(CONFIG_W83627HF_WDT) += w83627hf_wdt.o
 obj-$(CONFIG_W83877F_WDT) += w83877f_wdt.o
diff --git a/drivers/watchdog/tqmx86_wdt.c b/drivers/watchdog/tqmx86_wdt.c
new file mode 100644
index 000000000000..0d3a0fbbd7a5
--- /dev/null
+++ b/drivers/watchdog/tqmx86_wdt.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Watchdog driver for TQMx86 PLD.
+ *
+ * The watchdog supports power of 2 timeouts from 1 to 4096sec.
+ * Once started, it cannot be stopped.
+ *
+ * Based on the vendor code written by Vadim V.Vlasov
+ * <vvlasov@dev.rtsoft.ru>
+ */
+
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/timer.h>
+#include <linux/watchdog.h>
+
+/* default timeout (secs) */
+#define WDT_TIMEOUT 32
+
+static unsigned int timeout;
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout,
+	"Watchdog timeout in seconds. (1<=timeout<=4096, default="
+				__MODULE_STRING(WDT_TIMEOUT) ")");
+struct tqmx86_wdt {
+	struct watchdog_device wdd;
+	void __iomem *io_base;
+};
+
+#define TQMX86_WDCFG	0x00 /* Watchdog Configuration Register */
+#define TQMX86_WDCS	0x01 /* Watchdog Config/Status Register */
+
+static int tqmx86_wdt_start(struct watchdog_device *wdd)
+{
+	struct tqmx86_wdt *priv = watchdog_get_drvdata(wdd);
+
+	iowrite8(0x81, priv->io_base + TQMX86_WDCS);
+
+	return 0;
+}
+
+static int tqmx86_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
+{
+	struct tqmx86_wdt *priv = watchdog_get_drvdata(wdd);
+	u8 val;
+
+	t = roundup_pow_of_two(t);
+	val = ilog2(t) | 0x90;
+	val += 3; /* values 0,1,2 correspond to 0.125,0.25,0.5s timeouts */
+	iowrite8(val, priv->io_base + TQMX86_WDCFG);
+
+	wdd->timeout = t;
+
+	return 0;
+}
+
+static const struct watchdog_info tqmx86_wdt_info = {
+	.options	= WDIOF_SETTIMEOUT |
+			  WDIOF_KEEPALIVEPING,
+	.identity	= "TQMx86 Watchdog",
+};
+
+static struct watchdog_ops tqmx86_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= tqmx86_wdt_start,
+	.set_timeout	= tqmx86_wdt_set_timeout,
+};
+
+static int tqmx86_wdt_probe(struct platform_device *pdev)
+{
+	struct tqmx86_wdt *priv;
+	struct resource *res;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	if (IS_ERR(res))
+		return PTR_ERR(res);
+
+	priv->io_base = devm_ioport_map(&pdev->dev, res->start,
+					resource_size(res));
+	if (IS_ERR(priv->io_base))
+		return PTR_ERR(priv->io_base);
+
+	watchdog_set_drvdata(&priv->wdd, priv);
+
+	priv->wdd.parent = &pdev->dev;
+	priv->wdd.info = &tqmx86_wdt_info;
+	priv->wdd.ops = &tqmx86_wdt_ops;
+	priv->wdd.min_timeout = 1;
+	priv->wdd.max_timeout = 4096;
+	priv->wdd.max_hw_heartbeat_ms = 4096*1000;
+	priv->wdd.timeout = WDT_TIMEOUT;
+
+	watchdog_init_timeout(&priv->wdd, timeout, &pdev->dev);
+	watchdog_set_nowayout(&priv->wdd, WATCHDOG_NOWAYOUT);
+
+	tqmx86_wdt_set_timeout(&priv->wdd, priv->wdd.timeout);
+
+	err = devm_watchdog_register_device(&pdev->dev, &priv->wdd);
+	if (err)
+		return err;
+
+	dev_info(&pdev->dev, "TQMx86 watchdog\n");
+
+	return 0;
+}
+
+static struct platform_driver tqmx86_wdt_driver = {
+	.driver		= {
+		.name	= "tqmx86-wdt",
+	},
+	.probe		= tqmx86_wdt_probe,
+};
+
+module_platform_driver(tqmx86_wdt_driver);
+
+MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
+MODULE_DESCRIPTION("TQMx86 Watchdog");
+MODULE_ALIAS("platform:tqmx86-wdt");
+MODULE_LICENSE("GPL");
-- 
2.19.1
