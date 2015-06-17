Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:65143 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbbFQW7R (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 18:59:17 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [PATCH v2 2/3] watchdog: max63xx: add GPIO support
Date: Wed, 17 Jun 2015 18:58:59 -0400
Message-Id: <1434581940-15086-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1434581940-15086-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1434581940-15086-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Introduce a new struct max63xx_platform_data to support MAX63xx watchdog
chips connected via GPIO. A platform code can fill this structure with
GPIO numbers for WDI and WDSET pins to enable GPIO support in the code.

The driver takes care of requesting and releasing the GPIOs.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/Kconfig                  |  2 +-
 drivers/watchdog/max63xx_wdt.c            | 53 ++++++++++++++++++++++++++++++-
 include/linux/platform_data/max63xx_wdt.h | 27 ++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/platform_data/max63xx_wdt.h

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 742fbbc..bb65b20 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -418,7 +418,7 @@ config TS72XX_WATCHDOG
 
 config MAX63XX_WATCHDOG
 	tristate "Max63xx watchdog"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM || GPIOLIB
 	select WATCHDOG_CORE
 	help
 	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 3f7e8d5..cce2b12 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -22,6 +22,8 @@
 #include <linux/watchdog.h>
 #include <linux/bitops.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/max63xx_wdt.h>
+#include <linux/gpio.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -47,6 +49,9 @@ struct max63xx_wdt {
 	struct watchdog_device wdd;
 	const struct max63xx_timeout *timeout;
 
+	/* platform settings e.g. GPIO */
+	struct max63xx_platform_data *pdata;
+
 	/* memory mapping */
 	void __iomem *base;
 	spinlock_t lock;
@@ -199,6 +204,48 @@ static int max63xx_mmap_init(struct platform_device *p, struct max63xx_wdt *wdt)
 	return 0;
 }
 
+static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
+{
+	gpio_set_value_cansleep(wdt->pdata->wdi, 1);
+	gpio_set_value_cansleep(wdt->pdata->wdi, 0);
+}
+
+static void max63xx_gpio_set(struct max63xx_wdt *wdt, u8 set)
+{
+	gpio_set_value_cansleep(wdt->pdata->set0, set & BIT(0));
+	gpio_set_value_cansleep(wdt->pdata->set1, set & BIT(1));
+	gpio_set_value_cansleep(wdt->pdata->set2, set & BIT(2));
+}
+
+static int max63xx_gpio_init(struct platform_device *p, struct max63xx_wdt *wdt)
+{
+	int err;
+
+	err = devm_gpio_request_one(&p->dev, wdt->pdata->wdi,
+				    GPIOF_OUT_INIT_LOW, "max63xx_wdt WDI");
+	if (err)
+		return err;
+
+	err = devm_gpio_request_one(&p->dev, wdt->pdata->set0,
+				    GPIOF_OUT_INIT_LOW, "max63xx_wdt SET0");
+	if (err)
+		return err;
+
+	err = devm_gpio_request_one(&p->dev, wdt->pdata->set1,
+				    GPIOF_OUT_INIT_LOW, "max63xx_wdt SET1");
+	if (err)
+		return err;
+
+	err = devm_gpio_request_one(&p->dev, wdt->pdata->set2,
+				    GPIOF_OUT_INIT_LOW, "max63xx_wdt SET2");
+	if (err)
+		return err;
+
+	wdt->ping = max63xx_gpio_ping;
+	wdt->set = max63xx_gpio_set;
+	return 0;
+}
+
 static int max63xx_wdt_probe(struct platform_device *pdev)
 {
 	struct max63xx_wdt *wdt;
@@ -211,6 +258,8 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 
 	table = (struct max63xx_timeout *)pdev->id_entry->driver_data;
 
+	wdt->pdata = dev_get_platdata(&pdev->dev);
+
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
 
@@ -221,7 +270,9 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	err = max63xx_mmap_init(pdev, wdt);
+	/* GPIO or memory mapped? */
+	err = wdt->pdata && wdt->pdata->wdi ? max63xx_gpio_init(pdev, wdt) :
+		max63xx_mmap_init(pdev, wdt);
 	if (err)
 		return err;
 
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
2.4.3

