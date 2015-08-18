Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbbHREtJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:09 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Paul Mundt <lethal@linux-sh.org>
Subject: [PATCH 13/37] watchdog: sh: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:46 +0530
Message-Id: <2871811081a648b9ff895cbe6e9ed19093da3c9a.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/shwdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 567458b137a6..f90812170657 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -252,6 +252,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&sh_wdt_dev, nowayout);
 	watchdog_set_drvdata(&sh_wdt_dev, wdt);
+	sh_wdt_dev.parent = &pdev->dev;
 
 	spin_lock_init(&wdt->lock);
 
-- 
2.4.3

