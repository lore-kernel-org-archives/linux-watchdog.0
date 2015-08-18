Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41184 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbbHREtN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:13 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Ben Dooks <ben@simtec.co.uk>
Subject: [PATCH 14/37] watchdog: s3c2410: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:47 +0530
Message-Id: <3042460026d46d4c3e228003cd0cbdc7c94d9c57.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/s3c2410_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index e89ae027c91d..d781000c7825 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -607,6 +607,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	watchdog_set_nowayout(&wdt->wdt_device, nowayout);
 
 	wdt->wdt_device.bootstatus = s3c2410wdt_get_bootstatus(wdt);
+	wdt->wdt_device.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&wdt->wdt_device);
 	if (ret) {
-- 
2.4.3

