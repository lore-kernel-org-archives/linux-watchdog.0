Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:65166 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452AbaCDJk2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Mar 2014 04:40:28 -0500
Received: by mail-pb0-f53.google.com with SMTP id rp16so4991812pbb.12
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Mar 2014 01:40:27 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	sachin.kamat@linaro.org
Subject: [PATCH 1/2] watchdog: s3c2410_wdt: Remove unneeded initialization
Date: Tue,  4 Mar 2014 15:04:34 +0530
Message-Id: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Initializing clk to NULL as a reset/error condition does not
help as NULL is not an invalid condition w.r.t clk. Remove this
initialization altogether as there is no state retention.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/s3c2410_wdt.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index aba6cd46b45b..a0f8f771adec 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -607,7 +607,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 
  err_clk:
 	clk_disable_unprepare(wdt->clock);
-	wdt->clock = NULL;
 
  err:
 	return ret;
@@ -627,7 +626,6 @@ static int s3c2410wdt_remove(struct platform_device *dev)
 	s3c2410wdt_cpufreq_deregister(wdt);
 
 	clk_disable_unprepare(wdt->clock);
-	wdt->clock = NULL;
 
 	return 0;
 }
-- 
1.7.9.5

