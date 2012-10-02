Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:62317 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab2JBWfb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Oct 2012 18:35:31 -0400
Received: by padhz1 with SMTP id hz1so5679517pad.19
        for <linux-watchdog@vger.kernel.org>; Tue, 02 Oct 2012 15:35:30 -0700 (PDT)
From: Thomas Abraham <thomas.abraham@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	kgene.kim@samsung.com, ben-linux@fluff.org
Subject: [PATCH] watchdog: s3c2410_wdt: use clk_prepare_enable and clk_disable_unprepare
Date: Wed,  3 Oct 2012 07:32:40 +0900
Message-Id: <1349217160-2517-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Convert clk_enable/clk_disable to clk_prepare_enable/clk_disable_unprepare
calls as required by common clock framework.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/watchdog/s3c2410_wdt.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 9245b4d..3cdaaff 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -354,7 +354,7 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 		goto err_map;
 	}
 
-	clk_enable(wdt_clock);
+	clk_prepare_enable(wdt_clock);
 
 	ret = s3c2410wdt_cpufreq_register();
 	if (ret < 0) {
@@ -421,7 +421,7 @@ static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
 	s3c2410wdt_cpufreq_deregister();
 
  err_clk:
-	clk_disable(wdt_clock);
+	clk_disable_unprepare(wdt_clock);
 	clk_put(wdt_clock);
 	wdt_clock = NULL;
 
@@ -445,7 +445,7 @@ static int __devexit s3c2410wdt_remove(struct platform_device *dev)
 
 	s3c2410wdt_cpufreq_deregister();
 
-	clk_disable(wdt_clock);
+	clk_disable_unprepare(wdt_clock);
 	clk_put(wdt_clock);
 	wdt_clock = NULL;
 
-- 
1.7.4.1

