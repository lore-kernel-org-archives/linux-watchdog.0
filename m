Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20140817173034.662853063@linux.com>
Date: Sun, 17 Aug 2014 12:30:34 -0500
From: Christoph Lameter <cl@linux.com>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 11/35] [PATCH 11/36] watchdog: Replace __raw_get_cpu_var uses
References: <20140817173023.439660246@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=0011-watchdog-Replace-__raw_get_cpu_var-uses.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Most of these are the uses of &__raw_get_cpu_var for address calculation.

touch_softlockup_watchdog_sync() uses __raw_get_cpu_var to write to
per cpu variables. Use __this_cpu_write instead.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Christoph Lameter <cl@linux.com>
---
 kernel/watchdog.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux/kernel/watchdog.c
===================================================================
--- linux.orig/kernel/watchdog.c
+++ linux/kernel/watchdog.c
@@ -185,7 +185,7 @@ void touch_nmi_watchdog(void)
 	 * case we shouldn't have to worry about the watchdog
 	 * going off.
 	 */
-	__raw_get_cpu_var(watchdog_nmi_touch) = true;
+	raw_cpu_write(watchdog_nmi_touch, true);
 	touch_softlockup_watchdog();
 }
 EXPORT_SYMBOL(touch_nmi_watchdog);
@@ -194,8 +194,8 @@ EXPORT_SYMBOL(touch_nmi_watchdog);
 
 void touch_softlockup_watchdog_sync(void)
 {
-	__raw_get_cpu_var(softlockup_touch_sync) = true;
-	__raw_get_cpu_var(watchdog_touch_ts) = 0;
+	__this_cpu_write(softlockup_touch_sync, true);
+	__this_cpu_write(watchdog_touch_ts, 0);
 }
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
@@ -387,7 +387,7 @@ static void watchdog_set_prio(unsigned i
 
 static void watchdog_enable(unsigned int cpu)
 {
-	struct hrtimer *hrtimer = &__raw_get_cpu_var(watchdog_hrtimer);
+	struct hrtimer *hrtimer = raw_cpu_ptr(&watchdog_hrtimer);
 
 	/* kick off the timer for the hardlockup detector */
 	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -407,7 +407,7 @@ static void watchdog_enable(unsigned int
 
 static void watchdog_disable(unsigned int cpu)
 {
-	struct hrtimer *hrtimer = &__raw_get_cpu_var(watchdog_hrtimer);
+	struct hrtimer *hrtimer = raw_cpu_ptr(&watchdog_hrtimer);
 
 	watchdog_set_prio(SCHED_NORMAL, 0);
 	hrtimer_cancel(hrtimer);
@@ -534,7 +534,7 @@ static struct smp_hotplug_thread watchdo
 
 static void restart_watchdog_hrtimer(void *info)
 {
-	struct hrtimer *hrtimer = &__raw_get_cpu_var(watchdog_hrtimer);
+	struct hrtimer *hrtimer = raw_cpu_ptr(&watchdog_hrtimer);
 	int ret;
 
 	/*
