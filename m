Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36705 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782Ab3DLGvz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Apr 2013 02:51:55 -0400
From: "Kim, Milo" <Milo.Kim@ti.com>
To: "wim@iguana.be" <wim@iguana.be>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] watchdog: introduce new watchdog AUTOSTART option
Date: Fri, 12 Apr 2013 06:51:47 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F82E4BBC2@DQHE02.ent.ti.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Conventionally, watchdog timer driver is activated by an user space reque=
st.
This patch enables an automatic start/ping operation of a watchdog withou=
t an
application.

(a) Work flow
If a watchdog timer driver is configured with WDIOF_AUTOSTART option,
then it starts and ping automatically on watchdog device registration.
A delayed workqueue invokes a ping operation of the watchdog periodically=
.
In the mean time, if an application tries to open the watchdog device,
it returns as -EBUSY because the watchdog is already running.
When the watchdog is unregistered, timed workqueue is canceled.

(b) Structure changes
ping_period      : Period time for watchdog ping. Unit is millisecond.
work             : Workqueue for automatic ping operation.
WDOG_AUTOSTARTED : Added status bit. Set when ping is done.
                   Cleared when period time is expired.
WDIOF_AUTOSTART  : New option flag.

(c) Documentation
It describes how it works and how to use this feature in a watchdog drive=
r.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 Documentation/watchdog/watchdog-without-app.txt |   59 ++++++++++++++++
 drivers/watchdog/watchdog_dev.c                 |   86 +++++++++++++++++=
+++++-
 include/linux/watchdog.h                        |    6 ++
 include/uapi/linux/watchdog.h                   |    1 +
 4 files changed, 151 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/watchdog/watchdog-without-app.txt

diff --git a/Documentation/watchdog/watchdog-without-app.txt b/Documentat=
ion/watchdog/watchdog-without-app.txt
new file mode 100644
index 0000000..596a30a
--- /dev/null
+++ b/Documentation/watchdog/watchdog-without-app.txt
@@ -0,0 +1,59 @@
+The Linux WatchDog Timer Driver without an Application
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+Milo Kim <milo.kim@ti.com>
+
+Introduction
+------------
+Linux WatchDog Timer (WDT) driver is activated by an user space request.
+If a WDT needs to be enabled alone, without an application, you can conf=
igure
+the WDT driver with 'AUTOSTART' option.
+
+How it works
+------------
+* Conventional watchdog system
+
+  (WDT driver)        ------------                       (WDT Applicatio=
n)
+   register    -->      WDT Core
+                      ------------
+   .start      <--      WDT Dev   /dev/watchdogN  <--       open
+   .ping              ------------                 .        ioctl - keep=
alive
+   .stop                                           .        close
+                                                   .
+                                                   activated by an appli=
cation
+
+* Watchdog autostart feature
+
+  (WDT driver)        ------------
+   register    -->      WDT Core
+                      ------------
+   .start      <--      WDT Dev   /dev/watchdogN
+   .ping        .     ------------
+                .
+                .
+                start and ping periodically without an application
+
+How to use
+----------
+1) Add 'WDIOF_AUTOSTART' option in your watchdog_info.
+
+static const struct watchdog_info foo_wdt_info =3D {
+	.options =3D WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_AUTOSTART,
+	.identity =3D "Auto Watchdog Sample",
+};
+
+2) Define the value of 'ping_period' in your watchdog_device structure.
+   Unit is millisecond.
+
+static int foo_wdt_probe(struct platform_device *pdev)
+{
+	struct watchdog_device *foo_wdt;
+
+	foo_wdt->info =3D &foo_wdt_info;
+	foo_wdt->ops =3D &foo_wdt_ops;
+	foo_wdt->ping_period =3D 1000;	/* kick a watchdog per 1 sec */
+
+	return watchdog_register_device(foo_wdt);
+}
+
+Then the foo watchdog is started and ping periodically without an applic=
ation.
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
index 08b48bb..42bfc9a 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -44,6 +44,8 @@
=20
 #include "watchdog_core.h"
=20
+#define MAX_PING_PERIOD		(60 * 60 * 1000)	/* 1 hour */
+
 /* the dev_t structure to store the dynamically allocated watchdog devic=
es */
 static dev_t watchdog_devt;
 /* the watchdog device behind /dev/watchdog */
@@ -115,6 +117,70 @@ out_start:
 	return err;
 }
