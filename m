Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:64293 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916AbcGNJ02 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2016 05:26:28 -0400
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 3/3] watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE
Date: Thu, 14 Jul 2016 11:16:28 +0200
Message-ID: <1468487788-22457-4-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog framework takes care of feeding a hardware watchdog until
userspace opens /dev/watchdogN. If that never happens for some reason
(buggy init script, corrupt root filesystem or whatnot) but the kernel
itself is fine, the machine stays up indefinitely. This patch allows
setting an upper limit for how long the kernel will take care of the
watchdog, thus ensuring that the watchdog will eventually reset the
machine.

This is particularly useful for embedded devices where some fallback
logic is implemented in the bootloader (e.g., use a different root
partition, boot from network, ...).

The open timeout is also used as a maximum time for an application to
re-open /dev/watchdogN after closing it.

Setting a timeout of 0 (either on the kernel command line or via
sysfs) makes the system behave as if WATCHDOG_OPEN_DEADLINE=n.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/Kconfig        | 21 +++++++++++++++++++++
 drivers/watchdog/watchdog_dev.c | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b4b3e25..2674ddf 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -53,6 +53,27 @@ config WATCHDOG_SYSFS
 	  Say Y here if you want to enable watchdog device status read through
 	  sysfs attributes.
 
+config WATCHDOG_OPEN_DEADLINE
+	bool "Allow deadline for opening watchdog device"
+	help
+	  If a watchdog driver indicates that to the framework that
+	  the hardware watchdog is running, the framework takes care
+	  of pinging the watchdog until userspace opens
+	  /dev/watchdogN. By selecting this option, you can set a
+	  maximum time for which the kernel will do this after the
+	  device has been registered.
+
+config WATCHDOG_OPEN_TIMEOUT
+	int "Timeout value for opening watchdog device"
+	depends on WATCHDOG_OPEN_DEADLINE
+	default 120000
+	help
+	  The maximum time, in milliseconds, for which the watchdog
+	  framework takes care of pinging a watchdog device. A value
+	  of 0 means infinite. The value set here can be overridden by
+	  the commandline parameter "watchdog.open_timeout" or through
+	  sysfs.
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index da549e5..584c8a5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -65,6 +65,9 @@ struct watchdog_core_data {
 	struct mutex lock;
 	unsigned long last_keepalive;
 	unsigned long last_hw_keepalive;
+#ifdef CONFIG_WATCHDOG_OPEN_DEADLINE
+	unsigned long open_deadline;
+#endif
 	struct delayed_work work;
 	unsigned long status;		/* Internal status bits */
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
@@ -78,6 +81,32 @@ static struct watchdog_core_data *old_wd_data;
 
 static struct workqueue_struct *watchdog_wq;
 
+#ifdef CONFIG_WATCHDOG_OPEN_DEADLINE
+static unsigned open_timeout = CONFIG_WATCHDOG_OPEN_TIMEOUT;
+module_param(open_timeout, uint, 0644);
+
+static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
+{
+	if (!open_timeout)
+		return false;
+	return time_is_before_jiffies(data->open_deadline);
+}
+
+static void watchdog_set_open_deadline(struct watchdog_core_data *data)
+{
+	data->open_deadline = jiffies + msecs_to_jiffies(open_timeout);
+}
+#else
+static bool watchdog_past_open_deadline(struct watchdog_core_data *data)
+{
+	return false;
+}
+
+static void watchdog_set_open_deadline(struct watchdog_core_data *data)
+{
+}
+#endif
+
 static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 {
 	/* All variables in milli-seconds */
@@ -192,7 +221,13 @@ static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
 {
 	struct watchdog_device *wdd = wd_data->wdd;
 
-	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
+	if (!wdd)
+		return false;
+
+	if (watchdog_active(wdd))
+		return true;
+
+	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wd_data);
 }
 
 static void watchdog_ping_work(struct work_struct *work)
@@ -745,6 +780,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		watchdog_ping(wdd);
 	}
 
+	watchdog_set_open_deadline(wd_data);
 	watchdog_update_worker(wdd);
 
 	/* make sure that /dev/watchdog can be re-opened */
@@ -843,6 +879,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 
 	/* Record time of most recent heartbeat as 'just before now'. */
 	wd_data->last_hw_keepalive = jiffies - 1;
+	watchdog_set_open_deadline(wd_data);
 
 	/*
 	 * If the watchdog is running, prevent its driver from being unloaded,
-- 
2.5.0

