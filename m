Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:54410 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758305Ab3EWKoz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 May 2013 06:44:55 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 5/5] watchdog: wm831x: use platform_{get,set}_drvdata()
Date: Thu, 23 May 2013 19:44:53 +0900
Message-id: <003801ce57a2$8f0dae40$ad290ac0$@samsung.com>
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
 drivers/watchdog/wm831x_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 9dcb6d0..6c302fd 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -281,7 +281,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		goto err_gpio;
 	}
 
-	dev_set_drvdata(&pdev->dev, driver_data);
+	platform_set_drvdata(pdev, driver_data);
 
 	return 0;
 
@@ -294,7 +294,7 @@ err:
 
 static int wm831x_wdt_remove(struct platform_device *pdev)
 {
-	struct wm831x_wdt_drvdata *driver_data = dev_get_drvdata(&pdev->dev);
+	struct wm831x_wdt_drvdata *driver_data = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&driver_data->wdt);
 
-- 
1.7.10.4


