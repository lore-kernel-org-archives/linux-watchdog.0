Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57311 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634AbbHREtk (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:40 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 22/37] watchdog: mena21: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:55 +0530
Message-Id: <a49b0e0f3d04f1e4e55b3694aed8e687010b6110.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/mena21_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index d193a5e79c38..69013007dc47 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -197,6 +197,7 @@ static int a21_wdt_probe(struct platform_device *pdev)
 	watchdog_init_timeout(&a21_wdt, 30, &pdev->dev);
 	watchdog_set_nowayout(&a21_wdt, nowayout);
 	watchdog_set_drvdata(&a21_wdt, drv);
+	a21_wdt.parent = &pdev->dev;
 
 	reset = a21_wdt_get_bootstatus(drv);
 	if (reset == 2)
-- 
2.4.3

