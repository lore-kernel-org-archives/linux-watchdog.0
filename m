Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:55326 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755873AbbFOUJF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 16:09:05 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [RESEND PATCH 1/3] watchdog: max63xx: cleanup
Date: Mon, 15 Jun 2015 15:58:39 -0400
Message-Id: <1434398321-16035-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch cleans up the MAX63xx driver to help the introduction of new
features. Some of the changes include:

  * better device naming and description;
  * put module parameter just above their declaration for clarity;
  * remove global variables in favor of a driver data structure;
  * fix "quoted string split across lines" warning from checkpatch.pl;
  * constify timeouts;
  * factorize the SET write operations;
  * few typos and comments...

The MAX6369_WDSET and MAX6369_WDI bits are specific to the memory mapped
support, and can eventually be mapped in a different way. So remove them
in favor of clear comments in related max63xx_mmap_{ping,set} functions.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/Kconfig       |   7 +-
 drivers/watchdog/max63xx_wdt.c | 207 ++++++++++++++++++++---------------------
 2 files changed, 108 insertions(+), 106 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 742fbbc..c0e3a2e 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -417,11 +417,14 @@ config TS72XX_WATCHDOG
 	  module will be called ts72xx_wdt.
 
 config MAX63XX_WATCHDOG
-	tristate "Max63xx watchdog"
+	tristate "Maxim MAX6369 Pin-Selectable Watchdog Timer and compatibles"
 	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
-	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
+	  Support for MAX6369, MAX6370, MAX6371, MAX6372, MAX6373, and MAX6374.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called max63xx_wdt.
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index b3a1130..01fb4ef 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -1,7 +1,5 @@
 /*
- * drivers/char/watchdog/max63xx_wdt.c
- *
- * Driver for max63{69,70,71,72,73,74} watchdog timers
+ * Maxim MAX6369 Pin-Selectable Watchdog Timer and compatibles
  *
  * Copyright (C) 2009 Marc Zyngier <maz@misterjones.org>
  *
@@ -26,23 +24,33 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
-#define DEFAULT_HEARTBEAT 60
-#define MAX_HEARTBEAT     60
+#define DEFAULT_HEARTBEAT	60
+#define MAX_HEARTBEAT		60
 
-static unsigned int heartbeat = DEFAULT_HEARTBEAT;
-static bool nowayout  = WATCHDOG_NOWAYOUT;
+#define MAX63XX_DISABLED	3
 
-/*
- * Memory mapping: a single byte, 3 first lower bits to select bit 3
- * to ping the watchdog.
- */
-#define MAX6369_WDSET	(7 << 0)
-#define MAX6369_WDI	(1 << 3)
+static unsigned int heartbeat = DEFAULT_HEARTBEAT;
+module_param(heartbeat, int, 0);
+MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat period in seconds from 1 to "
+		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
+		 __MODULE_STRING(DEFAULT_HEARTBEAT));
 
-static DEFINE_SPINLOCK(io_lock);
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 static int nodelay;
-static void __iomem	*wdt_base;
+module_param(nodelay, int, 0);
+MODULE_PARM_DESC(nodelay, "Force selection of a timeout setting without initial delay (MAX6373/74 only, default=0)");
+
+struct max63xx_data {
+	const struct max63xx_timeout *timeout;
+
+	/* For memory mapped pins */
+	void __iomem	*base;
+	spinlock_t	lock;
+};
 
 /*
  * The timeout values used are actually the absolute minimum the chip
@@ -50,34 +58,32 @@ static void __iomem	*wdt_base;
  * (10s setting ends up with a 25s timeout), and can be up to 3 times
  * the nominal setting (according to the datasheet). So please take
  * these values with a grain of salt. Same goes for the initial delay
- * "feature". Only max6373/74 have a few settings without this initial
+ * "feature". Only MAX6373/74 have a few settings without this initial
  * delay (selected with the "nodelay" parameter).
  *
  * I also decided to remove from the tables any timeout smaller than a
- * second, as it looked completly overkill...
+ * second, as it looked completely overkill...
  */
-
-/* Timeouts in second */
 struct max63xx_timeout {
-	u8 wdset;
-	u8 tdelay;
-	u8 twd;
+	const u8 wdset;
+	const u8 tdelay;
+	const u8 twd;
 };
 
