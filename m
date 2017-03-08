Return-path: <andriy.shevchenko@linux.intel.com>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] watchdog: intel-mid_wdt: Keep watchdog running
Date: Wed,  8 Mar 2017 13:10:29 +0200
Message-Id: <20170308111029.60744-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-watchdog@vger.kernel.org>

Firmware followed by bootloader leaves watchdog running.

Keep it running in the driver.

User will not need any additional options to reboot in case of panic.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 45e4d02221b5..a128ccb085b0 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -147,8 +147,8 @@ static int mid_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	/* Make sure the watchdog is not running */
-	wdt_stop(wdt_dev);
+	/* Make sure the watchdog is serviced */
+	set_bit(WDOG_HW_RUNNING, &wdt_dev->status);
 
 	ret = devm_watchdog_register_device(&pdev->dev, wdt_dev);
 	if (ret) {
-- 
2.11.0
