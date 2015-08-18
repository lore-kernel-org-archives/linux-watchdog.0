Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60575 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbbHREtr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:47 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	David Cohen <david.a.cohen@linux.intel.com>
Subject: [PATCH 24/37] watchdog: intel-mid: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:57 +0530
Message-Id: <e7c5b17a597850192153e561be655596bf799be8.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: David Cohen <david.a.cohen@linux.intel.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/intel-mid_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 84f6701c391f..0a436b5d1e84 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -137,6 +137,7 @@ static int mid_wdt_probe(struct platform_device *pdev)
 	wdt_dev->min_timeout = MID_WDT_TIMEOUT_MIN;
 	wdt_dev->max_timeout = MID_WDT_TIMEOUT_MAX;
 	wdt_dev->timeout = MID_WDT_DEFAULT_TIMEOUT;
+	wdt_dev->parent = &pdev->dev;
 
 	watchdog_set_drvdata(wdt_dev, &pdev->dev);
 	platform_set_drvdata(pdev, wdt_dev);
-- 
2.4.3

