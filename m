Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32936 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbbHREtd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:33 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	"George G. Davis" <gdavis@mvista.com>
Subject: [PATCH 20/37] watchdog: omap: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:53 +0530
Message-Id: <4fc348a78ff3ae355dcc4536149f8f8f7b0011ba.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: George G. Davis <gdavis@mvista.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/omap_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index de911c7e477c..d96bee017fd3 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -253,6 +253,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	wdev->wdog.ops = &omap_wdt_ops;
 	wdev->wdog.min_timeout = TIMER_MARGIN_MIN;
 	wdev->wdog.max_timeout = TIMER_MARGIN_MAX;
+	wdev->wdog.parent = &pdev->dev;
 
 	if (watchdog_init_timeout(&wdev->wdog, timer_margin, &pdev->dev) < 0)
 		wdev->wdog.timeout = TIMER_MARGIN_DEFAULT;
-- 
2.4.3

