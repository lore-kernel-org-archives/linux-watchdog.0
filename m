Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40260 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbbHREta (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:30 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Sylver Bruneau <sylver.bruneau@googlemail.com>
Subject: [PATCH 19/37] watchdog: orion: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:52 +0530
Message-Id: <22180fbf226da19c6822bece3d5f5a17dbfaa0e0.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Sylver Bruneau <sylver.bruneau@googlemail.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/orion_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ef0c628d5037..c6b8f4a43bde 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -567,6 +567,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	dev->wdt.timeout = wdt_max_duration;
 	dev->wdt.max_timeout = wdt_max_duration;
+	dev->wdt.parent = &pdev->dev;
 	watchdog_init_timeout(&dev->wdt, heartbeat, &pdev->dev);
 
 	platform_set_drvdata(pdev, &dev->wdt);
-- 
2.4.3

