Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:52172 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPVv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:21:51 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so3964521pbb.8
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:21:51 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 08/14] watchdog/mpcore_wdt: disable wdt in suspend only if it is busy
Date: Tue, 18 Jun 2013 20:50:32 +0530
Message-Id: <8bad206e36e575433374b1ae6a18753ea00d6fa3.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We don't need to call mpcore_wdt_stop() in suspend, if wdt is not BUSY. So, call
mpcore_wdt_stop() conditionally in suspend.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index b4d06f1..75cc518 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -261,7 +261,9 @@ static int mpcore_wdt_remove(struct platform_device *pdev)
 static int mpcore_wdt_suspend(struct device *dev)
 {
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
-	mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
+
+	if (watchdog_active(&wdt->wdd))
+		mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

