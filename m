Return-path: <root@danube-imgworks.hb.imgtec.org>
From: Naidu.Tellapati@imgtec.com
To: wim@iguana.be, linux@roeck-us.net, James.Hartley@imgtec.com,
        abrestic@chromium.org, Ezequiel.Garcia@imgtec.com
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        Jude.Abraham@imgtec.com, Naidu Tellapati <Naidu.Tellapati@imgtec.com>
Subject: [PATCH v3 1/2] watchdog: ImgTec PDC Watchdog Timer Driver
Date: Tue, 18 Nov 2014 17:37:21 +0530
Message-Id: <1416312442-15688-2-git-send-email-Naidu.Tellapati@imgtec.com>
In-Reply-To: <1416312442-15688-1-git-send-email-Naidu.Tellapati@imgtec.com>
References: <1416312442-15688-1-git-send-email-Naidu.Tellapati@imgtec.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <Naidu.Tellapati@imgtec.com>

This commit adds support for ImgTec PowerDown Controller Watchdog Timer.

Signed-off-by: Jude Abraham <Jude.Abraham@imgtec.com>
Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
---
 drivers/watchdog/Kconfig      |   11 ++
 drivers/watchdog/Makefile     |    1 +
 drivers/watchdog/imgpdc_wdt.c |  311 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 323 insertions(+), 0 deletions(-)
 create mode 100644 drivers/watchdog/imgpdc_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index d0107d4..a184f23 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1235,6 +1235,17 @@ config BCM_KONA_WDT_DEBUG
 
 	  If in doubt, say 'N'.
 
+config IMGPDC_WDT
+	tristate "Imagination Technologies PDC Watchdog Timer"
+	depends on HAS_IOMEM
+	depends on METAG || MIPS || COMPILE_TEST
+	help
+	  Driver for Imagination Technologies PowerDown Controller
+	  Watchdog Timer.
+
+	  To compile this driver as a loadable module, choose M here.
+	  The module will be called imgpdc_wdt.
+
 config LANTIQ_WDT
 	tristate "Lantiq SoC watchdog"
 	depends on LANTIQ
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index c569ec8..d4dfbb4 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
 octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
 obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
 obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
