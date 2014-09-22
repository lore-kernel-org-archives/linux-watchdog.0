Return-path: <j.uzycki@elproma.com.pl>
From: Janusz Uzycki <j.uzycki@elproma.com.pl>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 5/6] watchdog: suspend/resume PM helper
Date: Mon, 22 Sep 2014 22:55:49 +0200
Message-Id: <1411419350-1297-5-git-send-email-j.uzycki@elproma.com.pl>
In-Reply-To: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
List-ID: <linux-watchdog@vger.kernel.org>

The helper replaces watchdog_active() condition
usually used in device-specific drivers for PM support.
It also solves race between ping timer and
driver-specific suspend function.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/watchdog/watchdog_dev.c | 38 +++++++++++++++++++++++++++
 include/linux/watchdog.h        |  4 +++
 2 files changed, 42 insertions(+)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index d289eab..2df88b7 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -311,6 +311,44 @@ static void watchdog_keepon_stop(struct watchdog_device *wdd)
 }
 
 /*
+ *	watchdog_suspend: deactivate ping timer if enabled and
+ *			  stop the watchdog if active
+ *	@wdd: the watchdog device to do the suspend on
+ */
+void watchdog_suspend(struct watchdog_device *wdd)
+{
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status))
+		return;
+
+	if (test_bit(WDOG_KEEP_ON, &wdd->status) &&
+	   !test_bit(WDOG_DEV_OPEN, &wdd->status))
+		del_timer_sync(&wdd->ping_timer);
+
+	if (watchdog_active(wdd))
+		wdd->ops->stop(wdd);
+}
+EXPORT_SYMBOL_GPL(watchdog_suspend);
+
+/*
+ *	watchdog_resume: start the watchdog if it was active
+ *			 and activate ping timer if it was enabled
+ *	@wdd: the watchdog device to do the resume on
+ */
+void watchdog_resume(struct watchdog_device *wdd)
+{
+	if (test_bit(WDOG_UNREGISTERED, &wdd->status))
+		return;
+
+	if (watchdog_active(wdd))
+		wdd->ops->start(wdd);
+
+	if (test_bit(WDOG_KEEP_ON, &wdd->status) &&
+	   !test_bit(WDOG_DEV_OPEN, &wdd->status))
+		watchdog_ping_timer_cb((unsigned long)wdd);
+}
+EXPORT_SYMBOL_GPL(watchdog_resume);
+
+/*
  *	watchdog_write: writes to the watchdog.
  *	@file: file from VFS
  *	@data: user address of data
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 650e0d5..eee1b65 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -147,4 +147,8 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
+/* drivers/watchdog/watchdog_dev.c */
+extern void watchdog_suspend(struct watchdog_device *);
+extern void watchdog_resume(struct watchdog_device *);
+
 #endif  /* ifndef _LINUX_WATCHDOG_H */
-- 
1.7.11.3
