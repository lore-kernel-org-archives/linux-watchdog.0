Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57245 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbbHREtD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:03 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Viresh Kumar <vireshk@kernel.org>
Subject: [PATCH 11/37] watchdog: sp805: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:44 +0530
Message-Id: <4535d0542876d504b4b390c3b1aca408bc021630.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Viresh Kumar <vireshk@kernel.org>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/sp805_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 4e7fec36f5c3..01d816251302 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -226,6 +226,7 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	wdt->adev = adev;
 	wdt->wdd.info = &wdt_info;
 	wdt->wdd.ops = &wdt_ops;
+	wdt->wdd.parent = &adev->dev;
 
 	spin_lock_init(&wdt->lock);
 	watchdog_set_nowayout(&wdt->wdd, nowayout);
-- 
2.4.3

