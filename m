Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57290 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREt1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:27 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Dmitry Chigirev <source@mvista.com>,
	Vitaly Wool <vitalywool@gmail.com>
Subject: [PATCH 18/37] watchdog: pnx4008: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:51 +0530
Message-Id: <b85701e533fe8c1f8dab8e7667299f243b228026.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Dmitry Chigirev <source@mvista.com>
cc: Vitaly Wool <vitalywool@gmail.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/pnx4008_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index b9c6049c3e78..4224b3ec83a5 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -167,6 +167,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
+	pnx4008_wdd.parent = &pdev->dev;
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
 
 	pnx4008_wdt_stop(&pnx4008_wdd);	/* disable for now */
-- 
2.4.3

