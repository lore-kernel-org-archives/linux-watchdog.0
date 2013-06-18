Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:36865 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPWO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:22:14 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so4028892pbc.3
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:22:14 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 11/14] watchdog/mpcore_wdt: Add clock framework support
Date: Tue, 18 Jun 2013 20:50:35 +0530
Message-Id: <7578634884ebfe416de3a179f8dd0827ab267882.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds in clk framework support for wdt driver. If clk_get fails for
some platform, then we continue without clk_* API's.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 47 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 43f749d..1a1a1fd 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -20,6 +20,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -39,6 +41,7 @@ struct mpcore_wdt {
 	struct device	*dev;
 	void __iomem	*base;
 	spinlock_t	lock;
+	struct clk	*clk;
 	int		irq;
 	unsigned int	perturb;
 };
@@ -109,15 +112,23 @@ static int mpcore_wdt_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
-static int mpcore_wdt_stop(struct watchdog_device *wdd)
+static void __mpcore_wdt_stop(struct mpcore_wdt *wdt)
 {
-	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
-
 	spin_lock(&wdt->lock);
 	writel_relaxed(0x12345678, wdt->base + TWD_WDOG_DISABLE);
 	writel_relaxed(0x87654321, wdt->base + TWD_WDOG_DISABLE);
 	writel_relaxed(0x0, wdt->base + TWD_WDOG_CONTROL);
 	spin_unlock(&wdt->lock);
+}
+
+static int mpcore_wdt_stop(struct watchdog_device *wdd)
+{
+	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+
+	__mpcore_wdt_stop(wdt);
+
+	if (!IS_ERR(wdt->clk))
+		clk_disable_unprepare(wdt->clk);
 
 	return 0;
 }
@@ -125,9 +136,18 @@ static int mpcore_wdt_stop(struct watchdog_device *wdd)
 static int mpcore_wdt_start(struct watchdog_device *wdd)
 {
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
 
 	dev_info(wdt->dev, "enabling watchdog\n");
 
+	if (!IS_ERR(wdt->clk)) {
+		ret = clk_prepare_enable(wdt->clk);
+		if (ret) {
+			dev_err(wdt->dev, "clock prepare-enabled failed");
+			return ret;
+		}
+	}
+
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_ping(wdd);
 
@@ -173,7 +193,7 @@ static void mpcore_wdt_shutdown(struct platform_device *pdev)
 	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
 	if (system_state == SYSTEM_RESTART || system_state == SYSTEM_HALT)
-		mpcore_wdt_stop(&wdt->wdd);
+		__mpcore_wdt_stop(wdt);
 }
 
 static int mpcore_wdt_probe(struct platform_device *pdev)
@@ -217,6 +237,17 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
+	wdt->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(wdt->clk)) {
+		dev_warn(&pdev->dev, "Clock not found\n");
+	} else {
+		ret = clk_prepare_enable(wdt->clk);
+		if (ret) {
+			dev_err(wdt->dev, "clock prepare-enable failed");
+			goto err_set_drvdata;
+		}
+	}
+
 	wdt->wdd.bootstatus = (readl_relaxed(wdt->base + TWD_WDOG_RESETSTAT) &
 			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
 
@@ -226,7 +257,7 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(wdt->dev, "watchdog_register_device() failed: %d\n",
 				ret);
-		goto err_register;
+		goto err_set_drvdata;
 	}
 
 	/*
@@ -246,7 +277,7 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_register:
+err_set_drvdata:
 	watchdog_set_drvdata(&wdt->wdd, NULL);
 
 	return ret;
@@ -267,7 +298,7 @@ static int mpcore_wdt_suspend(struct device *dev)
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	if (watchdog_active(&wdt->wdd))
-		mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
+		return mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
@@ -277,7 +308,7 @@ static int mpcore_wdt_resume(struct device *dev)
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	if (watchdog_active(&wdt->wdd))
-		mpcore_wdt_start(&wdt->wdd);
+		return mpcore_wdt_start(&wdt->wdd);
 
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e

