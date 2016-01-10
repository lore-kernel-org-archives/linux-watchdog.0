Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:32894 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbcAJHmu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 10 Jan 2016 02:42:50 -0500
From: richard.dorsch@gmail.com
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
	wim@iguana.be, fengguang.wu@intel.com, jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: [PATCH 8/8] Remove .owner from platform_driver struct
Date: Sat,  9 Jan 2016 23:42:45 -0800
Message-Id: <1452411765-6009-1-git-send-email-richard.dorsch@gmail.com>
In-Reply-To: <201601091012.XHk6Lh1F%fengguang.wu@intel.com>
References: <201601091012.XHk6Lh1F%fengguang.wu@intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 drivers/watchdog/imanager-wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/imanager-wdt.c b/drivers/watchdog/imanager-wdt.c
index 41d44bc..8a8b369 100644
--- a/drivers/watchdog/imanager-wdt.c
+++ b/drivers/watchdog/imanager-wdt.c
@@ -319,7 +319,6 @@ static int imanager_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver imanager_wdt_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
 		.name	= "imanager_wdt",
 	},
 	.probe	= imanager_wdt_probe,
-- 
2.6.4

