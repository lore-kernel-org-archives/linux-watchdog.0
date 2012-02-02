Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52124 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757082Ab2BBRwK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Feb 2012 12:52:10 -0500
From: Wolfram Sang <w.sang@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Roland Stigge <stigge@antcom.de>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/4] watchdog: pnx4008: don't use __raw_-accessors
Date: Thu,  2 Feb 2012 18:48:09 +0100
Message-Id: <1328204891-32551-3-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
References: <1328204891-32551-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

__raw_readl/__raw_writel are not meant for drivers [1].

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/117626

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/watchdog/pnx4008_wdt.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 322a392..6010602 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -97,22 +97,21 @@ static void wdt_enable(void)
 	spin_lock(&io_lock);
 
 	/* stop counter, initiate counter reset */
-	__raw_writel(RESET_COUNT, WDTIM_CTRL(wdt_base));
+	writel(RESET_COUNT, WDTIM_CTRL(wdt_base));
 	/*wait for reset to complete. 100% guarantee event */
-	while (__raw_readl(WDTIM_COUNTER(wdt_base)))
+	while (readl(WDTIM_COUNTER(wdt_base)))
 		cpu_relax();
 	/* internal and external reset, stop after that */
-	__raw_writel(M_RES2 | STOP_COUNT0 | RESET_COUNT0,
-		WDTIM_MCTRL(wdt_base));
+	writel(M_RES2 | STOP_COUNT0 | RESET_COUNT0, WDTIM_MCTRL(wdt_base));
 	/* configure match output */
-	__raw_writel(MATCH_OUTPUT_HIGH, WDTIM_EMR(wdt_base));
+	writel(MATCH_OUTPUT_HIGH, WDTIM_EMR(wdt_base));
 	/* clear interrupt, just in case */
-	__raw_writel(MATCH_INT, WDTIM_INT(wdt_base));
+	writel(MATCH_INT, WDTIM_INT(wdt_base));
 	/* the longest pulse period 65541/(13*10^6) seconds ~ 5 ms. */
-	__raw_writel(0xFFFF, WDTIM_PULSE(wdt_base));
-	__raw_writel(heartbeat * WDOG_COUNTER_RATE, WDTIM_MATCH0(wdt_base));
+	writel(0xFFFF, WDTIM_PULSE(wdt_base));
+	writel(heartbeat * WDOG_COUNTER_RATE, WDTIM_MATCH0(wdt_base));
 	/*enable counter, stop when debugger active */
-	__raw_writel(COUNT_ENAB | DEBUG_EN, WDTIM_CTRL(wdt_base));
+	writel(COUNT_ENAB | DEBUG_EN, WDTIM_CTRL(wdt_base));
 
 	spin_unlock(&io_lock);
 }
@@ -121,7 +120,7 @@ static void wdt_disable(void)
 {
 	spin_lock(&io_lock);
 
-	__raw_writel(0, WDTIM_CTRL(wdt_base));	/*stop counter */
+	writel(0, WDTIM_CTRL(wdt_base));	/*stop counter */
 
 	spin_unlock(&io_lock);
 }
@@ -277,7 +276,7 @@ static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	boot_status = (__raw_readl(WDTIM_RES(wdt_base)) &
+	boot_status = (readl(WDTIM_RES(wdt_base)) &
 		WDOG_RESET) ? WDIOF_CARDRESET : 0;
 	wdt_disable();		/*disable for now */
 	clk_disable(wdt_clk);
-- 
1.7.8.3

