Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREt6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:58 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Ray Lehtiniemi <rayl@mail.com>,
	Alessandro Zummo <a.zummo@towertech.it>
Subject: [PATCH 27/37] watchdog: ep93xx: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:00 +0530
Message-Id: <7c13d4cd85596bcd2b156017b267ef40cd5ef583.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Ray Lehtiniemi <rayl@mail.com>
cc: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/ep93xx_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 7a2cc7191c58..0a4d7cc05d54 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -132,6 +132,7 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	val = readl(mmio_base + EP93XX_WATCHDOG);
 	ep93xx_wdt_wdd.bootstatus = (val & 0x01) ? WDIOF_CARDRESET : 0;
 	ep93xx_wdt_wdd.timeout = timeout;
+	ep93xx_wdt_wdd.parent = &pdev->dev;
 
 	watchdog_set_nowayout(&ep93xx_wdt_wdd, nowayout);
 
-- 
2.4.3

