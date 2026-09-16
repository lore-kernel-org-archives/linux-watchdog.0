Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5150D49F10E;
	Wed, 16 Sep 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583443; cv=none; b=SIBoMObit0QNK9aqfJJYqper8iD0vbu3ijLi5SHuzBa3v+7+UY+f83PdYuhbbWjO6nJJ0u8/st+ec6jXH7qksJlf9hwC5LXElA4p91832radWCBOXyQrtM7zi/F24ToaAIAo7TQi80e0xb2ZwqIt9Jb9tr1sjsV6zefT0uVW61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583443; c=relaxed/simple;
	bh=HYrnP/UY/JSQyUQ/S+6h6FZeJGu4BlLn4CGWcriONE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVZP6MyJzpL4CBKOO+flPhyTmiG2BVF3eWYlvkPB036AiFHwSa1y1J6tRZmXly95nt/y/LnMDoTeQZkS5kgntKp7qDSilbFf47BnMcjT4rEFDyOlwCvrIiCE344eYaB7rc19r9vfyrhd6JW3pGhCoR77gtUcwM/y/n0hDi0lCuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
From: Bradley Morgan <brads@mainlining.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Craig Lamparter <craig.lamparter@hpe.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <brads@mainlining.org>
Subject: [PATCH v7 6/6] panic: kill the "buffer unavailable" redirect fallback
Date: Wed, 16 Sep 2026 18:29:57 +0000
Message-ID: <20260916182957.7788-7-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260916182957.7788-1-brads@mainlining.org>
References: <20260916182957.7788-1-brads@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The redirect buffer is a disgusting terrible hack. panic_force_buf is
kmalloc'ed in a late_initcall, and until then the redirect delivers
this as the panic message:

  Redirected panic (buffer unavailable)

The whole point of the redirect is to hand the panic message to the
target CPU, so the crash kernel boots knowing it panicked and not why.
And that window is the entire boot, from the early_param to the
late_initcall, which is exactly when you most want the message.

Make it a static 1KB buffer and kill the initcall. The cost is 1KB of
.bss in SMP crash dump builds, and it is only ever touched when
panic_force_cpu= is set anyway. The local msg variable is gone too,
the buffer goes directly to panic_smp_redirect_cpu().

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/panic.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 29c981926f5f..170744163fc2 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -307,7 +307,7 @@ atomic_t panic_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 atomic_t panic_redirect_cpu = ATOMIC_INIT(PANIC_CPU_INVALID);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_CRASH_DUMP)
-static char *panic_force_buf;
+static char panic_force_buf[PANIC_MSG_BUFSZ];
 
 static int __init panic_force_cpu_setup(char *str)
 {
@@ -326,17 +326,6 @@ static int __init panic_force_cpu_setup(char *str)
 }
 early_param("panic_force_cpu", panic_force_cpu_setup);
 
-static int __init panic_force_cpu_late_init(void)
-{
-	if (panic_force_cpu < 0)
-		return 0;
-
-	panic_force_buf = kmalloc(PANIC_MSG_BUFSZ, GFP_KERNEL);
-
-	return 0;
-}
-late_initcall(panic_force_cpu_late_init);
-
 static void do_panic_on_target_cpu(void *info)
 {
 	panic("%s", (char *)info);
@@ -380,7 +369,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 {
 	int this_cpu = raw_smp_processor_id();
 	int old_cpu = PANIC_CPU_INVALID;
-	const char *msg;
+	va_list ap;
 
 	/* Feature not enabled via boot parameter */
 	if (panic_force_cpu < 0)
@@ -413,20 +402,11 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		return old_cpu != this_cpu;
 
 	/*
-	 * Use dynamically allocated buffer if available, otherwise
-	 * fall back to static message for early boot panics or allocation failure.
+	 * Do not consume args, the caller reuses them if we fail.
 	 */
-	if (panic_force_buf) {
-		va_list ap;
-
-		/* Do not consume args, the caller reuses it if we fail */
-		va_copy(ap, args);
-		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
-		va_end(ap);
-		msg = panic_force_buf;
-	} else {
-		msg = "Redirected panic (buffer unavailable)";
-	}
+	va_copy(ap, args);
+	vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
+	va_end(ap);
 
 	console_verbose();
 	bust_spinlocks(1);
@@ -441,7 +421,7 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		dump_stack();
 	}
 
-	if (panic_smp_redirect_cpu(panic_force_cpu, (void *)msg) != 0) {
+	if (panic_smp_redirect_cpu(panic_force_cpu, panic_force_buf) != 0) {
 		atomic_set(&panic_redirect_cpu, PANIC_CPU_INVALID);
 		pr_warn("panic: failed to redirect to CPU %d, continuing on CPU %d\n",
 			panic_force_cpu, this_cpu);
-- 
2.47.3

