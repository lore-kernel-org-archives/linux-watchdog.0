Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:52265 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755876AbbFOUJF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 16:09:05 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [RESEND PATCH 2/3] watchdog: max63xx: add GPIO support
Date: Mon, 15 Jun 2015 15:58:40 -0400
Message-Id: <1434398321-16035-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds support for GPIO wired MAX63xx devices. It adds a
platform data structure which can be filled by a platform code with the
GPIO line numbers. The driver takes care of requesting and releasing
them.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/Kconfig                  |   2 +-
 drivers/watchdog/max63xx_wdt.c            | 108 ++++++++++++++++++++++++++----
 include/linux/platform_data/max63xx_wdt.h |  27 ++++++++
 3 files changed, 123 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/platform_data/max63xx_wdt.h

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c0e3a2e..b81d916 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -418,7 +418,7 @@ config TS72XX_WATCHDOG
 
 config MAX63XX_WATCHDOG
 	tristate "Maxim MAX6369 Pin-Selectable Watchdog Timer and compatibles"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM || GPIOLIB
 	select WATCHDOG_CORE
 	help
 	  Support for MAX6369, MAX6370, MAX6371, MAX6372, MAX6373, and MAX6374.
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 01fb4ef..9ab9fd1 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -3,13 +3,12 @@
  *
  * Copyright (C) 2009 Marc Zyngier <maz@misterjones.org>
  *
+ * Copyright (C) 2015 Savoir-faire Linux Inc.
+ *	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
+ *
  * This file is licensed under the terms of the GNU General Public
  * License version 2. This program is licensed "as is" without any
  * warranty of any kind, whether express or implied.
- *
- * This driver assumes the watchdog pins are memory mapped (as it is
- * the case for the Arcom Zeus). Should it be connected over GPIOs or
- * another interface, some abstraction will have to be introduced.
  */
 
 #include <linux/err.h>
