Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15421 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757800Ab2EKKAl (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 May 2012 06:00:41 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 5/9] sch56xx-watchdog: Use watchdog core
Date: Fri, 11 May 2012 12:00:23 +0200
Message-Id: <1336730427-1664-6-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
References: <1336730427-1664-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Note this patch depends on the "watchdog: Add multiple device support" patch
from Alan Cox.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch5627.c        |    2 +-
 drivers/hwmon/sch5636.c        |    2 +-
 drivers/hwmon/sch56xx-common.c |  371 +++++++---------------------------------
 drivers/hwmon/sch56xx-common.h |    2 +-
 4 files changed, 61 insertions(+), 316 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 8ec6dfb..8342275 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -579,7 +579,7 @@ static int __devinit sch5627_probe(struct platform_device *pdev)
 	}
 
 	/* Note failing to register the watchdog is not a fatal error */
-	data->watchdog = sch56xx_watchdog_register(data->addr,
+	data->watchdog = sch56xx_watchdog_register(&pdev->dev, data->addr,
 			(build_code << 24) | (build_id << 8) | hwmon_rev,
 			&data->update_lock, 1);
 
diff --git a/drivers/hwmon/sch5636.c b/drivers/hwmon/sch5636.c
index 906d4ed..96a7e68 100644
--- a/drivers/hwmon/sch5636.c
+++ b/drivers/hwmon/sch5636.c
@@ -510,7 +510,7 @@ static int __devinit sch5636_probe(struct platform_device *pdev)
 	}
 
 	/* Note failing to register the watchdog is not a fatal error */
