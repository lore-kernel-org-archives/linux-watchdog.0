Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32836 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbbHREst (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:49 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Timo Kokkonen <timo.t.kokkonen@nokia.com>
Subject: [PATCH 07/37] watchdog: twl4030: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:40 +0530
Message-Id: <df9e2dd9896939a623031480931c5f726afc765f.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Timo Kokkonen <timo.t.kokkonen@nokia.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/twl4030_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 2c1db6fa9a27..9bf3cc0f3961 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -83,6 +83,7 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 	wdt->timeout		= 30;
 	wdt->min_timeout	= 1;
 	wdt->max_timeout	= 30;
+	wdt->parent = &pdev->dev;
 
 	watchdog_set_nowayout(wdt, nowayout);
 	platform_set_drvdata(pdev, wdt);
-- 
2.4.3

