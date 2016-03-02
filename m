Return-path: <hidehiro.kawai.ez@hitachi.com>
Subject: [v2 PATCH 1/3] panic: Change nmi_panic from macro to function
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Mingarelli <thomas.mingarelli@hpe.com>,
        Wim Van Sebroeck <wim@iguana.be>, Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Javi Merino <javi.merino@arm.com>, Michal Hocko <mhocko@suse.com>,
        linux-watchdog@vger.kernel.org,
        "Steven Rostedt \(Red Hat\)" <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, Michal Nazarewicz <mina86@mina86.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        Borislav Petkov <bp@alien8.de>,
        Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
        Tejun Heo <tj@kernel.org>, Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
        openipmi-developer@lists.sourceforge.net, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guenter Roeck <linux@roeck-us.net>
Date: Wed, 02 Mar 2016 19:36:26 +0900
Message-ID: <20160302103626.5058.74361.stgit@softrs>
In-Reply-To: <20160302103624.5058.35844.stgit@softrs>
References: <20160302103624.5058.35844.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Change nmi_panic() macro to a normal function for the portability.
Also, export it for modules.

Signed-off-by: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Cc: Javi Merino <javi.merino@arm.com>
Cc: Gobinda Charan Maji <gobinda.cemk07@gmail.com>
Cc: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: Tejun Heo <tj@kernel.org>
---
 include/linux/kernel.h |   22 ++--------------------
 kernel/panic.c         |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f31638c..daf233f 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -255,7 +255,8 @@ extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...)
 	__noreturn __cold;
-void nmi_panic_self_stop(struct pt_regs *);
+__printf(2, 3)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...);
 extern void oops_enter(void);
 extern void oops_exit(void);
 void print_oops_end_marker(void);
@@ -455,25 +456,6 @@ extern atomic_t panic_cpu;
 #define PANIC_CPU_INVALID	-1
 
 /*
- * A variant of panic() called from NMI context. We return if we've already
- * panicked on this CPU. If another CPU already panicked, loop in
- * nmi_panic_self_stop() which can provide architecture dependent code such
- * as saving register state for crash dump.
- */
-#define nmi_panic(regs, fmt, ...)					\
-do {									\
-	int old_cpu, cpu;						\
-									\
-	cpu = raw_smp_processor_id();					\
-	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);	\
-									\
-	if (old_cpu == PANIC_CPU_INVALID)				\
-		panic(fmt, ##__VA_ARGS__);				\
-	else if (old_cpu != cpu)					\
-		nmi_panic_self_stop(regs);				\
-} while (0)
-
-/*
  * Only to be used by arch init code. If the user over-wrote the default
  * CONFIG_PANIC_TIMEOUT, honor it.
  */
diff --git a/kernel/panic.c b/kernel/panic.c
index d96469d..fb61e54 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -72,6 +72,32 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
 
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
+/*
+ * A variant of panic() called from NMI context. We return if we've already
+ * panicked on this CPU. If another CPU already panicked, loop in
+ * nmi_panic_self_stop() which can provide architecture dependent code such
+ * as saving register state for crash dump.
+ */
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
+{
+	static char buf[1024]; /* protected by panic_cpu */
+	va_list args;
+	int old_cpu, cpu;
+
+	cpu = raw_smp_processor_id();
+	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
+
+	if (old_cpu == PANIC_CPU_INVALID) {
+		va_start(args, fmt);
+		vsnprintf(buf, sizeof(buf), fmt, args);
+		va_end(args);
+
+		panic("%s", buf);
+	} else if (old_cpu != cpu)
+		nmi_panic_self_stop(regs);
+}
+EXPORT_SYMBOL(nmi_panic);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print