=20
+static void watchdog_set_autostart(struct watchdog_device *wdd)
+{
+	schedule_delayed_work(&wdd->work, msecs_to_jiffies(wdd->ping_period));
+	set_bit(WDOG_AUTOSTARTED, &wdd->status);
+}
+
+static void watchdog_clear_autostart(struct watchdog_device *wdd)
+{
+	clear_bit(WDOG_AUTOSTARTED, &wdd->status);
+}
+
+static bool watchdog_autostarted(struct watchdog_device *wdd)
+{
+	return test_bit(WDOG_AUTOSTARTED, &wdd->status);
+}
+
+static void watchdog_autoping_work(struct work_struct *w)
+{
+	struct watchdog_device *wdd =3D container_of(w, struct watchdog_device,
+						work.work);
+	int err;
+
+	if (!watchdog_autostarted(wdd))
+		return;
+
+	watchdog_clear_autostart(wdd);
+
+	err =3D watchdog_ping(wdd);
+	if (err)
+		return;
+
+	watchdog_set_autostart(wdd);
+}
+
+/*
+ *	watchdog_auto_start: start the watchdong and ping it
+ *	@wdd: the watchdog device to start
+ *
+ *	If watchdog_info has WDIOF_AUTOSTART option, then the watchdog
+ *	starts automatically. Ping operation is done by internal timer.
+ *	The watchdog driver is activated without a watchdog user application.
+ *	This function should be used by the watchdog driver, not an user-spac=
e
+ *	interface.
+ */
+
+static int watchdog_auto_start(struct watchdog_device *wdd)
+{
+	int err;
+
+	if (wdd->ping_period < 1 || wdd->ping_period >=3D MAX_PING_PERIOD) {
+		pr_err("invalid ping time value:%u\n", wdd->ping_period);
+		return -EINVAL;
+	}
+
+	err =3D watchdog_start(wdd);
+	if (err)
+		return err;
+
+	INIT_DELAYED_WORK(&wdd->work, watchdog_autoping_work);
+	watchdog_set_autostart(wdd);
+
+	return 0;
+}
+
 /*
  *	watchdog_stop: wrapper to stop the watchdog.
  *	@wddev: the watchdog device to stop
@@ -420,7 +486,8 @@ static int watchdog_open(struct inode *inode, struct =
file *file)
 		wdd =3D container_of(inode->i_cdev, struct watchdog_device, cdev);
=20
 	/* the watchdog is single open! */
-	if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status))
+	if (test_and_set_bit(WDOG_DEV_OPEN, &wdd->status) ||
+	    watchdog_autostarted(wdd))
 		return -EBUSY;
=20
 	/*
@@ -550,7 +617,21 @@ int watchdog_dev_register(struct watchdog_device *wa=
tchdog)
 			misc_deregister(&watchdog_miscdev);
 			old_wdd =3D NULL;
 		}
+		return err;
+	}
+
+	/* Activate the watchdog automatically by the driver itself */
+	if (watchdog->info->options & WDIOF_AUTOSTART) {
+		err =3D watchdog_auto_start(watchdog);
+		if (err) {
+			cdev_del(&watchdog->cdev);
+			if (watchdog->id =3D=3D 0) {
+				misc_deregister(&watchdog_miscdev);
+				old_wdd =3D NULL;
+			}
+		}
 	}
+
 	return err;
 }
=20
@@ -563,6 +644,9 @@ int watchdog_dev_register(struct watchdog_device *wat=
chdog)
=20
 int watchdog_dev_unregister(struct watchdog_device *watchdog)
 {
+	if (watchdog_autostarted(watchdog))
+		cancel_delayed_work_sync(&watchdog->work);
+
 	mutex_lock(&watchdog->lock);
 	set_bit(WDOG_UNREGISTERED, &watchdog->status);
 	mutex_unlock(&watchdog->lock);
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 2a3038e..4b7478a 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -62,6 +62,9 @@ struct watchdog_ops {
  * @timeout:	The watchdog devices timeout value.
  * @min_timeout:The watchdog devices minimum timeout value.
  * @max_timeout:The watchdog devices maximum timeout value.
+ * @ping_period:Period time for watchdog ping. Unit is millisecond.
+ *		Only valid with WDIOF_AUTOSTART.
+ * @work:       Workqueue for handling auto ping
  * @driver-data:Pointer to the drivers private data.
  * @lock:	Lock for watchdog core internal use only.
  * @status:	Field that contains the devices internal status bits.
@@ -86,6 +89,8 @@ struct watchdog_device {
 	unsigned int timeout;
 	unsigned int min_timeout;
 	unsigned int max_timeout;
+	unsigned int ping_period;
+	struct delayed_work work;
 	void *driver_data;
 	struct mutex lock;
 	unsigned long status;
@@ -95,6 +100,7 @@ struct watchdog_device {
 #define WDOG_ALLOW_RELEASE	2	/* Did we receive the magic char ? */
 #define WDOG_NO_WAY_OUT		3	/* Is 'nowayout' feature set ? */
 #define WDOG_UNREGISTERED	4	/* Has the device been unregistered */
+#define WDOG_AUTOSTARTED	5	/* Started and kicked automatically */
 };
=20
 #ifdef CONFIG_WATCHDOG_NOWAYOUT
diff --git a/include/uapi/linux/watchdog.h b/include/uapi/linux/watchdog.=
h
index 2babe72..9095ec8 100644
--- a/include/uapi/linux/watchdog.h
+++ b/include/uapi/linux/watchdog.h
@@ -47,6 +47,7 @@ struct watchdog_info {
 #define	WDIOF_PRETIMEOUT	0x0200  /* Pretimeout (in seconds), get/set */
 #define	WDIOF_ALARMONLY		0x0400	/* Watchdog triggers a management or
 					   other external alarm not a reboot */
+#define	WDIOF_AUTOSTART		0x1000	/* Start and ping automatically */
 #define	WDIOF_KEEPALIVEPING	0x8000	/* Keep alive ping reply */
=20
 #define	WDIOS_DISABLECARD	0x0001	/* Turn off the watchdog timer */
--=20
1.7.9.5


Best Regards,
Milo


--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
