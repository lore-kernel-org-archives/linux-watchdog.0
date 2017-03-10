Return-path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] watchdog: intel-mid_wdt: Keep watchdog running
Date: Fri, 10 Mar 2017 18:51:38 +0200
Message-Id: <20170310165138.53825-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

Firmware followed by bootloader leaves watchdog running.

Keep it running in the driver.

User will not need any additional options to reboot in case of panic
during boot.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 45e4d02221b5..f2c66689f42c 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -147,8 +147,16 @@ static int mid_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Make sure the watchdog is not running */
-	wdt_stop(wdt_dev);
+	/*
+	 * Make sure the watchdog is serviced.
+	 *
+	 * The firmware followed by U-Boot leaves the watchdog running
+	 * with the default threshold 60 seconds. Our default timeout is
+	 * 90 seconds, but internal worker divides it by two, which is
+	 * 45 seconds and should be enough (less by 15 seconds than
+	 * threshold).
+	 */
+	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
 
 	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
 	if (ret) {
-- 
2.11.0
