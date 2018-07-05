Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37106 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752973AbeGEDXP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 4 Jul 2018 23:23:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id v22-v6so5265709edq.4
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Jul 2018 20:23:14 -0700 (PDT)
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        sudeep.holla@arm.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH] watchdog: sp805: Add clock-frequency property
Date: Thu,  5 Jul 2018 08:52:48 +0530
Message-Id: <1530760968-13104-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When using ACPI node, binding clock devices are
not available as device tree, So clock-frequency
property given in _DSD object of ACPI device is
used to calculate Watchdog rate.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/watchdog/sp805_wdt.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 9849db0..d830dbc 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -22,6 +22,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -65,6 +66,7 @@ struct sp805_wdt {
 	spinlock_t			lock;
 	void __iomem			*base;
 	struct clk			*clk;
+	u64				rate;
 	struct amba_device		*adev;
 	unsigned int			load_val;
 };
@@ -80,7 +82,10 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
-	rate = clk_get_rate(wdt->clk);
+	if (wdt->rate)
+		rate = wdt->rate;
+	else
+		rate = clk_get_rate(wdt->clk);
 
 	/*
 	 * sp805 runs counter with given value twice, after the end of first
@@ -108,7 +113,10 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
-	rate = clk_get_rate(wdt->clk);
+	if (wdt->rate)
+		rate = wdt->rate;
+	else
+		rate = clk_get_rate(wdt->clk);
 
 	spin_lock(&wdt->lock);
 	load = readl_relaxed(wdt->base + WDTVALUE);
@@ -230,11 +238,22 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 
 	wdt->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
-		dev_warn(&adev->dev, "Clock not found\n");
-		ret = PTR_ERR(wdt->clk);
-		goto err;
+		dev_warn(&adev->dev, "Clock device not found\n");
+		wdt->clk = NULL;
+		/*
+		 * When Driver probe with ACPI device, clock devices
+		 * are not available, so watchdog rate get from
+		 * clock-frequency property given in _DSD object.
+		 */
+		device_property_read_u64(&adev->dev, "clock-frequency",
+					 &wdt->rate);
+		if (!wdt->rate) {
+			ret = -ENODEV;
+			goto err;
+		}
 	}
 
+
 	wdt->adev = adev;
 	wdt->wdd.info = &wdt_info;
 	wdt->wdd.ops = &wdt_ops;
-- 
2.7.4

