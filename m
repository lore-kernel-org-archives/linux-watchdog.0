Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:62855 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751068AbcLLJ2H (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 12 Dec 2016 04:28:07 -0500
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE
Date: Mon, 12 Dec 2016 10:17:53 +0100
Message-ID: <1481534273-7600-3-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
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
machine if userspace fails to come up.

This is particularly useful for embedded devices where some fallback
logic is implemented in the bootloader (e.g., use a different root
partition, boot from network, ...).

The open timeout is also used as a maximum time for an application to
re-open /dev/watchdogN after closing it.

The open timeout is taken from the device tree
property "open-timeout", and if that is not present, defaults to
CONFIG_WATCHDOG_DEFAULT_OPEN_TIMEOUT (whose default value itself
is five minutes).

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/Kconfig         | 19 +++++++++++++++++++
 drivers/watchdog/watchdog_core.c | 17 +++++++++++++++++
 drivers/watchdog/watchdog_dev.c  | 33 ++++++++++++++++++++++++++++++++-
 include/linux/watchdog.h         |  9 +++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3eb58cb..908bb3f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -52,6 +52,25 @@ config WATCHDOG_SYSFS
 	  Say Y here if you want to enable watchdog device status read through
 	  sysfs attributes.
 
+config WATCHDOG_OPEN_DEADLINE
+	bool "Allow deadline for opening watchdog device"
+	help
+	  If a watchdog driver indicates that to the framework that
+	  the hardware watchdog is running, the framework takes care
+	  of pinging the watchdog until userspace opens
+	  /dev/watchdogN. By selecting this option, the open-timeout
+	  device tree property is used as an upper bound for which the
+	  kernel does this - thus, if userspace hasn't opened the
+	  device within this time, the board reboots.
+
+config WATCHDOG_DEFAULT_OPEN_TIMEOUT
+	int "Default timeout value for opening watchdog device"
+	depends on WATCHDOG_OPEN_DEADLINE
+	default 300
+	help
+	  The default value used when the watchdog's device tree node
+	  does not have the "open-timeout" property.
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 74265b2..31294b2 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -191,6 +191,21 @@ void watchdog_set_restart_priority(struct watchdog_device *wdd, int priority)
 }
 EXPORT_SYMBOL_GPL(watchdog_set_restart_priority);
 
+static void
+watchdog_set_open_timeout(struct watchdog_device *wdd)
+{
+#ifdef CONFIG_WATCHDOG_OPEN_DEADLINE
+	u32 t;
+	struct device *dev;
+
+	dev = wdd->parent;
+	if (dev && !of_property_read_u32(dev->of_node, "open-timeout", &t))
+		wdd->open_timeout = t;
+	else
+		wdd->open_timeout = CONFIG_WATCHDOG_DEFAULT_OPEN_TIMEOUT;
+#endif
+}
+
 static int __watchdog_register_device(struct watchdog_device *wdd)
 {
 	int ret, id = -1;
@@ -225,6 +240,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 		return id;
 	wdd->id = id;
 
+	watchdog_set_open_timeout(wdd);
+
 	ret = watchdog_dev_register(wdd);
 	if (ret) {
 		ida_simple_remove(&watchdog_ida, id);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ca0a000..f725e0b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -80,6 +80,29 @@ static struct watchdog_core_data *old_wd_data;
 
 static struct workqueue_struct *watchdog_wq;
 
+#ifdef CONFIG_WATCHDOG_OPEN_DEADLINE
+static bool watchdog_past_open_deadline(struct watchdog_device *wdd)
+{
+	if (!wdd->open_timeout)
+		return false;
+	return time_is_before_jiffies(wdd->open_deadline);
+}
+
+static void watchdog_set_open_deadline(struct watchdog_device *wdd)
+{
+	wdd->open_deadline = jiffies + msecs_to_jiffies(1000 * wdd->open_timeout);
+}
+#else
+static bool watchdog_past_open_deadline(struct watchdog_device *wdd)
+{
+	return false;
+}
+
+static void watchdog_set_open_deadline(struct watchdog_device *wdd)
+{
+}
+#endif
+
 static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 {
 	/* All variables in milli-seconds */
@@ -194,7 +217,13 @@ static int watchdog_ping(struct watchdog_device *wdd)
 
 static bool watchdog_worker_should_ping(struct watchdog_device *wdd)
 {
-	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
+	if (!wdd)
+		return false;
+
+	if (watchdog_active(wdd))
+		return true;
+
+	return watchdog_hw_running(wdd) && !watchdog_past_open_deadline(wdd);
 }
 
 static void watchdog_ping_work(struct work_struct *work)
@@ -857,6 +886,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 		watchdog_ping(wdd);
 	}
 
+	watchdog_set_open_deadline(wdd);
 	watchdog_update_worker(wdd);
 
 	/* make sure that /dev/watchdog can be re-opened */
@@ -955,6 +985,7 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 
 	/* Record time of most recent heartbeat as 'just before now'. */
 	wd_data->last_hw_keepalive = jiffies - 1;
+	watchdog_set_open_deadline(wdd);
 
 	/*
 	 * If the watchdog is running, prevent its driver from being unloaded,
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 35a4d81..c4e7ff8 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -76,6 +76,11 @@ struct watchdog_ops {
  * @max_hw_heartbeat_ms:
  *		Hardware limit for maximum timeout, in milli-seconds.
  *		Replaces max_timeout if specified.
+ * @open_timeout:
+ *              The maximum time for which the kernel will ping the
+ *              device after registration.
+ * @open_deadline:
+ *              Set to jiffies + @open_timeout at registration.
  * @reboot_nb:	The notifier block to stop watchdog on reboot.
  * @restart_nb:	The notifier block to register a restart function.
  * @driver_data:Pointer to the drivers private data.
@@ -107,6 +112,10 @@ struct watchdog_device {
 	unsigned int max_timeout;
 	unsigned int min_hw_heartbeat_ms;
 	unsigned int max_hw_heartbeat_ms;
+#ifdef CONFIG_WATCHDOG_OPEN_DEADLINE
+	unsigned long open_timeout;
+	unsigned long open_deadline;
+#endif
 	struct notifier_block reboot_nb;
 	struct notifier_block restart_nb;
 	void *driver_data;
-- 
2.7.4

