Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41298 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREuJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:09 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
Subject: [PATCH 30/37] watchdog: da9063: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:03 +0530
Message-Id: <bbf6a8e14ceccc4568cdabfe4c6b243b08744487.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/da9063_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index e2fe2ebdebd4..6bf130bd863d 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -175,6 +175,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
 	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
+	wdt->wdtdev.parent = &pdev->dev;
 
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
 
-- 
2.4.3

