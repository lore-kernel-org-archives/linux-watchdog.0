Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48879 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752422AbdAYW2l (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 25 Jan 2017 17:28:41 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: Introduce watchdog_stop_on_unregister helper
Date: Wed, 25 Jan 2017 14:28:36 -0800
Message-Id: <1485383316-12669-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Many watchdog drivers explicitly stop the watchdog when unregistering it.
While it is unclear if this is actually needed (the whatdog should not be
running at that time if it can be stopped), introduce a helper to
explicitly stop the watchdog in the watchdog core when unregistering it.
This helps reducing driver code size while retaining functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  6 ++++++
 drivers/watchdog/watchdog_dev.c                |  5 +++++
 include/linux/watchdog.h                       | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index ea277478982f..9b93953f69cf 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -280,6 +280,12 @@ To disable the watchdog on reboot, the user must call the following helper:
 
 static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd);
 
+To disable the watchdog when unregistering the watchdog, the user must call
+the following helper. Note that this will only stop the watchdog if the
+nowayout flag is not set.
+
+static inline void watchdog_stop_on_unregister(struct watchdog_device *wdd);
+
 To change the priority of the restart handler the following helper should be
 used:
 
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 32930a073a12..d5d2bbd8f428 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -987,6 +987,11 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 	wdd->wd_data = NULL;
 	mutex_unlock(&wd_data->lock);
 
+	if (watchdog_active(wdd) &&
+	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
+		watchdog_stop(wdd);
+	}
+
 	cancel_delayed_work_sync(&wd_data->work);
 
 	kref_put(&wd_data->kref, watchdog_core_data_release);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 35a4d8185b51..b0df1b987d82 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -117,6 +117,7 @@ struct watchdog_device {
 #define WDOG_NO_WAY_OUT		1	/* Is 'nowayout' feature set ? */
 #define WDOG_STOP_ON_REBOOT	2	/* Should be stopped on reboot */
 #define WDOG_HW_RUNNING		3	/* True if HW watchdog running */
+#define WDOG_STOP_ON_UNREGISTER	4	/* Should be stopped on unregister */
 	struct list_head deferred;
 };
 
@@ -151,6 +152,15 @@ static inline void watchdog_stop_on_reboot(struct watchdog_device *wdd)
 	set_bit(WDOG_STOP_ON_REBOOT, &wdd->status);
 }
 
+/*
+ * Use the following function to stop the watchdog when unregistering the
+ * watchdog
+ */
+static inline void watchdog_stop_on_unregister(struct watchdog_device *wdd)
+{
+	set_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status);
+}
+
 /* Use the following function to check if a timeout value is invalid */
 static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
 {
-- 
2.7.4

