Return-path: <niklas.cassel@axis.com>
From: Niklas Cassel <niklas.cassel@axis.com>
To: <wim@iguana.be>, <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<peterz@infradead.org>, <edumazet@google.com>,
	Niklas Cassel <niklass@axis.com>
Subject: [PATCH v2] watchdog: softdog: fire watchdog even if softirqs do not get to run
Date: Mon, 27 Feb 2017 13:49:09 +0100
Message-ID: <1488199749-10603-1-git-send-email-niklass@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

From: Niklas Cassel <niklas.cassel@axis.com>

Checking for timer expiration is done from the softirq TIMER_SOFTIRQ.

Since commit 4cd13c21b207 ("softirq: Let ksoftirqd do its job"),
pending softirqs are no longer always handled immediately, instead,
if there are pending softirqs, and ksoftirqd is in state TASK_RUNNING,
the handling of the softirqs are deferred, and are instead supposed
to be handled by ksoftirqd, when ksoftirqd gets scheduled.

If a user space process with a real-time policy starts to misbehave
by never relinquishing the CPU while ksoftirqd is in state TASK_RUNNING,
what will happen is that all softirqs will get deferred, while ksoftirqd,
which is supposed to handle the deferred softirqs, will never get to run.

To make sure that the watchdog is able to fire even when we do not get
to run softirqs, replace the timers with hrtimers.

Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
---
Changes since v1
 * Rebased patch, since a patch conflicting with v1 has been merged.

 drivers/watchdog/softdog.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 7983029852ab..060740625485 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -21,13 +21,12 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/hrtimer.h>
 #include <linux/init.h>
-#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/reboot.h>
-#include <linux/timer.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -54,7 +53,10 @@ module_param(soft_panic, int, 0);
 MODULE_PARM_DESC(soft_panic,
 	"Softdog action, set to 1 to panic, 0 to reboot (default=0)");
 
-static void softdog_fire(unsigned long data)
+static struct hrtimer softdog_ticktock;
+static struct hrtimer softdog_preticktock;
+
+static enum hrtimer_restart softdog_fire(struct hrtimer *timer)
 {
 	module_put(THIS_MODULE);
 	if (soft_noboot) {
@@ -67,32 +69,33 @@ static void softdog_fire(unsigned long data)
 		emergency_restart();
 		pr_crit("Reboot didn't ?????\n");
 	}
-}
 
-static struct timer_list softdog_ticktock =
-		TIMER_INITIALIZER(softdog_fire, 0, 0);
+	return HRTIMER_NORESTART;
+}
 
 static struct watchdog_device softdog_dev;
 
-static void softdog_pretimeout(unsigned long data)
+static enum hrtimer_restart softdog_pretimeout(struct hrtimer *timer)
 {
 	watchdog_notify_pretimeout(&softdog_dev);
-}
 
-static struct timer_list softdog_preticktock =
-		TIMER_INITIALIZER(softdog_pretimeout, 0, 0);
+	return HRTIMER_NORESTART;
+}
 
 static int softdog_ping(struct watchdog_device *w)
 {
-	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
+	if (!hrtimer_active(&softdog_ticktock))
 		__module_get(THIS_MODULE);
+	hrtimer_start(&softdog_ticktock, ktime_set(w->timeout, 0),
+		      HRTIMER_MODE_REL);
 
 	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)) {
 		if (w->pretimeout)
-			mod_timer(&softdog_preticktock, jiffies +
-				  (w->timeout - w->pretimeout) * HZ);
+			hrtimer_start(&softdog_preticktock,
+				      ktime_set(w->timeout - w->pretimeout, 0),
+				      HRTIMER_MODE_REL);
 		else
-			del_timer(&softdog_preticktock);
+			hrtimer_cancel(&softdog_preticktock);
 	}
 
 	return 0;
@@ -100,11 +103,11 @@ static int softdog_ping(struct watchdog_device *w)
 
 static int softdog_stop(struct watchdog_device *w)
 {
-	if (del_timer(&softdog_ticktock))
+	if (hrtimer_cancel(&softdog_ticktock))
 		module_put(THIS_MODULE);
 
 	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT))
-		del_timer(&softdog_preticktock);
+		hrtimer_cancel(&softdog_preticktock);
 
 	return 0;
 }
@@ -136,8 +139,15 @@ static int __init softdog_init(void)
 	watchdog_set_nowayout(&softdog_dev, nowayout);
 	watchdog_stop_on_reboot(&softdog_dev);
 
-	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT))
+	hrtimer_init(&softdog_ticktock, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	softdog_ticktock.function = softdog_fire;
+
+	if (IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)) {
 		softdog_info.options |= WDIOF_PRETIMEOUT;
+		hrtimer_init(&softdog_preticktock, CLOCK_MONOTONIC,
+			     HRTIMER_MODE_REL);
+		softdog_preticktock.function = softdog_pretimeout;
+	}
 
 	ret = watchdog_register_device(&softdog_dev);
 	if (ret)
-- 
2.1.4
