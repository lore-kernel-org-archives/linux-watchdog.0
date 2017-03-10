Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33438 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932724AbdCJWWV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 10 Mar 2017 17:22:21 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3] watchdog: intel-mid_wdt: Keep watchdog running
Date: Sat, 11 Mar 2017 00:22:17 +0200
Message-Id: <20170310222217.87272-1-andriy.shevchenko@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Firmware followed by bootloader leaves watchdog running.

Keep it running in the driver.

User will not need any additional options to reboot in case of panic
during boot.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 45e4d02221b5..72c108a12c19 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -147,8 +147,21 @@ static int mid_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Make sure the watchdog is not running */
-	wdt_stop(wdt_dev);
+	/*
+	 * The firmware followed by U-Boot leaves the watchdog running
+	 * with the default threshold which may vary. When we get here
+	 * we should make a decision to prevent any side effects before
+	 * user space daemon will take care of it. The best option,
+	 * taking into consideration that there is no way to read values
+	 * back from hardware, is to enforce watchdog being run with
+	 * deterministic values.
+	 */
+	ret = wdt_start(wdt_dev);
+	if (ret)
+		return ret;
+
+	/* Make sure the watchdog is serviced */
+	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
 
 	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
 	if (ret) {
-- 
2.11.0

