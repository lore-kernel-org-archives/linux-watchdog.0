Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREu0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:26 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Markus Mayer <mmayer@broadcom.com>
Subject: [PATCH 35/37] watchdog: bcm_kona: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:08 +0530
Message-Id: <296335461e03dee66733340141ed03b904822e8b.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Markus Mayer <mmayer@broadcom.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/bcm_kona_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 22d8ae65772a..e0c98423f2c9 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -319,6 +319,7 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
+	bcm_kona_wdt_wdd.parent = &pdev->dev;
 
 	ret = bcm_kona_wdt_set_timeout_reg(&bcm_kona_wdt_wdd, 0);
 	if (ret) {
-- 
2.4.3

