Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:56211 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756452AbaCDJkd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Mar 2014 04:40:33 -0500
Received: by mail-pa0-f48.google.com with SMTP id hz1so361356pad.35
        for <linux-watchdog@vger.kernel.org>; Tue, 04 Mar 2014 01:40:32 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	sachin.kamat@linaro.org
Subject: [PATCH 2/2] watchdog: s3c2410_wdt: Check return value of clk_prepare_enable
Date: Tue,  4 Mar 2014 15:04:35 +0530
Message-Id: <1393925675-21636-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org>
References: <1393925675-21636-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

clk_prepare_enable can fail. Check its return value.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/watchdog/s3c2410_wdt.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index a0f8f771adec..7c6ccd071baf 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -525,7 +525,11 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	clk_prepare_enable(wdt->clock);
+	ret = clk_prepare_enable(wdt->clock);
+	if (ret < 0) {
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
+	}
 
 	ret = s3c2410wdt_cpufreq_register(wdt);
 	if (ret < 0) {
-- 
1.7.9.5

