Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57268 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREtQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:16 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Gabor Juhos <juhosg@openwrt.org>,
	John Crispin <blogic@openwrt.org>
Subject: [PATCH 15/37] watchdog: rt2880: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:48 +0530
Message-Id: <6d555998711110f55d94eb804eee5621999bf66a.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Gabor Juhos <juhosg@openwrt.org>
cc: John Crispin <blogic@openwrt.org>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/rt2880_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index a6f7e2e29beb..1967919ae743 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -161,6 +161,7 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 	rt288x_wdt_dev.dev = &pdev->dev;
 	rt288x_wdt_dev.bootstatus = rt288x_wdt_bootcause();
 	rt288x_wdt_dev.max_timeout = (0xfffful / rt288x_wdt_freq);
+	rt288x_wdt_dev.parent = &pdev->dev;
 
 	watchdog_init_timeout(&rt288x_wdt_dev, rt288x_wdt_dev.max_timeout,
 			      &pdev->dev);
-- 
2.4.3

