Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37084 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616AbbHREth (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:37 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Andreas Werner <andreas.werner@men.de>
Subject: [PATCH 21/37] watchdog: menf21bmc: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:54 +0530
Message-Id: <c80e5040fe23d849381e03ba27ae544f584d779b.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Andreas Werner <andreas.werner@men.de>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/menf21bmc_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/menf21bmc_wdt.c b/drivers/watchdog/menf21bmc_wdt.c
index 59f0913c7341..3aefddebb386 100644
--- a/drivers/watchdog/menf21bmc_wdt.c
+++ b/drivers/watchdog/menf21bmc_wdt.c
@@ -130,6 +130,7 @@ static int menf21bmc_wdt_probe(struct platform_device *pdev)
 	drv_data->wdt.info = &menf21bmc_wdt_info;
 	drv_data->wdt.min_timeout = BMC_WD_TIMEOUT_MIN;
 	drv_data->wdt.max_timeout = BMC_WD_TIMEOUT_MAX;
+	drv_data->wdt.parent = &pdev->dev;
 	drv_data->i2c_client = i2c_client;
 
 	/*
-- 
2.4.3

