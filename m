Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREsf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:35 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Wolfson Microelectronics <linux@wolfsonmicro.com>
Subject: [PATCH 03/37] watchdog: wm831x: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:36 +0530
Message-Id: <ba6b462280ebc6c56704b226b1b104bcb8e458d4.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Wolfson Microelectronics <linux@wolfsonmicro.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/wm831x_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 2fa17e746ff6..8d1184aee932 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -215,6 +215,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 
 	wm831x_wdt->info = &wm831x_wdt_info;
 	wm831x_wdt->ops = &wm831x_wdt_ops;
+	wm831x_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(wm831x_wdt, nowayout);
 	watchdog_set_drvdata(wm831x_wdt, driver_data);
 
-- 
2.4.3

