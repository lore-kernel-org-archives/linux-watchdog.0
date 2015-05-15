Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com,
	linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com,
	graeme.gregory@linaro.org,
	al.stone@linaro.org,
	hanjun.guo@linaro.org,
	timur@codeaurora.org,
	ashwin.chaugule@linaro.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	vgandhi@codeaurora.org,
	wim@iguana.be,
	jcm@redhat.com,
	leo.duran@amd.com,
	corbet@lwn.net,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH 4/6] Watchdog: introdouce "pretimeout" into framework
Date: Fri, 15 May 2015 19:24:48 +0800
Message-Id: <1431689090-3125-1-git-send-email-fu.wei@linaro.org>
In-Reply-To: <=fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

Reasons:
(1)kernel already has two watchdog drivers are using "pretimeout":
	drivers/char/ipmi/ipmi_watchdog.c
	drivers/watchdog/kempld_wdt.c(but the definition is different)
(2)some other dirvers are going to use this: ARM SBSA Generic Watchdog

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/watchdog/watchdog_core.c | 66 ++++++++++++++++++++++++++++++++++++++++
 drivers/watchdog/watchdog_dev.c  | 48 +++++++++++++++++++++++++++++
 include/linux/watchdog.h         | 19 ++++++++++++
 3 files changed, 133 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..6ca9578 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -54,6 +54,14 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 		wdd->min_timeout = 0;
 		wdd->max_timeout = 0;
 	}
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
@@ -98,6 +106,63 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 }
 EXPORT_SYMBOL_GPL(watchdog_init_timeout);
 
+static void watchdog_check_min_max_pretimeout(struct watchdog_device *wdd)
+{
+	/*
+	 * Check that we have valid min and max pretimeout values, if
+	 * not reset them both to 0 (=not used or unknown)
+	 */
+	if (wdd->min_pretimeout > wdd->max_pretimeout) {
+		pr_info("Invalid min and max pretimeout, resetting to 0!\n");
+		wdd->min_pretimeout = 0;
+		wdd->max_pretimeout = 0;
+	}
+}
+
+/**
+ * watchdog_init_pretimeout() - initialize the pretimeout field
+ * @pretimeout_parm: pretimeout module parameter
+ * @dev: Device that stores the timeout-sec property
+ *
+ * Initialize the pretimeout field of the watchdog_device struct with either
+ * the pretimeout module parameter (if it is valid value) or the timeout-sec
+ * property (only if it is a valid value and the timeout_parm is out of bounds).
+ * If none of them are valid then we keep the old value (which should normally
+ * be the default pretimeout value.
+ *
+ * A zero is returned on success and -EINVAL for failure.
+ */
+int watchdog_init_pretimeout(struct watchdog_device *wdd,
+			     unsigned int pretimeout_parm, struct device *dev)
+{
+	int ret = 0;
+	u32 timeouts[2];
+
+	watchdog_check_min_max_pretimeout(wdd);
+
+	/* try to get the timeout module parameter first */
+	if (!watchdog_pretimeout_invalid(wdd, pretimeout_parm) &&
+	    pretimeout_parm) {
+		wdd->pretimeout = pretimeout_parm;
+		return ret;
+	}
+	if (pretimeout_parm)
+		ret = -EINVAL;
+
+	/* try to get the timeout_sec property */
+	if (!dev || !dev->of_node)
+		return ret;
+	ret = of_property_read_u32_array(dev->of_node,
+					 "timeout-sec", timeouts, 2);
+	if (!watchdog_pretimeout_invalid(wdd, timeouts[1]) && timeouts[1])
+		wdd->pretimeout = timeouts[1];
+	else
+		ret = -EINVAL;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(watchdog_init_pretimeout);
+
 /**
  * watchdog_register_device() - register a watchdog device
  * @wdd: watchdog device
@@ -119,6 +184,7 @@ int watchdog_register_device(struct watchdog_device *wdd)
 	if (wdd->ops->start == NULL || wdd->ops->stop == NULL)
 		return -EINVAL;
 
+	watchdog_check_min_max_pretimeout(wdd);
 	watchdog_check_min_max_timeout(wdd);
 
 	/*
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
index a746bf5..f0a3c5b 100644
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
@@ -134,6 +150,9 @@ static inline void *watchdog_get_drvdata(struct watchdog_device *wdd)
 /* drivers/watchdog/watchdog_core.c */
 extern int watchdog_init_timeout(struct watchdog_device *wdd,
 				  unsigned int timeout_parm, struct device *dev);
+extern int watchdog_init_pretimeout(struct watchdog_device *wdd,
+				    unsigned int pretimeout_parm,
+				    struct device *dev);
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-- 
1.9.1
