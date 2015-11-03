Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bl2on0130.outbound.protection.outlook.com ([65.55.169.130]:63040
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751182AbbKCDb1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Nov 2015 22:31:27 -0500
From: Robin Gong <b38343@freescale.com>
To: <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v1 1/2] watchdog: add WDIOC_SETPRETIMEOUT and WDIOC_GETPRETIMEOUT
Date: Tue, 3 Nov 2015 11:29:26 +0800
Message-ID: <1446521367-25748-1-git-send-email-b38343@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since the watchdog common framework centrialize the IOCTL interfaces of
device driver now, the SETPRETIMEOUT and GETPRETIMEOUT need to be added
in the common code.

Signed-off-by: Robin Gong <b38343@freescale.com>
---
 drivers/watchdog/watchdog_dev.c | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/watchdog.h        |  9 +++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..02632fe 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -218,6 +218,37 @@ out_timeout:
 }
 
 /*
+ *	watchdog_set_pretimeout: set the watchdog timer pretimeout
+ *	@wddev: the watchdog device to set the timeout for
+ *	@timeout: pretimeout to set in seconds
+ */
+
+static int watchdog_set_pretimeout(struct watchdog_device *wddev,
+							unsigned int timeout)
+{
+	int err;
+
+	if ((wddev->ops->set_pretimeout == NULL) ||
+	    !(wddev->info->options & WDIOF_PRETIMEOUT))
+		return -EOPNOTSUPP;
+	if (watchdog_pretimeout_invalid(wddev, timeout))
+		return -EINVAL;
+
+	mutex_lock(&wddev->lock);
+
+	if (test_bit(WDOG_UNREGISTERED, &wddev->status)) {
+		err = -ENODEV;
+		goto out_timeout;
+	}
+
+	err = wddev->ops->set_pretimeout(wddev, timeout);
+
+out_timeout:
+	mutex_unlock(&wddev->lock);
+	return err;
+}
+
+/*
  *	watchdog_get_timeleft: wrapper to get the time left before a reboot
  *	@wddev: the watchdog device to get the remaining time from
  *	@timeleft: the time that's left
@@ -393,6 +424,13 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
 		if (err)
 			return err;
 		return put_user(val, p);
+	case WDIOC_SETPRETIMEOUT:
+		if (get_user(val, p))
+			return -EFAULT;
+		err = watchdog_set_pretimeout(wdd, val);
+		return err;
+	case WDIOC_GETPRETIMEOUT:
+		return put_user(wdd->pretimeout, p);
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index d74a0e9..6ddb2d6 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -25,6 +25,7 @@ struct watchdog_device;
  * @ping:	The routine that sends a keepalive ping to the watchdog device.
  * @status:	The routine that shows the status of the watchdog device.
  * @set_timeout:The routine for setting the watchdog devices timeout value.
+ * @set_pretimeout:The routine for setting the watchdog devices pretimeout.
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
@@ -86,6 +88,7 @@ struct watchdog_device {
 	const struct watchdog_ops *ops;
 	unsigned int bootstatus;
 	unsigned int timeout;
+	unsigned int pretimeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
 	void *driver_data;
@@ -123,6 +126,12 @@ static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigne
 		(t < wdd->min_timeout || t > wdd->max_timeout));
 }
 
+/* Use the following function to check if a pretimeout value is invalid */
+static inline bool watchdog_pretimeout_invalid(struct watchdog_device *wdd, unsigned int t)
+{
+	return ((wdd->timeout != 0) && (t >= wdd->timeout));
+}
+
 /* Use the following functions to manipulate watchdog driver specific data */
 static inline void watchdog_set_drvdata(struct watchdog_device *wdd, void *data)
 {
-- 
1.9.1

