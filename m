Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52946 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbbK2T3B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Nov 2015 14:29:01 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 4/9] watchdog: Add support for minimum time between heartbeats
Date: Sun, 29 Nov 2015 11:28:46 -0800
Message-Id: <1448825331-28840-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
References: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Some watchdogs require a minimum time between heartbeats.
Examples are the watchdogs in DA9062 and AT91SAM9x.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v6: Rebased to v4.4-rc2
v5: Rebased to v4.4-rc1
    Fixed typo in documentation.
v4: Added patch
---
 Documentation/watchdog/watchdog-kernel-api.txt |  4 ++++
 drivers/watchdog/watchdog_dev.c                | 12 ++++++++++++
 include/linux/watchdog.h                       |  6 ++++++
 3 files changed, 22 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index f2ee8226d320..b417fdb6caac 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -53,11 +53,13 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int min_hw_heartbeat_ms;
 	unsigned int max_hw_timeout_ms;
 	void *driver_data;
 	unsigned long status;
 	struct mutex lock;
 	unsigned long last_keepalive;
+	unsigned long last_hw_keepalive;
 	struct delayed_work work;
 	struct list_head deferred;
 };
@@ -83,6 +85,8 @@ It contains following fields:
 * max_timeout: the watchdog timer's maximum timeout value (in seconds),
   as seen from userspace. If set, the maximum configurable value for
   'timeout'. Not used if max_hw_timeout_ms is non-zero.
+* min_hw_heartbeat_ms: Minimum time between heartbeats sent to the chip,
+  in milli-seconds.
 * max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds.
   If set, the infrastructure will send heartbeats to the watchdog driver
   if 'timeout' is larger than max_hw_timeout, unless WDOG_ACTIVE
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 5dd7319c0169..82706d43e0c8 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -111,6 +111,8 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd,
 
 static int _watchdog_ping(struct watchdog_device *wdd)
 {
+	unsigned long earliest_keepalive = wdd->last_hw_keepalive +
+				msecs_to_jiffies(wdd->min_hw_heartbeat_ms);
 	int err;
 
 	if (test_bit(WDOG_UNREGISTERED, &wdd->status))
@@ -119,6 +121,13 @@ static int _watchdog_ping(struct watchdog_device *wdd)
 	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
 		return 0;
 
+	if (time_is_after_jiffies(earliest_keepalive)) {
+		mod_delayed_work(watchdog_wq, &wdd->work,
+				 earliest_keepalive - jiffies);
+		return 0;
+	}
+
+	wdd->last_hw_keepalive = jiffies;
 	if (wdd->ops->ping)
 		err = wdd->ops->ping(wdd);  /* ping the watchdog */
 	else
@@ -667,6 +676,9 @@ int watchdog_dev_register(struct watchdog_device *wdd)
 		return err;
 	}
 
+	/* Record time of most recent heartbeat as 'just before now'. */
+	wdd->last_hw_keepalive = jiffies - 1;
+
 	/*
 	 * If the watchdog is running, prevent its driver from being unloaded,
 	 * and schedule an immediate ping.
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 98f79db93600..606dfd55927f 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -66,6 +66,8 @@ struct watchdog_ops {
  * @max_timeout:The watchdog devices maximum timeout value (in seconds)
  *		as configurable from user space. Only relevant if
  *		max_hw_timeout_ms is not provided.
+ * @min_hw_heartbeat_ms:
+ *		Minimum time between heartbeats, in milli-seconds.
  * @max_hw_timeout_ms:
  *		Hardware limit for maximum timeout, in milli-seconds.
  *		Replaces max_timeout if specified.
@@ -75,6 +77,8 @@ struct watchdog_ops {
  * @last_keepalive:
  *		Time of most recent keepalive triggered from user space,
  *		in jiffies (watchdog core internal).
+ * @last_hw_keepalive:
+ *		Time of most recent keepalive sent to the driver, in jiffies.
  * @work:	Data structure for worker function (watchdog core internal).
  * @deferred:	entry in wtd_deferred_reg_list which is used to
  *		register early initialized watchdogs.
@@ -99,6 +103,7 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int min_hw_heartbeat_ms;
 	unsigned int max_hw_timeout_ms;
 	void *driver_data;
 	unsigned long status;
@@ -112,6 +117,7 @@ struct watchdog_device {
 	/* the following variables are for internal use only */
 	struct mutex lock;
 	unsigned long last_keepalive;
+	unsigned long last_hw_keepalive;
 	struct delayed_work work;
 	struct list_head deferred;
 };
-- 
2.1.4

