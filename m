Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35156 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbcAJHmO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jan 2016 02:42:14 -0500
From: richard.dorsch@gmail.com
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, fengguang.wu@intel.com, jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: [PATCH 7/8] Remove .owner from platform_driver struct
Date: Sat,  9 Jan 2016 23:42:08 -0800
Message-Id: <1452411728-5929-1-git-send-email-richard.dorsch@gmail.com>
In-Reply-To: <201601090859.rNB9E9Y6%fengguang.wu@intel.com>
References: <201601090859.rNB9E9Y6%fengguang.wu@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/gpio/imanager-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/imanager-gpio.c b/drivers/gpio/imanager-gpio.c
index 3939c0f..b6fa689 100644
--- a/drivers/gpio/imanager-gpio.c
+++ b/drivers/gpio/imanager-gpio.c
@@ -167,7 +167,6 @@ static int imanager_remove(struct platform_device *pdev)
 
 static struct platform_driver imanager_gpio_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "imanager_gpio",
 	},
 	.probe	= imanager_gpio_probe,
-- 
2.6.4

