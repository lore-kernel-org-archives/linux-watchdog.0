Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:63648 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab3D2JbW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 29 Apr 2013 05:31:22 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Andrew Morton' <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, 'Wim Van Sebroeck' <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH RESEND 2/2] watchdog: wm831x_wdt: use devm_gpio_request_one()
Date: Mon, 29 Apr 2013 18:31:20 +0900
Message-id: <000a01ce44bc$4ebef180$ec3cd480$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_gpio_request_one() to make cleanup paths simpler.
Also, GPIOF_DIR_OUT | GPIOF_INIT_LOW is replaced with
GPIOF_OUT_INIT_LOW.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/wm831x_wdt.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 9dcb6d0..3348ddd 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -247,9 +247,10 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		reg |= pdata->software << WM831X_WDOG_RST_SRC_SHIFT;
 
 		if (pdata->update_gpio) {
-			ret = gpio_request_one(pdata->update_gpio,
-					       GPIOF_DIR_OUT | GPIOF_INIT_LOW,
-					       "Watchdog update");
+			ret = devm_gpio_request_one(&pdev->dev,
+						pdata->update_gpio,
+						GPIOF_OUT_INIT_LOW,
+						"Watchdog update");
 			if (ret < 0) {
 				dev_err(wm831x->dev,
 					"Failed to request update GPIO: %d\n",
@@ -270,7 +271,7 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 		} else {
 			dev_err(wm831x->dev,
 				"Failed to unlock security key: %d\n", ret);
-			goto err_gpio;
+			goto err;
 		}
 	}
 
@@ -278,16 +279,13 @@ static int wm831x_wdt_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		dev_err(wm831x->dev, "watchdog_register_device() failed: %d\n",
 			ret);
-		goto err_gpio;
+		goto err;
 	}
 
 	dev_set_drvdata(&pdev->dev, driver_data);
 
 	return 0;
 
-err_gpio:
-	if (driver_data->update_gpio)
-		gpio_free(driver_data->update_gpio);
 err:
 	return ret;
 }
@@ -298,9 +296,6 @@ static int wm831x_wdt_remove(struct platform_device *pdev)
 
 	watchdog_unregister_device(&driver_data->wdt);
 
-	if (driver_data->update_gpio)
-		gpio_free(driver_data->update_gpio);
-
 	return 0;
 }
 
-- 
1.7.2.5


