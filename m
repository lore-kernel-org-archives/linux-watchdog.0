Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47485 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbaB1QQb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Feb 2014 11:16:31 -0500
From: Markus Pargmann <mpa@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] watchdog: core: module param to activate watchdog
Date: Fri, 28 Feb 2014 17:16:23 +0100
Message-Id: <1393604183-8755-1-git-send-email-mpa@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Many watchdog driver reset the watchdog device on initialization. This
is a problem if the watchdog is activated by the bootloader and should
be active the whole time until the userspace can write to it.

This patch adds a module parameter (watchdog.activate_first) that
activates the first registered watchdog. Using this parameter it is
possible to have an active watchdog during the whole boot process.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/watchdog/watchdog_core.c |  4 ++++
 drivers/watchdog/watchdog_core.h |  4 ++++
 drivers/watchdog/watchdog_dev.c  | 21 ++++++++++++++++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..6db16eb 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -43,6 +43,10 @@
 static DEFINE_IDA(watchdog_ida);
 static struct class *watchdog_class;
 
+unsigned int activate_first = 0;
+module_param(activate_first, uint, 0);
+MODULE_PARM_DESC(activate_first, "Activation timeout for first watchdog registered. 0 means no activation.");
+
 static void watchdog_check_min_max_timeout(struct watchdog_device *wdd)
 {
 	/*
diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
index 6c95141..4526170 100644
--- a/drivers/watchdog/watchdog_core.h
+++ b/drivers/watchdog/watchdog_core.h
@@ -28,6 +28,10 @@
 
 #define MAX_DOGS	32	/* Maximum number of watchdog devices */
 
+/* Activate first registered watchdog and set this as the timeout value
+ * (only != 0) */
+extern unsigned int activate_first;
+
 /*
  *	Functions/procedures to be called by the core
  */
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 6aaefba..fe60fdc 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -553,8 +553,27 @@ int watchdog_dev_register(struct watchdog_device *watchdog)
 			misc_deregister(&watchdog_miscdev);
 			old_wdd = NULL;
 		}
+
+		return err;
 	}
-	return err;
+
+	if (activate_first && watchdog->id == 0) {
+		err = watchdog_set_timeout(watchdog, activate_first);
+		if (err && err != -EOPNOTSUPP) {
+			pr_err("watchdog%d failed to set timeout for first activation\n",
+					watchdog->id);
+			return err;
+		}
+
+		err = watchdog_start(watchdog);
+		if (err) {
+			pr_err("watchdog%d failed to start first watchdog\n",
+					watchdog->id);
+			return err;
+		}
+	}
+
+	return 0;
 }
 
 /*
-- 
1.8.5.3

