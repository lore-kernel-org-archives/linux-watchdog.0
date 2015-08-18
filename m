Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60470 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbbHREs4 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:56 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Wolfram Sang <kernel@pengutronix.de>
Subject: [PATCH 09/37] watchdog: stmp3xxx_rtc: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:42 +0530
Message-Id: <8833ce9da792634ed606bfaa745c4b9806b4a0d5.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Wolfram Sang <kernel@pengutronix.de>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index e7f0d5b60d3d..3ee6128a540e 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -76,6 +76,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&stmp3xxx_wdd, &pdev->dev);
 
 	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
+	stmp3xxx_wdd.parent = &pdev->dev;
 
 	ret = watchdog_register_device(&stmp3xxx_wdd);
 	if (ret < 0) {
-- 
2.4.3

