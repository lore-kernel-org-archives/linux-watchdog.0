Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41359 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREue (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:34 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 37/37] watchdog: bcm2835: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:10 +0530
Message-Id: <0aa282cbbe45870937b056c20461a972bedcf173.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/bcm2835_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 7116968dee12..66c3e656a616 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -182,6 +182,7 @@ static int bcm2835_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&bcm2835_wdt_wdd, wdt);
 	watchdog_init_timeout(&bcm2835_wdt_wdd, heartbeat, dev);
 	watchdog_set_nowayout(&bcm2835_wdt_wdd, nowayout);
+	bcm2835_wdt_wdd.parent = &pdev->dev;
 	err = watchdog_register_device(&bcm2835_wdt_wdd);
 	if (err) {
 		dev_err(dev, "Failed to register watchdog device");
-- 
2.4.3

