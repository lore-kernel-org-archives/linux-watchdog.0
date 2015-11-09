Return-path: <wimvs@spo001.leaseweb.nl>
Date: Mon, 9 Nov 2015 19:51:17 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	David Cohen <david.a.cohen@linux.intel.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Justin Chen <justinpopo6@gmail.com>
Subject: [GIT PULL REQUEST] watchdog - v4.4 Merge window
Message-ID: <20151109185117.GA2268@spo001.leaseweb.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Linus,

Please pull from 'master' branch of
	git://www.linux-watchdog.org/linux-watchdog.git


It contains following changes:
* New driver for Broadcom 7038 Set-Top Box
* imx2_wdt: Use register definition in regmap_write()
* intel-mid: add Magic Closure flag
* watchdog framework improvements:
	Use device tree alias for naming watchdogs,
	propagate ping error code to the user space,
	Always evaluate new timeout against min_timeout,
	Use single variable name for struct watchdog_device
* include clean-ups
    
This will update the following files:

 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt |   19 
 drivers/watchdog/Kconfig                                        |    8 
 drivers/watchdog/Makefile                                       |    1 
 drivers/watchdog/bcm7038_wdt.c                                  |  237 ++++++++++
 drivers/watchdog/imx2_wdt.c                                     |    6 
 drivers/watchdog/intel-mid_wdt.c                                |    2 
 drivers/watchdog/watchdog_core.c                                |   15 
 drivers/watchdog/watchdog_dev.c                                 |  163 +++---
 include/linux/watchdog.h                                        |   23 
 9 files changed, 380 insertions(+), 94 deletions(-)

with these Changes:

commit 760d280084f8805e5de73e3591912d5db9da9dbe
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Tue Nov 3 09:00:16 2015 +0100

    watchdog: include: add units for timeout values in kerneldoc
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 80220fa72b917c64675f3ba4008d2c5a7b50b281
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Tue Nov 3 09:00:15 2015 +0100

    watchdog: include: fix some typos
    
    Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5ef796639c2cacaebc07cf7e63bd20d64f7b3cb0
Author: Alexander Usyskin <alexander.usyskin@intel.com>
Date:   Mon Oct 26 14:07:58 2015 +0200

    watchdog: core: propagate ping error code to the user space
    
    Watchdog ping return errors are ignored by watchdog core,
    Whatchdog daemon should be informed about possible hardware error or
    underlaying device driver get unregistered.
    
    Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
    Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit bc794ac3b5836ee2b2420b0597f33538ad100be0
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Tue Sep 29 01:27:25 2015 -0700

    watchdog: watchdog_dev: Use single variable name for struct watchdog_device
    
    The current code uses 'wdd', wddev', and 'watchdog' as variable names
    for struct watchdog_device. This is confusing and makes it difficult
    to enhance the code. Replace it all with 'wdd'.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
    Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 1e935949111e77b2b1b6fa550e88ff0573c2f4c7
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Tue Sep 29 01:27:24 2015 -0700

    watchdog: Always evaluate new timeout against min_timeout
    
    Up to now, a new timeout value is only evaluated against min_timeout
    if max_timeout is provided. This does not really make sense; a driver
    can have a minimum timeout even if it does not have a maximum timeout.
    Ensure that it is not smaller than min_timeout, even if max_timeout
    is not set.
    
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 8cbb97ea3e386eb95ecbd99260d681792963cebf
Author: David Cohen <david.a.cohen@linux.intel.com>
Date:   Mon Oct 5 16:49:58 2015 -0700

    watchdog: intel-mid: add Magic Closure flag
    
    Adding WDIOF_MAGICCLOSE to Intel MID watchdog driver. Once the watchdog
    is opened, it makes sense to disable watchdog only if it was gracefully
    released.
    
    Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9493c0d824f7012dab7034a5b527ac8f07db5bed
Author: Fabio Estevam <fabio.estevam@freescale.com>
Date:   Fri Oct 2 00:25:28 2015 -0300

    watchdog: imx2_wdt: Use register definition in regmap_write()
    
    In order to improve readability it is better to pass the register name
    definition rather than to pass its hardcoded offset.
    
    Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 9dd4e173f71d5ac6ea37f7dbf49af6e5cd44f9fb
