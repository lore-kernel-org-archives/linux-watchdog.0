Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34084 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbcGIJna (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 9 Jul 2016 05:43:30 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Martyn Welch <martyn.welch@collabora.com>
Subject: [RESEND PATCH 1/2] watchdog: ziirave_wdt: Correct I2C device id to fix module autoloading.
Date: Sat,  9 Jul 2016 11:43:19 +0200
Message-Id: <1468057400-5772-2-git-send-email-enric.balletbo@collabora.com>
In-Reply-To: <1468057400-5772-1-git-send-email-enric.balletbo@collabora.com>
References: <1468057400-5772-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The I2C core removes the manufacturer prefix from the compatible field
so it reports to user-space the uevent i2c:rave-wdt, but this doesn't
match with the i2c_device_id (i2c:ziirave-wdt) array so the module is not
autoloaded. Correct the I2C device id to match with the reported uevent
and fix the module autoloading functionality.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/ziirave_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index cbe373de..fa1efef 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -339,7 +339,7 @@ static int ziirave_wdt_remove(struct i2c_client *client)
 }
 
 static struct i2c_device_id ziirave_wdt_id[] = {
-	{ "ziirave-wdt", 0 },
+	{ "rave-wdt", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ziirave_wdt_id);
-- 
2.1.0

