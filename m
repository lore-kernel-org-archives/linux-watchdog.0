Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:6915 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752518AbdCBOCQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 2 Mar 2017 09:02:16 -0500
From: Chris Brandt <chris.brandt@renesas.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH v4 1/3] watchdog: add rza_wdt driver
Date: Thu,  2 Mar 2017 08:57:44 -0500
Message-Id: <20170302135746.30550-2-chris.brandt@renesas.com>
In-Reply-To: <20170302135746.30550-1-chris.brandt@renesas.com>
References: <20170302135746.30550-1-chris.brandt@renesas.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Adds a watchdog timer driver for the Renesas RZ/A Series SoCs. A reset
handler is also included since a WDT overflow is the only method for
restarting an RZ/A SoC.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/watchdog/Kconfig   |   8 ++
 drivers/watchdog/Makefile  |   1 +
 drivers/watchdog/rza_wdt.c | 208 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/watchdog/rza_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index acb00b5..123c516 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -701,6 +701,14 @@ config RENESAS_WDT
 	  This driver adds watchdog support for the integrated watchdogs in the
 	  Renesas R-Car and other SH-Mobile SoCs (usually named RWDT or SWDT).
 
+config RENESAS_RZAWDT
+	tristate "Renesas RZ/A WDT Watchdog"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select WATCHDOG_CORE
+	help
+	  This driver adds watchdog support for the integrated watchdogs in the
+	  Renesas RZ/A SoCs. These watchdogs can be used to reset a system.
+
 config ASPEED_WATCHDOG
 	tristate "Aspeed 2400 watchdog support"
 	depends on ARCH_ASPEED || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0c3d35e..84b897c 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -81,6 +81,7 @@ obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
 obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
 obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
+obj-$(CONFIG_RENESAS_RZAWDT) += rza_wdt.o
 obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
 
 # AVR32 Architecture
diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
new file mode 100644
index 0000000..17442c5
--- /dev/null
+++ b/drivers/watchdog/rza_wdt.c
@@ -0,0 +1,208 @@
+/*
+ * Renesas RZ/A Series WDT Driver
+ *
+ * Copyright (C) 2017 Renesas Electronics America, Inc.
+ * Copyright (C) 2017 Chris Brandt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/delay.h>
+#include <linux/watchdog.h>
+#include <linux/clk.h>
+
+#define DEFAULT_TIMEOUT 30
+
+/* Watchdog Timer Registers */
+#define WTCSR 0
+#define WTCSR_MAGIC 0xA500
+#define WTSCR_WT (1<<6)
+#define WTSCR_TME (1<<5)
+#define WTSCR_CKS(i) i
+
+#define WTCNT 2
+#define WTCNT_MAGIC 0x5A00
+
+#define WRCSR 4
+#define WRCSR_MAGIC 0x5A00
+#define WRCSR_RSTE (1<<6)
+#define WRCSR_CLEAR_WOVF 0xA500 /* special value */
+
+struct rza_wdt {
+	struct watchdog_device wdev;
+	void __iomem *base;
+	struct clk *clk;
+};
+
+static int rza_wdt_start(struct watchdog_device *wdev)
+{
+	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
+
+	/* Stop timer */
+	writew(WTCSR_MAGIC | 0, priv->base + WTCSR);
+
+	/* Must dummy read WRCSR:WOVF at least once before clearing */
+	readb(priv->base + WRCSR);
+	writew(WRCSR_CLEAR_WOVF, priv->base + WRCSR);
+
+	/*
+	 * Start timer with slowest clock source and reset option enabled.
+	 */
+	writew(WRCSR_MAGIC | WRCSR_RSTE, priv->base + WRCSR);
+	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
+	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME | WTSCR_CKS(7),
+	       priv->base + WTCSR);
+
+	return 0;
+}
+
+static int rza_wdt_stop(struct watchdog_device *wdev)
+{
+	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
+
+	writew(WTCSR_MAGIC | 0, priv->base + WTCSR);
+
+	return 0;
+}
+
+static int rza_wdt_ping(struct watchdog_device *wdev)
+{
+	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
+
+	writew(WTCNT_MAGIC | 0, priv->base + WTCNT);
+
+	return 0;
+}
+
+static int rza_wdt_restart(struct watchdog_device *wdev, unsigned long action,
+			    void *data)
+{
+	struct rza_wdt *priv = watchdog_get_drvdata(wdev);
+
+	/* Stop timer */
+	writew(WTCSR_MAGIC | 0, priv->base + WTCSR);
+
+	/* Must dummy read WRCSR:WOVF at least once before clearing */
+	readb(priv->base + WRCSR);
+	writew(WRCSR_CLEAR_WOVF, priv->base + WRCSR);
+
+	/*
+	 * Start timer with fastest clock source and only 1 clock left before
+	 * overflow with reset option enabled.
+	 */
+	writew(WRCSR_MAGIC | WRCSR_RSTE, priv->base + WRCSR);
+	writew(WTCNT_MAGIC | 255, priv->base + WTCNT);
+	writew(WTCSR_MAGIC | WTSCR_WT | WTSCR_TME, priv->base + WTCSR);
+
+	/*
+	 * Actually make sure the above sequence hits hardware before sleeping.
+	 */
+	wmb();
+
+	/* Wait for WDT overflow (reset) */
+	udelay(20);
+
+	return 0;
+}
+
+static const struct watchdog_info rza_wdt_ident = {
+	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.identity = "Renesas RZ/A WDT Watchdog",
+};
+
+static const struct watchdog_ops rza_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = rza_wdt_start,
+	.stop = rza_wdt_stop,
+	.ping = rza_wdt_ping,
+	.restart = rza_wdt_restart,
+};
+
+static int rza_wdt_probe(struct platform_device *pdev)
+{
+	struct rza_wdt *priv;
+	struct resource *res;
+	unsigned long rate;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	rate = clk_get_rate(priv->clk);
+	if (!rate)
+		return -ENOENT;
+
+	/* Assume slowest clock rate possible (CKS=7) */
+	rate /= 16384;
+
+	priv->wdev.info = &rza_wdt_ident,
+	priv->wdev.ops = &rza_wdt_ops,
+	priv->wdev.parent = &pdev->dev;
+
+	/*
+	 * Since the max possible timeout of our 8-bit count register is less
+	 * than a second, we must use max_hw_heartbeat_ms.
+	 */
+	priv->wdev.max_hw_heartbeat_ms = (1000 * U8_MAX)/rate;
+	dev_info(&pdev->dev, "max hw timeout of %dms\n",
+		 priv->wdev.max_hw_heartbeat_ms);
+
+	priv->wdev.min_timeout = 1;
+	priv->wdev.timeout = DEFAULT_TIMEOUT;
+
+	platform_set_drvdata(pdev, priv);
+	watchdog_set_drvdata(&priv->wdev, priv);
+
+	ret = watchdog_register_device(&priv->wdev);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int rza_wdt_remove(struct platform_device *pdev)
+{
+	struct rza_wdt *priv = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&priv->wdev);
+	iounmap(priv->base);
+	return 0;
+}
+
+static const struct of_device_id rza_wdt_of_match[] = {
+	{ .compatible = "renesas,rza-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rza_wdt_of_match);
+
+static struct platform_driver rza_wdt_driver = {
+	.probe = rza_wdt_probe,
+	.remove = rza_wdt_remove,
+	.driver = {
+		.name = "rza_wdt",
+		.of_match_table = rza_wdt_of_match,
+	},
+};
+
+module_platform_driver(rza_wdt_driver);
+
+MODULE_DESCRIPTION("Renesas RZ/A WDT Driver");
+MODULE_AUTHOR("Chris Brandt <chris.brandt@renesas.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.10.1


