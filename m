Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34993 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751090AbdAPEUe (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 15 Jan 2017 23:20:34 -0500
Received: by mail-pf0-f180.google.com with SMTP id f144so50012108pfa.2
        for <linux-watchdog@vger.kernel.org>; Sun, 15 Jan 2017 20:20:33 -0800 (PST)
From: Baoyou Xie <baoyou.xie@linaro.org>
To: jun.nie@linaro.org, wim@iguana.be, linux@roeck-us.net,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        baoyou.xie@linaro.org, xie.baoyou@zte.com.cn,
        chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
Subject: [PATCH v1 3/3] watchdog: zx2967: add watchdog controller driver for ZTE's zx2967 family
Date: Mon, 16 Jan 2017 12:19:55 +0800
Message-Id: <1484540395-3335-3-git-send-email-baoyou.xie@linaro.org>
In-Reply-To: <1484540395-3335-1-git-send-email-baoyou.xie@linaro.org>
References: <1484540395-3335-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds watchdog controller driver for ZTE's zx2967 family.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/watchdog/Kconfig      |  10 ++
 drivers/watchdog/Makefile     |   1 +
 drivers/watchdog/zx2967_wdt.c | 405 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 416 insertions(+)
 create mode 100644 drivers/watchdog/zx2967_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3eb58cb..79027da 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -714,6 +714,16 @@ config ASPEED_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called aspeed_wdt.
 
+config ZX2967_WATCHDOG
+	tristate "ZTE zx2967 SoCs watchdog support"
+	depends on ARCH_ZX
+	select WATCHDOG_CORE
+	help
+	  Say Y here to include support for the watchdog timer
+	  in ZTE zx2967 SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called zx2967_wdt.
+
 # AVR32 Architecture
 
 config AT32AP700X_WDT
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index caa9f4a..ea08925 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 obj-$(CONFIG_ATLAS7_WATCHDOG) += atlas7_wdt.o
 obj-$(CONFIG_RENESAS_WDT) += renesas_wdt.o
 obj-$(CONFIG_ASPEED_WATCHDOG) += aspeed_wdt.o
+obj-$(CONFIG_ZX2967_WATCHDOG) += zx2967_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
new file mode 100644
index 0000000..8791dd2
--- /dev/null
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -0,0 +1,405 @@
+/*
+ * watchdog driver for ZTE's zx2967 family
+ *
+ * Copyright (C) 2017 ZTE Ltd.
+ *
+ * Author: Baoyou Xie <baoyou.xie@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/reset.h>
+#include <linux/watchdog.h>
+
+#define ZX2967_WDT_CFG_REG			0x4
+#define ZX2967_WDT_LOAD_REG			0x8
+#define ZX2967_WDT_REFRESH_REG			0x18
+#define ZX2967_WDT_START_REG			0x1c
+
+#define ZX2967_WDT_REFRESH_MASK			0x3f
+
+#define ZX2967_WDT_CFG_DIV(n)			((((n)&0xff) - 1) << 8)
+#define ZX2967_WDT_START_EN			0x1
+
+#define ZX2967_WDT_WRITEKEY			0x12340000
+
+#define ZX2967_WDT_DIV_DEFAULT			16
+#define ZX2967_WDT_DEFAULT_TIMEOUT		32
+#define ZX2967_WDT_MIN_TIMEOUT			1
+#define ZX2967_WDT_MAX_TIMEOUT			500
+#define ZX2967_WDT_MAX_COUNT			0xffff
+
+#define ZX2967_WDT_FLAG_REBOOT_MON		(1 << 0)
+
+#define ZX2967_RESET_MASK_REG			0xb0
+
+#define zx2967_wdt_write_reg(v, r) \
+			writel((v) | ZX2967_WDT_WRITEKEY, r)
+#define zx2967_wdt_read_reg(r)			readl(r)
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+static unsigned int timeout = ZX2967_WDT_DEFAULT_TIMEOUT;
+
+struct zx2967_wdt {
+	struct device		*dev;
+	struct clk		*clock;
+	void __iomem		*reg_base;
+	unsigned int		conf;
+	unsigned int		load;
+	unsigned int		flags;
+	spinlock_t		lock;
+	struct watchdog_device	wdt_device;
+	struct notifier_block	restart_handler;
+	struct notifier_block	reboot_handler;
+};
+
+static void zx2967_wdt_refresh(struct zx2967_wdt *wdt)
+{
+	unsigned int val;
+
+	spin_lock(&wdt->lock);
+
+	val = zx2967_wdt_read_reg(wdt->reg_base + ZX2967_WDT_REFRESH_REG);
+	val ^= ZX2967_WDT_REFRESH_MASK;
+	zx2967_wdt_write_reg(val, wdt->reg_base + ZX2967_WDT_REFRESH_REG);
+
+	spin_unlock(&wdt->lock);
+}
+
+static void __zx2967_wdt_stop(struct zx2967_wdt *wdt)
+{
+	unsigned int val;
+
+	spin_lock(&wdt->lock);
+
+	val = zx2967_wdt_read_reg(wdt->reg_base + ZX2967_WDT_START_REG);
+	val &= ~(ZX2967_WDT_START_EN);
+	zx2967_wdt_write_reg(val, wdt->reg_base + ZX2967_WDT_START_REG);
+
+	spin_unlock(&wdt->lock);
+}
+
+static void __zx2967_wdt_start(struct zx2967_wdt *wdt)
+{
+	unsigned int val;
+
+	spin_lock(&wdt->lock);
+
+	val = zx2967_wdt_read_reg(wdt->reg_base + ZX2967_WDT_START_REG);
+	val |= ZX2967_WDT_START_EN;
+	zx2967_wdt_write_reg(val, wdt->reg_base + ZX2967_WDT_START_REG);
+
+	spin_unlock(&wdt->lock);
+}
+
+static unsigned int
+__zx2967_wdt_set_timeout(struct zx2967_wdt *wdt, unsigned int timeout)
+{
+	unsigned int freq = clk_get_rate(wdt->clock);
+	unsigned int divisor = ZX2967_WDT_DIV_DEFAULT, count;
+
+	count = timeout * freq;
+	if (count > divisor * ZX2967_WDT_MAX_COUNT)
+		divisor = DIV_ROUND_UP(count, ZX2967_WDT_MAX_COUNT);
+	count = DIV_ROUND_UP(count, divisor);
+	zx2967_wdt_write_reg(ZX2967_WDT_CFG_DIV(divisor),
+			     wdt->reg_base + ZX2967_WDT_CFG_REG);
+	zx2967_wdt_write_reg(count, wdt->reg_base + ZX2967_WDT_LOAD_REG);
+	zx2967_wdt_refresh(wdt);
+
+	wdt->load = count;
+	dev_info(wdt->dev, "count=%d, timeout=%d, divisor=%d\n",
+		 count, timeout, divisor);
+
+	return (count * divisor) / freq;
+}
+
+static int zx2967_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int timeout)
+{
+	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	if (watchdog_timeout_invalid(&wdt->wdt_device, timeout)) {
+		dev_err(wdt->dev, "timeout %d is invalid\n", timeout);
+
+		return -EINVAL;
+	}
+
+	wdd->timeout = __zx2967_wdt_set_timeout(wdt, timeout);
+
+	return 0;
+}
+
+static int zx2967_wdt_start(struct watchdog_device *wdd)
+{
+	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	__zx2967_wdt_stop(wdt);
+	zx2967_wdt_set_timeout(wdd, wdd->timeout);
+	__zx2967_wdt_start(wdt);
+
+	return 0;
+}
+
+static int zx2967_wdt_stop(struct watchdog_device *wdd)
+{
+	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	__zx2967_wdt_stop(wdt);
+
+	return 0;
+}
+
+static int zx2967_wdt_keepalive(struct watchdog_device *wdd)
+{
+	struct zx2967_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	zx2967_wdt_refresh(wdt);
+
+	return 0;
+}
+
+#define ZX2967_WDT_OPTIONS \
+	(WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE)
+static const struct watchdog_info zx2967_wdt_ident = {
+	.options          =     ZX2967_WDT_OPTIONS,
+	.firmware_version =	0,
+	.identity         =	"zx2967 watchdog",
+};
+
+static struct watchdog_ops zx2967_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = zx2967_wdt_start,
+	.stop = zx2967_wdt_stop,
+	.ping = zx2967_wdt_keepalive,
+	.set_timeout = zx2967_wdt_set_timeout,
+};
+
+static void zx2967_wdt_fix_sysdown(struct zx2967_wdt *wdt)
+{
+	__zx2967_wdt_stop(wdt);
+	__zx2967_wdt_set_timeout(wdt, 15);
+	__zx2967_wdt_start(wdt);
+}
+
+static int zx2967_wdt_notify_sys(struct notifier_block *this,
+			     unsigned long code, void *unused)
+{
+	struct zx2967_wdt *wdt = container_of(this, struct zx2967_wdt,
+					      reboot_handler);
+
+	wdt->flags |= ZX2967_WDT_FLAG_REBOOT_MON;
+	switch (code) {
+	case SYS_HALT:
+	case SYS_POWER_OFF:
+	case SYS_RESTART:
+		zx2967_wdt_fix_sysdown(wdt);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int zx2967_wdt_restart(struct notifier_block *this,
+			      unsigned long mode, void *cmd)
+{
+	struct zx2967_wdt *wdt;
+
+	wdt = container_of(this, struct zx2967_wdt, restart_handler);
+
+	zx2967_wdt_stop(&wdt->wdt_device);
+
+	zx2967_wdt_write_reg(0x80, wdt->reg_base + ZX2967_WDT_LOAD_REG);
+	zx2967_wdt_refresh(wdt);
+	zx2967_wdt_write_reg(ZX2967_WDT_START_EN,
+			     wdt->reg_base + ZX2967_WDT_START_REG);
+
+	zx2967_wdt_start(&wdt->wdt_device);
+	/* wait for reset*/
+	mdelay(500);
+
+	return NOTIFY_DONE;
+}
+
+static void zx2967_reset_mask_config(struct device *dev)
+{
+	struct device_node *np = NULL;
+	void __iomem *reg;
+	unsigned int  val, mask, config, size;
+	const unsigned int *prop;
+
+	prop = of_get_property(dev->of_node, "reset-mask-config", &size);
+	if (size < (sizeof(*prop) * 2)) {
+		dev_err(dev, "bad data for reset-mask-config");
+		return;
+	}
+	config = be32_to_cpup(prop++);
+	mask = be32_to_cpup(prop);
+	np = of_find_compatible_node(NULL, NULL, "zte,aon-sysctrl");
+	if (!np) {
+		dev_err(dev, "Cannot found pcu device node\n");
+		return;
+	}
+	reg = of_iomap(np, 0) + ZX2967_RESET_MASK_REG;
+	of_node_put(np);
+
+	val = readl(reg);
+	val &= ~mask;
+	val |= config;
+	writel(val, reg);
+}
+
+static int zx2967_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev;
+	struct zx2967_wdt *wdt;
+	struct resource *base;
+	int err, ret = 0;
+	unsigned int rate, val;
+
+	struct reset_control *rstc;
+
+	dev = &pdev->dev;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	wdt->dev = dev;
+	spin_lock_init(&wdt->lock);
+
+	wdt->wdt_device.info = &zx2967_wdt_ident;
+	wdt->wdt_device.ops = &zx2967_wdt_ops;
+	wdt->wdt_device.timeout = ZX2967_WDT_DEFAULT_TIMEOUT;
+	wdt->wdt_device.max_timeout = ZX2967_WDT_MAX_TIMEOUT;
+	wdt->wdt_device.min_timeout = ZX2967_WDT_MIN_TIMEOUT;
+	wdt->wdt_device.parent = &pdev->dev;
+
+	base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->reg_base = devm_ioremap_resource(dev, base);
+
+	if (of_find_property(dev->of_node, "reset-mask-config", NULL))
+		zx2967_reset_mask_config(dev);
+
+	wdt->reboot_handler.notifier_call = zx2967_wdt_notify_sys;
+	ret = register_reboot_notifier(&wdt->reboot_handler);
+	wdt->clock = devm_clk_get(dev, "wdtclk");
+	if (IS_ERR(wdt->clock)) {
+		dev_err(dev, "failed to find watchdog clock source\n");
+		ret = PTR_ERR(wdt->clock);
+		goto out;
+	}
+	ret = clk_prepare_enable(wdt->clock);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable clock\n");
+		goto out;
+	}
+
+	rate = clk_get_rate(wdt->clock);
+	if (rate == 24000000)
+		ret = clk_set_rate(wdt->clock, 32768);
+	rate = clk_get_rate(wdt->clock);
+
+	rstc = devm_reset_control_get(dev, "wdtrst");
+	if (!rstc) {
+		dev_info(dev, "rstc get failed");
+	} else {
+		reset_control_assert(rstc);
+		mdelay(10);
+		reset_control_deassert(rstc);
+	}
+
+	watchdog_set_drvdata(&wdt->wdt_device, wdt);
+
+	watchdog_init_timeout(&wdt->wdt_device, timeout, &pdev->dev);
+	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
+
+	zx2967_wdt_stop(&wdt->wdt_device);
+
+	err = watchdog_register_device(&wdt->wdt_device);
+	if (unlikely(err)) {
+		ret = err;
+		goto fail_register;
+	}
+
+	wdt->restart_handler.notifier_call = zx2967_wdt_restart;
+	wdt->restart_handler.priority = 128;
+	ret = register_restart_handler(&wdt->restart_handler);
+	if (ret) {
+		pr_err("cannot register restart handler, %d\n", ret);
+		goto fail_restart;
+	}
+
+	val = zx2967_wdt_read_reg(wdt->reg_base + ZX2967_WDT_START_REG);
+	dev_info(&pdev->dev, "watchdog enabled (timeout=%d sec, nowayout=%d)",
+		 wdt->wdt_device.timeout, nowayout);
+
+	return 0;
+
+fail_restart:
+	watchdog_unregister_device(&wdt->wdt_device);
+fail_register:
+	clk_disable_unprepare(wdt->clock);
+out:
+	return ret;
+}
+
+static int zx2967_wdt_remove(struct platform_device *pdev)
+{
+	struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
+
+	unregister_restart_handler(&wdt->restart_handler);
+	watchdog_unregister_device(&wdt->wdt_device);
+	clk_disable_unprepare(wdt->clock);
+
+	return 0;
+}
+
+static void zx2967_wdt_shutdown(struct platform_device *pdev)
+{
+	struct zx2967_wdt *wdt = platform_get_drvdata(pdev);
+
+	if (!(wdt->flags & ZX2967_WDT_FLAG_REBOOT_MON))
+		zx2967_wdt_stop(&wdt->wdt_device);
+}
+
+static const struct of_device_id zx2967_wdt_match[] = {
+	{ .compatible = "zte,zx296718-wdt", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, zx2967_wdt_match);
+
+static const struct platform_device_id zx2967_wdt_ids[] = {
+	{ .name = "zx2967-wdt", },
+	{}
+};
+MODULE_DEVICE_TABLE(platform, zx2967_wdt_ids);
+
+static struct platform_driver zx2967_wdt_driver = {
+	.probe		= zx2967_wdt_probe,
+	.remove		= zx2967_wdt_remove,
+	.shutdown	= zx2967_wdt_shutdown,
+	.id_table	= zx2967_wdt_ids,
+	.driver		= {
+		.name	= "zx2967-wdt",
+		.of_match_table	= of_match_ptr(zx2967_wdt_match),
+	},
+};
+module_platform_driver(zx2967_wdt_driver);
+
+MODULE_AUTHOR("Baoyou Xie <baoyou.xie@linaro.org>");
+MODULE_DESCRIPTION("ZTE zx2967 Watchdog Device Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

