Return-Path: <markus.mayer@linaro.org>
From: "Markus Mayer" <markus.mayer@linaro.org>
To: "Guenter Roeck" <linux@roeck-us.net>,
	"Wim Van Sebroeck" <wim@iguana.be>
cc: "Linux Watchdog List" <linux-watchdog@vger.kernel.org>,
	"Markus Mayer" <markus.mayer@linaro.org>
Subject: [RFC 1/2] watchdog: Add support to set timer resolution
Date: Fri, 29 Nov 2013 13:20:29 -0800
Message-ID: <1385760030-24264-2-git-send-email-markus.mayer@linaro.org>
In-Reply-To: <1385760030-24264-1-git-send-email-markus.mayer@linaro.org>
References: <1385760030-24264-1-git-send-email-markus.mayer@linaro.org>
MIME-Version: 1.0
Return-path: markus.mayer@linaro.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

This change adds support for watchdog timer resolution to the watchdog
framework. Two new ioctls are introduced:

  - WDIOC_GETRESOLUTION
  - WDIOC_SETRESOLUTION

They allow userland applications to retreive and program the watchdog
timer's resolution should the hardware and the driver support it.
---
 drivers/watchdog/watchdog_core.c |   14 +++++++++++++
 drivers/watchdog/watchdog_dev.c  |   41 ++++++++++++++++++++++++++++++++++++++
 include/linux/watchdog.h         |   12 +++++++++++
 include/uapi/linux/watchdog.h    |    3 +++
 4 files changed, 70 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 461336c..ca29e64 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -56,6 +56,19 @@ static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 	}
 }
 
+static void watchdog_check_min_max_resolution(struct watchdog_device *wdd)
+{
+	/*
+	 * Check that we have valid min and max timeout values, if
+	 * not reset them both to 0 (=not used or unknown)
+	 */
+	if (wdd->min_resolution > wdd->max_resolution) {
+		pr_info("Invalid min & max resolution values, setting to 0!\n");
+		wdd->min_resolution = 0;
+		wdd->max_resolution = 0;
+	}
+}
+
 /**
  * watchdog_init_timeout() - initialize the timeout field
  * @timeout_parm: timeout module parameter
@@ -120,6 +133,7 @@ int watchdog_register_device(struct watchdog_device *wdd)
 		return -EINVAL;
 
 	watchdog_check_min_max_timeout(wdd);
+	watchdog_check_min_max_resolution(wdd);
 
 	/*
 	 * Note: now that all watchdog_device data has been verified, we
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..fd4ea61 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -218,6 +218,37 @@ out_timeout:
 }
 
 /*
+ *	watchdog_set_resolution: set the watchdog timer resolution
+ *	@wddev: the watchdog device to set the resolution for
+ *	@resolution: timer resolution (in native format)
+ */
+static int watchdog_set_resolution(struct watchdog_device *wddev,
+							unsigned int resolution)
+{
+	int err;
+
+	if ((wddev->ops->set_resolution == NULL) ||
+	    !(wddev->info->options & WDIOF_SETRESOLUTION))
+		return -EOPNOTSUPP;
+
+	if (watchdog_resolution_invalid(wddev, resolution))
+		return -EINVAL;
+
+	mutex_lock(&wddev->lock);
+
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto out_resolution;
+	}
+
+	err = wddev->ops->set_resolution(wddev, resolution);
+
+out_resolution:
+	mutex_unlock(&wddev->lock);
+	return err;
+}
+
+/*
  *	watchdog_get_timeleft: wrapper to get the time left before a reboot
  *	@wddev: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
@@ -393,6 +424,16 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		if (err)
 			return err;
 		return put_user(val, p);
+	case WDIOC_SETRESOLUTION:
+		if (get_user(val, p))
+			return -EFAULT;
+		err = watchdog_set_resolution(wdd, val);
+		if (err < 0)
+			return err;
+		watchdog_ping(wdd);
+		return 0;
+	case WDIOC_GETRESOLUTION:
+		return put_user(wdd->resolution, p);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 2a3038e..c9b0a4dc 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -25,6 +25,7 @@ struct watchdog_device;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value.
+ * @set_resolution:The routine for setting the timer resolution value.
  * @get_timeleft:The routine that get's the time that's left before a reset.
  * @ref:	The ref operation for dyn. allocated watchdog_device structs
  * @unref:	The unref operation for dyn. allocated watchdog_device structs
@@ -44,6 +45,7 @@ struct watchdog_ops {
 	int (*ping)(struct watchdog_device *);
 	unsigned int (*status)(struct watchdog_device *);
 	int (*set_timeout)(struct watchdog_device *, unsigned int);
+	int (*set_resolution)(struct watchdog_device *, unsigned int);
 	unsigned int (*get_timeleft)(struct watchdog_device *);
 	void (*ref)(struct watchdog_device *);
 	void (*unref)(struct watchdog_device *);
@@ -86,6 +88,9 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int resolution;
+	unsigned int min_resolution;
+	unsigned int max_resolution;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
@@ -125,6 +130,13 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 		(t < wdd->min_timeout || t > wdd->max_timeout));
 }
 
+/* Use the following function to check if a resolution value is invalid */
+static inline bool watchdog_resolution_invalid(struct watchdog_device *wdd, unsigned int r)
+{
+	return ((wdd->max_resolution != 0) &&
+		(r < wdd->min_resolution || r > wdd->max_resolution));
+}
+
 /* Use the following functions to manipulate watchdog driver specific data */
 static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
 {
diff --git a/include/uapi/linux/watchdog.h b/include/uapi/linux/watchdog.h
index 2babe72..15cab9b 100644
--- a/include/uapi/linux/watchdog.h
+++ b/include/uapi/linux/watchdog.h
@@ -31,6 +31,8 @@ struct watchdog_info {
 #define	WDIOC_SETPRETIMEOUT	_IOWR(WATCHDOG_IOCTL_BASE, 8, int)
 #define	WDIOC_GETPRETIMEOUT	_IOR(WATCHDOG_IOCTL_BASE, 9, int)
 #define	WDIOC_GETTIMELEFT	_IOR(WATCHDOG_IOCTL_BASE, 10, int)
+#define	WDIOC_GETRESOLUTION	_IOR(WATCHDOG_IOCTL_BASE, 11, int)
+#define	WDIOC_SETRESOLUTION	_IOWR(WATCHDOG_IOCTL_BASE, 12, int)
 
 #define	WDIOF_UNKNOWN		-1	/* Unknown flag error */
 #define	WDIOS_UNKNOWN		-1	/* Unknown status error */
@@ -47,6 +49,7 @@ struct watchdog_info {
 #define	WDIOF_PRETIMEOUT	0x0200  /* Pretimeout (in seconds), get/set */
 #define	WDIOF_ALARMONLY		0x0400	/* Watchdog triggers a management or
 					   other external alarm not a reboot */
+#define	WDIOF_SETRESOLUTION	0x0800  /* Set resolution */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
 
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
-- 
1.7.9.5
