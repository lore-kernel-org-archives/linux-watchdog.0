Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33706 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbdHML2j (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 13 Aug 2017 07:28:39 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: max77620_wdt: constify platform_device_id
Date: Sun, 13 Aug 2017 16:58:28 +0530
Message-Id: <af372e3b17be9892810e4fc5ed5b1381a4ad2b97.1502623612.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

platform_device_id are not supposed to change at runtime. All functions
working with platform_device_id provided by <linux/platform_device.h>
work with const platform_device_id. So mark the non-const structs as
const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/max77620_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 68c41fa..2c9f53e 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -201,7 +201,7 @@ static int max77620_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id max77620_wdt_devtype[] = {
+static const struct platform_device_id max77620_wdt_devtype[] = {
 	{ .name = "max77620-watchdog", },
 	{ },
 };
-- 
2.7.4

