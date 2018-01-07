Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:51686 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbeAGDK2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 6 Jan 2018 22:10:28 -0500
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] watchdog: davinci_wdt: add restart function
Date: Sat,  6 Jan 2018 21:10:14 -0600
Message-Id: <1515294615-5473-2-git-send-email-david@lechnology.com>
In-Reply-To: <1515294615-5473-1-git-send-email-david@lechnology.com>
References: <1515294615-5473-1-git-send-email-david@lechnology.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This adds a restart function to the davinci watchdog timer driver.

This is copied from arch/arm/mach-davinci/time.c and will allow us to
remove the code from there.

Signed-off-by: David Lechner <david@lechnology.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/davinci_wdt.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 2f46487..3e4c592 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -140,6 +140,42 @@ static unsigned int davinci_wdt_get_timeleft(struct watchdog_device *wdd)
 	return wdd->timeout - timer_counter;
 }
 
+static int davinci_wdt_restart(struct watchdog_device *wdd,
+			       unsigned long action, void *data)
+{
+	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
+	u32 tgcr, wdtcr;
+
+	/* disable, internal clock source */
+	iowrite32(0, davinci_wdt->base + TCR);
+
+	/* reset timer, set mode to 64-bit watchdog, and unreset */
+	tgcr = 0;
+	iowrite32(tgcr, davinci_wdt->base + TGCR);
+	tgcr = TIMMODE_64BIT_WDOG | TIM12RS_UNRESET | TIM34RS_UNRESET;
+	iowrite32(tgcr, davinci_wdt->base + TGCR);
+
+	/* clear counter and period regs */
+	iowrite32(0, davinci_wdt->base + TIM12);
+	iowrite32(0, davinci_wdt->base + TIM34);
+	iowrite32(0, davinci_wdt->base + PRD12);
+	iowrite32(0, davinci_wdt->base + PRD34);
+
+	/* put watchdog in pre-active state */
+	wdtcr = WDKEY_SEQ0 | WDEN;
+	iowrite32(wdtcr, davinci_wdt->base + WDTCR);
+
+	/* put watchdog in active state */
+	wdtcr = WDKEY_SEQ1 | WDEN;
+	iowrite32(wdtcr, davinci_wdt->base + WDTCR);
+
+	/* write an invalid value to the WDKEY field to trigger a restart */
+	wdtcr = 0x00004000;
+	iowrite32(wdtcr, davinci_wdt->base + WDTCR);
+
+	return 0;
+}
+
 static const struct watchdog_info davinci_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING,
 	.identity = "DaVinci/Keystone Watchdog",
@@ -151,6 +187,7 @@ static const struct watchdog_ops davinci_wdt_ops = {
 	.stop		= davinci_wdt_ping,
 	.ping		= davinci_wdt_ping,
 	.get_timeleft	= davinci_wdt_get_timeleft,
+	.restart	= davinci_wdt_restart,
 };
 
 static int davinci_wdt_probe(struct platform_device *pdev)
@@ -195,6 +232,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(wdd, davinci_wdt);
 	watchdog_set_nowayout(wdd, 1);
+	watchdog_set_restart_priority(wdd, 128);
 
 	wdt_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	davinci_wdt->base = devm_ioremap_resource(dev, wdt_mem);
-- 
2.7.4

