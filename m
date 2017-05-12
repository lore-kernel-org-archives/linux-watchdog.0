Return-path: <sebastian.reichel@collabora.co.uk>
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv2] watchdog: core: add option to avoid early handling of watchdog
Date: Fri, 12 May 2017 14:05:32 +0200
Message-Id: <20170512120532.12986-1-sebastian.reichel@collabora.co.uk>
In-Reply-To: <f38c7967-ac56-c188-2232-42544088edd8@roeck-us.net>
References: <f38c7967-ac56-c188-2232-42544088edd8@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On some systems its desirable to have watchdog reboot the system
when it does not come up fast enough. This adds a kernel parameter
to disable the auto-update of watchdog before userspace takes over
and a kernel option to set the default. The info messages were
added to shorten error searching on misconfigured systems.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
Changes since PATCHv1:
 * fix Kconfig short description (previously copied from
   WATCHDOG_NOWAYOUT)
 * drop pr_info for auto-update case
 * restructure code to avoid return
---
 drivers/watchdog/Kconfig        | 11 +++++++++++
 drivers/watchdog/watchdog_dev.c | 19 ++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 52a70ee6014f..9a1bd1e39a75 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -46,6 +46,17 @@ config WATCHDOG_NOWAYOUT
 	  get killed. If you say Y here, the watchdog cannot be stopped once
 	  it has been started.
 
+config WATCHDOG_HANDLE_BOOT_ENABLED
+	bool "Update boot-enabled watchdog until userspace takes over"
+	default y
+	help
+	  The default watchdog behaviour (which you get if you say Y here) is
+	  to ping watchdog devices, that were enabled before the driver has
+	  been loaded until control is taken over from userspace using the
+	  /dev/watchdog file. If you say N here, the kernel will not update
+	  the watchdog on its own. Thus if your userspace does not start fast
+	  enough your device will reboot.
+
 config WATCHDOG_SYSFS
 	bool "Read different watchdog information through sysfs"
 	help
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index d5d2bbd8f428..4bc7ab60b12c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -80,6 +80,9 @@ static struct watchdog_core_data *old_wd_data;
 
 static struct workqueue_struct *watchdog_wq;
 
+static bool handle_boot_enabled =
+	IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED);
+
 static inline bool watchdog_need_worker(struct watchdog_device *wdd)
 {
 	/* All variables in milli-seconds */
@@ -956,9 +959,14 @@ static int watchdog_cdev_register(struct watchdog_device *wdd, dev_t devno)
 	 * and schedule an immediate ping.
 	 */
 	if (watchdog_hw_running(wdd)) {
-		__module_get(wdd->ops->owner);
-		kref_get(&wd_data->kref);
-		queue_delayed_work(watchdog_wq, &wd_data->work, 0);
+		if (handle_boot_enabled) {
+			__module_get(wdd->ops->owner);
+			kref_get(&wd_data->kref);
+			queue_delayed_work(watchdog_wq, &wd_data->work, 0);
+		} else {
+			pr_info("watchdog%d running and kernel based pre-userspace handler disabled\n",
+					wdd->id);
+		}
 	}
 
 	return 0;
@@ -1106,3 +1114,8 @@ void __exit watchdog_dev_exit(void)
 	class_unregister(&watchdog_class);
 	destroy_workqueue(watchdog_wq);
 }
+
+module_param(handle_boot_enabled, bool, 0444);
+MODULE_PARM_DESC(handle_boot_enabled,
+	"Watchdog core auto-updates boot enabled watchdogs before userspace takes over (default="
+	__MODULE_STRING(IS_ENABLED(CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED)) ")");
-- 
2.11.0
