Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail9.hitachi.co.jp ([133.145.228.44]:44304 "EHLO
	mail9.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757014AbcCCLD3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Mar 2016 06:03:29 -0500
Subject: [v3 PATCH 1/3] panic: Change nmi_panic from macro to function
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Mingarelli <thomas.mingarelli@hpe.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Corey Minyard <minyard@acm.org>
From: Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>
Cc: Javi Merino <javi.merino@arm.com>, Michal Hocko <mhocko@suse.com>,
	linux-watchdog@vger.kernel.org,
	"Steven Rostedt \(Red Hat\)" <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org,
	Michal Nazarewicz <mina86@mina86.com>,
	Michal Hocko <mhocko@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
	Borislav Petkov <bp@alien8.de>,
	Gobinda Charan Maji <gobinda.cemk07@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Nicolas Iooss <nicolas.iooss_linux@m4x.org>,
	openipmi-developer@lists.sourceforge.net,
	Borislav Petkov <bp@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guenter Roeck <linux@roeck-us.net>
Date: Thu, 03 Mar 2016 19:57:44 +0900
Message-ID: <20160303105744.4587.1001.stgit@softrs>
In-Reply-To: <20160303105741.4587.49047.stgit@softrs>
References: <20160303105741.4587.49047.stgit@softrs>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Change nmi_panic() macro to a normal function for the portability.
Also, export it for modules.

Changes since v2:
- Make nmi_panic receive a single string instead of printf style args

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
 include/linux/kernel.h |   21 +--------------------
 kernel/panic.c         |   20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f31638c..cbe7d70 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -255,7 +255,7 @@ extern long (*panic_blink)(int state);
 __printf(1, 2)
 void panic(const char *fmt, ...)
 	__noreturn __cold;
-void nmi_panic_self_stop(struct pt_regs *);
+void nmi_panic(struct pt_regs *regs, const char *msg);
 extern void oops_enter(void);
 extern void oops_exit(void);
 void print_oops_end_marker(void);
@@ -455,25 +455,6 @@ extern atomic_t panic_cpu;
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
index d96469d..8abfc30 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -72,6 +72,26 @@ void __weak nmi_panic_self_stop(struct pt_regs *regs)
 
 atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
+/*
+ * A variant of panic() called from NMI context. We return if we've already
+ * panicked on this CPU. If another CPU already panicked, loop in
+ * nmi_panic_self_stop() which can provide architecture dependent code such
+ * as saving register state for crash dump.
+ */
+void nmi_panic(struct pt_regs *regs, const char *msg)
+{
+	int old_cpu, cpu;
+
+	cpu = raw_smp_processor_id();
+	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, cpu);
+
+	if (old_cpu == PANIC_CPU_INVALID)
+		panic("%s", msg);
+	else if (old_cpu != cpu)
+		nmi_panic_self_stop(regs);
+}
+EXPORT_SYMBOL(nmi_panic);
+
 /**
  *	panic - halt the system
  *	@fmt: The text string to print


