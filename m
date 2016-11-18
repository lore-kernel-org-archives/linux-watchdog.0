Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27140 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753449AbcKROuH (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 18 Nov 2016 09:50:07 -0500
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        mika.westerberg@linux.intel.com
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] intel-mid_wdt: make sure watchdog is not running at startup
Date: Fri, 18 Nov 2016 16:50:02 +0200
Message-Id: <20161118145002.140630-1-andriy.shevchenko@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Make sure that the watchdog is not running after loading
and before it is started by opening /dev/watchdog.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/intel-mid_wdt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index db36d12..ff099a3 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -151,6 +151,9 @@ static int mid_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Make sure the watchdog is not running */
+	wdt_stop(wdt_dev);
+
 	ret = watchdog_register_device(wdt_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "error registering watchdog device\n");
-- 
2.10.2

