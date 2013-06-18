Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33666 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPVn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:21:43 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so4110378pab.13
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:21:43 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 07/14] watchdog/mpcore_wdt: Add support for dev_pm_ops interface
Date: Tue, 18 Jun 2013 20:50:31 +0530
Message-Id: <bb660fd116fa2fa66782979738fbe7f910c5753e.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds dev_pm_ops support for standby/slepp/hibernate.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 5955757..b4d06f1 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -257,40 +258,39 @@ static int mpcore_wdt_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int mpcore_wdt_suspend(struct platform_device *pdev, pm_message_t msg)
+static int mpcore_wdt_suspend(struct device *dev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
+	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 	mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
 
-static int mpcore_wdt_resume(struct platform_device *pdev)
+static int mpcore_wdt_resume(struct device *dev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
+	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	if (watchdog_active(&wdt->wdd))
 		mpcore_wdt_start(&wdt->wdd);
 
 	return 0;
 }
-#else
-#define mpcore_wdt_suspend	NULL
-#define mpcore_wdt_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mpcore_wdt_suspend,
+		mpcore_wdt_resume);
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:mpcore_wdt");
 
 static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
 	.remove		= mpcore_wdt_remove,
-	.suspend	= mpcore_wdt_suspend,
-	.resume		= mpcore_wdt_resume,
 	.shutdown	= mpcore_wdt_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "mpcore_wdt",
+		.pm	= &mpcore_wdt_dev_pm_ops,
 	},
 };
 
-- 
1.7.12.rc2.18.g61b472e