+obj-$(CONFIG_IMGPDC_WDT) += imgpdc_wdt.o
 
 # PARISC Architecture
 
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
new file mode 100644
index 0000000..aeee05a
--- /dev/null
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -0,0 +1,311 @@
+/*
+ * Imagination Technologies PowerDown Controller Watchdog Timer.
+ *
+ * Copyright (c) 2014 Imagination Technologies Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo Caione
+ *                                                     2012 Henrik Nordstrom
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/watchdog.h>
+
+/* registers */
+#define PDC_WD_SW_RESET			0x000
+
+#define PDC_WD_CONFIG			0x004
+#define PDC_WD_MAX_DELAY		31 /* 4:0 bits */
+#define PDC_WD_CONFIG_ENABLE		BIT(31)
+#define PDC_WD_CONFIG_DELAY_MASK	0x0000001f
+#define PDC_WD_CONFIG_DELAY_SHIFT	0
+
+#define PDC_WD_TICKLE1			0x008
+#define PDC_WD_TICKLE1_MAGIC		0xabcd1234
+
+#define PDC_WD_TICKLE2			0x00c
+#define PDC_WD_TICKLE2_MAGIC		0x4321dcba
+
+#define PDC_WD_TICKLE_STATUS_MASK	0x00000007
+#define PDC_WD_TICKLE_STATUS_SHIFT	0
+#define PDC_WD_TICKLE_STATUS_HRESET     0x0  /* Hard reset */
+#define PDC_WD_TICKLE_STATUS_TIMEOUT    0x1  /* Timeout */
+#define PDC_WD_TICKLE_STATUS_TICKLE     0x2  /* Tickled incorrectly */
+#define PDC_WD_TICKLE_STATUS_SRESET     0x3  /* Soft reset */
+#define PDC_WD_TICKLE_STATUS_USER       0x4  /* User reset */
+
+#define PDC_WD_MAX_CLK_RATE		50000000U
+
+/* timeout in seconds */
+#define PDC_WD_MIN_TIMEOUT		1
+#define PDC_WD_DEFAULT_TIMEOUT		64
+
+static int timeout = PDC_WD_DEFAULT_TIMEOUT;
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout, "PDC watchdog delay in seconds (default 64s)");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
+
+struct pdc_wdt_dev {
+	struct device *dev;
+	struct watchdog_device wdt_dev;
+	struct clk *wdt_clk;
+	struct clk *sys_clk;
+	unsigned long clk_rate;
+	unsigned int min_delay;
+	void __iomem *base;
+	spinlock_t lock;
+};
+
+static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
+{
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	spin_lock(&wdt->lock);
+	writel(PDC_WD_TICKLE1_MAGIC, wdt->base + PDC_WD_TICKLE1);
+	writel(PDC_WD_TICKLE2_MAGIC, wdt->base + PDC_WD_TICKLE2);
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static int pdc_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	spin_lock(&wdt->lock);
+	val = readl(wdt->base + PDC_WD_CONFIG);
+	val &= ~PDC_WD_CONFIG_ENABLE;
+	writel(val, wdt->base + PDC_WD_CONFIG);
+	spin_unlock(&wdt->lock);
+
+	/* Must tickle to finish the stop */
+	pdc_wdt_keepalive(wdt_dev);
+
+	return 0;
+}
+
+static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
+			       unsigned int new_timeout)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	if (new_timeout < wdt->wdt_dev.min_timeout ||
+	    new_timeout > wdt->wdt_dev.max_timeout)
+		return -EINVAL;
+
+	spin_lock(&wdt->lock);
+	wdt->wdt_dev.timeout = new_timeout;
+	/* round up to the next power of 2 */
+	new_timeout = order_base_2(new_timeout);
+	val = readl(wdt->base + PDC_WD_CONFIG);
+	val &= ~(PDC_WD_CONFIG_DELAY_MASK << PDC_WD_CONFIG_DELAY_SHIFT);
+	val |= (new_timeout + wdt->min_delay);
+	writel(val, wdt->base + PDC_WD_CONFIG);
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+/* Start the watchdog timer (delay should already be set */
+static int pdc_wdt_start(struct watchdog_device *wdt_dev)
+{
+	unsigned int val;
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	spin_lock(&wdt->lock);
+	val = readl(wdt->base + PDC_WD_CONFIG);
+	val |= PDC_WD_CONFIG_ENABLE;
+	writel(val, wdt->base + PDC_WD_CONFIG);
+	spin_unlock(&wdt->lock);
+
+	return 0;
+}
+
+static struct watchdog_info pdc_wdt_info = {
+	.options		= WDIOF_SETTIMEOUT |
+				  WDIOF_KEEPALIVEPING |
+				  WDIOF_MAGICCLOSE,
+	.identity = "PDC Watchdog",
+};
+
+/* Kernel interface */
+static const struct watchdog_ops pdc_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= pdc_wdt_start,
+	.stop		= pdc_wdt_stop,
+	.ping		= pdc_wdt_keepalive,
+	.set_timeout	= pdc_wdt_set_timeout,
+};
+
+static int pdc_wdt_probe(struct platform_device *pdev)
+{
+	int ret, val;
+	struct resource *res;
+	struct pdc_wdt_dev *pdc_wdt;
+
+	pdc_wdt = devm_kzalloc(&pdev->dev, sizeof(*pdc_wdt), GFP_KERNEL);
+	if (!pdc_wdt)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pdc_wdt->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pdc_wdt->base))
+		return PTR_ERR(pdc_wdt->base);
+
+	pdc_wdt->sys_clk = devm_clk_get(&pdev->dev, "sys");
+	if (IS_ERR(pdc_wdt->sys_clk)) {
+		dev_err(&pdev->dev, "failed to get the sys clock.\n");
+		ret = PTR_ERR(pdc_wdt->wdt_clk);
+		goto out_wdt;
+	}
+
+	spin_lock_init(&pdc_wdt->lock);
+
+	pdc_wdt->wdt_clk = devm_clk_get(&pdev->dev, "wdt");
+	if (IS_ERR(pdc_wdt->wdt_clk)) {
+		dev_err(&pdev->dev, "failed to get the wdt clock.\n");
+		ret = PTR_ERR(pdc_wdt->wdt_clk);
+		goto out_wdt;
+	}
+
+	ret = clk_prepare_enable(pdc_wdt->sys_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not prepare or enable sys clock.\n");
+		goto out_wdt;
+	}
+
+	ret = clk_prepare_enable(pdc_wdt->wdt_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "could not prepare or enable wdt clock.\n");
+		goto disable_sys_clk;
+	}
+	/* We use the clock rate to calculate the max timeout */
+	pdc_wdt->clk_rate = clk_get_rate(pdc_wdt->wdt_clk);
+	if (pdc_wdt->clk_rate < 1 || pdc_wdt->clk_rate > PDC_WD_MAX_CLK_RATE) {
+		dev_err(&pdev->dev, "invalid clock rate\n");
+		ret = -EINVAL;
+		goto disable_wdt_clk;
+	}
+
+	if (order_base_2(pdc_wdt->clk_rate)  == 0)
+		pdc_wdt->min_delay = 0;
+	else
+		pdc_wdt->min_delay = order_base_2(pdc_wdt->clk_rate) - 1;
+
+	pdc_wdt->wdt_dev.info = &pdc_wdt_info;
+	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
+	pdc_wdt->wdt_dev.min_timeout = PDC_WD_MIN_TIMEOUT;
+	pdc_wdt->wdt_dev.max_timeout =
+				(1 << (PDC_WD_MAX_DELAY - pdc_wdt->min_delay));
+	pdc_wdt->wdt_dev.parent = &pdev->dev;
+	pdc_wdt->dev = &pdev->dev;
+
+	ret = watchdog_init_timeout(&pdc_wdt->wdt_dev, timeout, &pdev->dev);
+	if (ret < 0)
+		pdc_wdt->wdt_dev.timeout = pdc_wdt->wdt_dev.max_timeout;
+
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+	/* Set timeouts before userland has a chance to start the timer */
+	pdc_wdt_set_timeout(&pdc_wdt->wdt_dev, pdc_wdt->wdt_dev.timeout);
+
+	/* Find what caused the last reset */
+	val = readl(pdc_wdt->base + PDC_WD_TICKLE1);
+	val = (val & PDC_WD_TICKLE_STATUS_MASK) >> PDC_WD_TICKLE_STATUS_SHIFT;
+	switch (val) {
+	case PDC_WD_TICKLE_STATUS_TICKLE:
+	case PDC_WD_TICKLE_STATUS_TIMEOUT:
+		pdc_wdt->wdt_dev.bootstatus |= WDIOF_CARDRESET;
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to timeout\n");
+		break;
+	case PDC_WD_TICKLE_STATUS_HRESET:
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to hard reset\n");
+		break;
+	case PDC_WD_TICKLE_STATUS_SRESET:
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to soft reset\n");
+		break;
+	case PDC_WD_TICKLE_STATUS_USER:
+		dev_info(&pdev->dev,
+			"watchdog module last reset due to user reset\n");
+		break;
+	default:
+		dev_info(&pdev->dev,
+			"contains an illegal status code (%08x)\n", val);
+		break;
+	}
+
+	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
+
+	platform_set_drvdata(pdev, pdc_wdt);
+	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
+
+	ret = watchdog_register_device(&pdc_wdt->wdt_dev);
+	if (ret)
+		goto disable_wdt_clk;
+
+	return 0;
+
+disable_wdt_clk:
+	clk_disable_unprepare(pdc_wdt->wdt_clk);
+disable_sys_clk:
+	clk_disable_unprepare(pdc_wdt->sys_clk);
+out_wdt:
+	return ret;
+}
+
+static void pdc_wdt_shutdown(struct platform_device *pdev)
+{
+	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
+
+	pdc_wdt_stop(&pdc_wdt->wdt_dev);
+}
+
+static int pdc_wdt_remove(struct platform_device *pdev)
+{
+	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
+
+	pdc_wdt_shutdown(pdev);
+	watchdog_unregister_device(&pdc_wdt->wdt_dev);
+	clk_disable_unprepare(pdc_wdt->wdt_clk);
+	clk_disable_unprepare(pdc_wdt->sys_clk);
+
+	return 0;
+}
+
+
+static const struct of_device_id pdc_wdt_match[] = {
+	{ .compatible = "img,pdc-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pdc_wdt_match);
+
+static struct platform_driver pdc_wdt_driver = {
+	.driver = {
+		.name = "imgpdc-wdt",
+		.of_match_table	= pdc_wdt_match,
+	},
+	.probe = pdc_wdt_probe,
+	.remove = pdc_wdt_remove,
+	.shutdown = pdc_wdt_shutdown,
+};
+module_platform_driver(pdc_wdt_driver);
+
+MODULE_AUTHOR("Jude Abraham <Jude.Abraham@imgtec.com>");
+MODULE_AUTHOR("Naidu Tellapati <Naidu.Tellapati@imgtec.com>");
+MODULE_DESCRIPTION("Imagination Technologies PDC Watchdog Timer Driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.0.4
