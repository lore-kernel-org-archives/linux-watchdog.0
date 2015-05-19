Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51242 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754605AbbESI0s (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:48 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 04/10] watchdog: core: Allow extending early timeout
Date: Tue, 19 May 2015 11:26:03 +0300
Message-Id: <1432023969-20736-5-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
References: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It is possible that the specified watchdog timeout value is shorter
than the time it takes for the watchdog daemon to start up and take
over the watchdog device. This is problem if WATCHDOG_BOOT_RUNNING is
the desired watchdog policy.

Add a new timeout value that specifies how long kernel should extend
the timeout by pinging the watchdog hardware. This option still
ensures a watchdog reset takes place in case watchdog daemon fails to
open the device, but gives more freedom in case user space is slow
starting up and watchdog might trigger prematurely.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/watchdog/Kconfig         | 21 +++++++++++++++++++++
 drivers/watchdog/watchdog_core.c | 37 +++++++++++++++++++++++++++++++++----
 drivers/watchdog/watchdog_dev.c  |  4 ++++
 include/linux/watchdog.h         |  1 +
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 0066d6d..33f2f9c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -96,6 +96,27 @@ config WATCHDOG_BOOT_NOTOUCH
 
 endchoice
 
+config WATCHDOG_EARLY_TIMEOUT_SEC
+	int "Extend watchdog early timeout"
+	depends on WATCHDOG_BOOT_RUNNING
+	default "0"
+	help
+	  When WATCHDOG_BOOT_RUNNIN policy is selected the default
+	  behavior is to start up or keep the watchdog hardware
+	  running during boot up. In some cases the boot up time for
+	  the userspace might be too long for the watchdog daemon to
+	  take over the watchdog device in time, which might lead to
+	  premature device reset.
+
+	  This option specifies how long should the watchdog core keep
+	  the watchdog hardware running before the device is
+	  opened. Should there be a crash that prevents the daemon
+	  from starting up, a normal watchdog reset occurs once the
+	  initial timeout expires. Normal timeout limits apply once
+	  watchdog daemon opens the device.
+
+	  The timeout value is in seconds.
+
 #
 # General Watchdog drivers
 #
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 9ae5b8e..7bf0e1e 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -141,6 +141,7 @@ static void watchdog_set_default_timeout(struct watchdog_device *wdd,
  */
 int watchdog_init_params(struct watchdog_device *wdd, struct device *dev)
 {
+	unsigned int t = 0;
 	int ret = 0;
 
 	watchdog_set_default_timeout(wdd, dev);
@@ -148,6 +149,13 @@ int watchdog_init_params(struct watchdog_device *wdd, struct device *dev)
 	if (wdd->max_timeout)
 		dev_err(dev, "Driver setting deprecated max_timeout, please fix\n");
 
+	wdd->early_timeout_sec = -1;
+#ifdef CONFIG_WATCHDOG_EARLY_TIMEOUT_SEC
+	wdd->early_timeout_sec = CONFIG_WATCHDOG_EARLY_TIMEOUT_SEC;
+#endif
+	if (!of_property_read_u32(dev->of_node, "early-timeout-sec", &t))
+		wdd->early_timeout_sec = t;
+
 	if (!wdd->hw_max_timeout)
 		return -EINVAL;
 
@@ -161,12 +169,16 @@ static void watchdog_worker(struct work_struct *work)
 						struct watchdog_device, work);
 	bool stopped_keepalive;
 	bool extend_keepalive;
+	bool early_timeout_keepalive;
 
 	mutex_lock(&wdd->lock);
 
 	/* Watchdog device is not open but HW does not support stopping */
 	stopped_keepalive = watchdog_hw_active(wdd) &&
-		!watchdog_dev_open(wdd);
+		!watchdog_dev_open(wdd) && (wdd->early_timeout_sec < 0);
+
+	early_timeout_keepalive = wdd->early_timeout_sec >= 0 &&
+		time_before(jiffies, wdd->expires);
 
 	/* Keepalive time is longer than what hardware is capable */
 	extend_keepalive = watchdog_dev_open(wdd) &&
@@ -181,7 +193,7 @@ static void watchdog_worker(struct work_struct *work)
 		return;
 	}
 
-	if (stopped_keepalive || extend_keepalive) {
+	if (stopped_keepalive || extend_keepalive || early_timeout_keepalive) {
 		unsigned long expires = msecs_to_jiffies(wdd->hw_heartbeat);
 
 		_watchdog_ping(wdd);
@@ -206,11 +218,28 @@ static int prepare_watchdog(struct watchdog_device *wdd)
 	watchdog_policy_start = IS_ENABLED(CONFIG_WATCHDOG_BOOT_RUNNING);
 	watchdog_policy_stop = IS_ENABLED(CONFIG_WATCHDOG_BOOT_STOPPED);
 
+	if (wdd->early_timeout_sec >= 0)
+		watchdog_policy_start = true;
+
+	if (wdd->early_timeout_sec > 0)
+		wdd->expires = jiffies + wdd->early_timeout_sec * HZ;
+
 	if (!watchdog_hw_active(wdd) && watchdog_policy_stop)
 		return 0;
 
-	if (watchdog_policy_start && !watchdog_hw_active(wdd))
-		return watchdog_start(wdd);
+	if (watchdog_policy_start && !watchdog_hw_active(wdd)) {
+		int ret;
+
+		ret = watchdog_start(wdd);
+
+		if (wdd->early_timeout_sec > 0) {
+			wdd->expires = jiffies + wdd->early_timeout_sec * HZ;
+			schedule_delayed_work(&wdd->work,
+					msecs_to_jiffies(wdd->hw_heartbeat));
+		}
+
+		return ret;
+	}
 
 	if (watchdog_policy_stop && watchdog_hw_active(wdd))
 		return watchdog_stop(wdd);
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ac17668..0310eda 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -122,6 +122,10 @@ int watchdog_start(struct watchdog_device *wddev)
 		set_bit(WDOG_ACTIVE, &wddev->status);
 
 out_started:
+	/* Once we open the device, early timeout can be disabled */
+	if (wddev->early_timeout_sec >= 0 && watchdog_dev_open(wddev))
+		wddev->early_timeout_sec = -1;
+
 out_no_start:
 	mutex_unlock(&wddev->lock);
 	return err;
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 03f0553..b746f7c 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -96,6 +96,7 @@ struct watchdog_device {
 	struct mutex lock;
 	struct delayed_work work;  /* keepalive worker */
 	unsigned long int expires; /* for keepalive worker */
+	int early_timeout_sec;
 	unsigned long status;
 /* Bit numbers for status flags */
 #define WDOG_ACTIVE		0	/* Is the watchdog hw running/active */
-- 
2.1.0

