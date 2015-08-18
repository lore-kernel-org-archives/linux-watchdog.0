Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREtX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:23 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Josh Cartwright <joshc@codeaurora.org>
Subject: [PATCH 17/37] watchdog: qcom: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:50 +0530
Message-Id: <4c8607020ae5fbcc0ba5b507c8c55b7baf1e14a4.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Josh Cartwright <joshc@codeaurora.org
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/qcom-wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index aa03ca8f2d9b..773dcfaee7b2 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -171,6 +171,7 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 	wdt->wdd.ops = &qcom_wdt_ops;
 	wdt->wdd.min_timeout = 1;
 	wdt->wdd.max_timeout = 0x10000000U / wdt->rate;
+	wdt->wdd.parent = &pdev->dev;
 
 	/*
 	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
-- 
2.4.3

