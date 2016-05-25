Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36376 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbcEYNcw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 09:32:52 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Robin Gong <b38343@freescale.com>
Subject: [PATCH 5/7] watchdog: add pretimeout support to the core
Date: Wed, 25 May 2016 15:32:29 +0200
Message-Id: <1464183151-4912-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Since the watchdog framework centrializes the IOCTL interfaces of device
drivers now, SETPRETIMEOUT and GETPRETIMEOUT need to be added in the
common code.

Signed-off-by: Robin Gong <b38343@freescale.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since Robin's last version:

* rebased
* 0 is valid and means disable pretimeout
  add code and docs for that
* add docs that drivers must update pretimeout when a new timeout is set
* reworded some documentation
* core handles wdd->pretimeout if set_pretimeout() is not populated
* add pretimeout to sysfs

 Documentation/watchdog/watchdog-kernel-api.txt | 20 ++++++++++
 drivers/watchdog/watchdog_dev.c                | 53 +++++++++++++++++++++++++-
 include/linux/watchdog.h                       | 11 ++++++
 3 files changed, 82 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index a9a65f8c0de9f0..4d4e0db6750c5f 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -50,6 +50,7 @@ struct watchdog_device {
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
 	unsigned int timeout;
+	unsigned int pretimeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	unsigned int min_hw_heartbeat_ms;
@@ -77,6 +78,7 @@ It contains following fields:
 * timeout: the watchdog timer's timeout value (in seconds).
   This is the time after which the system will reboot if user space does
   not send a heartbeat request if WDOG_ACTIVE is set.
+* pretimeout: the watchdog timer's pretimeout value (in seconds).
 * min_timeout: the watchdog timer's minimum timeout value (in seconds).
   If set, the minimum configurable value for 'timeout'.
 * max_timeout: the watchdog timer's maximum timeout value (in seconds),
@@ -120,6 +122,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *);
 	void (*ref)(struct watchdog_device *) __deprecated;
@@ -183,6 +186,23 @@ they are supported. These optional routines/operations are:
   set_timeout is not provided but WDIOF_SETTIMEOUT is set, the watchdog
   infrastructure updates the timeout value of the watchdog_device internally
   to the requested value.
+  If the pretimeout feature is used (WDIOF_PRETIMEOUT), then set_timeout must
+  also take care of checking if pretimeout is still valid and set up the timer
+  accordingly. This can't be done in the core without races, so it is the
+  duty of the driver.
+* set_pretimeout: this routine checks and changes the pretimeout value of
+  the watchdog. It is optional because not all watchdogs support pretimeout
+  notification. The timeout value is not an absolute time, but the number of
+  seconds before the actual timeout would happen. It returns 0 on success,
+  -EINVAL for "parameter out of range" and -EIO for "could not write value to
+  the watchdog". A value of 0 disables pretimeout notification.
+  (Note: the WDIOF_PRETIMEOUT needs to be set in the options field of the
+  watchdog's info structure).
+  If the watchdog driver does not have to perform any action but setting the
+  watchdog_device.pretimeout, this callback can be omitted. That means if
+  set_pretimeout is not provided but WDIOF_PRETIMEOUT is set, the watchdog
+  infrastructure updates the pretimeout value of the watchdog_device internally
+  to the requested value.
 * get_timeleft: this routines returns the time that's left before a reset.
 * restart: this routine restarts the machine. It returns 0 on success or a
   negative errno code for failure.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 5d028f94a90743..ad9f4032f02d18 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -308,10 +308,14 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	if (wdd->ops->set_timeout)
+	if (wdd->ops->set_timeout) {
 		err = wdd->ops->set_timeout(wdd, timeout);
-	else
+	} else {
 		wdd->timeout = timeout;
+		/* Disable pretimeout if it doesn't fit the new timeout */
+		if (wdd->pretimeout > wdd->timeout)
+			wdd->pretimeout = 0;
+	}
 
 	watchdog_update_worker(wdd);
 
@@ -319,6 +323,31 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 }
 
 /*
+ *	watchdog_set_pretimeout: set the watchdog timer pretimeout
+ *	@wdd: the watchdog device to set the timeout for
+ *	@timeout: pretimeout to set in seconds
+ */
+
+static int watchdog_set_pretimeout(struct watchdog_device *wdd,
+				   unsigned int timeout)
+{
+	int err = 0;
+
+	if (!(wdd->info->options & WDIOF_PRETIMEOUT))
+		return -EOPNOTSUPP;
+
+	if (watchdog_pretimeout_invalid(wdd, timeout))
+		return -EINVAL;
+
+	if (wdd->ops->set_pretimeout)
+		err = wdd->ops->set_pretimeout(wdd, timeout);
+	else
+		wdd->pretimeout = timeout;
+
+	return err;
+}
+
+/*
  *	watchdog_get_timeleft: wrapper to get the time left before a reboot
  *	@wdd: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
@@ -402,6 +431,15 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(timeout);
 
+static ssize_t pretimeout_show(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct watchdog_device *wdd = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%u\n", wdd->pretimeout);
+}
+static DEVICE_ATTR_RO(pretimeout);
+
 static ssize_t identity_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
@@ -441,6 +479,7 @@ static struct attribute *wdt_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_identity.attr,
 	&dev_attr_timeout.attr,
+	&dev_attr_pretimeout.attr,
 	&dev_attr_timeleft.attr,
 	&dev_attr_bootstatus.attr,
 	&dev_attr_status.attr,
@@ -621,6 +660,16 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 			break;
 		err = put_user(val, p);
 		break;
+	case WDIOC_SETPRETIMEOUT:
+		if (get_user(val, p)) {
+			err = -EFAULT;
+			break;
+		}
+		err = watchdog_set_pretimeout(wdd, val);
+		break;
+	case WDIOC_GETPRETIMEOUT:
+		err = put_user(wdd->pretimeout, p);
+		break;
 	default:
 		err = -ENOTTY;
 		break;
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 4b2fa45370fceb..496e52e5b91fc7 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -29,6 +29,7 @@ struct watchdog_governor;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
+ * @set_pretimeout:The routine for setting the watchdog devices pretimeout.
  * @get_timeleft:The routine that gets the time left before a reset (in seconds).
  * @restart:	The routine for restarting the machine.
  * @ioctl:	The routines that handles extra ioctl calls.
@@ -47,6 +48,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *, unsigned long, void *);
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
@@ -63,6 +65,7 @@ struct watchdog_ops {
  * @gov:	Pointer to watchdog pretimeout governor.
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value (in seconds).
+ * @pretimeout: The watchdog devices pre_timeout value.
  * @min_timeout:The watchdog devices minimum timeout value (in seconds).
  * @max_timeout:The watchdog devices maximum timeout value (in seconds)
  *		as configurable from user space. Only relevant if
@@ -98,6 +101,7 @@ struct watchdog_device {
 	struct watchdog_governor *gov;
 	unsigned int bootstatus;
 	unsigned int timeout;
+	unsigned int pretimeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	unsigned int min_hw_heartbeat_ms;
@@ -165,6 +169,13 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 		 t > wdd->max_timeout);
 }
 
+/* Use the following function to check if a pretimeout value is invalid */
+static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd,
+					       unsigned int t)
+{
+	return t && wdd->timeout && t >= wdd->timeout;
+}
+
 /* Use the following functions to manipulate watchdog driver specific data */
 static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
 {
-- 
2.8.1

