Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35166 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdHUQsy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 21 Aug 2017 12:48:54 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: ziirave: constify i2c_device_id
Date: Mon, 21 Aug 2017 22:18:38 +0530
Message-Id: <41ddca0e60e2e4cd9773eccb39481e3da44878e4.1503334039.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/ziirave_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index b4e0cea..d3594aa 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -737,7 +737,7 @@ static int ziirave_wdt_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct i2c_device_id ziirave_wdt_id[] = {
+static const struct i2c_device_id ziirave_wdt_id[] = {
 	{ "rave-wdt", 0 },
 	{ }
 };
-- 
2.7.4

