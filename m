Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:42201 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPVd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:21:33 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr13so4018193pbb.20
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:21:32 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 06/14] watchdog/mpcore_wdt: convert to use module_platform_driver()
Date: Tue, 18 Jun 2013 20:50:30 +0530
Message-Id: <dce2c81fcc88396f4a78495b759def2ebf995080.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch converts the mpcore_wdt driver to use the module_platform_driver()
macro which makes the code smaller and a bit simpler.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index b699df4..5955757 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -294,18 +294,7 @@ static struct platform_driver mpcore_wdt_driver = {
 	},
 };
 
-static int __init mpcore_wdt_init(void)
-{
-	return platform_driver_register(&mpcore_wdt_driver);
-}
-
-static void __exit mpcore_wdt_exit(void)
-{
-	platform_driver_unregister(&mpcore_wdt_driver);
-}
-
-module_init(mpcore_wdt_init);
-module_exit(mpcore_wdt_exit);
+module_platform_driver(mpcore_wdt_driver);
 
 MODULE_AUTHOR("ARM Limited");
 MODULE_DESCRIPTION("MPcore Watchdog Device Driver");
-- 
1.7.12.rc2.18.g61b472e

