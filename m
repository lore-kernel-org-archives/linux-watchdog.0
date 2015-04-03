Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f202.google.com ([209.85.213.202]:34701 "EHLO
	mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbDCRFZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 3 Apr 2015 13:05:25 -0400
Received: by igdh15 with SMTP id h15so3930025igd.1
        for <linux-watchdog@vger.kernel.org>; Fri, 03 Apr 2015 10:05:24 -0700 (PDT)
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Bresticker <abrestic@chromium.org>,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	James Hogan <james.hogan@imgtec.com>
Subject: [PATCH V3 2/3] watchdog: imgpdc: Set timeout before starting watchdog
Date: Fri,  3 Apr 2015 10:05:21 -0700
Message-Id: <1428080722-29683-2-git-send-email-abrestic@chromium.org>
In-Reply-To: <1428080722-29683-1-git-send-email-abrestic@chromium.org>
References: <1428080722-29683-1-git-send-email-abrestic@chromium.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Set up the watchdog for the specified timeout before attempting to start it.

Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
---
No changes from v2.
Changes from v1:
 - Moved setting of timeout to a helper as suggested by Guenter.
---
 drivers/watchdog/imgpdc_wdt.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index d6826a6..ffeb1bf 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -84,18 +84,24 @@ static int pdc_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static void __pdc_wdt_set_timeout(struct pdc_wdt_dev *wdt)
+{
+	unsigned long clk_rate = clk_get_rate(wdt->wdt_clk);
+	unsigned int val;
+
+	val = readl(wdt->base + PDC_WDT_CONFIG) & ~PDC_WDT_CONFIG_DELAY_MASK;
+	val |= order_base_2(wdt->wdt_dev.timeout * clk_rate) - 1;
+	writel(val, wdt->base + PDC_WDT_CONFIG);
+}
+
 static int pdc_wdt_set_timeout(struct watchdog_device *wdt_dev,
 			       unsigned int new_timeout)
 {
-	unsigned int val;
 	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
-	unsigned long clk_rate = clk_get_rate(wdt->wdt_clk);
 
 	wdt->wdt_dev.timeout = new_timeout;
 
-	val = readl(wdt->base + PDC_WDT_CONFIG) & ~PDC_WDT_CONFIG_DELAY_MASK;
-	val |= order_base_2(new_timeout * clk_rate) - 1;
-	writel(val, wdt->base + PDC_WDT_CONFIG);
+	__pdc_wdt_set_timeout(wdt);
 
 	return 0;
 }
@@ -106,6 +112,8 @@ static int pdc_wdt_start(struct watchdog_device *wdt_dev)
 	unsigned int val;
 	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
 
+	__pdc_wdt_set_timeout(wdt);
+
 	val = readl(wdt->base + PDC_WDT_CONFIG);
 	val |= PDC_WDT_CONFIG_ENABLE;
 	writel(val, wdt->base + PDC_WDT_CONFIG);
-- 
2.2.0.rc0.207.ga3a616c

