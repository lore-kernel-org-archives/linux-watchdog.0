Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54275 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756259Ab1LNSX3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Dec 2011 13:23:29 -0500
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	patches@opensource.wolfsonmicro.com,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] watchdog: Convert wm831x driver to devm_kzalloc()
Date: Thu, 15 Dec 2011 02:23:19 +0800
Message-Id: <1323886999-9373-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Saves a small amount of code and systematically eliminates leaks.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/watchdog/wm831x_wdt.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 6cd1ba4..263c883 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -199,7 +199,8 @@ static int __devinit wm831x_wdt_probe(struct platform_device *pdev)
 	if (reg & WM831X_WDOG_DEBUG)
 		dev_warn(wm831x->dev, "Watchdog is paused\n");
 
-	driver_data = kzalloc(sizeof(*driver_data), GFP_KERNEL);
+	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
+				   GFP_KERNEL);
 	if (!driver_data) {
 		dev_err(wm831x->dev, "Unable to alloacate watchdog device\n");
 		ret = -ENOMEM;
@@ -250,7 +251,7 @@ static int __devinit wm831x_wdt_probe(struct platform_device *pdev)
 				dev_err(wm831x->dev,
 					"Failed to request update GPIO: %d\n",
 					ret);
-				goto err_alloc;
+				goto err;
 			}
 
 			ret = gpio_direction_output(pdata->update_gpio, 0);
@@ -292,8 +293,6 @@ static int __devinit wm831x_wdt_probe(struct platform_device *pdev)
 err_gpio:
 	if (driver_data->update_gpio)
 		gpio_free(driver_data->update_gpio);
-err_alloc:
-	kfree(driver_data);
 err:
 	return ret;
 }
-- 
1.7.7.3

