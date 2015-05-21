Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:34597 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755429AbbEUIdv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 May 2015 04:33:51 -0400
Received: by pdbnk13 with SMTP id nk13so100621212pdb.1
        for <linux-watchdog@vger.kernel.org>; Thu, 21 May 2015 01:33:50 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v2 5/7] Watchdog: introduce "pretimeout" into framework
Date: Thu, 21 May 2015 16:32:34 +0800
Message-Id: <1432197156-16947-6-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1432197156-16947-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

Also update Documentation/watchdog/watchdog-kernel-api.txt to
introduce:
(1)the new elements in the watchdog_device and watchdog_ops struct;
(2)the new API "watchdog_init_timeouts".

Reasons:
(1)kernel already has two watchdog drivers are using "pretimeout":
	drivers/char/ipmi/ipmi_watchdog.c
	drivers/watchdog/kempld_wdt.c(but the definition is different)
(2)some other dirvers are going to use this: ARM SBSA Generic Watchdog

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 Documentation/watchdog/watchdog-kernel-api.txt |  62 ++++++++++++---
 drivers/watchdog/watchdog_core.c               | 103 +++++++++++++++++++------
 drivers/watchdog/watchdog_dev.c                |  48 ++++++++++++
 include/linux/watchdog.h                       |  30 ++++++-
 4 files changed, 208 insertions(+), 35 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index a0438f3..43900df 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -49,6 +49,9 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int pretimeout;
+	unsigned int min_pretimeout;
+	unsigned int max_pretimeout;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
@@ -70,6 +73,9 @@ It contains following fields:
 * timeout: the watchdog timer's timeout value (in seconds).
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
 * max_timeout: the watchdog timer's maximum timeout value (in seconds).
+* pretimeout: the watchdog timer's pretimeout value (in seconds).
+* min_pretimeout: the watchdog timer's minimum pretimeout value (in seconds).
+* max_pretimeout: the watchdog timer's maximum pretimeout value (in seconds).
 * bootstatus: status of the device after booting (reported with watchdog
   WDIOF_* status bits).
 * driver_data: a pointer to the drivers private data of a watchdog device.
@@ -92,6 +98,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	void (*ref)(struct watchdog_device *);
 	void (*unref)(struct watchdog_device *);
