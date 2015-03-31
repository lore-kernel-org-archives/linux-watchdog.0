Return-path: <baruch@tkos.co.il>
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v3 2/2] watchdog: digicolor: driver for Conexant Digicolor CX92755 SoC
Date: Tue, 31 Mar 2015 09:14:59 +0300
Message-Id: <c765076e13eb2407541c256d4c527bbacb53ddd8.1427782499.git.baruch@tkos.co.il>
In-Reply-To: <9995b9d0be8cda30103be7406a781cd79f347aeb.1427782499.git.baruch@tkos.co.il>
References: <9995b9d0be8cda30103be7406a781cd79f347aeb.1427782499.git.baruch@tkos.co.il>
List-ID: <linux-watchdog@vger.kernel.org>

This commit add a driver for the watchdog functionality of the Conexant CX92755
SoC, from the Digicolor series of SoCs. Of 8 system timers provided by the
CX92755, the first one, timer A, can reset the chip when its counter reaches
zero. This driver uses this capability to provide userspace with a standard
watchdog, using the watchdog timer driver core framework. This driver also
implements a reboot handler for the reboot(2) system call.

The watchdog driver shares the timer registers with the CX92755 timer driver
(drivers/clocksource/timer-digicolor.c). The timer driver, however, uses only
timers other than A, so both drivers should coexist.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v3:
   Address further comments of Guenter Roeck:

   * Remove redundant parentheses
   * Use a single label in probe error path

v2:
   Address the comments of Guenter Roeck:

   * Set default timeout to max_timeout
   * Move watchdog timer set code to a helper routine to avoid code duplication
   * Update watchdog timer on .set_timeout callback
   * Fix iomap leak on error path
   * Change restart registration error message to a warning
   * Use devm_clk_get() to acquire the clock
---
 drivers/watchdog/Kconfig         |  10 ++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/digicolor_wdt.c | 205 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/watchdog/digicolor_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 16f202350997..7d73d6c78cf6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -515,6 +515,16 @@ config MEDIATEK_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called mtk_wdt.
 
+config DIGICOLOR_WATCHDOG
+	tristate "Conexant Digicolor SoCs watchdog support"
+	depends on ARCH_DIGICOLOR
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in Conexant Digicolor SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called digicolor_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 5c19294d1c30..0721f10e8d13 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_BCM_KONA_WDT) += bcm_kona_wdt.o
 obj-$(CONFIG_TEGRA_WATCHDOG) += tegra_wdt.o
 obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
+obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
new file mode 100644
index 000000000000..31d8e4936611
--- /dev/null
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -0,0 +1,205 @@
+/*
+ * Watchdog driver for Conexant Digicolor
+ *
+ * Copyright (C) 2015 Paradox Innovation Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/watchdog.h>
+#include <linux/reboot.h>
+#include <linux/platform_device.h>
+#include <linux/of_address.h>
+
+#define TIMER_A_CONTROL		0
+#define TIMER_A_COUNT		4
+
+#define TIMER_A_ENABLE_COUNT	BIT(0)
+#define TIMER_A_ENABLE_WATCHDOG	BIT(1)
+
+struct dc_wdt {
+	void __iomem		*base;
+	struct clk		*clk;
+	struct notifier_block	restart_handler;
+	spinlock_t		lock;
+};
+
+static unsigned timeout;
+module_param(timeout, uint, 0);
+MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds");
+
+static void dc_wdt_set(struct dc_wdt *wdt, u32 ticks)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&wdt->lock, flags);
+
+	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
+	writel_relaxed(ticks, wdt->base + TIMER_A_COUNT);
+	writel_relaxed(TIMER_A_ENABLE_COUNT | TIMER_A_ENABLE_WATCHDOG,
+		       wdt->base + TIMER_A_CONTROL);
+
+	spin_unlock_irqrestore(&wdt->lock, flags);
+}
+
+static int dc_restart_handler(struct notifier_block *this, unsigned long mode,
+			      void *cmd)
+{
+	struct dc_wdt *wdt = container_of(this, struct dc_wdt, restart_handler);
+
+	dc_wdt_set(wdt, 1);
+	/* wait for reset to assert... */
+	mdelay(500);
+
+	return NOTIFY_DONE;
+}
+
+static int dc_wdt_start(struct watchdog_device *wdog)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+
+	dc_wdt_set(wdt, wdog->timeout * clk_get_rate(wdt->clk));
+
+	return 0;
+}
+
+static int dc_wdt_stop(struct watchdog_device *wdog)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+
+	writel_relaxed(0, wdt->base + TIMER_A_CONTROL);
+
+	return 0;
+}
+
+static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+
+	dc_wdt_set(wdt, t * clk_get_rate(wdt->clk));
+	wdog->timeout = t;
+
+	return 0;
+}
+
+static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
+	uint32_t count = readl_relaxed(wdt->base + TIMER_A_COUNT);
+
+	return count / clk_get_rate(wdt->clk);
+}
+
+static struct watchdog_ops dc_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= dc_wdt_start,
+	.stop		= dc_wdt_stop,
+	.set_timeout	= dc_wdt_set_timeout,
+	.get_timeleft	= dc_wdt_get_timeleft,
+};
+
+static struct watchdog_info dc_wdt_info = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE
+			| WDIOF_KEEPALIVEPING,
+	.identity	= "Conexant Digicolor Watchdog",
+};
+
+static struct watchdog_device dc_wdt_wdd = {
+	.info		= &dc_wdt_info,
+	.ops		= &dc_wdt_ops,
+	.min_timeout	= 1,
+};
+
+static int dc_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct dc_wdt *wdt;
+	int ret;
+
+	wdt = devm_kzalloc(dev, sizeof(struct dc_wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, wdt);
+
+	wdt->base = of_iomap(np, 0);
+	if (!wdt->base) {
+		dev_err(dev, "Failed to remap watchdog regs");
+		return -ENODEV;
+	}
+
+	wdt->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(wdt->clk)) {
+		ret = PTR_ERR(wdt->clk);
+		goto err_iounmap;
+	}
+	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
+	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
+
+	spin_lock_init(&wdt->lock);
+
+	watchdog_set_drvdata(&dc_wdt_wdd, wdt);
+	watchdog_init_timeout(&dc_wdt_wdd, timeout, dev);
+	ret = watchdog_register_device(&dc_wdt_wdd);
+	if (ret) {
+		dev_err(dev, "Failed to register watchdog device");
+		goto err_iounmap;
+	}
+
+	wdt->restart_handler.notifier_call = dc_restart_handler;
+	wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdt->restart_handler);
+	if (ret)
+		dev_warn(&pdev->dev, "cannot register restart handler\n");
+
+	return 0;
+
+err_iounmap:
+	iounmap(wdt->base);
+	return ret;
+}
+
+static int dc_wdt_remove(struct platform_device *pdev)
+{
+	struct dc_wdt *wdt = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&wdt->restart_handler);
+	watchdog_unregister_device(&dc_wdt_wdd);
+	iounmap(wdt->base);
+
+	return 0;
+}
+
+static void dc_wdt_shutdown(struct platform_device *pdev)
+{
+	dc_wdt_stop(&dc_wdt_wdd);
+}
+
+static const struct of_device_id dc_wdt_of_match[] = {
+	{ .compatible = "cnxt,cx92755-wdt", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dc_wdt_of_match);
+
+static struct platform_driver dc_wdt_driver = {
+	.probe		= dc_wdt_probe,
+	.remove		= dc_wdt_remove,
+	.shutdown	= dc_wdt_shutdown,
+	.driver = {
+		.name =		"digicolor-wdt",
+		.of_match_table = dc_wdt_of_match,
+	},
+};
+module_platform_driver(dc_wdt_driver);
+
+MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
+MODULE_DESCRIPTION("Driver for Conexant Digicolor watchdog timer");
+MODULE_LICENSE("GPL");
-- 
2.1.4
