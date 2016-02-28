Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:32845 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920AbcB1VMb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 28 Feb 2016 16:12:31 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v8 04/10] watchdog: Make stop function optional
Date: Sun, 28 Feb 2016 13:12:17 -0800
Message-Id: <1456693943-6876-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
References: <1456693943-6876-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Not all hardware watchdogs can be stopped. The driver for
such watchdogs would typically only set the WATCHDOG_HW_RUNNING
flag in its stop function. Make the stop function optional and set
WATCHDOG_HW_RUNNING in the watchdog core if it is not provided.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v8: Split functionality from patch introducing WATCHDOG_HW_RUNNING
---
 Documentation/watchdog/watchdog-kernel-api.txt | 20 ++++++++++++--------
 drivers/watchdog/watchdog_core.c               |  2 +-
 drivers/watchdog/watchdog_dev.c                |  6 +++++-
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 954134a5c4a4..9eabca1d9355 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -85,7 +85,8 @@ It contains following fields:
   If set, the infrastructure will send heartbeats to the watchdog driver
   if 'timeout' is larger than max_hw_heartbeat_ms, unless WDOG_ACTIVE
   is set and userspace failed to send a heartbeat for at least 'timeout'
-  seconds.
+  seconds. max_hw_heartbeat_ms must be set if a driver does not implement
+  the stop function.
 * reboot_nb: notifier block that is registered for reboot notifications, for
   internal use only. If the driver calls watchdog_stop_on_reboot, watchdog core
   will stop the watchdog on such notifications.
@@ -134,17 +135,20 @@ are:
   device.
   The routine needs a pointer to the watchdog timer device structure as a
   parameter. It returns zero on success or a negative errno code for failure.
-* stop: with this routine the watchdog timer device is being stopped.
-  The routine needs a pointer to the watchdog timer device structure as a
-  parameter. It returns zero on success or a negative errno code for failure.
-  Some watchdog timer hardware can only be started and not be stopped.
-  If a watchdog can not be stopped, the watchdog driver must set the
-  WDOG_HW_RUNNING flag in its stop function to inform the watchdog core that
-  the watchdog is still running.
 
 Not all watchdog timer hardware supports the same functionality. That's why
 all other routines/operations are optional. They only need to be provided if
 they are supported. These optional routines/operations are:
+* stop: with this routine the watchdog timer device is being stopped.
+  The routine needs a pointer to the watchdog timer device structure as a
+  parameter. It returns zero on success or a negative errno code for failure.
+  Some watchdog timer hardware can only be started and not be stopped. A
+  driver supporting such hardware does not have to implement the stop routine.
+  If a driver has no stop function, the watchdog core will set WDOG_HW_RUNNING
+  and start calling the driver's keepalive pings function after the watchdog
+  device is closed.
+  If a watchdog driver does not implement the stop function, it must set
+  max_hw_heartbeat_ms.
 * ping: this is the routine that sends a keepalive ping to the watchdog timer
   hardware.
   The routine needs a pointer to the watchdog timer device structure as a
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index e600fd93b7de..45aabbd52b02 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -199,7 +199,7 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		return -EINVAL;
 
 	/* Mandatory operations need to be supported */
-	if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
+	if (!wdd->ops->start || (!wdd->ops->stop && !wdd->max_hw_heartbeat_ms))
 		return -EINVAL;
 
 	watchdog_check_min_max_timeout(wdd);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 5d3a9fa4856e..5163c3eb3428 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -246,7 +246,11 @@ static int watchdog_stop(struct watchdog_device *wdd)
 		return -EBUSY;
 	}
 
-	err = wdd->ops->stop(wdd);
+	if (wdd->ops->stop)
+		err = wdd->ops->stop(wdd);
+	else
+		set_bit(WDOG_HW_RUNNING, &wdd->status);
+
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
 		watchdog_update_worker(wdd);
-- 
2.5.0

