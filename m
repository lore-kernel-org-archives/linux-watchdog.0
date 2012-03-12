Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:58143 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803Ab2CLEX5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:57 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 14/22] watchdog/mpcore_wdt: replace (__raw_)readl/writel with lighter *_relaxed variants
Date: Mon, 12 Mar 2012 09:52:09 +0530
Message-ID: <8ff8571bad9de24858b525e01c51a22d7837e201.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

readl/writel versions for ARMV6+ contain memory barrier instruction for
synchronizing DMA buffers. These are not required at least on this module.  So
use lighter _relaxed variants.

Also, __raw_* variants don't have take care about endianess, so replace them too
with _relaxed variants.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 7ded2a0..0d2ea32 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -71,10 +71,10 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 	struct mpcore_wdt *wdt = arg;
 
 	/* Check it really was our interrupt */
-	if (readl(wdt->base + TWD_WDOG_INTSTAT)) {
+	if (readl_relaxed(wdt->base + TWD_WDOG_INTSTAT)) {
 		dev_crit(wdt->dev, "Triggered - Reboot ignored.\n");
 		/* Clear the interrupt on the watchdog */
-		writel(1, wdt->base + TWD_WDOG_INTSTAT);
+		writel_relaxed(1, wdt->base + TWD_WDOG_INTSTAT);
 		return IRQ_HANDLED;
 	}
 	return IRQ_NONE;
@@ -94,12 +94,12 @@ static int mpcore_wdt_ping(struct watchdog_device *wdd)
 
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
 
@@ -111,9 +111,9 @@ static int mpcore_wdt_stop(struct watchdog_device *wdd)
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
@@ -130,10 +130,10 @@ static int mpcore_wdt_start(struct watchdog_device *wdd)
 
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
1.7.8.110.g4cb5d

