Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/2] watchdog: Implement status function in watchdog core
Date: Sun, 17 Jul 2016 15:04:11 -0700
Message-Id: <1468793052-26252-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Up to now, the watchdog status function called a driver function,
which was supposed to return the watchdog status. All but one
driver using the watchdog core did not implement this function,
and the driver implementing it did not implement it correctly
(the function is supposed to return WDIOF_ flags). At the same time,
at least some of the status information can be provided by the watchdog
core.

Provide the available status bits directly from the watchdog driver core.
Call the driver status function if it exists to get the boot status, but
always provide WDIOF_MAGICCLOSE and WDIOF_KEEPALIVEPING internally.
This patch makes the 'status' sysfs attribute always available.
This attribute is now displayed as hex number with 0x prepended to be
easier to decode.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Still call the status function if it is implemented in the driver.
    Fix typo in description.

 Documentation/watchdog/watchdog-kernel-api.txt |  4 +++
 drivers/watchdog/watchdog_dev.c                | 34 ++++++++++++++++++++------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/watchdog/watchdog-kernel-api.txt b/Documentation/watchdog/watchdog-kernel-api.txt
index 92700d229bf9..7f31125c123e 100644
--- a/Documentation/watchdog/watchdog-kernel-api.txt
+++ b/Documentation/watchdog/watchdog-kernel-api.txt
@@ -167,6 +167,10 @@ they are supported. These optional routines/operations are:
   info structure).
 * status: this routine checks the status of the watchdog timer device. The
   status of the device is reported with watchdog WDIOF_* status flags/bits.
+  WDIOF_MAGICCLOSE and WDIOF_KEEPALIVEPING are reported by the watchdog core;
+  it is not necessary to report those bits from the driver. Also, if no status
+  function is provided by the driver, the watchdog core reports the status bits
+  provided in the bootstatus variable of struct watchdog_device.
 * set_timeout: this routine checks and changes the timeout of the watchdog
   timer device. It returns 0 on success, -EINVAL for "parameter out of range"
   and -EIO for "could not write value to the watchdog". On success this
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 14f8a92fca12..270f4bf291e3 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -69,6 +69,7 @@ struct watchdog_core_data {
 	unsigned long status;		/* Internal status bits */
 #define _WDOG_DEV_OPEN		0	/* Opened ? */
 #define _WDOG_ALLOW_RELEASE	1	/* Did we receive the magic char ? */
+#define _WDOG_KEEPALIVE		2	/* Did we receive a keepalive ? */
 };
 
 /* the dev_t structure to store the dynamically allocated watchdog devices */
@@ -184,6 +185,8 @@ static int watchdog_ping(struct watchdog_device *wdd)
 	if (!watchdog_active(wdd) && !watchdog_hw_running(wdd))
 		return 0;
 
+	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
+
 	wd_data->last_keepalive = jiffies;
 	return __watchdog_ping(wdd);
 }
@@ -223,6 +226,8 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (watchdog_active(wdd))
 		return 0;
 
+	set_bit(_WDOG_KEEPALIVE, &wd_data->status);
+
 	started_at = jiffies;
 	if (watchdog_hw_running(wdd) && wdd->ops->ping)
 		err = wdd->ops->ping(wdd);
@@ -286,10 +291,27 @@ static int watchdog_stop(struct watchdog_device *wdd)
 
 static unsigned int watchdog_get_status(struct watchdog_device *wdd)
 {
-	if (!wdd->ops->status)
-		return 0;
+	struct watchdog_core_data *wd_data = wdd->wd_data;
+	unsigned int status;
 
-	return wdd->ops->status(wdd);
+	if (wdd->ops->status)
+		status = wdd->ops->status(wdd);
+	else
+		status = wdd->bootstatus & (WDIOF_CARDRESET |
+					    WDIOF_OVERHEAT |
+					    WDIOF_FANFAULT |
+					    WDIOF_EXTERN1 |
+					    WDIOF_EXTERN2 |
+					    WDIOF_POWERUNDER |
+					    WDIOF_POWEROVER);
+
+	if (test_bit(_WDOG_ALLOW_RELEASE, &wd_data->status))
+		status |= WDIOF_MAGICCLOSE;
+
+	if (test_and_clear_bit(_WDOG_KEEPALIVE, &wd_data->status))
+		status |= WDIOF_KEEPALIVEPING;
+
+	return status;
 }
 
 /*
@@ -365,7 +387,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	status = watchdog_get_status(wdd);
 	mutex_unlock(&wd_data->lock);
 
-	return sprintf(buf, "%u\n", status);
+	return sprintf(buf, "0x%x\n", status);
 }
 static DEVICE_ATTR_RO(status);
 
@@ -433,9 +455,7 @@ static umode_t wdt_is_visible(struct kobject *kobj, struct attribute *attr,
 	struct watchdog_device *wdd = dev_get_drvdata(dev);
 	umode_t mode = attr->mode;
 
-	if (attr == &dev_attr_status.attr && !wdd->ops->status)
-		mode = 0;
-	else if (attr == &dev_attr_timeleft.attr && !wdd->ops->get_timeleft)
+	if (attr == &dev_attr_timeleft.attr && !wdd->ops->get_timeleft)
 		mode = 0;
 
 	return mode;
-- 
2.5.0