@@ -20,6 +19,8 @@
 #include <linux/watchdog.h>
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/max63xx_wdt.h>
+#include <linux/gpio.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -47,6 +48,9 @@ MODULE_PARM_DESC(nodelay, "Force selection of a timeout setting without initial
 struct max63xx_data {
 	const struct max63xx_timeout *timeout;
 
+	/* Platform data for optional config, such as GPIOs */
+	struct max63xx_platform_data *pdata;
+
 	/* For memory mapped pins */
 	void __iomem	*base;
 	spinlock_t	lock;
@@ -168,6 +172,50 @@ static const struct watchdog_ops max63xx_mmap_ops = {
 	.ping = max63xx_mmap_ping,
 };
 
+static int max63xx_gpio_ping(struct watchdog_device *wdev)
+{
+	struct max63xx_data *data = watchdog_get_drvdata(wdev);
+
+	gpio_set_value_cansleep(data->pdata->wdi, 1);
+	gpio_set_value_cansleep(data->pdata->wdi, 0);
+
+	return 0;
+}
+
+static inline void max63xx_gpio_set(struct watchdog_device *wdev, u8 set)
+{
+	struct max63xx_data *data = watchdog_get_drvdata(wdev);
+
+	gpio_set_value_cansleep(data->pdata->set0, set & BIT(0));
+	gpio_set_value_cansleep(data->pdata->set1, set & BIT(1));
+	gpio_set_value_cansleep(data->pdata->set2, set & BIT(2));
+}
+
+static int max63xx_gpio_start(struct watchdog_device *wdev)
+{
+	struct max63xx_data *data = watchdog_get_drvdata(wdev);
+
+	max63xx_gpio_set(wdev, data->timeout->wdset);
+
+	/* Check for an edge triggered startup */
+	if (data->timeout->tdelay == 0)
+		max63xx_gpio_ping(wdev);
+	return 0;
+}
+
+static int max63xx_gpio_stop(struct watchdog_device *wdev)
+{
+	max63xx_gpio_set(wdev, MAX63XX_DISABLED);
+	return 0;
+}
+
+static const struct watchdog_ops max63xx_gpio_ops = {
+	.owner = THIS_MODULE,
+	.start = max63xx_gpio_start,
+	.stop = max63xx_gpio_stop,
+	.ping = max63xx_gpio_ping,
+};
+
 static const struct watchdog_info max63xx_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 	.identity = "MAX63xx Watchdog Timer",
@@ -175,7 +223,6 @@ static const struct watchdog_info max63xx_wdt_info = {
 
 static int max63xx_wdt_probe(struct platform_device *pdev)
 {
-	struct resource *mem;
 	struct watchdog_device *wdev;
 	struct max63xx_data *data;
 	struct max63xx_timeout *table;
@@ -190,6 +237,8 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 
 	table = (struct max63xx_timeout *) pdev->id_entry->driver_data;
 
+	data->pdata = dev_get_platdata(&pdev->dev);
+
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
 
@@ -206,14 +255,47 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 	wdev->timeout = data->timeout->twd;
 	wdev->info = &max63xx_wdt_info;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->base = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(data->base))
-		return PTR_ERR(data->base);
-
-	spin_lock_init(&data->lock);
-
-	wdev->ops = &max63xx_mmap_ops;
+	/* GPIO or memory mapped? */
+	if (data->pdata && data->pdata->wdi) {
+		int err;
+
+		err = devm_gpio_request_one(&pdev->dev, data->pdata->wdi,
+					    GPIOF_OUT_INIT_LOW,
+					    "MAX63XX Watchdog WDI");
+		if (err)
+			return err;
+
+		err = devm_gpio_request_one(&pdev->dev, data->pdata->set0,
+					    GPIOF_OUT_INIT_LOW,
+					    "MAX63XX Watchdog SET0");
+		if (err)
+			return err;
+
+		err = devm_gpio_request_one(&pdev->dev, data->pdata->set1,
+					    GPIOF_OUT_INIT_LOW,
+					    "MAX63XX Watchdog SET1");
+		if (err)
+			return err;
+
+		err = devm_gpio_request_one(&pdev->dev, data->pdata->set2,
+					    GPIOF_OUT_INIT_LOW,
+					    "MAX63XX Watchdog SET2");
+		if (err)
+			return err;
+
+		wdev->ops = &max63xx_gpio_ops;
+	} else {
+		struct resource *mem;
+
+		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		data->base = devm_ioremap_resource(&pdev->dev, mem);
+		if (IS_ERR(data->base))
+			return PTR_ERR(data->base);
+
+		spin_lock_init(&data->lock);
+
+		wdev->ops = &max63xx_mmap_ops;
+	}
 
 	watchdog_set_drvdata(wdev, data);
 	platform_set_drvdata(pdev, wdev);
diff --git a/include/linux/platform_data/max63xx_wdt.h b/include/linux/platform_data/max63xx_wdt.h
new file mode 100644
index 0000000..ae28024
--- /dev/null
+++ b/include/linux/platform_data/max63xx_wdt.h
@@ -0,0 +1,27 @@
+/*
+ * Maxim MAX6369 Pin-Selectable Watchdog Timer and compatibles
+ *
+ * Copyright (c) 2015 Savoir-faire Linux Inc.
+ *          Vivien Didelot <vivien.didelot@savoirfairelinux.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _PDATA_MAX63XX_H
+#define _PDATA_MAX63XX_H
+
+/**
+ * struct max63xx_platform_data - MAX63xx connectivity info
+ * @wdi:	Watchdog Input GPIO number.
+ * @set0:	Watchdog SET0 GPIO number.
+ * @set1:	Watchdog SET1 GPIO number.
+ * @set2:	Watchdog SET2 GPIO number.
+ */
+struct max63xx_platform_data {
+	unsigned int wdi;
+	unsigned int set0, set1, set2;
+};
+
+#endif /* _PDATA_MAX63XX_H */
-- 
2.4.2

