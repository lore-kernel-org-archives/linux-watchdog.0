Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:43189 "EHLO mail.cosmopool.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbbJBUS0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 2 Oct 2015 16:18:26 -0400
From: Harald Geyer <harald@ccbib.org>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: rtc-linux@googlegroups.com, linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de, Harald Geyer <harald@ccbib.org>
Subject: [PATCH 1/2] rtc: stmp3xxx: unify register access macros
Date: Fri,  2 Oct 2015 20:18:01 +0000
Message-Id: <1443817082-24370-1-git-send-email-harald@ccbib.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use STMP_OFFSET_REG_(SET|CLR) instead of defining _SET and _CLR for
STMP3XXX_RTC_CTRL and STMP3XXX_RTC_PERSISTENT0 - no functional changes.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 drivers/rtc/rtc-stmp3xxx.c |   27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index eb09edd..ca54d03 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -32,8 +32,6 @@
 #include <linux/stmp3xxx_rtc_wdt.h>
 
 #define STMP3XXX_RTC_CTRL			0x0
-#define STMP3XXX_RTC_CTRL_SET			0x4
-#define STMP3XXX_RTC_CTRL_CLR			0x8
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ_EN		0x00000001
 #define STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN	0x00000002
 #define STMP3XXX_RTC_CTRL_ALARM_IRQ		0x00000004
@@ -52,8 +50,6 @@
 #define STMP3XXX_RTC_WATCHDOG			0x50
 
 #define STMP3XXX_RTC_PERSISTENT0		0x60
-#define STMP3XXX_RTC_PERSISTENT0_SET		0x64
-#define STMP3XXX_RTC_PERSISTENT0_CLR		0x68
 #define STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE		(1 << 0)
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN		(1 << 1)
 #define STMP3XXX_RTC_PERSISTENT0_ALARM_EN		(1 << 2)
@@ -179,7 +175,7 @@ static irqreturn_t stmp3xxx_rtc_interrupt(int irq, void *dev_id)
 
 	if (status & STMP3XXX_RTC_CTRL_ALARM_IRQ) {
 		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ,
-				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+			rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 		rtc_update_irq(rtc_data->rtc, 1, RTC_AF | RTC_IRQF);
 		return IRQ_HANDLED;
 	}
@@ -194,15 +190,17 @@ static int stmp3xxx_alarm_irq_enable(struct device *dev, unsigned int enabled)
 	if (enabled) {
 		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
-				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0 +
+				STMP_OFFSET_REG_SET);
 		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-				rtc_data->io + STMP3XXX_RTC_CTRL_SET);
+			rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_SET);
 	} else {
 		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN,
-				rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
+			rtc_data->io + STMP3XXX_RTC_PERSISTENT0 +
+				STMP_OFFSET_REG_CLR);
 		writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-				rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+			rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 	}
 	return 0;
 }
@@ -245,7 +243,7 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 		return 0;
 
 	writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+		rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 
 	return 0;
 }
@@ -334,16 +332,17 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 			STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE;
 	}
 
-	writel(pers0_set, rtc_data->io + STMP3XXX_RTC_PERSISTENT0_SET);
+	writel(pers0_set, rtc_data->io + STMP3XXX_RTC_PERSISTENT0 +
+			STMP_OFFSET_REG_SET);
 
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE | pers0_clr,
-			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
+		rtc_data->io + STMP3XXX_RTC_PERSISTENT0 + STMP_OFFSET_REG_CLR);
 
 	writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN |
 			STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
-			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
+		rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
 
 	rtc_data->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 				&stmp3xxx_rtc_ops, THIS_MODULE);
@@ -376,7 +375,7 @@ static int stmp3xxx_rtc_resume(struct device *dev)
 	writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
 			STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE,
-			rtc_data->io + STMP3XXX_RTC_PERSISTENT0_CLR);
+		rtc_data->io + STMP3XXX_RTC_PERSISTENT0 + STMP_OFFSET_REG_CLR);
 	return 0;
 }
 #endif
-- 
1.7.10.4

