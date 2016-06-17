Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49300 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbcFQKwn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2016 06:52:43 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 1/2] watchdog: ziirave_wdt: Correct I2C device id to fix module autoloading.
Date: Fri, 17 Jun 2016 12:52:33 +0200
Message-Id: <1466160754-15599-2-git-send-email-enric.balletbo@collabora.com>
In-Reply-To: <1466160754-15599-1-git-send-email-enric.balletbo@collabora.com>
References: <1466160754-15599-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The I2C core removes the manufacturer prefix from the compatible field
so it reports to user-space the uevent i2c:rave-wdt, but this doesn't
match with the i2c_device_id (i2c:ziirave-wdt) array so the module is not
autoloaded. Correct the I2C device id to match with the reported uevent
and fix the module autoloading functionality.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
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

