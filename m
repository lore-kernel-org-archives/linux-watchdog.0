Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Stephane Eranian <eranian@google.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] watchdog: Move NMI function header declarations from watchdog.h to nmi.h
Date: Tue, 28 Jul 2015 18:02:16 -0700
Message-Id: <1438131736-7175-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The kernel's NMI watchdog has nothing to do with the watchdog
subsystem. Its header declarations are in linux/nmi.h, not in
linux/watchdog.h.

The code provided two sets of dummy functions if HARDLOCKUP_DETECTOR
is not configured, one in the include file and one in kernel/watchdog.c.
Remove the dummy functions from kernel/watchdog.c and use those from
the include file.

Cc: Stephane Eranian <eranian@google.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Remove duplicate dummy functions from kernel/watchdog.c.

 arch/x86/kernel/cpu/perf_event_intel.c | 2 +-
 include/linux/nmi.h                    | 8 +++++---
 include/linux/watchdog.h               | 8 --------
 kernel/watchdog.c                      | 2 --
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel.c b/arch/x86/kernel/cpu/perf_event_intel.c
index b9826a981fb2..415f6b26f4b6 100644
--- a/arch/x86/kernel/cpu/perf_event_intel.c
+++ b/arch/x86/kernel/cpu/perf_event_intel.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <linux/watchdog.h>
+#include <linux/nmi.h>
 
 #include <asm/cpufeature.h>
 #include <asm/hardirq.h>
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index f94da0e65dea..088714537d10 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -26,10 +26,12 @@ static inline void touch_nmi_watchdog(void)
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR)
 extern void hardlockup_detector_disable(void);
+void watchdog_nmi_disable_all(void);
+void watchdog_nmi_enable_all(void);
 #else
-static inline void hardlockup_detector_disable(void)
-{
-}
+static inline void hardlockup_detector_disable(void) {}
+static inline void watchdog_nmi_disable_all(void) {}
+static inline void watchdog_nmi_enable_all(void) {}
 #endif
 
 /*
diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index f47feada5b42..d74a0e907b9e 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -140,12 +140,4 @@ extern int watchdog_init_timeout(struct watchdog_device *wdd,
 extern int watchdog_register_device(struct watchdog_device *);
 extern void watchdog_unregister_device(struct watchdog_device *);
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
-void watchdog_nmi_disable_all(void);
-void watchdog_nmi_enable_all(void);
-#else
-static inline void watchdog_nmi_disable_all(void) {}
-static inline void watchdog_nmi_enable_all(void) {}
-#endif
-
 #endif  /* ifndef _LINUX_WATCHDOG_H */
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index a6ffa43f2993..33c98fe665da 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -651,8 +651,6 @@ unlock:
 #else
 static int watchdog_nmi_enable(unsigned int cpu) { return 0; }
 static void watchdog_nmi_disable(unsigned int cpu) { return; }
-void watchdog_nmi_enable_all(void) {}
-void watchdog_nmi_disable_all(void) {}
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 static struct smp_hotplug_thread watchdog_threads = {
-- 
2.1.4
