Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43302 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbcGUVWA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jul 2016 17:22:00 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: core: Clear WDOG_HW_RUNNING before calling the stop function
Date: Thu, 21 Jul 2016 14:21:56 -0700
Message-Id: <1469136116-17931-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

WDOG_HW_RUNNING indicates that the hardware watchdog is running while the
watchdog device is closed. The flag may be set by the driver when it is
instantiated to indicate that the watchdog is running, and that the
watchdog core needs to send heartbeat requests to the driver until the
watchdog device is opened.

When the watchdog device is closed, the flag can be used by the driver's
stop function to indicate to the watchdog core that it was unable to stop
the watchdog, and that the watchdog core needs to send heartbeat requests.
This only works if the flag is actually cleared when the watchdog is
stopped. To avoid having to clear the flag in each driver's stop function,
clear it in the watchdog core before calling the stop function.

Reported-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Fixes: ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index f128efc36135..040bf8382f46 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -267,10 +267,12 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		return -EBUSY;
 	}
 
-	if (wdd->ops->stop)
+	if (wdd->ops->stop) {
+		clear_bit(WDOG_HW_RUNNING, &wdd->status);
 		err = wdd->ops->stop(wdd);
-	else
+	} else {
 		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	}
 
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-- 
2.5.0

