Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:42108 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932511AbbDJNHP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Apr 2015 09:07:15 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv5 2/4] watchdog: Allow watchdog to reset device at early boot
Date: Fri, 10 Apr 2015 16:06:37 +0300
Message-Id: <1428671199-5562-3-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1428671199-5562-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1428671199-5562-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Historically the watchdogs have always been stopped before user space
opens and takes over the device. This is not good on many production
systems where any crash, in kernel or user space, must always result
in a device reset.

Add a new early_timeout_sec parameter to the watchdog that gives user
space certain amount of time to set up itself and take over the
watchdog. Until this timeout has been reached the watchdog core takes
care of petting the watchdog HW. If there is any crash in kernel or
user space, reboot is guaranteed as watchdog hardware is never
stopped.

There is also mode of supplying zero seconds for the early_timeout_sec
parameter. In this mode the worker is not scheduled, so the watchdog
timer is not touched nor is the HW petted until user space takes over
it.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/watchdog_core.c | 39 ++++++++++++++++++++++++++++++---------
 include/linux/watchdog.h         |  1 +
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 8e7d08d..d6bedf7 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -111,12 +111,18 @@ EXPORT_SYMBOL_GPL(watchdog_init_timeout);
  */
 int watchdog_init_params(struct watchdog_device *wdd, struct device *dev)
 {
+	unsigned int t = 0;
 	int ret = 0;
 
 	ret = watchdog_init_timeout(wdd, wdd->timeout, dev);
 	if (ret < 0)
 		return ret;
 
+	if (!of_property_read_u32(dev->of_node, "early-timeout-sec", &t))
+		wdd->early_timeout_sec = t;
+	else
+		wdd->early_timeout_sec = -1;
+
 	/*
 	 * Max HW timeout needs to be set so that core knows when to
 	 * use a kernel worker to support longer watchdog timeouts
@@ -139,6 +145,7 @@ static void watchdog_worker(struct work_struct *work)
 	}
 
 	if ((!watchdog_active(wdd) && !watchdog_is_stoppable(wdd)) ||
+		(!watchdog_active(wdd) && wdd->early_timeout_sec >= 0) ||
 		(watchdog_active(wdd) &&
 			wdd->hw_max_timeout < wdd->timeout * HZ)) {
 		if (wdd->ops->ping)
@@ -152,17 +159,31 @@ static void watchdog_worker(struct work_struct *work)
 
 static int prepare_watchdog(struct watchdog_device *wdd)
 {
-	/* Stop the watchdog now before user space opens the device */
-	if (wdd->hw_features & WDOG_HW_IS_STOPPABLE &&
-		wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT) {
-		wdd->ops->stop(wdd);
-
-	} else if (!(wdd->hw_features & WDOG_HW_IS_STOPPABLE)) {
+	if (wdd->early_timeout_sec >= 0) {
 		/*
-		 * Can't stop it, use a kernel timer to tick
-		 * it until it's open by user space
+		 * early timeout, if set, ensures that watchdog will
+		 * reset the device unless user space opens the
+		 * watchdog device within the given interval.
 		 */
-		schedule_delayed_work(&wdd->work, wdd->hw_heartbeat);
+		if (!(wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT))
+			wdd->ops->start(wdd);
+
+		if (wdd->early_timeout_sec > 0) {
+			schedule_delayed_work(&wdd->work,  wdd->hw_heartbeat);
+		}
+	} else {
+		/* Stop the watchdog now before user space opens the device */
+		if (wdd->hw_features & WDOG_HW_IS_STOPPABLE &&
+			wdd->hw_features & WDOG_HW_RUNNING_AT_BOOT) {
+			wdd->ops->stop(wdd);
+
+		} else if (!(wdd->hw_features & WDOG_HW_IS_STOPPABLE)) {
+			/*
+			 * Can't stop it, use a kernel timer to tick
+			 * it until it's open by user space
+			 */
+			schedule_delayed_work(&wdd->work, wdd->hw_heartbeat);
+		}
 	}
 	return 0;
 }
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index c16c921..6f868b6 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -94,6 +94,7 @@ struct watchdog_device {
 	unsigned int hw_max_timeout; /* in jiffies */
 	unsigned int hw_heartbeat; /* in jiffies */
 	unsigned long int expires; /* for soft timer */
+	unsigned int early_timeout_sec;
 	void *driver_data;
 	struct mutex lock;
 	struct delayed_work work;
-- 
2.1.0

