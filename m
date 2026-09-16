Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E928D4D0CDB;
	Wed, 16 Sep 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583435; cv=none; b=RB1KdGFKBOptgP97H7tictzliISA1teMOFTtgepsck+Dvtr+8ocxyhWU13eur5OGYcSdWhsTteWCZMhr3ZaZpOi8ts3msHJ0boXCbYQFJ9OADrcoNCLSVb4OIn2qmqnqA0xy8nW38ZHKlffxueNVfwmzwahFzOCwoXHHtjwDK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583435; c=relaxed/simple;
	bh=pCu8eDaR4ZlUXsDj7+6hsRc7dGWfoLSDSAAuOdPUByE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0h1mNZRUP0a7GUY6TMCZlY671Cg3sYUqTqBVURVJg7xNBAz6M+X50Xo3fCIwgkTtPI7fzqz71UmPFs8Eh6zkIwHXWg1ei/Qn51jE5KKET5Op85kU8om9o4B5zvgkX/F0gotY6uRl0DaKeGxNfa8KQj0g2konUVnRONSVrY7MQs=
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
Subject: [PATCH v7 1/6] panic: fix redirect CPU race in panic_try_force_cpu()
Date: Wed, 16 Sep 2026 18:29:52 +0000
Message-ID: <20260916182957.7788-2-brads@mainlining.org>
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

The cmpxchg() in panic_try_force_cpu() makes sure that only one CPU
tries to redirect panic() to the requested CPU. It is similar to the
cmpxchg() in panic_try_start() which makes sure that only one CPU does
the panic(). In both situations, only the winner of cmpxchg() should
proceed further. Other CPUs should go offline.

There is a bug because the cmpxchg loser returns false and falls through
into vpanic(). Two non-target CPUs A and B panic, the requested CPU is C:

             cpu A                          cpu B
          ----------                     ----------
    panic()                              panic()
    vpanic()                             vpanic()
    panic_try_force_cpu()                panic_try_force_cpu()
        cmpxchg wins                        cmpxchg fails
        redirect = A                        old_cpu = A
        IPI -> C                            return false      <- BUG
        return true                     panic_try_start() wins
    panic_smp_self_stop()                __crash_kexec() on B
    (A stops)                            (target C bypassed)

The loser must stop, not fall through. It cannot just return true,
though. A CPU that already won the redirect cmpxchg can reenter
panic_try_force_cpu() on the same CPU, for example a nested NMI during
the message formatting, before the IPI is sent:

             cpu A (1st)                  cpu A (nested)
          ----------                     ----------
    panic()
    vpanic()
    panic_try_force_cpu()
        cmpxchg wins (redirect = A)
        vsnprintf(msg) ...
            <-- NMI, nested panic -->
                                     panic()
                                     vpanic()
                                     panic_try_force_cpu()
                                         cmpxchg fails
                                         old_cpu == A (this CPU)
                                         return true   <- would halt
                                     panic_smp_self_stop()
                                     (IPI never sent, panic abandoned)

Check old_cpu against this_cpu so a second call from the same CPU
returns false and falls through to panic_try_start() instead.

Also fix the panic_in_progress() check. We must not redirect when
panic_cpu is already assigned. Return true to stop when the panic is on
another CPU, false to proceed when it is this one.

Update the panic_try_force_cpu() doc comment for the new return value
semantics.

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260705164123.18746-1-include@grrlz.net
Closes: https://sashiko.dev/#/patchset/20260707172252.4842-1-include@grrlz.net
Cc: stable@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/panic.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 50715f14cf04..08072bfae422 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -371,8 +371,9 @@ int __weak panic_smp_redirect_cpu(int target_cpu, void *msg)
  * for the crash kernel to function correctly. This function redirects
  * panic handling to the CPU specified via the panic_force_cpu= boot parameter.
  *
- * Returns false if panic should proceed on current CPU.
- * Returns true if panic was redirected.
+ * Returns true when this CPU must stop: the panic was redirected or is
+ * already running on another CPU.
+ * Returns false when panic() should proceed on this CPU.
  */
 __printf(1, 0)
 static bool panic_try_force_cpu(const char *fmt, va_list args)
@@ -396,16 +397,20 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 		return false;
 	}
 
-	/* Another panic already in progress */
+	/*
+	 * Don't redirect when a panic is already in progress. Stop this
+	 * CPU when it's another one, proceed when it's this one.
+	 */
 	if (panic_in_progress())
-		return false;
+		return panic_on_other_cpu();
 
 	/*
-	 * Only one CPU can do the redirect. Use atomic cmpxchg to ensure
-	 * we don't race with another CPU also trying to redirect.
+	 * Only one CPU can do the redirection. Others should go offline.
+	 * Continue with panic() when we already tried the redirection
+	 * from this CPU before, for example via nmi_panic().
 	 */
 	if (!atomic_try_cmpxchg(&panic_redirect_cpu, &old_cpu, this_cpu))
-		return false;
+		return old_cpu != this_cpu;
 
 	/*
 	 * Use dynamically allocated buffer if available, otherwise
-- 
2.47.3

