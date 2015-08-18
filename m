Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32969 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREtv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:51 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH 25/37] watchdog: ie6xx: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:58 +0530
Message-Id: <96621c4f7605b390f7c3e4dd7613a4a229f500ae.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Alexander Stein <alexander.stein@systec-electronic.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/ie6xx_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 9bc39ae51624..78c2541f5d52 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -267,6 +267,7 @@ static int ie6xx_wdt_probe(struct platform_device *pdev)
 
 	ie6xx_wdt_dev.timeout = timeout;
 	watchdog_set_nowayout(&ie6xx_wdt_dev, nowayout);
+	ie6xx_wdt_dev.parent = &pdev->dev;
 
 	spin_lock_init(&ie6xx_wdt_data.unlock_sequence);
 
-- 
2.4.3

