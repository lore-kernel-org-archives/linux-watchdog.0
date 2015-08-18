Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33007 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREuD (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:03 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 28/37] watchdog: digicolor: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:01 +0530
Message-Id: <d84aa2598fda3d7cc9c3b6092def423b79109ee7.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/digicolor_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 31d8e4936611..50abe1bf62a5 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -143,6 +143,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	}
 	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
 	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
+	dc_wdt_wdd.parent = &pdev->dev;
 
 	spin_lock_init(&wdt->lock);
 
-- 
2.4.3

