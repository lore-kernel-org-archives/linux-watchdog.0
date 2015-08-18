Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57392 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREuQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:16 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	David Dajun Chen <dchen@diasemi.com>
Subject: [PATCH 32/37] watchdog: da9055: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:05 +0530
Message-Id: <e11ec3162605a57d754ff9fece75b48dd4a3fc33.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: David Dajun Chen <dchen@diasemi.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/da9055_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 495089d8dbfe..04d1430d93d2 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -161,6 +161,7 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 	da9055_wdt->timeout = DA9055_DEF_TIMEOUT;
 	da9055_wdt->info = &da9055_wdt_info;
 	da9055_wdt->ops = &da9055_wdt_ops;
+	da9055_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(da9055_wdt, nowayout);
 	watchdog_set_drvdata(da9055_wdt, driver_data);
 
-- 
2.4.3

