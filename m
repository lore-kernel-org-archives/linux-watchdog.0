Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57194 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREsm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:42 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonas Aaberg <jonas.aberg@stericsson.com>
Subject: [PATCH 05/37] watchdog: ux500: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:38 +0530
Message-Id: <9f0540fd79dee28ec6c2b3a1d23ef3bf73a2a6d2.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Mathieu Poirier <mathieu.poirier@linaro.org>
cc: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/ux500_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index 9de09ab00838..37c084353cce 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -96,6 +96,7 @@ static int ux500_wdt_probe(struct platform_device *pdev)
 			ux500_wdt.max_timeout = WATCHDOG_MAX28;
 	}
 
+	ux500_wdt.parent = &pdev->dev;
 	watchdog_set_nowayout(&ux500_wdt, nowayout);
 
 	/* disable auto off on sleep */
-- 
2.4.3

