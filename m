Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33041 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREuT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:19 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Anthony Olech <Anthony.Olech@diasemi.com>
Subject: [PATCH 33/37] watchdog: da9052: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:06 +0530
Message-Id: <03d0403e435c5aba0acaef66004a71c0511ebcbd.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Anthony Olech <Anthony.Olech@diasemi.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/da9052_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 2e9589652e1e..67e67977bd29 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -195,6 +195,7 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	da9052_wdt->timeout = DA9052_DEF_TIMEOUT;
 	da9052_wdt->info = &da9052_wdt_info;
 	da9052_wdt->ops = &da9052_wdt_ops;
+	da9052_wdt->parent = &pdev->dev;
 	watchdog_set_drvdata(da9052_wdt, driver_data);
 
 	kref_init(&driver_data->kref);
-- 
2.4.3