Author: Justin Chen <justinpopo6@gmail.com>
Date:   Wed Sep 2 11:00:17 2015 -0700

    watchdog: watchdog_dev: Use device tree alias for naming watchdogs
    
    Currently there is no way to easily differentiate multiple
    watchdog devices. The watchdogs are named by the order they
    are probed.
    1st probed watchdog: /dev/watchdog0
    2nd probed watchdog: /dev/watchdog1
    ...
    
    This change uses the alias of the watchdog device node for
    the name of the watchdog.
    aliases {
        watchdog0 = "/...../...."
        watchdog3 = "/..../....."
        watchdog2 = "/..../....."
        ...
    }
    
    This will translate to...
    /dev/watchdog0
    /dev/watchdog3
    /dev/watchdog2
    
    v2
    Assign alias number to id in watchdog_core instead of watchdog_dev.
    If failed to get id, fallback to original ida_simple_get call.
    
    Signed-off-by: Justin Chen <justinpopo6@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 7a3629fe999028e09bc96ccb0c9e22e0a9cf2725
Author: Justin Chen <justinpopo6@gmail.com>
Date:   Mon Aug 31 11:02:43 2015 -0700

    watchdog: Watchdog driver for Broadcom Set-Top Box
    
    Watchdog driver for Broadcom 7038 and newer chips.
    
    Signed-off-by: Justin Chen <justinpopo6@gmail.com>
    Reviewed-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

commit 5c5049dab955690d2b30e9397d128d4685211f74
Author: Justin Chen <justinpopo6@gmail.com>
Date:   Mon Aug 31 11:02:42 2015 -0700

    watchdog: bcm7038: add device tree binding documentation
    
    Add device tree binding documentation for the watchdog hardware block
    on bcm7038 and newer SoCs.
    
    Signed-off-by: Justin Chen <justinpopo6@gmail.com>
    Acked-by: Rob Herring <robh@kernel.org>
    Acked-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

For completeness, I added the overal diff below.

Greetings,
Wim.

================================================================================
diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
new file mode 100644
index 0000000..8412227
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
@@ -0,0 +1,19 @@
+BCM7038 Watchdog timer
+
+Required properties:
+
+- compatible : should be "brcm,bcm7038-wdt"
+- reg : Specifies base physical address and size of the registers.
+
+Optional properties:
+
+- clocks: The clock running the watchdog. If no clock is found the
+	  driver will default to 27000000 Hz.
+
+Example:
+
+watchdog@f040a7e8 {
+	compatible = "brcm,bcm7038-wdt";
+	clocks = <&upg_fixed>;
+	reg = <0xf040a7e8 0x16>;
+};
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79e1aa1..7a8a6c6 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1313,6 +1313,14 @@ config BCM_KONA_WDT_DEBUG
 
 	  If in doubt, say 'N'.
 
+config BCM7038_WDT
+	tristate "BCM7038 Watchdog"
+	select WATCHDOG_CORE
+	help
+	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
+
+	 Say 'Y or 'M' here to enable the driver.
+
 config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"
 	depends on HAS_IOMEM
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 0c616e3..53d4827 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_MESON_WATCHDOG) += meson_wdt.o
 obj-$(CONFIG_MEDIATEK_WATCHDOG) += mtk_wdt.o
 obj-$(CONFIG_DIGICOLOR_WATCHDOG) += digicolor_wdt.o
 obj-$(CONFIG_LPC18XX_WATCHDOG) += lpc18xx_wdt.o
+obj-$(CONFIG_BCM7038_WDT) += bcm7038_wdt.o
 
 # AVR32 Architecture
 obj-$(CONFIG_AT32AP700X_WDT) += at32ap700x_wdt.o
diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
new file mode 100644
index 0000000..4245b65
--- /dev/null
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -0,0 +1,237 @@
+/*
+ * Copyright (C) 2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/watchdog.h>
+
+#define WDT_START_1		0xff00
+#define WDT_START_2		0x00ff
+#define WDT_STOP_1		0xee00
+#define WDT_STOP_2		0x00ee
+
+#define WDT_TIMEOUT_REG		0x0
+#define WDT_CMD_REG		0x4
+
+#define WDT_MIN_TIMEOUT		1 /* seconds */
+#define WDT_DEFAULT_TIMEOUT	30 /* seconds */
+#define WDT_DEFAULT_RATE	27000000
+
+struct bcm7038_watchdog {
+	void __iomem		*base;
+	struct watchdog_device	wdd;
+	u32			rate;
+	struct clk		*clk;
+};
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+
+static void bcm7038_wdt_set_timeout_reg(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+	u32 timeout;
+
+	timeout = wdt->rate * wdog->timeout;
+
+	writel(timeout, wdt->base + WDT_TIMEOUT_REG);
+}
+
+static int bcm7038_wdt_ping(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+
+	writel(WDT_START_1, wdt->base + WDT_CMD_REG);
+	writel(WDT_START_2, wdt->base + WDT_CMD_REG);
+
+	return 0;
+}
+
+static int bcm7038_wdt_start(struct watchdog_device *wdog)
+{
+	bcm7038_wdt_set_timeout_reg(wdog);
+	bcm7038_wdt_ping(wdog);
+
+	return 0;
+}
+
+static int bcm7038_wdt_stop(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+
+	writel(WDT_STOP_1, wdt->base + WDT_CMD_REG);
+	writel(WDT_STOP_2, wdt->base + WDT_CMD_REG);
+
+	return 0;
+}
+
+static int bcm7038_wdt_set_timeout(struct watchdog_device *wdog,
+				   unsigned int t)
+{
+	/* Can't modify timeout value if watchdog timer is running */
+	bcm7038_wdt_stop(wdog);
+	wdog->timeout = t;
+	bcm7038_wdt_start(wdog);
+
+	return 0;
+}
+
+static unsigned int bcm7038_wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	struct bcm7038_watchdog *wdt = watchdog_get_drvdata(wdog);
+	u32 time_left;
+
+	time_left = readl(wdt->base + WDT_CMD_REG);
+
+	return time_left / wdt->rate;
+}
+
+static struct watchdog_info bcm7038_wdt_info = {
+	.identity	= "Broadcom BCM7038 Watchdog Timer",
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+				WDIOF_MAGICCLOSE
+};
+
+static struct watchdog_ops bcm7038_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= bcm7038_wdt_start,
+	.stop		= bcm7038_wdt_stop,
+	.set_timeout	= bcm7038_wdt_set_timeout,
+	.get_timeleft	= bcm7038_wdt_get_timeleft,
+};
+
+static int bcm7038_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bcm7038_watchdog *wdt;
+	struct resource *res;
+	int err;
+
+	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
+	if (!wdt)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, wdt);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	wdt->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
+
+	wdt->clk = devm_clk_get(dev, NULL);
+	/* If unable to get clock, use default frequency */
+	if (!IS_ERR(wdt->clk)) {
+		clk_prepare_enable(wdt->clk);
+		wdt->rate = clk_get_rate(wdt->clk);
+		/* Prevent divide-by-zero exception */
+		if (!wdt->rate)
+			wdt->rate = WDT_DEFAULT_RATE;
+	} else {
+		wdt->rate = WDT_DEFAULT_RATE;
+		wdt->clk = NULL;
+	}
+
+	wdt->wdd.info		= &bcm7038_wdt_info;
+	wdt->wdd.ops		= &bcm7038_wdt_ops;
+	wdt->wdd.min_timeout	= WDT_MIN_TIMEOUT;
+	wdt->wdd.timeout	= WDT_DEFAULT_TIMEOUT;
+	wdt->wdd.max_timeout	= 0xffffffff / wdt->rate;
+	wdt->wdd.parent		= dev;
+	watchdog_set_drvdata(&wdt->wdd, wdt);
+
+	err = watchdog_register_device(&wdt->wdd);
+	if (err) {
+		dev_err(dev, "Failed to register watchdog device\n");
+		clk_disable_unprepare(wdt->clk);
+		return err;
+	}
+
+	dev_info(dev, "Registered BCM7038 Watchdog\n");
+
+	return 0;
+}
+
+static int bcm7038_wdt_remove(struct platform_device *pdev)
+{
+	struct bcm7038_watchdog *wdt = platform_get_drvdata(pdev);
+
+	if (!nowayout)
+		bcm7038_wdt_stop(&wdt->wdd);
+
+	watchdog_unregister_device(&wdt->wdd);
+	clk_disable_unprepare(wdt->clk);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int bcm7038_wdt_suspend(struct device *dev)
+{
+	struct bcm7038_watchdog *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		return bcm7038_wdt_stop(&wdt->wdd);
+
+	return 0;
+}
+
+static int bcm7038_wdt_resume(struct device *dev)
+{
+	struct bcm7038_watchdog *wdt = dev_get_drvdata(dev);
+
+	if (watchdog_active(&wdt->wdd))
+		return bcm7038_wdt_start(&wdt->wdd);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(bcm7038_wdt_pm_ops, bcm7038_wdt_suspend,
+			 bcm7038_wdt_resume);
+
+static void bcm7038_wdt_shutdown(struct platform_device *pdev)
+{
+	struct bcm7038_watchdog *wdt = platform_get_drvdata(pdev);
+
+	if (watchdog_active(&wdt->wdd))
+		bcm7038_wdt_stop(&wdt->wdd);
+}
+
+static const struct of_device_id bcm7038_wdt_match[] = {
+	{ .compatible = "brcm,bcm7038-wdt" },
+	{},
+};
+
+static struct platform_driver bcm7038_wdt_driver = {
+	.probe		= bcm7038_wdt_probe,
+	.remove		= bcm7038_wdt_remove,
+	.shutdown	= bcm7038_wdt_shutdown,
+	.driver		= {
+		.name		= "bcm7038-wdt",
+		.of_match_table	= bcm7038_wdt_match,
+		.pm		= &bcm7038_wdt_pm_ops,
+	}
+};
+module_platform_driver(bcm7038_wdt_driver);
+
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Driver for Broadcom 7038 SoCs Watchdog");
+MODULE_AUTHOR("Justin Chen");
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 0bb1a1d..29ef719 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -91,7 +91,7 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
 						    struct imx2_wdt_device,
 						    restart_handler);
 	/* Assert SRS signal */
-	regmap_write(wdev->regmap, 0, wcr_enable);
+	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
 	/*
 	 * Due to imx6q errata ERR004346 (WDOG: WDOG SRS bit requires to be
 	 * written twice), we add another two writes to ensure there must be at
@@ -99,8 +99,8 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
 	 * the target check here, since the writes shouldn't be a huge burden
 	 * for other platforms.
 	 */
-	regmap_write(wdev->regmap, 0, wcr_enable);
-	regmap_write(wdev->regmap, 0, wcr_enable);
+	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
+	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
 
 	/* wait for reset to assert... */
 	mdelay(500);
diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 0a436b5..db36d12 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -101,7 +101,7 @@ static irqreturn_t mid_wdt_irq(int irq, void *dev_id)
 
 static const struct watchdog_info mid_wdt_info = {
 	.identity = "Intel MID SCU watchdog",
-	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,
 };
 
 static const struct watchdog_ops mid_wdt_ops = {
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 1a80594..873f139 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -139,7 +139,7 @@ EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
 static int __watchdog_register_device(struct watchdog_device *wdd)
 {
-	int ret, id, devno;
+	int ret, id = -1, devno;
 
 	if (wdd == NULL || wdd->info == NULL || wdd->ops == NULL)
 		return -EINVAL;
@@ -157,7 +157,18 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	 */
 
 	mutex_init(&wdd->lock);
-	id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
+
+	/* Use alias for watchdog id if possible */
+	if (wdd->parent) {
+		ret = of_alias_get_id(wdd->parent->of_node, "watchdog");
+		if (ret >= 0)
+			id = ida_simple_get(&watchdog_ida, ret,
+					    ret + 1, GFP_KERNEL);
+	}
+
+	if (id < 0)
+		id = ida_simple_get(&watchdog_ida, 0, MAX_DOGS, GFP_KERNEL);
+
 	if (id < 0)
 		return id;
 	wdd->id = id;
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..56a649e 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -51,7 +51,7 @@ static struct watchdog_device *old_wdd;
 
 /*
  *	watchdog_ping: ping the watchdog.
- *	@wddev: the watchdog device to ping
+ *	@wdd: the watchdog device to ping
  *
  *	If the watchdog has no own ping operation then it needs to be
  *	restarted via the start operation. This wrapper function does
@@ -59,65 +59,65 @@ static struct watchdog_device *old_wdd;
  *	We only ping when the watchdog device is running.
  */
 
-static int watchdog_ping(struct watchdog_device *wddev)
+static int watchdog_ping(struct watchdog_device *wdd)
 {
 	int err = 0;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_ping;
 	}
 
-	if (!watchdog_active(wddev))
+	if (!watchdog_active(wdd))
 		goto out_ping;
 
-	if (wddev->ops->ping)
-		err = wddev->ops->ping(wddev);  /* ping the watchdog */
+	if (wdd->ops->ping)
+		err = wdd->ops->ping(wdd);	/* ping the watchdog */
 	else
-		err = wddev->ops->start(wddev); /* restart watchdog */
+		err = wdd->ops->start(wdd);	/* restart watchdog */
 
 out_ping:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_start: wrapper to start the watchdog.
- *	@wddev: the watchdog device to start
+ *	@wdd: the watchdog device to start
  *
  *	Start the watchdog if it is not active and mark it active.
  *	This function returns zero on success or a negative errno code for
  *	failure.
  */
 
-static int watchdog_start(struct watchdog_device *wddev)
+static int watchdog_start(struct watchdog_device *wdd)
 {
 	int err = 0;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_start;
 	}
 
-	if (watchdog_active(wddev))
+	if (watchdog_active(wdd))
 		goto out_start;
 
-	err = wddev->ops->start(wddev);
+	err = wdd->ops->start(wdd);
 	if (err == 0)
-		set_bit(WDOG_ACTIVE, &wddev->status);
+		set_bit(WDOG_ACTIVE, &wdd->status);
 
 out_start:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_stop: wrapper to stop the watchdog.
- *	@wddev: the watchdog device to stop
+ *	@wdd: the watchdog device to stop
  *
  *	Stop the watchdog if it is still active and unmark it active.
  *	This function returns zero on success or a negative errno code for
@@ -125,155 +125,154 @@ out_start:
  *	If the 'nowayout' feature was set, the watchdog cannot be stopped.
  */
 
-static int watchdog_stop(struct watchdog_device *wddev)
+static int watchdog_stop(struct watchdog_device *wdd)
 {
 	int err = 0;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_stop;
 	}
 
-	if (!watchdog_active(wddev))
+	if (!watchdog_active(wdd))
 		goto out_stop;
 
-	if (test_bit(WDOG_NO_WAY_OUT, &wddev->status)) {
-		dev_info(wddev->dev, "nowayout prevents watchdog being stopped!\n");
+	if (test_bit(WDOG_NO_WAY_OUT, &wdd->status)) {
+		dev_info(wdd->dev, "nowayout prevents watchdog being stopped!\n");
 		err = -EBUSY;
 		goto out_stop;
 	}
 
-	err = wddev->ops->stop(wddev);
+	err = wdd->ops->stop(wdd);
 	if (err == 0)
-		clear_bit(WDOG_ACTIVE, &wddev->status);
+		clear_bit(WDOG_ACTIVE, &wdd->status);
 
 out_stop:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_get_status: wrapper to get the watchdog status
- *	@wddev: the watchdog device to get the status from
+ *	@wdd: the watchdog device to get the status from
  *	@status: the status of the watchdog device
  *
  *	Get the watchdog's status flags.
  */
 
-static int watchdog_get_status(struct watchdog_device *wddev,
+static int watchdog_get_status(struct watchdog_device *wdd,
 							unsigned int *status)
 {
 	int err = 0;
 
 	*status = 0;
-	if (!wddev->ops->status)
+	if (!wdd->ops->status)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_status;
 	}
 
-	*status = wddev->ops->status(wddev);
+	*status = wdd->ops->status(wdd);
 
 out_status:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_set_timeout: set the watchdog timer timeout
- *	@wddev: the watchdog device to set the timeout for
+ *	@wdd: the watchdog device to set the timeout for
  *	@timeout: timeout to set in seconds
  */
 
-static int watchdog_set_timeout(struct watchdog_device *wddev,
+static int watchdog_set_timeout(struct watchdog_device *wdd,
 							unsigned int timeout)
 {
 	int err;
 
-	if ((wddev->ops->set_timeout == NULL) ||
-	    !(wddev->info->options & WDIOF_SETTIMEOUT))
+	if (!wdd->ops->set_timeout || !(wdd->info->options & WDIOF_SETTIMEOUT))
 		return -EOPNOTSUPP;
 
-	if (watchdog_timeout_invalid(wddev, timeout))
+	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_timeout;
 	}
 
-	err = wddev->ops->set_timeout(wddev, timeout);
+	err = wdd->ops->set_timeout(wdd, timeout);
 
 out_timeout:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_get_timeleft: wrapper to get the time left before a reboot
- *	@wddev: the watchdog device to get the remaining time from
+ *	@wdd: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
  *
  *	Get the time before a watchdog will reboot (if not pinged).
  */
 
-static int watchdog_get_timeleft(struct watchdog_device *wddev,
+static int watchdog_get_timeleft(struct watchdog_device *wdd,
 							unsigned int *timeleft)
 {
 	int err = 0;
 
 	*timeleft = 0;
-	if (!wddev->ops->get_timeleft)
+	if (!wdd->ops->get_timeleft)
 		return -EOPNOTSUPP;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_timeleft;
 	}
 
-	*timeleft = wddev->ops->get_timeleft(wddev);
+	*timeleft = wdd->ops->get_timeleft(wdd);
 
 out_timeleft:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
 /*
  *	watchdog_ioctl_op: call the watchdog drivers ioctl op if defined
- *	@wddev: the watchdog device to do the ioctl on
+ *	@wdd: the watchdog device to do the ioctl on
  *	@cmd: watchdog command
  *	@arg: argument pointer
  */
 
-static int watchdog_ioctl_op(struct watchdog_device *wddev, unsigned int cmd,
+static int watchdog_ioctl_op(struct watchdog_device *wdd, unsigned int cmd,
 							unsigned long arg)
 {
 	int err;
 
-	if (!wddev->ops->ioctl)
+	if (!wdd->ops->ioctl)
 		return -ENOIOCTLCMD;
 
-	mutex_lock(&wddev->lock);
+	mutex_lock(&wdd->lock);
 
-	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status)) {
 		err = -ENODEV;
 		goto out_ioctl;
 	}
 
-	err = wddev->ops->ioctl(wddev, cmd, arg);
+	err = wdd->ops->ioctl(wdd, cmd, arg);
 
 out_ioctl:
-	mutex_unlock(&wddev->lock);
+	mutex_unlock(&wdd->lock);
 	return err;
 }
 
@@ -295,6 +294,7 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 	struct watchdog_device *wdd = file->private_data;
 	size_t i;
 	char c;
+	int err;
 
 	if (len == 0)
 		return 0;
@@ -314,7 +314,9 @@ static ssize_t watchdog_write(struct file *file, const char __user *data,
 	}
 
 	/* someone wrote to us, so we send the watchdog a keepalive ping */
-	watchdog_ping(wdd);
+	err = watchdog_ping(wdd);
+	if (err < 0)
+		return err;
 
 	return len;
 }
@@ -370,8 +372,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 	case WDIOC_KEEPALIVE:
 		if (!(wdd->info->options & WDIOF_KEEPALIVEPING))
 			return -EOPNOTSUPP;
-		watchdog_ping(wdd);
-		return 0;
+		return watchdog_ping(wdd);
 	case WDIOC_SETTIMEOUT:
 		if (get_user(val, p))
 			return -EFAULT;
@@ -381,7 +382,9 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		/* If the watchdog is active then we send a keepalive ping
 		 * to make sure that the watchdog keep's running (and if
 		 * possible that it takes the new timeout) */
-		watchdog_ping(wdd);
+		err = watchdog_ping(wdd);
+		if (err < 0)
+			return err;
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		/* timeout == 0 means that we don't know the timeout */
@@ -513,43 +516,43 @@ static struct miscdevice watchdog_miscdev = {
 
 /*
  *	watchdog_dev_register: register a watchdog device
- *	@watchdog: watchdog device
+ *	@wdd: watchdog device
  *
  *	Register a watchdog device including handling the legacy
  *	/dev/watchdog node. /dev/watchdog is actually a miscdevice and
  *	thus we set it up like that.
  */
 
-int watchdog_dev_register(struct watchdog_device *watchdog)
+int watchdog_dev_register(struct watchdog_device *wdd)
 {
 	int err, devno;
 
-	if (watchdog->id == 0) {
-		old_wdd = watchdog;
-		watchdog_miscdev.parent = watchdog->parent;
+	if (wdd->id == 0) {
+		old_wdd = wdd;
+		watchdog_miscdev.parent = wdd->parent;
 		err = misc_register(&watchdog_miscdev);
 		if (err != 0) {
 			pr_err("%s: cannot register miscdev on minor=%d (err=%d).\n",
-				watchdog->info->identity, WATCHDOG_MINOR, err);
+				wdd->info->identity, WATCHDOG_MINOR, err);
 			if (err == -EBUSY)
 				pr_err("%s: a legacy watchdog module is probably present.\n",
-					watchdog->info->identity);
+					wdd->info->identity);
 			old_wdd = NULL;
 			return err;
 		}
 	}
 
 	/* Fill in the data structures */
-	devno = MKDEV(MAJOR(watchdog_devt), watchdog->id);
-	cdev_init(&watchdog->cdev, &watchdog_fops);
-	watchdog->cdev.owner = watchdog->ops->owner;
+	devno = MKDEV(MAJOR(watchdog_devt), wdd->id);
+	cdev_init(&wdd->cdev, &watchdog_fops);
+	wdd->cdev.owner = wdd->ops->owner;
 
 	/* Add the device */
-	err  = cdev_add(&watchdog->cdev, devno, 1);
+	err  = cdev_add(&wdd->cdev, devno, 1);
 	if (err) {
 		pr_err("watchdog%d unable to add device %d:%d\n",
-			watchdog->id,  MAJOR(watchdog_devt), watchdog->id);
-		if (watchdog->id == 0) {
+			wdd->id,  MAJOR(watchdog_devt), wdd->id);
+		if (wdd->id == 0) {
 			misc_deregister(&watchdog_miscdev);
 			old_wdd = NULL;
 		}
@@ -564,14 +567,14 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
  *	Unregister the watchdog and if needed the legacy /dev/watchdog device.
  */
 
-int watchdog_dev_unregister(struct watchdog_device *watchdog)
+int watchdog_dev_unregister(struct watchdog_device *wdd)
 {
-	mutex_lock(&watchdog->lock);
-	set_bit(WDOG_UNREGISTERED, &watchdog->status);
-	mutex_unlock(&watchdog->lock);
+	mutex_lock(&wdd->lock);
+	set_bit(WDOG_UNREGISTERED, &wdd->status);
+	mutex_unlock(&wdd->lock);
 
-	cdev_del(&watchdog->cdev);
-	if (watchdog->id == 0) {
+	cdev_del(&wdd->cdev);
+	if (wdd->id == 0) {
 		misc_deregister(&watchdog_miscdev);
 		old_wdd = NULL;
 	}
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index d74a0e9..027b1f4 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -24,8 +24,8 @@ struct watchdog_device;
  * @stop:	The routine for stopping the watchdog device.
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
- * @set_timeout:The routine for setting the watchdog devices timeout value.
- * @get_timeleft:The routine that get's the time that's left before a reset.
+ * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
+ * @get_timeleft:The routine that gets the time left before a reset (in seconds).
  * @ref:	The ref operation for dyn. allocated watchdog_device structs
  * @unref:	The unref operation for dyn. allocated watchdog_device structs
  * @ioctl:	The routines that handles extra ioctl calls.
@@ -33,7 +33,7 @@ struct watchdog_device;
  * The watchdog_ops structure contains a list of low-level operations
  * that control a watchdog device. It also contains the module that owns
  * these operations. The start and stop function are mandatory, all other
- * functions are optonal.
+ * functions are optional.
  */
 struct watchdog_ops {
 	struct module *owner;
@@ -59,9 +59,9 @@ struct watchdog_ops {
  * @info:	Pointer to a watchdog_info structure.
  * @ops:	Pointer to the list of watchdog operations.
  * @bootstatus:	Status of the watchdog device at boot.
- * @timeout:	The watchdog devices timeout value.
- * @min_timeout:The watchdog devices minimum timeout value.
- * @max_timeout:The watchdog devices maximum timeout value.
+ * @timeout:	The watchdog devices timeout value (in seconds).
+ * @min_timeout:The watchdog devices minimum timeout value (in seconds).
+ * @max_timeout:The watchdog devices maximum timeout value (in seconds).
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
@@ -119,8 +119,15 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
 /* Use the following function to check if a timeout value is invalid */
 static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
 {
-	return ((wdd->max_timeout != 0) &&
-		(t < wdd->min_timeout || t > wdd->max_timeout));
+	/*
+	 * The timeout is invalid if
+	 * - the requested value is smaller than the configured minimum timeout,
+	 * or
+	 * - a maximum timeout is configured, and the requested value is larger
+	 *   than the maximum timeout.
+	 */
+	return t < wdd->min_timeout ||
+		(wdd->max_timeout && t > wdd->max_timeout);
 }
 
 /* Use the following functions to manipulate watchdog driver specific data */
