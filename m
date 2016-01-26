Return-path: <linux@roeck-us.net>
From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v7 4/9] watchdog: Add support for minimum time between heartbeats
Date: Mon, 25 Jan 2016 18:53:11 -0800
Message-Id: <1453776796-3885-5-git-send-email-patchwork@patchwork.roeck-us.net>
In-Reply-To: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

Some watchdogs require a minimum time between heartbeats.
Examples are the watchdogs in DA9062 and AT91SAM9x.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v7: Rebased to v4.5-rc1
v6: Rebased to v4.4-rc2
v5: Rebased to v4.4-rc1
    Fixed typo in documentation.
v4: Added patch
---
 Documentation/watchdog/watchdog-kernel-api.txt |  3 +++
 drivers/watchdog/watchdog_dev.c                | 15 +++++++++++++++
 include/linux/watchdog.h                       |  3 +++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 62d49d6a7ff5..2221fb4f2739 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -52,6 +52,7 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int min_hw_heartbeat_ms;
 	unsigned int max_hw_timeout_ms;
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
@@ -81,6 +82,8 @@ It contains following fields:
 * max_timeout: the watchdog timer's maximum timeout value (in seconds),
   as seen from userspace. If set, the maximum configurable value for
   'timeout'. Not used if max_hw_timeout_ms is non-zero.
+* min_hw_heartbeat_ms: Minimum time between heartbeats sent to the chip,
+  in milli-seconds.
 * max_hw_timeout_ms: Maximum hardware timeout, in milli-seconds.
   If set, the infrastructure will send heartbeats to the watchdog driver
   if 'timeout' is larger than max_hw_timeout_ms, unless WDOG_ACTIVE
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 1a8f3861fe92..ff03cbc8e081 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -64,6 +64,7 @@ struct watchdog_core_data {
 	struct watchdog_device *wdd;
 	struct mutex lock;
 	unsigned long last_keepalive;
+	unsigned long last_hw_keepalive;
 	struct delayed_work work;
 	unsigned long status;		/* Internal status bits */
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
@@ -138,8 +139,19 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd,
 
 static int __watchdog_ping(struct watchdog_device *wdd)
 {
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+	unsigned long earliest_keepalive = wd_data->last_hw_keepalive +
+				msecs_to_jiffies(wdd->min_hw_heartbeat_ms);
 	int err;
 
+	if (time_is_after_jiffies(earliest_keepalive)) {
+		mod_delayed_work(watchdog_wq, &wd_data->work,
+				 earliest_keepalive - jiffies);
+		return 0;
+	}
+
+	wd_data->last_hw_keepalive = jiffies;
+
 	if (wdd->ops->ping)
 		err = wdd->ops->ping(wdd);  /* ping the watchdog */
 	else
@@ -820,6 +832,9 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 		return err;
 	}
 
+	/* Record time of most recent heartbeat as 'just before now'. */
+	wd_data->last_hw_keepalive = jiffies - 1;
+
 	/*
 	 * If the watchdog is running, prevent its driver from being unloaded,
 	 * and schedule an immediate ping.
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 19c675eed80f..537e84e2592a 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -65,6 +65,8 @@ struct watchdog_ops {
  * @max_timeout:The watchdog devices maximum timeout value (in seconds)
  *		as configurable from user space. Only relevant if
  *		max_hw_timeout_ms is not provided.
+ * @min_hw_heartbeat_ms:
+ *		Minimum time between heartbeats, in milli-seconds.
  * @max_hw_timeout_ms:
  *		Hardware limit for maximum timeout, in milli-seconds.
  *		Replaces max_timeout if specified.
@@ -95,6 +97,7 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int min_hw_heartbeat_ms;
 	unsigned int max_hw_timeout_ms;
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
-- 
2.1.4
