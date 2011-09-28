Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40173 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025Ab1I1MaY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 28 Sep 2011 08:30:24 -0400
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Alessandro Zummo <alessandro.zummo@towertech.it>,
	Andrew Morton <akpm@linux-foundation.org>,
	rtc-linux@googlegroups.com
Subject: [PATCH 1/4] rtc: stmp3xxx: add wdt-accessor function
Date: Wed, 28 Sep 2011 14:29:54 +0200
Message-Id: <1317212997-26668-2-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
References: <1317212997-26668-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This RTC also includes a watchdog timer. Provide an accessor function
for it to be picked up by a watchdog driver. Also register the
platform_device here to get proper boot-time dependencies.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: rtc-linux@googlegroups.com
---

Andrew, Wim: Alessandro was not around in the last weeks, so I'd suggest this
patch goes via the watchdog-tree together with the rest of this series if it
passes the review of the watchdog-list? All changes here are in preparation for
the watchdog driver and do not affect the general RTC. Is that okay?

 drivers/rtc/rtc-stmp3xxx.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 7315068..379ceb6 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 
 #include <mach/common.h>
+#include <mach/mxs.h>
 
 #define STMP3XXX_RTC_CTRL			0x0
 #define STMP3XXX_RTC_CTRL_SET			0x4
@@ -34,6 +35,7 @@
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
+#define STMP3XXX_RTC_CTRL_WATCHDOGEN		0x00000010
 
 #define STMP3XXX_RTC_STAT			0x10
 #define STMP3XXX_RTC_STAT_STALE_SHIFT		16
@@ -43,6 +45,8 @@
 
 #define STMP3XXX_RTC_ALARM			0x40
 
+#define STMP3XXX_RTC_WATCHDOG			0x50
+
 #define STMP3XXX_RTC_PERSISTENT0		0x60
 #define STMP3XXX_RTC_PERSISTENT0_SET		0x64
 #define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
@@ -50,12 +54,51 @@
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
 
+#ifdef CONFIG_STMP3XXX_RTC_WATCHDOG
+struct platform_device stmp3xxx_wdt_pdev = {
+	.name = "stmp3xxx_rtc_wdt",
+	.id = -1,
+};
+
+void stmp3xxx_wdt_setup(struct device *dev, u32 timeout)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct stmp3xxx_rtc_data *rtc_data = platform_get_drvdata(pdev);
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
+EXPORT_SYMBOL_GPL(stmp3xxx_wdt_setup);
+
+static void stmp3xxx_wdt_register(struct device *dev)
+{
+	stmp3xxx_wdt_pdev.dev.parent = dev;
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
@@ -231,6 +274,7 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 		goto out_irq_alarm;
 	}
 
+	stmp3xxx_wdt_register(&pdev->dev);
 	return 0;
 
 out_irq_alarm:
-- 
1.7.6.3

