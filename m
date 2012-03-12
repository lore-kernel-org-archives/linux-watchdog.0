Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:55522 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751785Ab2CLEXv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:51 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 10/22] watchdog/mpcore_wdt: Use dev_(crit, err, info) instead of dev_printk
Date: Mon, 12 Mar 2012 09:52:05 +0530
Message-ID: <6e02b1c0f3c1540da56b92a06161a800a1089145.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 19aaad7..c820e4f 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -71,8 +71,7 @@ static irqreturn_t mpcore_wdt_fire(int irq, void *arg)
 
 	/* Check it really was our interrupt */
 	if (readl(wdt->base + TWD_WDOG_INTSTAT)) {
-		dev_printk(KERN_CRIT, wdt->dev,
-					"Triggered - Reboot ignored.\n");
+		dev_crit(wdt->dev, "Triggered - Reboot ignored.\n");
 		/* Clear the interrupt on the watchdog */
 		writel(1, wdt->base + TWD_WDOG_INTSTAT);
 		return IRQ_HANDLED;
@@ -123,7 +122,7 @@ static int mpcore_wdt_start(struct watchdog_device *wdd)
 {
 	struct mpcore_wdt *wdt = watchdog_get_drvdata(wdd);
 
-	dev_printk(KERN_INFO, wdt->dev, "enabling watchdog.\n");
+	dev_info(wdt->dev, "enabling watchdog.\n");
 
 	/* This loads the count register but does NOT start the count yet */
 	mpcore_wdt_ping(wdd);
@@ -192,7 +191,7 @@ static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
 		ret = devm_request_irq(wdt->dev, wdt->irq, mpcore_wdt_fire, 0,
 				"mpcore_wdt", wdt);
 		if (ret) {
-			dev_printk(KERN_ERR, wdt->dev,
+			dev_err(wdt->dev,
 					"cannot register IRQ%d for watchdog\n",
 					wdt->irq);
 			return ret;
-- 
1.7.8.110.g4cb5d

