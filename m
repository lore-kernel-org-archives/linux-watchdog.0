Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57422 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREua (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:30 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 36/37] watchdog: bcm47xx: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:09 +0530
Message-Id: <6157630bdd5e7a0ea8e2f01c9b0fd7b12f0c68ab.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/bcm47xx_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index b28a072abf78..4064a43f1360 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -209,6 +209,7 @@ static int bcm47xx_wdt_probe(struct platform_device *pdev)
 
 	wdt->wdd.info = &bcm47xx_wdt_info;
 	wdt->wdd.timeout = WDT_DEFAULT_TIME;
+	wdt->wdd.parent = &pdev->dev;
 	ret = wdt->wdd.ops->set_timeout(&wdt->wdd, timeout);
 	if (ret)
 		goto err_timer;
-- 
2.4.3

