Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7C4D37CB;
	Wed, 16 Sep 2026 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583434; cv=none; b=ngr26X7QYbfOpVoTU3JB0dTdFSh/Y4uTIcQffi7r3K5SIUAI048Sbylst22PF/IWSJWILhMRlkhgYMLo/rq260grPt2wI2N67SarT59Ay3r61c+bj2XsIJk22wgzIYgeLvDZdCsWns/1ubGP3HxLDvY7yZJTrveQsT0F2GsovMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583434; c=relaxed/simple;
	bh=1L0EWxkDhNvr8iX44QENpR0+tXTy2IOKo6E6J3CPJHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTrJrkIal12knp2CUwkBUUExBS5gcBwPK1peuNc+88BzcdpFUoOlgmtmuUK2dH7RaziY7nrMBXt4av8x6OsFHqI7x78RjVPWj+ZRmHjhidfv/b81GYKxtlV/h7rXhrv7O3qXmkS4ojvImcnPYneleUgnzG+t19t45R5E5T11pes=
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
Subject: [PATCH v7 5/6] panic: allow force_cpu redirect from an NMI
Date: Wed, 16 Sep 2026 18:29:56 +0000
Message-ID: <20260916182957.7788-6-brads@mainlining.org>
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

nmi_panic() claims panic_cpu via panic_try_start() before calling
panic(). When the panic later reaches panic_try_force_cpu(), the
panic_in_progress() check sees panic_cpu set and refuses to redirect.
The crash kernel runs on the CPU that took the NMI instead of the CPU
requested with panic_force_cpu=:

  nmi_panic()
    panic_try_start()              wins, panic_cpu = X
    panic("%s", msg)
      vpanic()
        panic_try_force_cpu()
          panic_in_progress()      true, panic_cpu is X
          return false             redirect bypassed
        panic_try_start()          already won
        __crash_kexec()            on X, not the requested CPU

Try the redirect before claiming panic_cpu instead, as suggested by
Petr Mladek. nmi_panic() now calls panic_try_force_cpu() first and
claims panic_cpu only when no redirect happened. The requested CPU
claims panic_cpu itself when it runs panic(), so panic_cpu does not
need to be handed off. panic_try_force_cpu() copies the arguments
before formatting (patch 3), so nmi_panic() can pass them to vpanic()
again when no redirect happens.

The redirect IPI is sent with smp_call_function_single_async(), which
is not guaranteed to work from NMI context. Treat it as best effort.
It is worth the risk because the redirection is only used when the
crash kernel would not work on the panicking CPU anyway.

Keep returning when the panic is already running on this CPU. A
nested NMI, for example with unknown_nmi_panic while this CPU is
inside panic(), must return and let the interrupted panic() continue
instead of parking the CPU in nmi_panic_self_stop().

Mark the redirecting CPU offline before stopping it, like vpanic()
does, so that panic_other_cpus_shutdown() on the target CPU does not
wait for it.

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260708164312.19044-1-include@grrlz.net
Cc: stable@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/panic.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index e240ca06faab..29c981926f5f 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -513,10 +513,11 @@ bool panic_on_other_cpu(void)
 EXPORT_SYMBOL(panic_on_other_cpu);
 
 /*
- * A variant of panic() called from NMI context. We return if we've already
- * panicked on this CPU. If another CPU already panicked, loop in
- * nmi_panic_self_stop() which can provide architecture dependent code such
- * as saving register state for crash dump.
+ * A variant of panic() called from NMI context. The panic is first
+ * redirected to the CPU requested via panic_force_cpu=, when configured.
+ * We return if we've already panicked on this CPU. If another CPU already
+ * panicked, loop in nmi_panic_self_stop() which can provide architecture
+ * dependent code for saving register state for crash dump.
  */
 void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
 {
@@ -524,6 +525,16 @@ void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
 
 	va_start(args, fmt);
 
+	/* Try to redirect to the requested CPU before claiming panic_cpu. */
+	if (panic_try_force_cpu(fmt, args)) {
+		/*
+		 * Mark ourselves offline so panic_other_cpus_shutdown() won't
+		 * wait for us on architectures that check num_online_cpus().
+		 */
+		set_cpu_online(raw_smp_processor_id(), false);
+		nmi_panic_self_stop(regs);
+	}
+
 	if (panic_try_start())
 		vpanic(fmt, args);
 
-- 
2.47.3

