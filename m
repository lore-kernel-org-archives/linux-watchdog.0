Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37060 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREtU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:20 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 16/37] watchdog: retu: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:49 +0530
Message-Id: <0327fe2173fdca52a809c56f41b6e3da4d0eedab.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/retu_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
index b7c68e275aeb..39cd51df2ffc 100644
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -127,6 +127,7 @@ static int retu_wdt_probe(struct platform_device *pdev)
 	retu_wdt->timeout	= RETU_WDT_MAX_TIMER;
 	retu_wdt->min_timeout	= 0;
 	retu_wdt->max_timeout	= RETU_WDT_MAX_TIMER;
+	retu_wdt->parent	= &pdev->dev;
 
 	watchdog_set_drvdata(retu_wdt, wdev);
 	watchdog_set_nowayout(retu_wdt, nowayout);
-- 
2.4.3

