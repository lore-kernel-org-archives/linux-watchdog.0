Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:35891 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752790Ab2EMWoE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 13 May 2012 18:44:04 -0400
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: patches@opensource.wolfsonmicro.com,
	linux-watchdog@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] watchdog: wm831x: Convert to gpio_request_one()
Date: Sun, 13 May 2012 23:42:55 +0100
Message-Id: <1336948975-5937-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the more modern API.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/watchdog/wm831x_wdt.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index b1815c5..87d66d2 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -247,8 +247,9 @@ static int __devinit wm831x_wdt_probe(struct platform_device *pdev)
 		reg |= pdata->software << WM831X_WDOG_RST_SRC_SHIFT;
 
 		if (pdata->update_gpio) {
-			ret = gpio_request(pdata->update_gpio,
-					   "Watchdog update");
+			ret = gpio_request_one(pdata->update_gpio,
+					       GPIOF_DIR_OUT | GPIOF_INIT_LOW,
+					       "Watchdog update");
 			if (ret < 0) {
 				dev_err(wm831x->dev,
 					"Failed to request update GPIO: %d\n",
@@ -256,14 +257,6 @@ static int __devinit wm831x_wdt_probe(struct platform_device *pdev)
 				goto err;
 			}
 
-			ret = gpio_direction_output(pdata->update_gpio, 0);
-			if (ret != 0) {
-				dev_err(wm831x->dev,
-					"gpio_direction_output returned: %d\n",
-					ret);
-				goto err_gpio;
-			}
-
 			driver_data->update_gpio = pdata->update_gpio;
 
 			/* Make sure the watchdog takes hardware updates */
-- 
1.7.10

