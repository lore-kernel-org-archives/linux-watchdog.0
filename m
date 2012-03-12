Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:58422 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877Ab2CLEYE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:24:04 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 16/22] watchdog/mpcore_wdt: Add clock framework support
Date: Mon, 12 Mar 2012 09:52:11 +0530
Message-ID: <418b92e874f89c0163536aa4c79d0230f73b0c42.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds in clk framework support for wdt driver. If clk_get fails for
some platform, then we continue without clk_* API's.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   66 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 73d50c3..23c324c 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -17,6 +17,8 @@
  *
  * (c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  */
+#include <linux/clk.h>
+#include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -36,6 +38,7 @@ struct mpcore_wdt {
 	struct device	*dev;
 	void __iomem	*base;
 	spinlock_t	lock;
+	struct clk	*clk;
 	int		irq;
 	unsigned int	perturb;
 };
@@ -106,15 +109,25 @@ static int mpcore_wdt_ping(struct watchdog_device *wdd)
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
+	if (!IS_ERR(wdt->clk)) {
+		clk_disable(wdt->clk);
+		clk_unprepare(wdt->clk);
+	}
 
 	return 0;
 }
@@ -122,9 +135,25 @@ static int mpcore_wdt_stop(struct watchdog_device *wdd)
 static int mpcore_wdt_start(struct watchdog_device *wdd)
 {
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
+	int ret;
 
 	dev_info(wdt->dev, "enabling watchdog.\n");
 
+	if (!IS_ERR(wdt->clk)) {
+		ret = clk_prepare(wdt->clk);
+		if (ret) {
+			dev_err(wdt->dev, "clock prepare fail");
+			return ret;
+		}
+
+		ret = clk_enable(wdt->clk);
+		if (ret) {
+			dev_err(wdt->dev, "Clock enable failed\n");
+			clk_unprepare(wdt->clk);
+			return ret;
+		}
+	}
+
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_ping(wdd);
 
@@ -170,7 +199,7 @@ static void mpcore_wdt_shutdown(struct platform_device *pdev)
 	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
 
 	if (system_state == SYSTEM_RESTART || system_state == SYSTEM_HALT)
-		mpcore_wdt_stop(&wdt->wdd);
+		__mpcore_wdt_stop(wdt);
 }
 
 static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
@@ -214,6 +243,24 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&wdt->wdd, wdt);
 
+	wdt->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(wdt->clk)) {
+		dev_warn(&pdev->dev, "Clock not found\n");
+	} else {
+		ret = clk_prepare(wdt->clk);
+		if (ret) {
+			dev_err(wdt->dev, "clock prepare fail");
+			goto err_put_clk;
+		}
+
+		ret = clk_enable(wdt->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Clock enable failed\n");
+			clk_unprepare(wdt->clk);
+			goto err_put_clk;
+		}
+	}
+
 	wdt->wdd.bootstatus = (readl_relaxed(wdt->base + TWD_WDOG_RESETSTAT) &
 			TWD_WDOG_RESETSTAT_MASK) ? WDIOF_CARDRESET : 0;
 
@@ -223,7 +270,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(wdt->dev, "watchdog_register_device() failed: %d\n",
 				ret);
-		goto err_register;
+		goto err_put_clk;
 	}
 
 	/*
@@ -243,7 +290,10 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_register:
+err_put_clk:
+	if (!IS_ERR(wdt->clk))
+		clk_put(wdt->clk);
+
 	platform_set_drvdata(pdev, NULL);
 	watchdog_set_drvdata(&wdt->wdd, NULL);
 
@@ -266,7 +316,7 @@ static int mpcore_wdt_suspend(struct device *dev)
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	if (is_wdd_active(&wdt->wdd))
-		mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
+		return mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
@@ -276,7 +326,7 @@ static int mpcore_wdt_resume(struct device *dev)
 	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	if (is_wdd_active(&wdt->wdd))
-		mpcore_wdt_start(&wdt->wdd);
+		return mpcore_wdt_start(&wdt->wdd);
 
 	return 0;
 }
-- 
1.7.8.110.g4cb5d

