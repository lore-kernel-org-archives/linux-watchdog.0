Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20131219155033.183620013@linux.com>
Date: Thu, 19 Dec 2013 09:50:38 -0600
From: Christoph Lameter <cl@linux.com>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 23/40] watchdog: Replace __raw_get_cpu_var uses
References: <20131219155015.443763038@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=this_watchdog
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

[Patch depends on another patch in this series that introduces raw_cpu_ops]

Most of these are the uses of &__raw_get_cpu_var for address calculation.

touch_softlockup_watchdog_sync() uses __raw_get_cpu_var to write to
per cpu variables. Use __this_cpu_write instead.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Christoph Lameter <cl@linux.com>

Index: linux/kernel/watchdog.c
===================================================================
--- linux.orig/kernel/watchdog.c	2013-12-02 16:07:54.234510172 -0600
+++ linux/kernel/watchdog.c	2013-12-02 16:07:54.234510172 -0600
@@ -174,8 +174,8 @@ EXPORT_SYMBOL(touch_nmi_watchdog);
 
 void touch_softlockup_watchdog_sync(void)
 {
-	__raw_get_cpu_var(softlockup_touch_sync) = true;
-	__raw_get_cpu_var(watchdog_touch_ts) = 0;
+	__this_cpu_write(softlockup_touch_sync, true);
+	__this_cpu_write(watchdog_touch_ts, 0);
 }
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
@@ -341,7 +341,7 @@ static void watchdog_set_prio(unsigned i
 
 static void watchdog_enable(unsigned int cpu)
 {
-	struct hrtimer *hrtimer = &__raw_get_cpu_var(watchdog_hrtimer);
+	struct hrtimer *hrtimer = raw_cpu_ptr(&watchdog_hrtimer);
 
 	/* kick off the timer for the hardlockup detector */
 	hrtimer_init(hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
@@ -361,7 +361,7 @@ static void watchdog_enable(unsigned int
 
 static void watchdog_disable(unsigned int cpu)
 {
-	struct hrtimer *hrtimer = &__raw_get_cpu_var(watchdog_hrtimer);
+	struct hrtimer *hrtimer = raw_cpu_ptr(&watchdog_hrtimer);
 
 	watchdog_set_prio(SCHED_NORMAL, 0);
 	hrtimer_cancel(hrtimer);
@@ -488,7 +488,7 @@ static struct smp_hotplug_thread watchdo
 
 static void restart_watchdog_hrtimer(void *info)
 {
-	struct hrtimer *hrtimer = &__raw_get_cpu_var(watchdog_hrtimer);
+	struct hrtimer *hrtimer = raw_cpu_ptr(&watchdog_hrtimer);
 	int ret;
 
 	/*
