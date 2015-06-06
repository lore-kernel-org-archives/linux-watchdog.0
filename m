Return-path: <jtheou@adeneo-embedded.us>
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Guenter Roeck <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jean-Baptiste Theou
	<jtheou@adeneo-embedded.us>
Subject: [PATCH v2 1/3] watchdog_core: Add watchdog registration deferral mechanism
Date: Fri, 5 Jun 2015 18:46:50 -0700
Message-ID: <1433555212-4729-1-git-send-email-jtheou@adeneo-embedded.us>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Currently, watchdog subsystem require the misc subsystem to
register a watchdog. This may not be the case in case of an
early registration of a watchdog, which can be required when
the watchdog cannot be disabled.

This patch use deferral mechanism to remove this requirement.

Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
---
 drivers/watchdog/watchdog_core.c | 92 ++++++++++++++++++++++++++++++++++++++--
 include/linux/watchdog.h         |  3 ++
 2 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..edf6294 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,41 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
+/*
+ * Deferred Registration infrastructure.
+ *
+ * Sometimes watchdog drivers need to be loaded as soon as possible,
+ * for example when it's impossible to disable it. To do so,
+ * raising the initcall level of the watchdog driver is a solution.
+ * But in such case, the miscdev is maybe not ready (subsys_initcall), and
+ * watchdog core need miscdev to be populate.
+ *
+ * The deferred registration infrastructure offer a way for the watchdog
+ * subsystem to register a watchdog properly, even before miscdev is ready
+ *
+ * This is based on driver probe deferral mechanism.
+ */
+
+static DEFINE_MUTEX(watchdog_deferred_registration_mutex);
+static LIST_HEAD(watchdog_deferred_registration_pending_list);
+static bool watchdog_deferred_registration_done;
+
+static int watchdog_deferred_registration_add(struct watchdog_device *wdd)
+{
+	dev_dbg(wdd->dev, "Added to deferred list\n");
+	list_add(&wdd->deferred_registration,
+		 &watchdog_deferred_registration_pending_list);
+	return 0;
+}
+
+static void watchdog_deferred_registration_del(struct watchdog_device *wdd)
+{
+	if (!list_empty(&wdd->deferred_registration)) {
+		dev_dbg(wdd->dev, "Removed from deferred list\n");
+		list_del_init(&wdd->deferred_registration);
+	}
+}
+
 static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
 	/*
@@ -99,7 +134,7 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
 /**
- * watchdog_register_device() - register a watchdog device
+ * __watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
  *
  * Register a watchdog device with the kernel so that the
@@ -108,7 +143,7 @@ EXPORT_SYMBOL_GPL(watchdog_init_timeout);
  * A zero is returned on success and a negative errno code for
  * failure.
  */
-int watchdog_register_device(struct watchdog_device *wdd)
+int __watchdog_register_device(struct watchdog_device *wdd)
 {
 	int ret, id, devno;
 
@@ -164,16 +199,35 @@ int watchdog_register_device(struct watchdog_device *wdd)
 
 	return 0;
 }
+
+/*
+ * watchdog_register_device use either the deferred approach,
+ * or directly register the watchdog, depending on the current
+ * initcall level.
+ */
+
+int watchdog_register_device(struct watchdog_device *wdd)
+{
+	int ret;
+
+	mutex_lock(&watchdog_deferred_registration_mutex);
+	if (watchdog_deferred_registration_done)
+		ret = __watchdog_register_device(wdd);
+	else
+		ret = watchdog_deferred_registration_add(wdd);
+	mutex_unlock(&watchdog_deferred_registration_mutex);
+	return ret;
+}
 EXPORT_SYMBOL_GPL(watchdog_register_device);
 
 /**
- * watchdog_unregister_device() - unregister a watchdog device
+ * __watchdog_unregister_device() - unregister a watchdog device
  * @wdd: watchdog device to unregister
  *
  * Unregister a watchdog device that was previously successfully
  * registered with watchdog_register_device().
  */
-void watchdog_unregister_device(struct watchdog_device *wdd)
+void __watchdog_unregister_device(struct watchdog_device *wdd)
 {
 	int ret;
 	int devno;
@@ -189,8 +243,37 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 	ida_simple_remove(&watchdog_ida, wdd->id);
 	wdd->dev = NULL;
 }
+
+void watchdog_unregister_device(struct watchdog_device *wdd)
+{
+	mutex_lock(&watchdog_deferred_registration_mutex);
+	if (watchdog_deferred_registration_done)
+		__watchdog_unregister_device(wdd);
+	else
+		watchdog_deferred_registration_del(wdd);
+	mutex_unlock(&watchdog_deferred_registration_mutex);
+}
+
 EXPORT_SYMBOL_GPL(watchdog_unregister_device);
 
+/**
+ * watchdog_deferred_registration_initcall() - Register queued watchdog
+ */
+static int watchdog_deferred_registration_initcall(void)
+{
+	mutex_lock(&watchdog_deferred_registration_mutex);
+	watchdog_deferred_registration_done = true;
+	while (!list_empty(&watchdog_deferred_registration_pending_list)) {
+		struct watchdog_device *wdd = list_first_entry(&watchdog_deferred_registration_pending_list,
+							       struct watchdog_device, deferred_registration);
+		list_del_init(&wdd->deferred_registration);
+		__watchdog_register_device(wdd);
+	}
+	mutex_unlock(&watchdog_deferred_registration_mutex);
+	return 0;
+}
+late_initcall(watchdog_deferred_registration_initcall);
+
 static int __init watchdog_init(void)
 {
 	int err;
@@ -222,5 +305,6 @@ module_exit(watchdog_exit);
 
 MODULE_AUTHOR("Alan Cox <alan@lxorguk.ukuu.org.uk>");
 MODULE_AUTHOR("Wim Van Sebroeck <wim@iguana.be>");
+MODULE_AUTHOR("Jean-Baptiste Theou <jbtheou@gmail.com>");
 MODULE_DESCRIPTION("WatchDog Timer Driver Core");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index a746bf5..fcc190e 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -65,6 +65,8 @@ struct watchdog_ops {
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
+ * @deferred_registration: entry in deferred_registration_list which is used to
+ *			   register early initialized watchdog.
  *
  * The watchdog_device structure contains all information about a
  * watchdog timer device.
@@ -95,6 +97,7 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+	struct list_head deferred_registration;
 };
 
 #define WATCHDOG_NOWAYOUT		IS_BUILTIN(CONFIG_WATCHDOG_NOWAYOUT)
-- 
2.4.2
