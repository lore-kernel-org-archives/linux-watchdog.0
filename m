Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:54889 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971AbaDDOyD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 4 Apr 2014 10:54:03 -0400
From: Anatolij Gustschin <agust@denx.de>
To: linux-arm-kernel@lists.infradead.org,
	Shawn Guo <shawn.guo@linaro.org>
Cc: linux-watchdog@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: imx2_wdt: handle enabled watchdog properly
Date: Fri,  4 Apr 2014 16:54:01 +0200
Message-Id: <1396623242-15234-1-git-send-email-agust@denx.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If the watchdog is already enabled (e.g. started by the boot loader),
we need to handle this case properly and start reloading the watchdog
time-out counter as frequently as needed.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/imx2_wdt.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index dd51d95..bef9a9f 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -54,6 +54,7 @@
 #define IMX2_WDT_DEFAULT_TIME	60		/* in seconds */
 
 #define WDOG_SEC_TO_COUNT(s)	((s * 2 - 1) << 8)
+#define WDOG_COUNT_TO_SEC(c)	((((c) >> 8) + 1) / 2)
 
 #define IMX2_WDT_STATUS_OPEN	0
 #define IMX2_WDT_STATUS_STARTED	1
@@ -120,6 +121,27 @@ static void imx2_wdt_timer_ping(unsigned long arg)
 	mod_timer(&imx2_wdt.timer, jiffies + imx2_wdt.timeout * HZ / 2);
 }
 
+static inline void imx2_wdt_ping_if_active(void)
+{
+	u16 val = __raw_readw(imx2_wdt.base + IMX2_WDT_WCR);
+
+	if (val & IMX2_WDT_WCR_WDE) {
+		/* Must enable the clock, wdog service doesn't work otherwise */
+		clk_prepare_enable(imx2_wdt.clk);
+
+		set_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status);
+		imx2_wdt.timeout = WDOG_COUNT_TO_SEC(val);
+		if (imx2_wdt.timeout < 2) {
+			imx2_wdt.timeout = 2;
+			/* Set new watchdog time-out value */
+			val &= ~IMX2_WDT_WCR_WT;
+			val |= WDOG_SEC_TO_COUNT(imx2_wdt.timeout);
+			__raw_writew(val, imx2_wdt.base + IMX2_WDT_WCR);
+		}
+		imx2_wdt_timer_ping(0);
+	}
+}
+
 static void imx2_wdt_start(void)
 {
 	if (!test_and_set_bit(IMX2_WDT_STATUS_STARTED, &imx2_wdt.status)) {
@@ -283,6 +305,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
+	imx2_wdt_ping_if_active();
+
 	dev_info(&pdev->dev,
 		"IMX2+ Watchdog Timer enabled. timeout=%ds (nowayout=%d)\n",
 						imx2_wdt.timeout, nowayout);
-- 
1.7.9.5

