Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:32966 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681Ab1LHRT6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 8 Dec 2011 12:19:58 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	Wolfram Sang <w.sang@pengutronix.de>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	rtc-linux@googlegroups.com
Subject: [PATCH 1/3] rtc: stmp3xxx: add wdt-accessor function
Date: Thu,  8 Dec 2011 18:19:41 +0100
Message-Id: <1323364783-1059-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1323364783-1059-1-git-send-email-w.sang@pengutronix.de>
References: <1323364783-1059-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This RTC also includes a watchdog timer. Provide an accessor function
for it to be picked up by a watchdog driver. Also register the
platform_device here to get the boot-time dependencies right.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rtc-linux@googlegroups.com
---

Andrew, Wim: Alessandro was not around in the last weeks, so I'd suggest this
patch goes via the watchdog-tree together with the rest of this series if it
passes the review of the watchdog-list? All changes here are in preparation for
the watchdog driver and do not affect the general RTC. Concerns from V1 have
been hopefully addressed (no EXPORT_SYMBOL anymore, better documentation)

 drivers/rtc/rtc-stmp3xxx.c       |   64 ++++++++++++++++++++++++++++++++++++++
 include/linux/stmp3xxx_rtc_wdt.h |   15 +++++++++
 2 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/stmp3xxx_rtc_wdt.h

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 7315068..811b44b 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -25,8 +25,10 @@
 #include <linux/interrupt.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
+#include <linux/stmp3xxx_rtc_wdt.h>
 
 #include <mach/common.h>
+#include <mach/mxs.h>
 
 #define STMP3XXX_RTC_CTRL			0x0
 #define STMP3XXX_RTC_CTRL_SET			0x4
@@ -34,6 +36,7 @@
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
+#define STMP3XXX_RTC_CTRL_WATCHDOGEN		0x00000010
 
 #define STMP3XXX_RTC_STAT			0x10
 #define STMP3XXX_RTC_STAT_STALE_SHIFT		16
@@ -43,6 +46,8 @@
 
 #define STMP3XXX_RTC_ALARM			0x40
 
+#define STMP3XXX_RTC_WATCHDOG			0x50
+
 #define STMP3XXX_RTC_PERSISTENT0		0x60
 #define STMP3XXX_RTC_PERSISTENT0_SET		0x64
 #define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
@@ -50,12 +55,70 @@
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
 
+#if defined(CONFIG_STMP3XXX_RTC_WATCHDOG) || defined(CONFIG_STMP3XXX_RTC_WATCHDOG_MODULE)
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
+void stmp3xxx_wdt_set_timeout(struct device *dev, u32 timeout)
+{
+	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
+	void __iomem *base;
+
+	if (timeout) {
+		writel(timeout, rtc_data->io + STMP3XXX_RTC_WATCHDOG);
+		base = rtc_data->io + MXS_SET_ADDR;
+	} else {
+		base = rtc_data->io + MXS_CLR_ADDR;
+	}
+	writel(STMP3XXX_RTC_CTRL_WATCHDOGEN, base + STMP3XXX_RTC_CTRL);
+	writel(STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER,
+		base + STMP3XXX_RTC_PERSISTENT1);
+}
+
+static struct stmp3xxx_wdt_pdata wdt_pdata = {
+	.wdt_set_timeout = stmp3xxx_wdt_set_timeout,
+};
+
+static struct platform_device stmp3xxx_wdt_pdev = {
+	.name = "stmp3xxx_rtc_wdt",
+	.dev = {
+		.platform_data = &wdt_pdata,
+	},
+};
+
+static void stmp3xxx_wdt_register(struct platform_device *rtc_pdev)
+{
+	stmp3xxx_wdt_pdev.dev.parent = &rtc_pdev->dev;
+	stmp3xxx_wdt_pdev.id = rtc_pdev->id;
+	platform_device_register(&stmp3xxx_wdt_pdev);
+}
+#else
+static void stmp3xxx_wdt_register(struct device *dev)
+{
+}
+#endif /* CONFIG_STMP3XXX_RTC_WATCHDOG */
+
 static void stmp3xxx_wait_time(struct stmp3xxx_rtc_data *rtc_data)
 {
 	/*
@@ -231,6 +294,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
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
1.7.7.3

