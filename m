Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:41145 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388014AbeGWJiE (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Jul 2018 05:38:04 -0400
Received: by mail-qt0-f195.google.com with SMTP id e19-v6so15742991qtp.8
        for <linux-watchdog@vger.kernel.org>; Mon, 23 Jul 2018 01:37:58 -0700 (PDT)
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: ray.jui@broadcom.com, vladimir.olovyannikov@broadcom.com,
        vikram.prakash@broadcom.com, scott.branden@broadcom.com,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] watchdog: sp805: Add clock-frequency property
Date: Mon, 23 Jul 2018 14:07:40 +0530
Message-Id: <1532335060-686-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use clock-frequency property given in _DSD object
of ACPI device to calculate Watchdog rate as binding
clock devices are not available as device tree.

Note: There is no formal review process for _DSD
properties

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/watchdog/sp805_wdt.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 9849db0..a896b1c 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -11,6 +11,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi.h>
 #include <linux/device.h>
 #include <linux/resource.h>
 #include <linux/amba/bus.h>
@@ -22,6 +23,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -65,6 +67,7 @@ struct sp805_wdt {
 	spinlock_t			lock;
 	void __iomem			*base;
 	struct clk			*clk;
+	u64				rate;
 	struct amba_device		*adev;
 	unsigned int			load_val;
 };
@@ -80,7 +83,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
 	u64 load, rate;
 
-	rate = clk_get_rate(wdt->clk);
+	rate = wdt->rate;
 
 	/*
 	 * sp805 runs counter with given value twice, after the end of first
@@ -106,9 +109,7 @@ static int wdt_setload(struct watchdog_device *wdd, unsigned int timeout)
 static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 {
 	struct sp805_wdt *wdt = watchdog_get_drvdata(wdd);
-	u64 load, rate;
-
-	rate = clk_get_rate(wdt->clk);
+	u64 load;
 
 	spin_lock(&wdt->lock);
 	load = readl_relaxed(wdt->base + WDTVALUE);
@@ -118,7 +119,7 @@ static unsigned int wdt_timeleft(struct watchdog_device *wdd)
 		load += wdt->load_val + 1;
 	spin_unlock(&wdt->lock);
 
-	return div_u64(load, rate);
+	return div_u64(load, wdt->rate);
 }
 
 static int
@@ -228,11 +229,25 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
-	wdt->clk = devm_clk_get(&adev->dev, NULL);
-	if (IS_ERR(wdt->clk)) {
-		dev_warn(&adev->dev, "Clock not found\n");
-		ret = PTR_ERR(wdt->clk);
-		goto err;
+	if (adev->dev.of_node) {
+		wdt->clk = devm_clk_get(&adev->dev, NULL);
+		if (IS_ERR(wdt->clk)) {
+			dev_err(&adev->dev, "Clock not found\n");
+			return PTR_ERR(wdt->clk);
+		}
+		wdt->rate = clk_get_rate(wdt->clk);
+	} else if (has_acpi_companion(&adev->dev)) {
+		/*
+		 * When Driver probe with ACPI device, clock devices
+		 * are not available, so watchdog rate get from
+		 * clock-frequency property given in _DSD object.
+		 */
+		device_property_read_u64(&adev->dev, "clock-frequency",
+					 &wdt->rate);
+		if (!wdt->rate) {
+			dev_err(&adev->dev, "no clock-frequency property\n");
+			return -ENODEV;
+		}
 	}
 
 	wdt->adev = adev;
-- 
2.7.4

