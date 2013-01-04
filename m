Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39923 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777Ab3ADN7E (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Jan 2013 08:59:04 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com
Subject: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
Date: Fri,  4 Jan 2013 14:58:47 +0100
Message-Id: <1357307929-1666-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1357307929-1666-1-git-send-email-w.sang@pengutronix.de>
References: <1357307929-1666-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This RTC also includes a watchdog timer. Provide an accessor function for
setting the watchdog timeout value which will be picked up by a watchdog
driver. Also register the platform_device for the watchdog here to get the
boot-time dependencies right. The watchdog driver will depend on this RTC
driver in Kconfig.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rtc-linux@googlegroups.com
---

Change since last version:

* dynamically allocate the new platform device instead of a static one
* build fixes when watchdog is disabled

 drivers/rtc/rtc-stmp3xxx.c       |   64 ++++++++++++++++++++++++++++++++++++++
 include/linux/stmp3xxx_rtc_wdt.h |   15 +++++++++
 2 files changed, 79 insertions(+)
 create mode 100644 include/linux/stmp3xxx_rtc_wdt.h

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 739ef556..cc9a9b6 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -26,6 +26,8 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/of_device.h>
+#include <linux/stmp_device.h>
+#include <linux/stmp3xxx_rtc_wdt.h>
 
 #include <mach/common.h>
 
@@ -35,6 +37,7 @@
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
+#define STMP3XXX_RTC_CTRL_WATCHDOGEN		0x00000010
 
 #define STMP3XXX_RTC_STAT			0x10
 #define STMP3XXX_RTC_STAT_STALE_SHIFT		16
@@ -44,6 +47,8 @@
 
 #define STMP3XXX_RTC_ALARM			0x40
 
+#define STMP3XXX_RTC_WATCHDOG			0x50
+
 #define STMP3XXX_RTC_PERSISTENT0		0x60
 #define STMP3XXX_RTC_PERSISTENT0_SET		0x64
 #define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
@@ -51,12 +56,70 @@
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_EN	0x00000004
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE	0x00000080
 
+#define STMP3XXX_RTC_PERSISTENT1		0x70
+/* missing bitmask in headers */
+#define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
+
 struct stmp3xxx_rtc_data {
 	struct rtc_device *rtc;
 	void __iomem *io;
 	int irq_alarm;
 };
 
+#if IS_ENABLED(CONFIG_STMP3XXX_RTC_WATCHDOG)
+/**
+ * stmp3xxx_wdt_set_timeout - configure the watchdog inside the STMP3xxx RTC
+ * @dev: the parent device of the watchdog (= the RTC)
+ * @timeout: the desired value for the timeout register of the watchdog.
+ *           0 disables the watchdog
+ *
+ * The watchdog needs one register and two bits which are in the RTC domain.
+ * To handle the resource conflict, the RTC driver will create another
+ * platform_device for the watchdog driver as a child of the RTC device.
+ * The watchdog driver is passed the below accessor function via platform_data
+ * to configure the watchdog. Locking is not needed because accessing SET/CLR
+ * registers is atomic.
+ */
+
+static void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
+{
+	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
+
+	if (timeout) {
+		writel(timeout, rtc_data->io + STMP3XXX_RTC_WATCHDOG);
+		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
+		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
+		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
+		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_SET);
+	} else {
+		writel(STMP3XXX_RTC_CTRL_WATCHDOGEN,
+		       rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
+		writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
+		       rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + STMP_OFFSET_REG_CLR);
+	}
+}
+
+static struct stmp3xxx_wdt_pdata wdt_pdata = {
+	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
+};
+
+static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
+{
+	struct platform_device *wdt_pdev =
+		platform_device_alloc("stmp3xxx_rtc_wdt", rtc_pdev->id);
+
+	if (wdt_pdev) {
+		wdt_pdev->dev.parent = &rtc_pdev->dev;
+		wdt_pdev->dev.platform_data = &wdt_pdata;
+		platform_device_add(wdt_pdev);
+	}
+}
+#else
+static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
+{
+}
+#endif /* CONFIG_STMP3XXX_RTC_WATCHDOG */
+
 static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
 {
 	/*
@@ -232,6 +295,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		goto out_irq_alarm;
 	}
 
+	stmp3xxx_wdt_register(pdev);
 	return 0;
 
 out_irq_alarm:
diff --git a/include/linux/stmp3xxx_rtc_wdt.h b/include/linux/stmp3xxx_rtc_wdt.h
new file mode 100644
index 0000000..1dd12c9
--- /dev/null
+++ b/include/linux/stmp3xxx_rtc_wdt.h
@@ -0,0 +1,15 @@
+/*
+ * stmp3xxx_rtc_wdt.h
+ *
+ * Copyright (C) 2011 Wolfram Sang, Pengutronix e.K.
+ *
+ * This file is released under the GPLv2.
+ */
+#ifndef __LINUX_STMP3XXX_RTC_WDT_H
+#define __LINUX_STMP3XXX_RTC_WDT_H
+
+struct stmp3xxx_wdt_pdata {
+	void (*wdt_set_timeout)(struct device *dev, u32 timeout);
+};
+
+#endif /* __LINUX_STMP3XXX_RTC_WDT_H */
-- 
1.7.10.4

