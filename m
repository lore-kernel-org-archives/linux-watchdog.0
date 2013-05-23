Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:38708 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758069Ab3EWKoK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 May 2013 06:44:10 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/5] watchdog: da9052: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:44:09 +0900
Message-id: <003501ce57a2$749344d0$5db9ce70$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the wrapper functions for getting and setting the driver data using
platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
so we can directly pass a struct platform_device.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/da9052_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 3674450..f09c54e 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -215,14 +215,14 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	dev_set_drvdata(&pdev->dev, driver_data);
+	platform_set_drvdata(pdev, driver_data);
 err:
 	return ret;
 }
 
 static int da9052_wdt_remove(struct platform_device *pdev)
 {
-	struct da9052_wdt_data *driver_data = dev_get_drvdata(&pdev->dev);
+	struct da9052_wdt_data *driver_data = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&driver_data->wdt);
 	kref_put(&driver_data->kref, da9052_wdt_release_resources);
-- 
1.7.10.4


