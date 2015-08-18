Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41306 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREuM (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:12 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	S Twiss <stwiss.opensource@diasemi.com>
Subject: [PATCH 31/37] watchdog: da9062: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:04 +0530
Message-Id: <4f1b4306701de454245f654b448ca5f23c205cc4.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: S Twiss <stwiss.opensource@diasemi.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/da9062_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index b3a870ce85be..7386111220d5 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -210,6 +210,7 @@ static int da9062_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
 	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
 	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
+	wdt->wdtdev.parent = &pdev->dev;
 
 	watchdog_set_drvdata(&wdt->wdtdev, wdt);
 	dev_set_drvdata(&pdev->dev, wdt);
-- 
2.4.3

