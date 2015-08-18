Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40366 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREuW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:22 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 34/37] watchdog: coh901327: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:07 +0530
Message-Id: <3d4b71b2e0656939243299b4720ba6564ac44c34.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/coh901327_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901327_wdt.c
index ce12f437f195..a099b77fc0b9 100644
--- a/drivers/watchdog/coh901327_wdt.c
+++ b/drivers/watchdog/coh901327_wdt.c
@@ -358,6 +358,7 @@ static int __init coh901327_probe(struct platform_device *pdev)
 	if (ret < 0)
 		coh901327_wdt.timeout = 60;
 
+	coh901327_wdt.parent = &pdev->dev;
 	ret = watchdog_register_device(&coh901327_wdt);
 	if (ret == 0)
 		dev_info(&pdev->dev,
-- 
2.4.3

