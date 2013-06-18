Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:64624 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPV0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:21:26 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so3990473pbc.21
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:21:25 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 05/14] watchdog/mpcore_wdt: Set default heartbeat in probe instead of init
Date: Tue, 18 Jun 2013 20:50:29 +0530
Message-Id: <683596e050b7fe09ab0c473db1648b0269ee6671.1371535242.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently mpcore_margin is handled in mpcore_wdt_init routine, which will be
called even if we haven't added any device for watchdog.

This patch moves this code into probe routine, so that it only gets hit once we
add device for this driver.

This also uses dev_info() style print statements instead of printk()

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index ca9afa7..b699df4 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -224,6 +224,21 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 		goto err_register;
 	}
 
+	/*
+	 * Check that the mpcore_margin value is within it's range; if not reset
+	 * to the default
+	 */
+	if (mpcore_margin < MIN_TIME || mpcore_margin > MAX_TIME) {
+		mpcore_margin = TIMER_MARGIN;
+		dev_info(wdt->dev, "mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
+			TIMER_MARGIN);
+	}
+
+	mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
+	dev_info(wdt->dev, "MPcore Watchdog Timer: 0.1. mpcore_noboot=%d "
+			"mpcore_margin=%d sec (nowayout= %d)\n", mpcore_noboot,
+			mpcore_margin, nowayout);
+
 	return 0;
 
 err_register:
@@ -281,20 +296,6 @@ static struct platform_driver mpcore_wdt_driver = {
 
 static int __init mpcore_wdt_init(void)
 {
-	/*
-	 * Check that the mpcore_margin value is within it's range;
-	 * if not reset to the default
-	 */
-	if (mpcore_margin < MIN_TIME || mpcore_margin > MAX_TIME) {
-		mpcore_margin = TIMER_MARGIN;
-		pr_info("mpcore_margin value must be 0 < mpcore_margin < 65536, using %d\n",
-			TIMER_MARGIN);
-	}
-
-	mpcore_wdt_set_heartbeat(NULL, mpcore_margin);
-	pr_info("MPcore Watchdog Timer: 0.1. mpcore_noboot=%d mpcore_margin=%d sec (nowayout= %d)\n",
-		mpcore_noboot, mpcore_margin, nowayout);
-
 	return platform_driver_register(&mpcore_wdt_driver);
 }
 
-- 
1.7.12.rc2.18.g61b472e

