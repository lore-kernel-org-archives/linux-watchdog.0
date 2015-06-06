Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vpnchicago.adeneo-embedded.us ([65.182.180.190]:7882 "EHLO
	mxadeneo.adeneo-embedded.us" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751889AbbFFW1A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 6 Jun 2015 18:27:00 -0400
From: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
To: Wim Van Sebroeck <wim@iguana.be>
CC: Guenter Roeck <linux@roeck-us.net>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
Subject: [PATCH v4 1/2] watchdog_core: Add watchdog registration deferral mechanism
Date: Sat, 6 Jun 2015 15:25:36 -0700
Message-ID: <1433629537-21925-1-git-send-email-jtheou@adeneo-embedded.us>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently, watchdog subsystem require the misc subsystem to
register a watchdog. This may not be the case in case of an
early registration of a watchdog, which can be required when
the watchdog cannot be disabled.

This patch introduces a deferral mechanism to remove this requirement.

Signed-off-by: Jean-Baptiste Theou <jtheou@adeneo-embedded.us>
---
Changes in v4:
 - Adjust patch based on Guenter feedbacks on v3

Changes in v3:
 - Adjust patch based on Guenter feedbacks
 - Fix watchdog_deferred_registration_del
 - Fix typos


 Documentation/watchdog/watchdog-kernel-api.txt |   7 ++
 drivers/watchdog/watchdog_core.c               | 118 +++++++++++++++++++++----
 include/linux/watchdog.h                       |   3 +
 3 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index a0438f3..e83518c 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -36,6 +36,10 @@ The watchdog_unregister_device routine deregisters a registered watchdog timer
 device. The parameter of this routine is the pointer to the registered
 watchdog_device structure.
 
+The watchdog subsystem includes an registration deferral mechanism,
+which allows you to register an watchdog as early as you wish during
+the boot process.
+
 The watchdog device structure looks like this:
 
 struct watchdog_device {
@@ -52,6 +56,7 @@ struct watchdog_device {
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
+	struct list_head deferred_registration;
 };
 
 It contains following fields:
@@ -80,6 +85,8 @@ It contains following fields:
   information about the status of the device (Like: is the watchdog timer
   running/active, is the nowayout bit set, is the device opened via
   the /dev/watchdog interface or not, ...).
+* deferred_registration: entry in deferred_registration_list which is used to
+  register early initialized watchdogs.
 
 The list of watchdog operations is defined as:
 
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..9a35dbb 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,45 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
+/*
+ * Deferred Registration infrastructure.
+ *
+ * Sometimes watchdog drivers needs to be loaded as soon as possible,
+ * for example when it's impossible to disable it. To do so,
+ * raising the initcall level of the watchdog driver is a solution.
+ * But in such case, the miscdev is maybe not ready (subsys_initcall), and
+ * watchdog_core need miscdev to register the watchdog as a char device.
+ *
+ * The deferred registration infrastructure offer a way for the watchdog
+ * subsystem to register a watchdog properly, even before miscdev is ready.
+ */
+
+static DEFINE_MUTEX(watchdog_deferred_registration_mutex);
+static LIST_HEAD(watchdog_deferred_registration_pending_list);
+static bool watchdog_deferred_registration_done;
+
+static int watchdog_deferred_registration_add(struct watchdog_device *wdd)
+{
+	list_add_tail(&wdd->deferred_registration,
+		     &watchdog_deferred_registration_pending_list);
+	return 0;
+}
+
+static void watchdog_deferred_registration_del(struct watchdog_device *wdd)
+{
+	struct list_head *p, *n;
+	struct watchdog_device *wdd_tmp;
+
+	list_for_each_safe(p, n, &watchdog_deferred_registration_pending_list) {
+		wdd_tmp = list_entry(p, struct watchdog_device,
+				     deferred_registration);
+		if (wdd_tmp == wdd) {
+			list_del(&wdd_tmp->deferred_registration);
+			break;
+		}
+	}
+}
+
 static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
 	/*
@@ -98,17 +137,7 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
-/**
- * watchdog_register_device() - register a watchdog device
- * @wdd: watchdog device
- *
- * Register a watchdog device with the kernel so that the
- * watchdog timer can be accessed from userspace.
- *
- * A zero is returned on success and a negative errno code for
- * failure.
- */
-int watchdog_register_device(struct watchdog_device *wdd)
+static int __watchdog_register_device(struct watchdog_device *wdd)
 {
 	int ret, id, devno;
 
@@ -164,16 +193,33 @@ int watchdog_register_device(struct watchdog_device *wdd)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(watchdog_register_device);
 
 /**
- * watchdog_unregister_device() - unregister a watchdog device
- * @wdd: watchdog device to unregister
+ * watchdog_register_device() - register a watchdog device
+ * @wdd: watchdog device
  *
- * Unregister a watchdog device that was previously successfully
- * registered with watchdog_register_device().
+ * Register a watchdog device with the kernel so that the
+ * watchdog timer can be accessed from userspace.
+ *
+ * A zero is returned on success and a negative errno code for
+ * failure.
  */
-void watchdog_unregister_device(struct watchdog_device *wdd)
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
+EXPORT_SYMBOL_GPL(watchdog_register_device);
+
+static void __watchdog_unregister_device(struct watchdog_device *wdd)
 {
 	int ret;
 	int devno;
@@ -189,8 +235,43 @@ void watchdog_unregister_device(struct watchdog_device *wdd)
 	ida_simple_remove(&watchdog_ida, wdd->id);
 	wdd->dev = NULL;
 }
+
+/**
+ * watchdog_unregister_device() - unregister a watchdog device
+ * @wdd: watchdog device to unregister
+ *
+ * Unregister a watchdog device that was previously successfully
+ * registered with watchdog_register_device().
+ */
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
 
+static int __init watchdog_deferred_registration(void)
+{
+	mutex_lock(&watchdog_deferred_registration_mutex);
+	watchdog_deferred_registration_done = true;
+	while (!list_empty(&watchdog_deferred_registration_pending_list)) {
+		struct watchdog_device *wdd;
+
+		wdd = list_first_entry(&watchdog_deferred_registration_pending_list,
+				      struct watchdog_device, deferred_registration);
+		list_del(&wdd->deferred_registration);
+		__watchdog_register_device(wdd);
+	}
+	mutex_unlock(&watchdog_deferred_registration_mutex);
+	return 0;
+}
+
 static int __init watchdog_init(void)
 {
 	int err;
@@ -207,6 +288,7 @@ static int __init watchdog_init(void)
 		return err;
 	}
 
+	watchdog_deferred_registration();
 	return 0;
 }
 
@@ -217,7 +299,7 @@ static void __exit watchdog_exit(void)
 	ida_destroy(&watchdog_ida);
 }
 
-subsys_initcall(watchdog_init);
+subsys_initcall_sync(watchdog_init);
 module_exit(watchdog_exit);
 
 MODULE_AUTHOR("Alan Cox <alan@lxorguk.ukuu.org.uk>");
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index a746bf5..f9bb943 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -65,6 +65,8 @@ struct watchdog_ops {
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
+ * @deferred_registration: entry in deferred_registration_list which is used to
+ *			   register early initialized watchdogs.
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

