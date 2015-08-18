Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32960 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbbHREto (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:44 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 23/37] watchdog: jz4740: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:56 +0530
Message-Id: <59aa829200728ba906f507745564d5a850cdb49e.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/jz4740_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 4c2cc09c0c57..6a7d5c365438 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -174,6 +174,7 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
 	jz4740_wdt->timeout = heartbeat;
 	jz4740_wdt->min_timeout = 1;
 	jz4740_wdt->max_timeout = MAX_HEARTBEAT;
+	jz4740_wdt->parent = &pdev->dev;
 	watchdog_set_nowayout(jz4740_wdt, nowayout);
 	watchdog_set_drvdata(jz4740_wdt, drvdata);
 
-- 
2.4.3

