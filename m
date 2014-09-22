Return-path: <j.uzycki@elproma.com.pl>
From: Janusz Uzycki <j.uzycki@elproma.com.pl>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 2/6] watchdog: boottime protection feature (requires 'keep on')
Date: Mon, 22 Sep 2014 22:55:46 +0200
Message-Id: <1411419350-1297-2-git-send-email-j.uzycki@elproma.com.pl>
In-Reply-To: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
List-ID: <linux-watchdog@vger.kernel.org>

After the boot time active watchdog(s) have to be maintained
by userland.
The protection works only if boot time is non-zero
and keep on feature is enabled.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/watchdog/watchdog_core.c |  4 ++++
 drivers/watchdog/watchdog_dev.c  | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..13f3d3a 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,10 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
+unsigned int boottime = 0;
+module_param(boottime, uint, 0);
+MODULE_PARM_DESC(boottime, "After the boot time active watchdog(s) have to be maintained by userland. 0 disables the protection.");
+
 static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
 	/*
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 51a65f6..d289eab 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -42,6 +42,7 @@
 #include <linux/init.h>		/* For __init/__exit/... */
 #include <linux/uaccess.h>	/* For copy_to_user/put_user/... */
 #include <linux/jiffies.h>	/* for ping timer */
+#include <linux/time.h>		/* for uptime */
 
 #include "watchdog_core.h"
 
@@ -282,6 +283,16 @@ out_ioctl:
 static void watchdog_ping_timer_cb(unsigned long data)
 {
 	struct watchdog_device *wdd = (struct watchdog_device *)data;
+	extern unsigned int boottime;
+	if (boottime) {
+		struct timespec uptime;
+		get_monotonic_boottime(&uptime);
+		if (uptime.tv_sec > boottime) {
+			dev_info(wdd->dev,
+				 "Boottime for userland exceeded. Reboot expected!\n");
+			return;
+		}
+	}
 	watchdog_ping(wdd);
 	/* call next ping half the timeout value */
 	mod_timer(&wdd->ping_timer,
-- 
1.7.11.3
