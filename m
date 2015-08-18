Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37031 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbbHREtG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:06 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Barry Song <baohua@kernel.org>
Subject: [PATCH 12/37] watchdog: sirfsoc: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:45 +0530
Message-Id: <56852cc981b5b202212582e18170afa3f2432b52.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Barry Song <baohua@kernel.org>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/sirfsoc_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 42fa5c0c518a..d0578ab2e636 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -154,6 +154,7 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&sirfsoc_wdd, timeout, &pdev->dev);
 	watchdog_set_nowayout(&sirfsoc_wdd, nowayout);
+	sirfsoc_wdd.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&sirfsoc_wdd);
 	if (ret)
-- 
2.4.3

