Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35406 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932690Ab3FRPWe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:22:34 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so4001558pdi.41
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:22:33 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 14/14] watchdog/mpcore_wdt: Add DT probing support for ARM mpcore watchdog
Date: Tue, 18 Jun 2013 20:50:38 +0530
Message-Id: <51fb528c67247ea5ef6c66650f6adf7a2a21bc81.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds Device tree probing support for ARM Mpcore watchdog. Its binding
were already documented in Documentation/devicetree/bindings/arm/twd.txt.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index d7ee4eb..50f5a0b 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -27,6 +27,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/reboot.h>
@@ -403,6 +404,16 @@ static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mpcore_wdt_suspend,
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:mpcore_wdt");
 
+#ifdef CONFIG_OF
+static const struct of_device_id mpcore_wdt_id_table[] = {
+	{ .compatible = "arm,cortex-a9-twd-wdt" },
+	{ .compatible = "arm,cortex-a5-twd-wdt" },
+	{ .compatible = "arm,arm11mp-twd-wdt" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpcore_wdt_id_table);
+#endif
+
 static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
 	.remove		= mpcore_wdt_remove,
@@ -411,6 +422,7 @@ static struct platform_driver mpcore_wdt_driver = {
 		.owner	= THIS_MODULE,
 		.name	= "mpcore_wdt",
 		.pm	= &mpcore_wdt_dev_pm_ops,
+		.of_match_table = of_match_ptr(mpcore_wdt_id_table),
 	},
 };
 
-- 
1.7.12.rc2.18.g61b472e

