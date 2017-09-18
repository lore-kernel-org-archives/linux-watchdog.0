Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50551 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751734AbdIRFuH (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 18 Sep 2017 01:50:07 -0400
From: Andrew Jeffery <andrew@aj.id.au>
To: linux-watchdog@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, wim@iguana.be,
        linux@roeck-us.net, joel@jms.id.au, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-aspeed@lists.ozlabs.org,
        ryan_chen@aspeedtech.com
Subject: [PATCH 1/4] watchdog: aspeed: Retain watchdog enabled state
Date: Mon, 18 Sep 2017 15:19:02 +0930
Message-Id: <20170918054905.16470-2-andrew@aj.id.au>
In-Reply-To: <20170918054905.16470-1-andrew@aj.id.au>
References: <20170918054905.16470-1-andrew@aj.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

An unintended post-condition of probe() is that the watchdog is
disabled. Rework probe() such that we retain the value of the "enabled"
bit from the control register, and take the appropriate actions with
respect to the watchdog core if so. Otherwise, just configure the
watchdog as directed.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/watchdog/aspeed_wdt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 79cc766cd30f..99bc6fbd8852 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -221,7 +221,8 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	config = ofdid->data;
 
-	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
+	wdt->ctrl |= readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE;
+	wdt->ctrl |= WDT_CTRL_1MHZ_CLK;
 
 	/*
 	 * Control reset on a per-device basis to ensure the
@@ -243,11 +244,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "aspeed,external-signal"))
 		wdt->ctrl |= WDT_CTRL_WDT_EXT;
 
-	writel(wdt->ctrl, wdt->base + WDT_CTRL);
-
-	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
+	if (wdt->ctrl & WDT_CTRL_ENABLE) {
 		aspeed_wdt_start(&wdt->wdd);
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
+	} else {
+		writel(wdt->ctrl, wdt->base + WDT_CTRL);
 	}
 
 	if (of_device_is_compatible(np, "aspeed,ast2500-wdt")) {
-- 
2.11.0

