Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:39686 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110Ab3FRPV7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Jun 2013 11:21:59 -0400
Received: by mail-pb0-f44.google.com with SMTP id uo1so4023568pbc.17
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Jun 2013 08:21:59 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: wim@iguana.be
Cc: marc.zyngier@arm.com, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 09/14] watchdog/mpcore_wdt: replace (__raw_)readl/writel with lighter *_relaxed variants
Date: Tue, 18 Jun 2013 20:50:33 +0530
Message-Id: <a0a9b5ee4615bb49459dc2b1d69295529b14a05d.1371535243.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

readl/writel versions for ARMV6+ contain memory barrier instruction for
synchronizing DMA buffers. These are not required at least on this module.  So
use lighter _relaxed variants.

Also, __raw_* variants don't have take care about endianess, so replace them too
with _relaxed variants.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/watchdog/mpcore_wdt.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 75cc518..d8917ad 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -74,10 +74,10 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 	struct mpcore_wdt *wdt = arg;
 
 	/* Check it really was our interrupt */
-	if (readl(wdt->base + TWD_WDOG_INTSTAT)) {
+	if (readl_relaxed(wdt->base + TWD_WDOG_INTSTAT)) {
 		dev_crit(wdt->dev, "Triggered - Reboot ignored\n");
 		/* Clear the interrupt on the watchdog */
-		writel(1, wdt->base + TWD_WDOG_INTSTAT);
+		writel_relaxed(1, wdt->base + TWD_WDOG_INTSTAT);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -97,12 +97,12 @@ static int mpcore_wdt_ping(struct watchdog_device *wdd)
 
 	spin_lock(&wdt->lock);
 	/* Assume prescale is set to 256 */
-	count =  __raw_readl(wdt->base + TWD_WDOG_COUNTER);
+	count = readl_relaxed(wdt->base + TWD_WDOG_COUNTER);
 	count = (0xFFFFFFFFU - count) * (HZ / 5);
 	count = (count / 256) * mpcore_margin;
 
 	/* Reload the counter */
-	writel(count + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
+	writel_relaxed(count + wdt->perturb, wdt->base + TWD_WDOG_LOAD);
 	wdt->perturb = wdt->perturb ? 0 : 1;
 	spin_unlock(&wdt->lock);
 
@@ -114,9 +114,9 @@ static int mpcore_wdt_stop(struct watchdog_device *wdd)
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
 
 	spin_lock(&wdt->lock);
-	writel(0x12345678, wdt->base + TWD_WDOG_DISABLE);
-	writel(0x87654321, wdt->base + TWD_WDOG_DISABLE);
-	writel(0x0, wdt->base + TWD_WDOG_CONTROL);
+	writel_relaxed(0x12345678, wdt->base + TWD_WDOG_DISABLE);
+	writel_relaxed(0x87654321, wdt->base + TWD_WDOG_DISABLE);
+	writel_relaxed(0x0, wdt->base + TWD_WDOG_CONTROL);
 	spin_unlock(&wdt->lock);
 
 	return 0;
@@ -133,10 +133,10 @@ static int mpcore_wdt_start(struct watchdog_device *wdd)
 
 	if (mpcore_noboot) {
 		/* Enable watchdog - prescale=256, watchdog mode=0, enable=1 */
-		writel(0x0000FF01, wdt->base + TWD_WDOG_CONTROL);
+		writel_relaxed(0x0000FF01, wdt->base + TWD_WDOG_CONTROL);
 	} else {
 		/* Enable watchdog - prescale=256, watchdog mode=1, enable=1 */
-		writel(0x0000FF09, wdt->base + TWD_WDOG_CONTROL);
+		writel_relaxed(0x0000FF09, wdt->base + TWD_WDOG_CONTROL);
 	}
 
 	return 0;
-- 
1.7.12.rc2.18.g61b472e

