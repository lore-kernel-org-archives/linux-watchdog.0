Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37831 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936276AbdIYQRG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 25 Sep 2017 12:17:06 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 2/2] watchdog: Fix kref imbalance seen if handle_boot_enabled=0
Date: Mon, 25 Sep 2017 09:17:02 -0700
Message-Id: <1506356222-528-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1506356222-528-1-git-send-email-linux@roeck-us.net>
References: <1506356222-528-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If handle_boot_enabled is set to 0, the watchdog driver module use
counter will not be increased and kref_get() will not be called when
registering the watchdog. Subsequently, on open, this does not happen
either because the code believes that it was already done because the
hardware watchdog is marked as running.

We could introduce a state variable to indicate this state, but let's
just increase the module use counter and call kref_get() unconditionally
if the hardware watchdog is running when a driver is registering itself
to keep the code simple.

Fixes: 2501b015313fe ("watchdog: core: add option to avoid early ...")
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_dev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index e6edf3737ea7..b30fb637ae94 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -966,14 +966,13 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 	 * and schedule an immediate ping.
 	 */
 	if (watchdog_hw_running(wdd)) {
-		if (handle_boot_enabled) {
-			__module_get(wdd->ops->owner);
-			kref_get(&wd_data->kref);
+		__module_get(wdd->ops->owner);
+		kref_get(&wd_data->kref);
+		if (handle_boot_enabled)
 			queue_delayed_work(watchdog_wq, &wd_data->work, 0);
-		} else {
+		else
 			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
-					wdd->id);
-		}
+				wdd->id);
 	}
 
 	return 0;
-- 
2.7.4