@@ -153,9 +160,19 @@ they are supported. These optional routines/operations are:
   and -EIO for "could not write value to the watchdog". On success this
   routine should set the timeout value of the watchdog_device to the
   achieved timeout value (which may be different from the requested one
-  because the watchdog does not necessarily has a 1 second resolution).
+  because the watchdog does not necessarily has a 1 second resolution;
+  If the driver supports pretimeout, then the timeout value must be greater
+  than that).
   (Note: the WDIOF_SETTIMEOUT needs to be set in the options field of the
   watchdog's info structure).
+* set_pretimeout: this routine checks and changes the pretimeout of the
+  watchdog timer device. It returns 0 on success, -EINVAL for "parameter out of
+  range" and -EIO for "could not write value to the watchdog". On success this
+  routine should set the pretimeout value of the watchdog_device to the
+  achieved pretimeout value (which may be different from the requested one
+  because the watchdog does not necessarily has a 1 second resolution).
+  (Note: the WDIOF_PRETIMEOUT needs to be set in the options field of the
+  watchdog's info structure).
 * get_timeleft: this routines returns the time that's left before a reset.
 * ref: the operation that calls kref_get on the kref of a dynamically
   allocated watchdog_device struct.
@@ -213,14 +230,41 @@ The watchdog_get_drvdata function allows you to retrieve driver specific data.
 The argument of this function is the watchdog device where you want to retrieve
 data from. The function returns the pointer to the driver specific data.
 
-To initialize the timeout field, the following function can be used:
+To initialize the timeout and pretimeout fields, the following function can be
+used:
 
-extern int watchdog_init_timeout(struct watchdog_device *wdd,
-                                  unsigned int timeout_parm, struct device *dev);
+extern int watchdog_init_timeouts(struct watchdog_device *wdd,
+                                  unsigned int pretimeout_parm,
+                                  unsigned int timeout_parm,
+                                  void (*update_limits)(struct watchdog_device *),
+                                  struct device *dev);
 
-The watchdog_init_timeout function allows you to initialize the timeout field
-using the module timeout parameter or by retrieving the timeout-sec property from
-the device tree (if the module timeout parameter is invalid). Best practice is
-to set the default timeout value as timeout value in the watchdog_device and
-then use this function to set the user "preferred" timeout value.
+The watchdog_init_timeouts function allows you to initialize the pretimeout and
+timeout fields using the module pretimeout and timeout parameter or by
+retrieving the elements in the timeout-sec property(the first element is for
+timeout, the second one is for pretimeout) from the device tree(if the module
+pretimeout and timeout parameter are invalid).
+Normally, the pretimeout value will affect the limitation of timeout, and it
+is also hardware related. So you can write a function in your driver to update
+the limitation of timeout, according to the pretimeout value. Then pass the
+function pointer by the update_limits parameter. If you driver doesn't
+need this adjustment, just pass NULL to the update_limits parameter.
+Most of watchdog timers have not pretimeout as the warning signal. They just
+reset the system, once the timeout watch period expires. In this case, we can
+pass 0 to the pretimeout_parm, and pass NULL to the update_limits. Or use the
+old API: watchdog_init_timeout(see below)
+Best practice is to set the default pretimeout and timeout value as pretimeout
+and timeout value in the watchdog_device and then use this function to set the
+user "preferred" pretimeout value.
 This routine returns zero on success and a negative errno code for failure.
+
+For backward compatibility, we also support the timeout initialization API:
+
+static inline int watchdog_init_timeout(struct watchdog_device *wdd,
+					unsigned int timeout_parm,
+					struct device *dev);
+
+Because of the introduction of pretimeout and watchdog_init_timeouts, this
+function has become a small wrapper function of watchdog_init_timeouts.
+
+
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..460796e 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,60 +43,115 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
-static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
+static void watchdog_check_min_max_timeouts(struct watchdog_device *wdd)
 {
 	/*
-	 * Check that we have valid min and max timeout values, if
-	 * not reset them both to 0 (=not used or unknown)
+	 * Check that we have valid min and max pretimeout and timeout values,
+	 * if not reset them both to 0 (=not used or unknown)
 	 */
+	if (wdd->min_pretimeout > wdd->max_pretimeout) {
+		pr_info("Invalid min and max pretimeout, resetting to 0!\n");
+		wdd->min_pretimeout = 0;
+		wdd->max_pretimeout = 0;
+	}
 	if (wdd->min_timeout > wdd->max_timeout) {
 		pr_info("Invalid min and max timeout values, resetting to 0!\n");
 		wdd->min_timeout = 0;
 		wdd->max_timeout = 0;
 	}
+	/*
+	 * Check that we have valid min and max timeout values,
+	 * if not reset them both to pretimeout limits
+	 */
+	if (wdd->min_pretimeout && wdd->min_timeout < wdd->min_pretimeout) {
+		pr_info("Invalid min timeout, resetting to min pretimeout!\n");
+		wdd->min_timeout = wdd->min_pretimeout;
+	}
+	if (wdd->max_pretimeout && wdd->max_timeout < wdd->max_pretimeout) {
+		pr_info("Invalid max timeout, resetting to max pretimeout!\n");
+		wdd->max_timeout = wdd->max_pretimeout;
+	}
 }
 
 /**
- * watchdog_init_timeout() - initialize the timeout field
+ * watchdog_init_timeouts() - initialize the pretimeout and timeout field
+ * @pretimeout_parm: pretimeout module parameter
  * @timeout_parm: timeout module parameter
  * @dev: Device that stores the timeout-sec property
  *
- * Initialize the timeout field of the watchdog_device struct with either the
- * timeout module parameter (if it is valid value) or the timeout-sec property
- * (only if it is a valid value and the timeout_parm is out of bounds).
- * If none of them are valid then we keep the old value (which should normally
- * be the default timeout value.
+ * Initialize the pretimeout and timeout field of the watchdog_device struct
+ * with either the pretimeout and timeout module parameter (if it is valid
+ * value) or the timeout-sec property (only if it is a valid value and the
+ * pretimeout_parm and timeout_parm is out of bounds). If none of them are
+ * valid then we keep the old value (which should normally be the default
+ * timeout value.
  *
  * A zero is returned on success and -EINVAL for failure.
  */
-int watchdog_init_timeout(struct watchdog_device *wdd,
-				unsigned int timeout_parm, struct device *dev)
+int watchdog_init_timeouts(struct watchdog_device *wdd,
+			   unsigned int pretimeout_parm,
+			   unsigned int timeout_parm,
+			   void (*update_limits)(struct watchdog_device *),
+			   struct device *dev)
 {
-	unsigned int t = 0;
+	unsigned int timeout = 0, pretimeout = 0;
+	const __be32 *ppretimeout;
 	int ret = 0;
+	struct property *timeout_sec;
+	int length;
 
-	watchdog_check_min_max_timeout(wdd);
+	watchdog_check_min_max_timeouts(wdd);
 
-	/* try to get the timeout module parameter first */
-	if (!watchdog_timeout_invalid(wdd, timeout_parm) && timeout_parm) {
-		wdd->timeout = timeout_parm;
-		return ret;
+	/* try to get the timeout and pretimeout module parameter first */
+	if (pretimeout_parm) {
+		if (!watchdog_pretimeout_invalid(wdd, pretimeout_parm)) {
+			wdd->pretimeout = pretimeout_parm;
+			if (update_limits)
+				update_limits(wdd);
+		} else {
+			pr_warn("Invalid pretimeout parameter!\n");
+			ret = -EINVAL;
+		}
 	}
-	if (timeout_parm)
+
+	if (timeout_parm) {
+		if (!watchdog_timeout_invalid(wdd, timeout_parm)) {
+			wdd->timeout = timeout_parm;
+			return ret;
+		}
+		pr_warn("Invalid timeout parameter!\n");
 		ret = -EINVAL;
+	}
 
 	/* try to get the timeout_sec property */
 	if (dev == NULL || dev->of_node == NULL)
 		return ret;
-	of_property_read_u32(dev->of_node, "timeout-sec", &t);
-	if (!watchdog_timeout_invalid(wdd, t) && t)
-		wdd->timeout = t;
-	else
+
+	timeout_sec = of_find_property(dev->of_node, "timeout-sec", &length);
+	if (timeout_sec) {
+		ppretimeout = of_prop_next_u32(timeout_sec, NULL, &timeout);
+		if (length == 2) {
+			of_prop_next_u32(timeout_sec, ppretimeout, &pretimeout);
+			if (!watchdog_pretimeout_invalid(wdd, pretimeout) &&
+			    pretimeout) {
+				wdd->pretimeout = pretimeout;
+				if (update_limits)
+					update_limits(wdd);
+			} else {
+				ret = -EINVAL;
+			}
+		}
+		if (!watchdog_timeout_invalid(wdd, timeout) && timeout)
+			wdd->timeout = timeout;
+		else
+			ret = -EINVAL;
+	} else {
 		ret = -EINVAL;
+	}
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(watchdog_init_timeout);
+EXPORT_SYMBOL_GPL(watchdog_init_timeouts);
 
 /**
  * watchdog_register_device() - register a watchdog device
@@ -119,7 +174,7 @@ int watchdog_register_device(struct watchdog_device *wdd)
 	if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
 		return -EINVAL;
 
-	watchdog_check_min_max_timeout(wdd);
+	watchdog_check_min_max_timeouts(wdd);
 
 	/*
 	 * Note: now that all watchdog_device data has been verified, we
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..b519257 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -218,6 +218,38 @@ out_timeout:
 }
 
 /*
+ *	watchdog_set_pretimeout: set the watchdog timer pretimeout
+ *	@wddev: the watchdog device to set the timeout for
+ *	@pretimeout: pretimeout to set in seconds
+ */
+
+static int watchdog_set_pretimeout(struct watchdog_device *wddev,
+				   unsigned int pretimeout)
+{
+	int err;
+
+	if (!wddev->ops->set_pretimeout ||
+	    !(wddev->info->options & WDIOF_PRETIMEOUT))
+		return -EOPNOTSUPP;
+
+	if (watchdog_pretimeout_invalid(wddev, pretimeout))
+		return -EINVAL;
+
+	mutex_lock(&wddev->lock);
+
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto out_pretimeout;
+	}
+
+	err = wddev->ops->set_pretimeout(wddev, pretimeout);
+
+out_pretimeout:
+	mutex_unlock(&wddev->lock);
+	return err;
+}
+
+/*
  *	watchdog_get_timeleft: wrapper to get the time left before a reboot
  *	@wddev: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
@@ -388,6 +420,22 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		if (wdd->timeout == 0)
 			return -EOPNOTSUPP;
 		return put_user(wdd->timeout, p);
+	case WDIOC_SETPRETIMEOUT:
+		if (get_user(val, p))
+			return -EFAULT;
+		err = watchdog_set_pretimeout(wdd, val);
+		if (err < 0)
+			return err;
+		/* If the watchdog is active then we send a keepalive ping
+		 * to make sure that the watchdog keep's running (and if
+		 * possible that it takes the new timeout) */
+		watchdog_ping(wdd);
+		/* Fall */
+	case WDIOC_GETPRETIMEOUT:
+		/* timeout == 0 means that we don't use the pretimeout */
+		if (wdd->pretimeout == 0)
+			return -EOPNOTSUPP;
+		return put_user(wdd->pretimeout, p);
 	case WDIOC_GETTIMELEFT:
 		err = watchdog_get_timeleft(wdd, &val);
 		if (err)
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index a746bf5..df430a3 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -25,6 +25,7 @@ struct watchdog_device;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value.
+ * @set_pretimeout:The routine for setting the watchdog devices pretimeout value
  * @get_timeleft:The routine that get's the time that's left before a reset.
  * @ref:	The ref operation for dyn. allocated watchdog_device structs
  * @unref:	The unref operation for dyn. allocated watchdog_device structs
@@ -44,6 +45,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	void (*ref)(struct watchdog_device *);
 	void (*unref)(struct watchdog_device *);
@@ -62,6 +64,9 @@ struct watchdog_ops {
  * @timeout:	The watchdog devices timeout value.
  * @min_timeout:The watchdog devices minimum timeout value.
  * @max_timeout:The watchdog devices maximum timeout value.
+ * @pretimeout:	The watchdog devices pretimeout value.
+ * @min_pretimeout:The watchdog devices minimum pretimeout value.
+ * @max_pretimeout:The watchdog devices maximum pretimeout value.
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
@@ -86,6 +91,9 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int pretimeout;
+	unsigned int min_pretimeout;
+	unsigned int max_pretimeout;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
@@ -120,6 +128,14 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 		(t < wdd->min_timeout || t > wdd->max_timeout));
 }
 
+/* Use the following function to check if a pretimeout value is invalid */
+static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
+					       unsigned int t)
+{
+	return ((wdd->max_pretimeout != 0) &&
+		(t < wdd->min_pretimeout || t > wdd->max_pretimeout));
+}
+
 /* Use the following functions to manipulate watchdog driver specific data */
 static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
 {
@@ -132,11 +148,21 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 }
 
 /* drivers/watchdog/watchdog_core.c */
-extern int watchdog_init_timeout(struct watchdog_device *wdd,
-				  unsigned int timeout_parm, struct device *dev);
+extern int watchdog_init_timeouts(struct watchdog_device *wdd,
+				  unsigned int pretimeout_parm,
+				  unsigned int timeout_parm,
+				  void (*update_limits)(struct watchdog_device *),
+				  struct device *dev);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
+static inline int watchdog_init_timeout(struct watchdog_device *wdd,
+					unsigned int timeout_parm,
+					struct device *dev)
+{
+	return watchdog_init_timeouts(wdd, 0, timeout_parm, NULL, dev);
+}
+
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 void watchdog_nmi_disable_all(void);
 void watchdog_nmi_enable_all(void);
-- 
1.9.1

