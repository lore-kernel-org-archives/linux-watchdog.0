Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbbHREsq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:46 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: [PATCH 06/37] watchdog: txx9wdt: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:39 +0530
Message-Id: <c9824208a198e90de7da0bcf2f1347bb393e800a.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/txx9wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 7f615933d31a..c4fa6b55c53d 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -131,6 +131,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
 	txx9wdt.timeout = timeout;
 	txx9wdt.min_timeout = 1;
 	txx9wdt.max_timeout = WD_MAX_TIMEOUT;
+	txx9wdt.parent = &pdev->dev;
 	watchdog_set_nowayout(&txx9wdt, nowayout);
 
 	ret = watchdog_register_device(&txx9wdt);
-- 
2.4.3