-	data->watchdog = sch56xx_watchdog_register(data->addr,
+	data->watchdog = sch56xx_watchdog_register(&pdev->dev, data->addr,
 					(revision[0] << 8) | revision[1],
 					&data->update_lock, 0);
 
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index ce52fc5..c7de81a 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -66,15 +66,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 
 struct sch56xx_watchdog_data {
 	u16 addr;
-	u32 revision;
 	struct mutex *io_lock;
-	struct mutex watchdog_lock;
-	struct list_head list; /* member of the watchdog_data_list */
-	struct kref kref;
-	struct miscdevice watchdog_miscdev;
-	unsigned long watchdog_is_open;
-	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
-	char watchdog_expect_close;
+	struct watchdog_info wdinfo;
+	struct watchdog_device wddev;
 	u8 watchdog_preset;
 	u8 watchdog_control;
 	u8 watchdog_output_enable;
@@ -82,15 +76,6 @@ struct sch56xx_watchdog_data {
 
 static struct platform_device *sch56xx_pdev;
 
-/*
- * Somewhat ugly :( global data pointer list with all sch56xx devices, so that
- * we can find our device data as when using misc_register there is no other
- * method to get to ones device data from the open fop.
- */
-static LIST_HEAD(watchdog_data_list);
-/* Note this lock not only protect list access, but also data.kref access */
-static DEFINE_MUTEX(watchdog_data_mutex);
-
 /* Super I/O functions */
 static inline int superio_inb(int base, int reg)
 {
@@ -272,22 +257,13 @@ EXPORT_SYMBOL(sch56xx_read_virtual_reg12);
  * Watchdog routines
  */
 
-/*
- * Release our data struct when the platform device has been released *and*
- * all references to our watchdog device are released.
- */
-static void sch56xx_watchdog_release_resources(struct kref *r)
-{
-	struct sch56xx_watchdog_data *data =
-		container_of(r, struct sch56xx_watchdog_data, kref);
-	kfree(data);
-}
-
-static int watchdog_set_timeout(struct sch56xx_watchdog_data *data,
-				int timeout)
+static int watchdog_set_timeout(struct watchdog_device *wddev,
+				unsigned int timeout)
 {
-	int ret, resolution;
+	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
+	unsigned int resolution;
 	u8 control;
+	int ret;
 
 	/* 1 second or 60 second resolution? */
 	if (timeout <= 255)
@@ -298,12 +274,6 @@ static int watchdog_set_timeout(struct sch56xx_watchdog_data *data,
 	if (timeout < resolution || timeout > (resolution * 255))
 		return -EINVAL;
 
-	mutex_lock(&data->watchdog_lock);
-	if (!data->addr) {
-		ret = -ENODEV;
-		goto leave;
-	}
-
 	if (resolution == 1)
 		control = data->watchdog_control | SCH56XX_WDOG_TIME_BASE_SEC;
 	else
@@ -316,7 +286,7 @@ static int watchdog_set_timeout(struct sch56xx_watchdog_data *data,
 						control);
 		mutex_unlock(data->io_lock);
 		if (ret)
-			goto leave;
+			return ret;
 
 		data->watchdog_control = control;
 	}
@@ -326,38 +296,17 @@ static int watchdog_set_timeout(struct sch56xx_watchdog_data *data,
 	 * the watchdog countdown.
 	 */
 	data->watchdog_preset = DIV_ROUND_UP(timeout, resolution);
+	wddev->timeout = data->watchdog_preset * resolution;
 
-	ret = data->watchdog_preset * resolution;
-leave:
-	mutex_unlock(&data->watchdog_lock);
-	return ret;
-}
-
-static int watchdog_get_timeout(struct sch56xx_watchdog_data *data)
-{
-	int timeout;
-
-	mutex_lock(&data->watchdog_lock);
-	if (data->watchdog_control & SCH56XX_WDOG_TIME_BASE_SEC)
-		timeout = data->watchdog_preset;
-	else
-		timeout = data->watchdog_preset * 60;
-	mutex_unlock(&data->watchdog_lock);
-
-	return timeout;
+	return 0;
 }
 
-static int watchdog_start(struct sch56xx_watchdog_data *data)
+static int watchdog_start(struct watchdog_device *wddev)
 {
+	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
 	int ret;
 	u8 val;
 
-	mutex_lock(&data->watchdog_lock);
-	if (!data->addr) {
-		ret = -ENODEV;
-		goto leave_unlock_watchdog;
-	}
-
 	/*
 	 * The sch56xx's watchdog cannot really be started / stopped
 	 * it is always running, but we can avoid the timer expiring
@@ -405,39 +354,29 @@ static int watchdog_start(struct sch56xx_watchdog_data *data)
 
 leave:
 	mutex_unlock(data->io_lock);
-leave_unlock_watchdog:
-	mutex_unlock(&data->watchdog_lock);
 	return ret;
 }
 
-static int watchdog_trigger(struct sch56xx_watchdog_data *data)
+static int watchdog_trigger(struct watchdog_device *wddev)
 {
+	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
 	int ret;
 
-	mutex_lock(&data->watchdog_lock);
-	if (!data->addr) {
-		ret = -ENODEV;
-		goto leave;
-	}
-
 	/* Reset the watchdog countdown counter */
 	mutex_lock(data->io_lock);
 	ret = sch56xx_write_virtual_reg(data->addr, SCH56XX_REG_WDOG_PRESET,
 					data->watchdog_preset);
 	mutex_unlock(data->io_lock);
-leave:
-	mutex_unlock(&data->watchdog_lock);
+
 	return ret;
 }
 
-static int watchdog_stop_unlocked(struct sch56xx_watchdog_data *data)
+static int watchdog_stop(struct watchdog_device *wddev)
 {
+	struct sch56xx_watchdog_data *data = watchdog_get_drvdata(wddev);
 	int ret = 0;
 	u8 val;
 
-	if (!data->addr)
-		return -ENODEV;
-
 	if (data->watchdog_output_enable & SCH56XX_WDOG_OUTPUT_ENABLE) {
 		val = data->watchdog_output_enable &
 		      ~SCH56XX_WDOG_OUTPUT_ENABLE;
@@ -455,184 +394,19 @@ static int watchdog_stop_unlocked(struct sch56xx_watchdog_data *data)
 	return ret;
 }
 
-static int watchdog_stop(struct sch56xx_watchdog_data *data)
-{
-	int ret;
-
-	mutex_lock(&data->watchdog_lock);
-	ret = watchdog_stop_unlocked(data);
-	mutex_unlock(&data->watchdog_lock);
-
-	return ret;
-}
-
-static int watchdog_release(struct inode *inode, struct file *filp)
-{
-	struct sch56xx_watchdog_data *data = filp->private_data;
-
-	if (data->watchdog_expect_close) {
-		watchdog_stop(data);
-		data->watchdog_expect_close = 0;
-	} else {
-		watchdog_trigger(data);
-		pr_crit("unexpected close, not stopping watchdog!\n");
-	}
-
-	clear_bit(0, &data->watchdog_is_open);
-
-	mutex_lock(&watchdog_data_mutex);
-	kref_put(&data->kref, sch56xx_watchdog_release_resources);
-	mutex_unlock(&watchdog_data_mutex);
-
-	return 0;
-}
-
-static int watchdog_open(struct inode *inode, struct file *filp)
-{
-	struct sch56xx_watchdog_data *pos, *data = NULL;
-	int ret, watchdog_is_open;
-
-	/*
-	 * We get called from drivers/char/misc.c with misc_mtx hold, and we
-	 * call misc_register() from sch56xx_watchdog_probe() with
-	 * watchdog_data_mutex hold, as misc_register() takes the misc_mtx
-	 * lock, this is a possible deadlock, so we use mutex_trylock here.
-	 */
-	if (!mutex_trylock(&watchdog_data_mutex))
-		return -ERESTARTSYS;
-	list_for_each_entry(pos, &watchdog_data_list, list) {
-		if (pos->watchdog_miscdev.minor == iminor(inode)) {
-			data = pos;
-			break;
-		}
-	}
-	/* Note we can never not have found data, so we don't check for this */
-	watchdog_is_open = test_and_set_bit(0, &data->watchdog_is_open);
-	if (!watchdog_is_open)
-		kref_get(&data->kref);
-	mutex_unlock(&watchdog_data_mutex);
-
-	if (watchdog_is_open)
-		return -EBUSY;
-
-	filp->private_data = data;
-
-	/* Start the watchdog */
-	ret = watchdog_start(data);
-	if (ret) {
-		watchdog_release(inode, filp);
-		return ret;
-	}
-
-	return nonseekable_open(inode, filp);
-}
-
-static ssize_t watchdog_write(struct file *filp, const char __user *buf,
-	size_t count, loff_t *offset)
-{
-	int ret;
-	struct sch56xx_watchdog_data *data = filp->private_data;
-
-	if (count) {
-		if (!nowayout) {
-			size_t i;
-
-			/* Clear it in case it was set with a previous write */
-			data->watchdog_expect_close = 0;
-
-			for (i = 0; i != count; i++) {
-				char c;
-				if (get_user(c, buf + i))
-					return -EFAULT;
-				if (c == 'V')
-					data->watchdog_expect_close = 1;
-			}
-		}
-		ret = watchdog_trigger(data);
-		if (ret)
-			return ret;
-	}
-	return count;
-}
-
-static long watchdog_ioctl(struct file *filp, unsigned int cmd,
-			   unsigned long arg)
-{
-	struct watchdog_info ident = {
-		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
-		.identity = "sch56xx watchdog"
-	};
-	int i, ret = 0;
-	struct sch56xx_watchdog_data *data = filp->private_data;
-
-	switch (cmd) {
-	case WDIOC_GETSUPPORT:
-		ident.firmware_version = data->revision;
-		if (!nowayout)
-			ident.options |= WDIOF_MAGICCLOSE;
-		if (copy_to_user((void __user *)arg, &ident, sizeof(ident)))
-			ret = -EFAULT;
-		break;
-
-	case WDIOC_GETSTATUS:
-	case WDIOC_GETBOOTSTATUS:
-		ret = put_user(0, (int __user *)arg);
-		break;
-
-	case WDIOC_KEEPALIVE:
-		ret = watchdog_trigger(data);
-		break;
-
-	case WDIOC_GETTIMEOUT:
-		i = watchdog_get_timeout(data);
-		ret = put_user(i, (int __user *)arg);
-		break;
-
-	case WDIOC_SETTIMEOUT:
-		if (get_user(i, (int __user *)arg)) {
-			ret = -EFAULT;
-			break;
-		}
-		ret = watchdog_set_timeout(data, i);
-		if (ret >= 0)
-			ret = put_user(ret, (int __user *)arg);
-		break;
-
-	case WDIOC_SETOPTIONS:
-		if (get_user(i, (int __user *)arg)) {
-			ret = -EFAULT;
-			break;
-		}
-
-		if (i & WDIOS_DISABLECARD)
-			ret = watchdog_stop(data);
-		else if (i & WDIOS_ENABLECARD)
-			ret = watchdog_trigger(data);
-		else
-			ret = -EINVAL;
-		break;
-
-	default:
-		ret = -ENOTTY;
-	}
-	return ret;
-}
-
-static const struct file_operations watchdog_fops = {
-	.owner = THIS_MODULE,
-	.llseek = no_llseek,
-	.open = watchdog_open,
-	.release = watchdog_release,
-	.write = watchdog_write,
-	.unlocked_ioctl = watchdog_ioctl,
+static const struct watchdog_ops watchdog_ops = {
+	.owner		= THIS_MODULE,
+	.start		= watchdog_start,
+	.stop		= watchdog_stop,
+	.ping		= watchdog_trigger,
+	.set_timeout	= watchdog_set_timeout,
 };
 
-struct sch56xx_watchdog_data *sch56xx_watchdog_register(
+struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 	u16 addr, u32 revision, struct mutex *io_lock, int check_enabled)
 {
 	struct sch56xx_watchdog_data *data;
-	int i, err, control, output_enable;
-	const int watchdog_minors[] = { WATCHDOG_MINOR, 212, 213, 214, 215 };
+	int err, control, output_enable;
 
 	/* Cache the watchdog registers */
 	mutex_lock(io_lock);
@@ -656,82 +430,53 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(
 		return NULL;
 
 	data->addr = addr;
-	data->revision = revision;
 	data->io_lock = io_lock;
-	data->watchdog_control = control;
-	data->watchdog_output_enable = output_enable;
-	mutex_init(&data->watchdog_lock);
-	INIT_LIST_HEAD(&data->list);
-	kref_init(&data->kref);
-
-	err = watchdog_set_timeout(data, 60);
-	if (err < 0)
-		goto error;
 
-	/*
-	 * We take the data_mutex lock early so that watchdog_open() cannot
-	 * run when misc_register() has completed, but we've not yet added
-	 * our data to the watchdog_data_list.
-	 */
-	mutex_lock(&watchdog_data_mutex);
-	for (i = 0; i < ARRAY_SIZE(watchdog_minors); i++) {
-		/* Register our watchdog part */
-		snprintf(data->watchdog_name, sizeof(data->watchdog_name),
-			"watchdog%c", (i == 0) ? '\0' : ('0' + i));
-		data->watchdog_miscdev.name = data->watchdog_name;
-		data->watchdog_miscdev.fops = &watchdog_fops;
-		data->watchdog_miscdev.minor = watchdog_minors[i];
-		err = misc_register(&data->watchdog_miscdev);
-		if (err == -EBUSY)
-			continue;
-		if (err)
-			break;
+	strlcpy(data->wdinfo.identity, "sch56xx watchdog",
+		sizeof(data->wdinfo.identity));
+	data->wdinfo.firmware_version = revision;
+	data->wdinfo.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT;
+	if (!nowayout)
+		data->wdinfo.options |= WDIOF_MAGICCLOSE;
+
+	data->wddev.info = &data->wdinfo;
+	data->wddev.ops = &watchdog_ops;
+	data->wddev.busdev = parent;
+	data->wddev.timeout = 60;
+	data->wddev.min_timeout = 1;
+	data->wddev.max_timeout = 255 * 60;
+	if (nowayout)
+		data->wddev.status |= WDOG_NO_WAY_OUT;
+	if (output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)
+		data->wddev.status |= WDOG_ACTIVE;
+
+	/* Since the watchdog uses a downcounter there is no register to read
+	   the BIOS set timeout from (if any was set at all) ->
+	   Choose a preset which will give us a 1 minute timeout */
+	if (control & SCH56XX_WDOG_TIME_BASE_SEC)
+		data->watchdog_preset = 60; /* seconds */
+	else
+		data->watchdog_preset = 1; /* minute */
 
-		list_add(&data->list, &watchdog_data_list);
-		pr_info("Registered /dev/%s chardev major 10, minor: %d\n",
-			data->watchdog_name, watchdog_minors[i]);
-		break;
-	}
-	mutex_unlock(&watchdog_data_mutex);
+	data->watchdog_control = control;
+	data->watchdog_output_enable = output_enable;
 
+	watchdog_set_drvdata(&data->wddev, data);
+	err = watchdog_register_device(&data->wddev);
 	if (err) {
 		pr_err("Registering watchdog chardev: %d\n", err);
-		goto error;
-	}
-	if (i == ARRAY_SIZE(watchdog_minors)) {
-		pr_warn("Couldn't register watchdog (no free minor)\n");
-		goto error;
+		kfree(data);
+		return NULL;
 	}
 
 	return data;
-
-error:
-	kfree(data);
-	return NULL;
 }
 EXPORT_SYMBOL(sch56xx_watchdog_register);
 
 void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data)
 {
-	mutex_lock(&watchdog_data_mutex);
-	misc_deregister(&data->watchdog_miscdev);
-	list_del(&data->list);
-	mutex_unlock(&watchdog_data_mutex);
-
-	mutex_lock(&data->watchdog_lock);
-	if (data->watchdog_is_open) {
-		pr_warn("platform device unregistered with watchdog "
-			"open! Stopping watchdog.\n");
-		watchdog_stop_unlocked(data);
-	}
-	/* Tell the wdog start/stop/trigger functions our dev is gone */
-	data->addr = 0;
-	data->io_lock = NULL;
-	mutex_unlock(&data->watchdog_lock);
-
-	mutex_lock(&watchdog_data_mutex);
-	kref_put(&data->kref, sch56xx_watchdog_release_resources);
-	mutex_unlock(&watchdog_data_mutex);
+	watchdog_unregister_device(&data->wddev);
+	kfree(data);
 }
 EXPORT_SYMBOL(sch56xx_watchdog_unregister);
 
diff --git a/drivers/hwmon/sch56xx-common.h b/drivers/hwmon/sch56xx-common.h
index 7475086..704ea2c 100644
--- a/drivers/hwmon/sch56xx-common.h
+++ b/drivers/hwmon/sch56xx-common.h
@@ -27,6 +27,6 @@ int sch56xx_read_virtual_reg16(u16 addr, u16 reg);
 int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg, u16 lsn_reg,
 			       int high_nibble);
 
-struct sch56xx_watchdog_data *sch56xx_watchdog_register(
+struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 	u16 addr, u32 revision, struct mutex *io_lock, int check_enabled);
 void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data);
-- 
1.7.10

