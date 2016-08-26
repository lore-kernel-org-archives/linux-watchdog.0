Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:49315 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754024AbcHZQIO (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 26 Aug 2016 12:08:14 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Robin Gong <b38343@freescale.com>
Subject: [PATCH v4 1/7] watchdog: add pretimeout support to the core
Date: Fri, 26 Aug 2016 19:07:55 +0300
Message-ID: <1472227681-1405-2-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472227681-1405-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Since the watchdog framework centrializes the IOCTL interfaces of device
drivers now, SETPRETIMEOUT and GETPRETIMEOUT need to be added in the
common code.

Signed-off-by: Robin Gong <b38343@freescale.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
[vzapolskiy: added conditional pretimeout sysfs attribute visibility]
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Reviewed at http://www.spinics.net/lists/linux-watchdog/msg09484.html

Changes from v3 to v4:
* included back to the main series as it was done in v2,
* added a fix suggested by Guenter, if a watchdog device does not have
  its own set_timeout() function, disable pretimeout if a new timeout
  value is less or equal to the set pretimeout period
* added Reviewed-by: Guenter tag

Changes from v2 to v3:
* none (not published)

Changes from v1 to v2:
* removed my wrong generalization of wdd->pretimeout update
* added seconds unit of time to describe internal kernel API

 Documentation/watchdog/watchdog-kernel-api.txt | 20 +++++++++
 drivers/watchdog/watchdog_dev.c                | 56 +++++++++++++++++++++++++-
 include/linux/watchdog.h                       | 11 +++++
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 7f31125c123e..3402dcad5b03 100644
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
@@ -121,6 +123,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *);
 	void (*ref)(struct watchdog_device *) __deprecated;
@@ -188,6 +191,23 @@ they are supported. These optional routines/operations are:
   If set_timeout is not provided but, WDIOF_SETTIMEOUT is set, the watchdog
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
index 040bf8382f46..f7c286c18d13 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -335,10 +335,14 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 	if (watchdog_timeout_invalid(wdd, timeout))
 		return -EINVAL;
 
-	if (wdd->ops->set_timeout)
+	if (wdd->ops->set_timeout) {
 		err = wdd->ops->set_timeout(wdd, timeout);
-	else
+	} else {
 		wdd->timeout = timeout;
+		/* Disable pretimeout if it doesn't fit the new timeout */
+		if (wdd->pretimeout >= wdd->timeout)
+			wdd->pretimeout = 0;
+	}
 
 	watchdog_update_worker(wdd);
 
@@ -346,6 +350,31 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
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
@@ -429,6 +458,15 @@ static ssize_t timeout_show(struct device *dev, struct device_attribute *attr,
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
@@ -459,6 +497,9 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 
 	if (attr == &dev_attr_timeleft.attr && !wdd->ops->get_timeleft)
 		mode = 0;
+	else if (attr == &dev_attr_pretimeout.attr &&
+		 !(wdd->info->options & WDIOF_PRETIMEOUT))
+		mode = 0;
 
 	return mode;
 }
@@ -466,6 +507,7 @@ static struct attribute *wdt_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_identity.attr,
 	&dev_attr_timeout.attr,
+	&dev_attr_pretimeout.attr,
 	&dev_attr_timeleft.attr,
 	&dev_attr_bootstatus.attr,
 	&dev_attr_status.attr,
@@ -646,6 +688,16 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
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
index 7047bc7f8106..4035df7ec023 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -28,6 +28,7 @@ struct watchdog_core_data;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value (in seconds).
+ * @set_pretimeout:The routine for setting the watchdog devices pretimeout.
  * @get_timeleft:The routine that gets the time left before a reset (in seconds).
  * @restart:	The routine for restarting the machine.
  * @ioctl:	The routines that handles extra ioctl calls.
@@ -46,6 +47,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_pretimeout)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	int (*restart)(struct watchdog_device *, unsigned long, void *);
 	long (*ioctl)(struct watchdog_device *, unsigned int, unsigned long);
@@ -61,6 +63,7 @@ struct watchdog_ops {
  * @ops:	Pointer to the list of watchdog operations.
  * @bootstatus:	Status of the watchdog device at boot.
  * @timeout:	The watchdog devices timeout value (in seconds).
+ * @pretimeout: The watchdog devices pre_timeout value.
  * @min_timeout:The watchdog devices minimum timeout value (in seconds).
  * @max_timeout:The watchdog devices maximum timeout value (in seconds)
  *		as configurable from user space. Only relevant if
@@ -96,6 +99,7 @@ struct watchdog_device {
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
 	unsigned int timeout;
+	unsigned int pretimeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	unsigned int min_hw_heartbeat_ms;
@@ -163,6 +167,13 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
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

