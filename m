Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33015 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREuG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:50:06 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Subject: [PATCH 29/37] watchdog: davinci: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:18:02 +0530
Message-Id: <af1b68d4343e8ccdfed0220516691c681daccfb0.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/davinci_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index cfdf8a408aea..17454ca653f4 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -179,6 +179,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	wdd->min_timeout	= 1;
 	wdd->max_timeout	= MAX_HEARTBEAT;
 	wdd->timeout		= DEFAULT_HEARTBEAT;
+	wdd->parent		= &pdev->dev;
 
 	watchdog_init_timeout(wdd, heartbeat, dev);
 
-- 
2.4.3

