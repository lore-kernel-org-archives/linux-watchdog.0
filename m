Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:61961 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbbIRJXo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 18 Sep 2015 05:23:44 -0400
From: Oleksij Rempel <linux@rempel-privat.de>
To: linux-watchdog@vger.kernel.org, wim@iguana.be
Cc: Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH] watchdog: add Alphascale asm9260-wdt driver
Date: Fri, 18 Sep 2015 11:23:32 +0200
Message-Id: <1442568212-15509-1-git-send-email-linux@rempel-privat.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add WD support for Alphascale asm9260 SoC. This driver
provide support for different function modes:
- HW mode to trigger SoC reset on timeout
- SW mode do soft reset if needed
- DEBUG mode

Optional support for stopping watchdog. If reset binding are not provided
this driver will work in nowayout mode.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 .../bindings/watchdog/alphascale-asm9260.txt       |  38 ++
 drivers/watchdog/Kconfig                           |   9 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/asm9260_wdt.c                     | 405 +++++++++++++++++++++
 4 files changed, 453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
 create mode 100644 drivers/watchdog/asm9260_wdt.c

diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
new file mode 100644
index 0000000..cbe388b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
@@ -0,0 +1,38 @@
+Alphascale asm9260 Watchdog timer
+
+Required properties:
+
+- compatible : should be "alphascale,asm9260-wdt".
+- reg : Specifies base physical address and size of the registers.
+- clocks : the clock feeding the watchdog timer.
+	Needed if platform uses clocks. See clock-bindings.txt
+- clock-names : should be set to
+	"mod" - source for tick counter.
+	"ahb" - ahb gate.
+
+Optional properties:
+- resets : phandle pointing to the system reset controller with correct
+	reset line index for watchdog controller reset. This propertie is
+	required if you need to disable "nowayout" and it works only with
+	CONFIG_WATCHDOG_NOWAYOUT=n.
+- reset-names : should be set to "wdt_rst" if "resets" is used.
+- timeout-sec : shall contain the default watchdog timeout in seconds,
+	if unset, the default timeout is 30 seconds.
+- alphascale,mode : tree modes are supported
+	"hw" - hw reset (defaul).
+	"sw" - sw reset.
+	"debug" - no action is taken.
+
+Example:
+
+watchdog0: watchdog@80048000 {
+	compatible = "alphascale,asm9260-wdt";
+	reg = <0x80048000 0x10>;
+	clocks = <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
+	clock-names = "mod", "ahb";
+	interrupts = <55>;
+	resets = <&rst WDT_RESET>;
+	reset-names = "wdt_rst";
+	timeout-sec = <30>;
+	alphascale,mode = "hw"
+};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c68edc1..cc5f675 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -173,6 +173,15 @@ config ARM_SP805_WATCHDOG
 	  ARM Primecell SP805 Watchdog timer. This will reboot your system when
 	  the timeout is reached.
 
+config ASM9260_WATCHDOG
+	tristate "Alphascale ASM9260 watchdog"
+	depends on MACH_ASM9260
+	depends on OF
+	select WATCHDOG_CORE
+	help
+	  Watchdog timer embedded into Alphascale asm9260 chips. This will reboot your
+	  system when the timeout is reached.
+
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
 	depends on SOC_AT91RM9200 && MFD_SYSCON
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0c616e3..bd7b0cd 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
 
 # ARM Architecture
 obj-$(CONFIG_ARM_SP805_WATCHDOG) += sp805_wdt.o
+obj-$(CONFIG_ASM9260_WATCHDOG) += asm9260_wdt.o
 obj-$(CONFIG_AT91RM9200_WATCHDOG) += at91rm9200_wdt.o
 obj-$(CONFIG_AT91SAM9X_WATCHDOG) += at91sam9_wdt.o
 obj-$(CONFIG_CADENCE_WATCHDOG) += cadence_wdt.o
diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
new file mode 100644
index 0000000..e5f859b
--- /dev/null
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -0,0 +1,405 @@
+/*
+ * Watchdog driver for Alphascale ASM9260.
+ *
+ * Copyright (c) 2014 Oleksij Rempel <linux@rempel-privat.de>
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#include <linux/delay.h>
+#include <linux/clk.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/reset.h>
+#include <linux/uaccess.h>
+#include <linux/watchdog.h>
+
+#define CLOCK_FREQ	1000000
+
+/* Watchdog Mode register */
+#define HW_WDMOD			0x00
+/* Wake interrupt. Set by HW, can't be cleared. */
+#define BM_MOD_WDINT			BIT(3)
+/* This bit set if timeout reached. Cleared by SW. */
+#define BM_MOD_WDTOF			BIT(2)
+/* HW Reset on timeout */
+#define BM_MOD_WDRESET			BIT(1)
+/* WD enable */
+#define BM_MOD_WDEN			BIT(0)
+
+/*
+ * Watchdog Timer Constant register
+ * Minimal value is 0xff, the meaning of this value
+ * depends on used clock: T = WDCLK * (0xff + 1) * 4
+ */
+#define HW_WDTC				0x04
+#define BM_WDTC_MAX(freq)		(0x7fffffff / (freq))
+
+/* Watchdog Feed register */
+#define HW_WDFEED			0x08
+
+/* Watchdog Timer Value register */
+#define HW_WDTV				0x0c
+
+#define ASM9260_WDT_DEFAULT_TIMEOUT	30
+
+enum asm9260_wdt_mode {
+	HW_RESET,
+	SW_RESET,
+	DEBUG,
+};
+
+struct asm9260_wdt_priv {
+	struct device		*dev;
+	struct watchdog_device	wdd;
+	struct clk		*clk;
+	struct clk		*clk_ahb;
+	struct reset_control	*rst;
+	struct notifier_block	restart_handler;
+
+	void __iomem		*iobase;
+	int			irq;
+	unsigned long		wdt_freq;
+	enum asm9260_wdt_mode	mode;
+};
+
+static int asm9260_wdt_feed(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	iowrite32(0xaa, priv->iobase + HW_WDFEED);
+	iowrite32(0x55, priv->iobase + HW_WDFEED);
+
+	return 0;
+}
+
+static unsigned int asm9260_wdt_gettimeleft(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+	u32 counter;
+
+	counter = ioread32(priv->iobase + HW_WDTV);
+
+	return DIV_ROUND_CLOSEST(counter, priv->wdt_freq);
+}
+
+static int asm9260_wdt_updatetimeout(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+	u32 counter;
+
+	counter = wdd->timeout * priv->wdt_freq;
+
+	iowrite32(counter, priv->iobase + HW_WDTC);
+
+	return 0;
+}
+
+static int asm9260_wdt_enable(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+	u32 mode = 0;
+
+	if (priv->mode == HW_RESET)
+		mode = BM_MOD_WDRESET;
+
+	iowrite32(BM_MOD_WDEN | mode, priv->iobase + HW_WDMOD);
+
+	asm9260_wdt_updatetimeout(wdd);
+
+	asm9260_wdt_feed(wdd);
+
+	return 0;
+}
+
+static int asm9260_wdt_disable(struct watchdog_device *wdd)
+{
+	struct asm9260_wdt_priv *priv = watchdog_get_drvdata(wdd);
+
+	/* The only way to disable WD is to reset it. */
+	reset_control_assert(priv->rst);
+	reset_control_deassert(priv->rst);
+
+	return 0;
+}
+
+static int asm9260_wdt_settimeout(struct watchdog_device *wdd, unsigned int to)
+{
+	wdd->timeout = to;
+	asm9260_wdt_updatetimeout(wdd);
+
+	return 0;
+}
+
+static void asm9260_wdt_sys_reset(struct asm9260_wdt_priv *priv)
+{
+	/* init WD if it was not started */
+	priv->wdd.timeout = 1;
+
+	iowrite32(BM_MOD_WDEN | BM_MOD_WDRESET, priv->iobase + HW_WDMOD);
+
+	asm9260_wdt_updatetimeout(&priv->wdd);
+	/* first pass correct sequence */
+	asm9260_wdt_feed(&priv->wdd);
+	/*
+	 * Then write wrong pattern to the feed to trigger reset
+	 * ASAP.
+	 */
+	iowrite32(0xff, priv->iobase + HW_WDFEED);
+
+	mdelay(1000);
+}
+
+static irqreturn_t asm9260_wdt_irq(int irq, void *devid)
+{
+	struct asm9260_wdt_priv *priv = devid;
+	u32 stat;
+
+	stat = ioread32(priv->iobase + HW_WDMOD);
+	if (!(stat & BM_MOD_WDINT))
+		return IRQ_NONE;
+
+	/*
+	 * BM_MOD_WDINT flag can't be removed by SW. Only way is
+	 * to reset WD Controller.
+	 * TODO: add Controller reset if needed.
+	 */
+	if (priv->mode == DEBUG)
+		dev_info(priv->dev, "Watchdog Timeout. Do nothing.\n");
+	else {
+		dev_info(priv->dev, "Watchdog Timeout. Doing SW Reset.\n");
+		asm9260_wdt_sys_reset(priv);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int asm9260_restart_handler(struct notifier_block *this,
+				unsigned long mode, void *cmd)
+{
+	struct asm9260_wdt_priv *priv =
+		container_of(this, struct asm9260_wdt_priv, restart_handler);
+
+	asm9260_wdt_sys_reset(priv);
+
+	return NOTIFY_DONE;
+}
+
+static const struct watchdog_info asm9260_wdt_ident = {
+	.options          =     WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING
+				| WDIOF_MAGICCLOSE,
+	.firmware_version =	0,
+	.identity         =	"Alphascale asm9260 Watchdog",
+};
+
+static struct watchdog_ops asm9260_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= asm9260_wdt_enable,
+	.stop		= asm9260_wdt_disable,
+	.get_timeleft	= asm9260_wdt_gettimeleft,
+	.ping		= asm9260_wdt_feed,
+	.set_timeout	= asm9260_wdt_settimeout,
+};
+
+static int __init asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *priv)
+{
+	int clk_idx = 0, err;
+
+	priv->clk = devm_clk_get(priv->dev, "mod");
+	if (IS_ERR(priv->clk))
+		goto out_err;
+
+	/* configure AHB clock */
+	clk_idx = 1;
+	priv->clk_ahb = devm_clk_get(priv->dev, "ahb");
+	if (IS_ERR(priv->clk_ahb))
+		goto out_err;
+
+	err = clk_prepare_enable(priv->clk_ahb);
+	if (err)
+		dev_err(priv->dev, "Failed to enable ahb_clk!\n");
+
+	err = clk_set_rate(priv->clk, CLOCK_FREQ);
+	if (err) {
+		clk_disable_unprepare(priv->clk_ahb);
+		dev_err(priv->dev, "Failed to set rate!\n");
+	}
+
+	err = clk_prepare_enable(priv->clk);
+	if (err) {
+		clk_disable_unprepare(priv->clk_ahb);
+		dev_err(priv->dev, "Failed to enable clk!\n");
+	}
+
+	/* wdt has internal divider */
+	priv->wdt_freq = clk_get_rate(priv->clk) / 2;
+
+	return 0;
+out_err:
+	dev_err(priv->dev, "%s: Failed to get clk (%i)\n", __func__, clk_idx);
+	return 1;
+}
+
+static void __init asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *priv)
+{
+	const char *tmp;
+	int ret;
+
+	/* default mode */
+	priv->mode = HW_RESET;
+
+	ret = of_property_read_string(priv->dev->of_node,
+			"alphascale,mode", &tmp);
+	if (ret)
+		return;
+
+	if (!strcmp(tmp, "hw"))
+		priv->mode = HW_RESET;
+	else if (!strcmp(tmp, "sw"))
+		priv->mode = SW_RESET;
+	else if (!strcmp(tmp, "debug"))
+		priv->mode = DEBUG;
+	else {
+		dev_warn(priv->dev, "unknown reset-type: %s. Using defaul \"hw\" mode.",
+			tmp);
+		return;
+	}
+
+	dev_info(priv->dev, "using \"%s\" mode.", tmp);
+}
+
+static int __init asm9260_wdt_probe(struct platform_device *pdev)
+{
+	struct asm9260_wdt_priv *priv;
+	struct watchdog_device *wdd;
+	struct resource *res;
+	bool nowayout = WATCHDOG_NOWAYOUT;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(struct asm9260_wdt_priv),
+			GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->iobase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->iobase))
+		return PTR_ERR(priv->iobase);
+
+	ret = asm9260_wdt_get_dt_clks(priv);
+	if (ret)
+		return ret;
+
+	priv->rst = devm_reset_control_get(&pdev->dev, "wdt_rst");
+	if (IS_ERR(priv->rst)) {
+		dev_info(&pdev->dev, "No reset control found. Enabling \"nowayout\" mode\n");
+		nowayout = 1;
+		priv->rst = NULL;
+	}
+
+	wdd = &priv->wdd;
+	wdd->info = &asm9260_wdt_ident;
+	wdd->ops = &asm9260_wdt_ops;
+	wdd->min_timeout = 1;
+	wdd->max_timeout = BM_WDTC_MAX(priv->wdt_freq);
+	wdd->parent = &pdev->dev;
+
+	watchdog_set_drvdata(wdd, priv);
+
+	/*
+	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
+	 * default, unless the max timeout is less than 30 seconds, then use
+	 * the max instead.
+	 */
+	wdd->timeout = ASM9260_WDT_DEFAULT_TIMEOUT;
+	watchdog_init_timeout(wdd, 0, &pdev->dev);
+
+	watchdog_set_nowayout(wdd, nowayout);
+
+	asm9260_wdt_get_dt_mode(priv);
+
+	if (priv->mode != HW_RESET)
+		priv->irq = platform_get_irq(pdev, 0);
+
+	if (priv->irq > 0) {
+		/*
+		 * Not all supported platforms specify an interrupt for the
+		 * watchdog, so let's make it optional.
+		 */
+		ret = devm_request_irq(&pdev->dev, priv->irq,
+				asm9260_wdt_irq, IRQF_SHARED,
+				pdev->name, priv);
+		if (ret < 0)
+			dev_err(&pdev->dev, "failed to request IRQ\n");
+	}
+
+	ret = watchdog_register_device(wdd);
+	if (ret)
+		goto clk_off;
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->restart_handler.notifier_call = asm9260_restart_handler;
+	priv->restart_handler.priority = 128;
+	ret = register_restart_handler(&priv->restart_handler);
+	if (ret)
+		dev_err(&pdev->dev, "cannot register restart handler\n");
+
+	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
+		wdd->timeout, nowayout);
+	return 0;
+
+clk_off:
+	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_ahb);
+	return ret;
+}
+
+static void asm9260_wdt_shutdown(struct platform_device *pdev)
+{
+	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	asm9260_wdt_disable(&priv->wdd);
+}
+
+static int __exit asm9260_wdt_remove(struct platform_device *pdev)
+{
+	struct asm9260_wdt_priv *priv = platform_get_drvdata(pdev);
+
+	asm9260_wdt_shutdown(pdev);
+
+	unregister_restart_handler(&priv->restart_handler);
+	clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk_ahb);
+
+	return 0;
+}
+
+static const struct of_device_id asm9260_wdt_of_match[] = {
+	{ .compatible = "alphascale,asm9260-wdt"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, asm9260_wdt_of_match);
+
+static struct platform_driver asm9260_wdt_driver = {
+	.driver = {
+		.name = "asm9260-wdt",
+		.owner = THIS_MODULE,
+		.of_match_table	= asm9260_wdt_of_match,
+	},
+	.probe = asm9260_wdt_probe,
+	.remove = asm9260_wdt_remove,
+	.shutdown = asm9260_wdt_shutdown,
+};
+module_platform_driver(asm9260_wdt_driver);
+
+MODULE_DESCRIPTION("asm9260 WatchDog Timer Driver");
+MODULE_AUTHOR("Oleksij Rempel <linux@rempel-privat.de>");
+MODULE_LICENSE("GPL");
-- 
2.5.0

