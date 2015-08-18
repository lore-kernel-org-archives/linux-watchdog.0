Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41118 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREsj (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:39 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Marc Vertes <marc.vertes@sigfox.com>
Subject: [PATCH 04/37] watchdog: via: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:37 +0530
Message-Id: <1d2269d9939f5441dd49a62d82fcf6050a23146d.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Marc Vertes <marc.vertes@sigfox.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/via_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 56369c4f1961..5f9cbc37520d 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -206,6 +206,7 @@ static int wdt_probe(struct pci_dev *pdev,
 		timeout = WDT_TIMEOUT;
 
 	wdt_dev.timeout = timeout;
+	wdt_dev.parent = &pdev->dev;
 	watchdog_set_nowayout(&wdt_dev, nowayout);
 	if (readl(wdt_mem) & VIA_WDT_FIRED)
 		wdt_dev.bootstatus |= WDIOF_CARDRESET;
-- 
2.4.3

