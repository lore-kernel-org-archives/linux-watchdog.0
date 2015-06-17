Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [85.220.129.30] ([85.220.129.30]:54487 "EHLO smtp1.goneo.de"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754738AbbFQJIs (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 05:08:48 -0400
From: poeschel@lemonage.de
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] watchdog: omap_wdt: implement get_timeleft
Date: Wed, 17 Jun 2015 10:58:59 +0200
Message-Id: <1434531539-6198-1-git-send-email-poeschel@lemonage.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

The omap watchdog hardware is able to read the watchdog timer counter
register. This implements this functionality in the omap_wdt driver, so
one is can read the time until the watchdog will trigger the reset in
seconds using WDIOC_GETTIMELEFT.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 drivers/watchdog/omap_wdt.c | 11 +++++++++++
 drivers/watchdog/omap_wdt.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1e6be9e..2480a27 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -188,6 +188,16 @@ static int omap_wdt_set_timeout(struct watchdog_device *wdog,
 	return 0;
 }
 
+static unsigned int omap_wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	struct omap_wdt_dev *wdev = watchdog_get_drvdata(wdog);
+	void __iomem *base = wdev->base;
+	u32 value;
+
+	value = readl_relaxed(base + OMAP_WATCHDOG_CRR);
+	return GET_WCCR_SECS(value);
+}
+
 static const struct watchdog_info omap_wdt_info = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
 	.identity = "OMAP Watchdog",
@@ -199,6 +209,7 @@ static const struct watchdog_ops omap_wdt_ops = {
 	.stop		= omap_wdt_stop,
 	.ping		= omap_wdt_ping,
 	.set_timeout	= omap_wdt_set_timeout,
+	.get_timeleft	= omap_wdt_get_timeleft,
 };
 
 static int omap_wdt_probe(struct platform_device *pdev)
diff --git a/drivers/watchdog/omap_wdt.h b/drivers/watchdog/omap_wdt.h
index 09b774c..42f31ec 100644
--- a/drivers/watchdog/omap_wdt.h
+++ b/drivers/watchdog/omap_wdt.h
@@ -50,5 +50,6 @@
 
 #define PTV			0	/* prescale */
 #define GET_WLDR_VAL(secs)	(0xffffffff - ((secs) * (32768/(1<<PTV))) + 1)
+#define GET_WCCR_SECS(val)	((0xffffffff - (val) + 1) / (32768/(1<<PTV)))
 
 #endif				/* _OMAP_WATCHDOG_H */
-- 
2.1.4

