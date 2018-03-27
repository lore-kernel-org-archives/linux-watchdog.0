Return-Path: <eajames@linux.vnet.ibm.com>
Return-path: <eajames@linux.vnet.ibm.com>
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wim@linux-watchdog.org, linux@roeck-us.net, joel@jms.id.au,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v2] aspeed: watchdog: Set bootstatus during probe
Date: Tue, 27 Mar 2018 15:09:27 -0500
Message-Id: <1522181367-11231-1-git-send-email-eajames@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>

Check the aspeed timeout status register to see if the system has booted
from the secondary boot source. If so, set the watchdog device
bootstatus flag for "Card previously reset the CPU."

Signed-off-by: Eddie James <eajames@linux.vnet.ibm.com>
---
Changes since v1:
 - use bootstatus instead of status
 - use WDIOF_CARDRESET instead of raw register contents

 drivers/watchdog/aspeed_wdt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index a5b8eb2..1abe4d0 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -55,6 +55,8 @@ struct aspeed_wdt_config {
 #define   WDT_CTRL_WDT_INTR		BIT(2)
 #define   WDT_CTRL_RESET_SYSTEM		BIT(1)
 #define   WDT_CTRL_ENABLE		BIT(0)
+#define WDT_TIMEOUT_STATUS	0x10
+#define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
 
 /*
  * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
@@ -192,6 +194,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	struct device_node *np;
 	const char *reset_type;
 	u32 duration;
+	u32 status;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -307,6 +310,10 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
 	}
 
+	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
+	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY)
+		wdt->wdd.bootstatus = WDIOF_CARDRESET;
+
 	ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register\n");
-- 
1.8.3.1