-static struct max63xx_timeout max6369_table[] = {
+static const struct max63xx_timeout max6369_table[] = {
 	{ 5,  1,  1 },
 	{ 6, 10, 10 },
 	{ 7, 60, 60 },
 	{ },
 };
 
-static struct max63xx_timeout max6371_table[] = {
+static const struct max63xx_timeout max6371_table[] = {
 	{ 6, 60,  3 },
 	{ 7, 60, 60 },
 	{ },
 };
 
-static struct max63xx_timeout max6373_table[] = {
+static const struct max63xx_timeout max6373_table[] = {
 	{ 2, 60,  1 },
 	{ 5,  0,  1 },
 	{ 1,  3,  3 },
@@ -86,8 +92,6 @@ static struct max63xx_timeout max6373_table[] = {
 	{ },
 };
 
-static struct max63xx_timeout *current_timeout;
-
 static struct max63xx_timeout *
 max63xx_select_timeout(struct max63xx_timeout *table, int value)
 {
@@ -106,111 +110,124 @@ max63xx_select_timeout(struct max63xx_timeout *table, int value)
 	return NULL;
 }
 
-static int max63xx_wdt_ping(struct watchdog_device *wdd)
+static int max63xx_mmap_ping(struct watchdog_device *wdev)
 {
+	struct max63xx_data *data = watchdog_get_drvdata(wdev);
 	u8 val;
 
-	spin_lock(&io_lock);
+	spin_lock(&data->lock);
 
-	val = __raw_readb(wdt_base);
+	val = __raw_readb(data->base);
 
-	__raw_writeb(val | MAX6369_WDI, wdt_base);
-	__raw_writeb(val & ~MAX6369_WDI, wdt_base);
+	/* WDI is the 4th bit of the memory mapped byte */
+	__raw_writeb(val | BIT(3), data->base);
+	__raw_writeb(val & ~BIT(3), data->base);
 
-	spin_unlock(&io_lock);
+	spin_unlock(&data->lock);
 	return 0;
 }
 
-static int max63xx_wdt_start(struct watchdog_device *wdd)
+static inline void max63xx_mmap_set(struct watchdog_device *wdev, u8 set)
 {
-	struct max63xx_timeout *entry = watchdog_get_drvdata(wdd);
+	struct max63xx_data *data = watchdog_get_drvdata(wdev);
 	u8 val;
 
-	spin_lock(&io_lock);
-
-	val = __raw_readb(wdt_base);
-	val &= ~MAX6369_WDSET;
-	val |= entry->wdset;
-	__raw_writeb(val, wdt_base);
+	spin_lock(&data->lock);
 
-	spin_unlock(&io_lock);
+	/* SET0, SET1, SET2 are the 3 lower bits of the memory mapped byte */
+	val = __raw_readb(data->base);
+	val &= ~7;
+	val |= set & 7;
+	__raw_writeb(val, data->base);
 
-	/* check for a edge triggered startup */
-	if (entry->tdelay == 0)
-		max63xx_wdt_ping(wdd);
-	return 0;
+	spin_unlock(&data->lock);
 }
 
-static int max63xx_wdt_stop(struct watchdog_device *wdd)
+static int max63xx_mmap_start(struct watchdog_device *wdev)
 {
-	u8 val;
-
-	spin_lock(&io_lock);
+	struct max63xx_data *data = watchdog_get_drvdata(wdev);
 
-	val = __raw_readb(wdt_base);
-	val &= ~MAX6369_WDSET;
-	val |= 3;
-	__raw_writeb(val, wdt_base);
+	max63xx_mmap_set(wdev, data->timeout->wdset);
 
-	spin_unlock(&io_lock);
+	/* Check for an edge triggered startup */
+	if (data->timeout->tdelay == 0)
+		max63xx_mmap_ping(wdev);
 	return 0;
 }
 
-static const struct watchdog_info max63xx_wdt_info = {
-	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
-	.identity = "max63xx Watchdog",
-};
+static int max63xx_mmap_stop(struct watchdog_device *wdev)
+{
+	max63xx_mmap_set(wdev, MAX63XX_DISABLED);
+	return 0;
+}
 
-static const struct watchdog_ops max63xx_wdt_ops = {
+static const struct watchdog_ops max63xx_mmap_ops = {
 	.owner = THIS_MODULE,
-	.start = max63xx_wdt_start,
-	.stop = max63xx_wdt_stop,
-	.ping = max63xx_wdt_ping,
+	.start = max63xx_mmap_start,
+	.stop = max63xx_mmap_stop,
+	.ping = max63xx_mmap_ping,
 };
 
-static struct watchdog_device max63xx_wdt_dev = {
-	.info = &max63xx_wdt_info,
-	.ops = &max63xx_wdt_ops,
+static const struct watchdog_info max63xx_wdt_info = {
+	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "MAX63xx Watchdog Timer",
 };
 
 static int max63xx_wdt_probe(struct platform_device *pdev)
 {
-	struct resource	*wdt_mem;
+	struct resource *mem;
+	struct watchdog_device *wdev;
+	struct max63xx_data *data;
 	struct max63xx_timeout *table;
 
-	table = (struct max63xx_timeout *)pdev->id_entry->driver_data;
+	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
+	if (!wdev)
+		return -ENOMEM;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	table = (struct max63xx_timeout *) pdev->id_entry->driver_data;
 
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
 
-	dev_info(&pdev->dev, "requesting %ds heartbeat\n", heartbeat);
-	current_timeout = max63xx_select_timeout(table, heartbeat);
-
-	if (!current_timeout) {
-		dev_err(&pdev->dev, "unable to satisfy heartbeat request\n");
+	data->timeout = max63xx_select_timeout(table, heartbeat);
+	if (!data->timeout) {
+		dev_err(&pdev->dev, "unable to satisfy %ds heartbeat request\n",
+			heartbeat);
 		return -EINVAL;
 	}
 
 	dev_info(&pdev->dev, "using %ds heartbeat with %ds initial delay\n",
-		 current_timeout->twd, current_timeout->tdelay);
+		 data->timeout->twd, data->timeout->tdelay);
+
+	wdev->timeout = data->timeout->twd;
+	wdev->info = &max63xx_wdt_info;
 
-	heartbeat = current_timeout->twd;
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
 
-	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	wdt_base = devm_ioremap_resource(&pdev->dev, wdt_mem);
-	if (IS_ERR(wdt_base))
-		return PTR_ERR(wdt_base);
+	spin_lock_init(&data->lock);
 
-	max63xx_wdt_dev.timeout = heartbeat;
-	watchdog_set_nowayout(&max63xx_wdt_dev, nowayout);
-	watchdog_set_drvdata(&max63xx_wdt_dev, current_timeout);
+	wdev->ops = &max63xx_mmap_ops;
 
-	return watchdog_register_device(&max63xx_wdt_dev);
+	watchdog_set_drvdata(wdev, data);
+	platform_set_drvdata(pdev, wdev);
+
+	watchdog_set_nowayout(wdev, nowayout);
+
+	return watchdog_register_device(wdev);
 }
 
 static int max63xx_wdt_remove(struct platform_device *pdev)
 {
-	watchdog_unregister_device(&max63xx_wdt_dev);
+	struct watchdog_device *wdev = platform_get_drvdata(pdev);
+
+	watchdog_unregister_device(wdev);
 	return 0;
 }
 
@@ -229,29 +246,11 @@ static struct platform_driver max63xx_wdt_driver = {
 	.probe		= max63xx_wdt_probe,
 	.remove		= max63xx_wdt_remove,
 	.id_table	= max63xx_id_table,
-	.driver		= {
-		.name	= "max63xx_wdt",
-	},
+	.driver.name	= "max63xx_wdt",
 };
 
 module_platform_driver(max63xx_wdt_driver);
 
 MODULE_AUTHOR("Marc Zyngier <maz@misterjones.org>");
-MODULE_DESCRIPTION("max63xx Watchdog Driver");
-
-module_param(heartbeat, int, 0);
-MODULE_PARM_DESC(heartbeat,
-		 "Watchdog heartbeat period in seconds from 1 to "
-		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
-		 __MODULE_STRING(DEFAULT_HEARTBEAT));
-
-module_param(nowayout, bool, 0);
-MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-
-module_param(nodelay, int, 0);
-MODULE_PARM_DESC(nodelay,
-		 "Force selection of a timeout setting without initial delay "
-		 "(max6373/74 only, default=0)");
-
+MODULE_DESCRIPTION("Maxim MAX63xx Watchdog Timer driver");
 MODULE_LICENSE("GPL");
-- 
2.4.2

