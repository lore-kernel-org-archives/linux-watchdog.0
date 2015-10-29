Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:40391 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbbJ2U1u (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 29 Oct 2015 16:27:50 -0400
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Cc: shawnguo@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	robh+dt@kernel.org, sameo@linux.intel.com, lee.jones@linaro.org,
	dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
Date: Thu, 29 Oct 2015 16:27:28 -0400
Message-Id: <1446150450-22093-4-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
 .../devicetree/bindings/mfd/ts4800-syscon.txt      |   8 +
 .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  12 ++
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/ts4800-syscon.c                        |  13 +-
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/ts4800_wdt.c                      | 216 +++++++++++++++++++++
 7 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
 create mode 100644 drivers/watchdog/ts4800_wdt.c

diff --git a/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
index 8dbc12c..8c0fd1d 100644
--- a/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
+++ b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
@@ -4,9 +4,17 @@ Required properties:
 - compatible : must be "ts,ts4800-syscon"
 - reg : physical base address and length of memory mapped region
 
+The driver exposes following subdevices:
+- a watchdog: see ../watchdog/ts4800-wdt.txt
+
 Example:
 
 syscon@b0010000 {
 	compatible = "ts,ts4800-syscon";
 	reg = <0xb0010000 0x3d>;
+
+	wdt@e {
+		compatible = "ts,ts4800-wdt";
+		offset = <0xe>;
+	};
 };
diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
new file mode 100644
index 0000000..a9305c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
@@ -0,0 +1,12 @@
+Technologic Systems Watchdog
+
+Required properties:
+- compatible : must be "ts,ts4800-wdt"
+- offset : offset of the feed register from syscon base
+
+Example:
+
+wdt1: wdt@b0010000 {
+	compatible = "ts,ts4800-wdt";
+	offset = <0xe>;
+};
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8f03dce..95ba036 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1304,6 +1304,7 @@ config MFD_TC6393XB
 
 config MFD_TS4800_SYSCON
 	tristate "TS-4800 Syscon Support"
+	select MFD_CORE
 	select REGMAP
 	select REGMAP_MMIO
 	help
diff --git a/drivers/mfd/ts4800-syscon.c b/drivers/mfd/ts4800-syscon.c
index 1e42e96..03b3b04a 100644
--- a/drivers/mfd/ts4800-syscon.c
+++ b/drivers/mfd/ts4800-syscon.c
@@ -24,6 +24,13 @@
 #include <linux/mfd/ts4800-syscon.h>
 
 
+static const struct mfd_cell ts4800_syscon_cells[] = {
+	{
+		.name = "ts4800-watchdog",
+		.of_compatible = "ts,ts4800-wdt",
+	},
+};
+
 static const struct regmap_config ts4800_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 2,
@@ -56,11 +63,15 @@ static int ts4800_syscon_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, syscon);
 
-	return 0;
+	return mfd_add_devices(&pdev->dev, -1, ts4800_syscon_cells,
+			       ARRAY_SIZE(ts4800_syscon_cells),
+			       NULL, 0, NULL);
 }
 
 static int ts4800_syscon_remove(struct platform_device *pdev)
 {
+	mfd_remove_devices(&pdev->dev);
+
 	return 0;
 }
 
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 241fafd..aaa42b8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -417,6 +417,16 @@ config NUC900_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called nuc900_wdt.
 
+config TS4800_WATCHDOG
+	tristate "TS-4800 Watchdog"
+	depends on OF
+	depends on MFD_TS4800_SYSCON
+	select WATCHDOG_CORE
+	help
+	  Technologic Systems TS-4800 has watchdog timer implemented in
+	  an external FPGA. Say Y here if you want to support for the
+	  watchdog timer on TS-4800 board.
+
 config TS72XX_WATCHDOG
 	tristate "TS-72XX SBC Watchdog"
 	depends on MACH_TS72XX
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 59ea9a1..435fc93 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) += rn5t618_wdt.o
 obj-$(CONFIG_COH901327_WATCHDOG) += coh901327_wdt.o
 obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) += stmp3xxx_rtc_wdt.o
 obj-$(CONFIG_NUC900_WATCHDOG) += nuc900_wdt.o
+obj-$(CONFIG_TS4800_WATCHDOG) += ts4800_wdt.o
 obj-$(CONFIG_TS72XX_WATCHDOG) += ts72xx_wdt.o
 obj-$(CONFIG_IMX2_WDT) += imx2_wdt.o
 obj-$(CONFIG_UX500_WATCHDOG) += ux500_wdt.o
diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
new file mode 100644
index 0000000..9b9e638
--- /dev/null
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -0,0 +1,216 @@
+/*
+ * ts4800_wdt.c - Watchdog driver for TS-4800 based boards
+ *
+ * Copyright (c) 2015 - Savoir-faire Linux
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/watchdog.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/mfd/ts4800-syscon.h>
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+	"Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+
+/* possible feed values */
+#define TS4800_WDT_FEED_2S	0x1
+#define TS4800_WDT_FEED_10S	0x2
+#define TS4800_WDT_DISABLE	0x3
+
+
+struct ts4800_wdt {
+	struct watchdog_device  wdd;
+	struct regmap           *regmap;
+	u32                     feed_offset;
+	u16                     feed_val;
+};
+
+/*
+ * TS-4800 supports the following timeout values:
+ *
+ *   value desc
+ *   ---------------------
+ *     0    feed for 338ms
+ *     1    feed for 2.706s
+ *     2    feed for 10.824s
+ *     3    disable watchdog
+ *
+ * Keep the regmap/timeout map ordered by timeout
+ */
+static const struct {
+	const int timeout;
+	const int regval;
+} ts4800_wdt_map[] = {
+	{ 2,  TS4800_WDT_FEED_2S },
+	{ 10, TS4800_WDT_FEED_10S },
+};
+
+static int timeout_to_regval(struct watchdog_device *wdd, int new_timeout)
+{
+	int i;
+
+	new_timeout = clamp_val(new_timeout,
+				wdd->min_timeout, wdd->max_timeout);
+
+	for (i = 0; i < ARRAY_SIZE(ts4800_wdt_map); i++) {
+		if (ts4800_wdt_map[i].timeout >= new_timeout)
+			return ts4800_wdt_map[i].timeout;
+	}
+
+	return -EINVAL;
+}
+
+static void ts4800_write_feed(struct ts4800_wdt *wdt, u16 val)
+{
+	regmap_write(wdt->regmap, wdt->feed_offset, val);
+}
+
+static int ts4800_wdt_ping(struct watchdog_device *wdd)
+{
+	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	ts4800_write_feed(wdt, wdt->feed_val);
+	return 0;
+}
+
+static int ts4800_wdt_stop(struct watchdog_device *wdd)
+{
+	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	ts4800_write_feed(wdt, TS4800_WDT_DISABLE);
+	return 0;
+}
+
+static int ts4800_wdt_set_timeout(struct watchdog_device *wdd,
+				  unsigned int new_timeout)
+{
+	struct ts4800_wdt *wdt = watchdog_get_drvdata(wdd);
+	int val = timeout_to_regval(wdd, new_timeout);
+
+	if (val < 0)
+		return val;
+
+	wdt->feed_val = (u16) val;
+
+	return 0;
+}
+
+static const struct watchdog_ops ts4800_wdt_ops = {
+	.owner = THIS_MODULE,
+	/*
+	 * pinging the watchdog enables it, so use same function
+	 * for pinging and starting the watchdog
+	 */
+	.start = ts4800_wdt_ping,
+	.stop = ts4800_wdt_stop,
+	.ping = ts4800_wdt_ping,
+	.set_timeout = ts4800_wdt_set_timeout,
+};
+
+static const struct watchdog_info ts4800_wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
+	.identity = "TS-4800 Watchdog",
+};
+
+static int ts4800_wdt_probe(struct platform_device *pdev)
+{
+	int max_timeout_index = ARRAY_SIZE(ts4800_wdt_map) - 1;
+	struct device_node *np = pdev->dev.of_node;
+	struct ts4800_syscon *syscon;
+	struct watchdog_device *wdd;
+	struct ts4800_wdt *wdt;
+	u32 offset;
+	int ret;
+
+	ret = of_property_read_u32(np, "offset", &offset);
+	if (ret) {
+		dev_err(&pdev->dev, "An offset must be provided\n");
+		return -EINVAL;
+	}
+
+	/* allocate memory for watchdog struct */
+	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	/* set regmap and offset to know where to write */
+	syscon = dev_get_drvdata(pdev->dev.parent);
+	wdt->regmap = syscon->regmap;
+	wdt->feed_offset = offset;
+
+	/* Initialize struct watchdog_device */
+	wdd = &wdt->wdd;
+	wdd->info = &ts4800_wdt_info;
+	wdd->ops = &ts4800_wdt_ops;
+	wdd->min_timeout = ts4800_wdt_map[0].timeout;
+	wdd->max_timeout = ts4800_wdt_map[max_timeout_index].timeout;
+	wdd->timeout = wdd->max_timeout;
+	wdt->feed_val = ts4800_wdt_map[max_timeout_index].regval;
+
+	watchdog_set_drvdata(wdd, wdt);
+	watchdog_set_nowayout(wdd, nowayout);
+
+	/*
+	 * Must be called after watchdog_set_drvdata to dereference a valid
+	 * pointer. The feed register is write-only, so it is not possible to
+	 * determine if watchdog is already started or not. Disable it to be in
+	 * a known state.
+	 */
+	ts4800_wdt_stop(wdd);
+
+	ret = watchdog_register_device(wdd);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to register watchdog device\n");
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, wdt);
+
+	dev_info(&pdev->dev,
+		 "initialized (timeout = %d sec, nowayout = %d)\n",
+		 wdd->timeout, nowayout);
+
+	return 0;
+}
+
+static int ts4800_wdt_remove(struct platform_device *pdev)
+{
+	struct ts4800_wdt *wdt = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(&wdt->wdd);
+
+	return 0;
+}
+
+static const struct of_device_id ts4800_wdt_of_match[] = {
+	{ .compatible = "ts,ts4800-wdt", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ts4800_wdt_of_match);
+
+static struct platform_driver ts4800_wdt_driver = {
+	.probe		= ts4800_wdt_probe,
+	.remove		= ts4800_wdt_remove,
+	.driver		= {
+		.name	= "ts4800_wdt",
+		.of_match_table = ts4800_wdt_of_match,
+	},
+};
+
+module_platform_driver(ts4800_wdt_driver);
+
+MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ts4800_wdt");
-- 
2.5.0

