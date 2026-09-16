Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415424C2243;
	Wed, 16 Sep 2026 18:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583420; cv=none; b=X2gNEsiJP7U2HucVrdO9ug9oxpL5E6xBWtW5683zuU4sAIHHJXnvQB+WC0SfWu73Gj5uO9EqUrj1mBMaoPAcvxFWLzMwIM0BpXqlNqzF8fBTQ0rZX2KzLY24UtKZ553H2igncqp6NBprgYsfiUEZWUk8KQCLZn5EALEmkLNC47Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583420; c=relaxed/simple;
	bh=dyv4fdkjAz/+IS25pIkAfJLfB8i1e/864CKJn6kTrSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDX0c6z7ZwQP2fPN8DURq9KIHfhnrUazpruqDWnZdG4cZfZpZcd1bxIQskfX7UdY83JruihRpSPzWJfBy9S8vgOpaXHQYKAo8S1DBTj4onLxqqh/hEqNNLObw0fIrWRDtKbvfvS2TJFeareOdFDjXq38Ea3h+1X9KP5vS7FvCUA=
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
Subject: [PATCH v7 4/6] panic: restore variable arguments to nmi_panic()
Date: Wed, 16 Sep 2026 18:29:55 +0000
Message-ID: <20260916182957.7788-5-brads@mainlining.org>
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

nmi_panic() used to accept variable arguments until commit
ebc41f20d77f ("panic: change nmi_panic from macro to function")
flattened it to a final message string. vpanic() did not exist back
then, so the function had to format through panic("%s", msg).

Bring the variable arguments back and format with vpanic() directly.
The next patch makes nmi_panic() try the panic_force_cpu= redirect
before claiming panic_cpu, which needs the arguments twice: once to
format the message for the redirected CPU and once for vpanic() when
no redirect happens. Passing a final string would lose that.

No current caller passes a string with format specifiers. The closest
one is hpwdt_pretimeout(), which builds panic_msg with hex_byte_pack()
and has only two variants, both plain strings. But the new __printf()
annotation on nmi_panic() would warn with -Wformat-security there
because the buffer is passed directly as the format argument, so
switch it to nmi_panic(regs, "%s", panic_msg).

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 drivers/watchdog/hpwdt.c |  2 +-
 include/linux/panic.h    |  3 ++-
 kernel/panic.c           | 10 ++++++++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 8af1fad2de0b..78227d200afe 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -199,7 +199,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	}
 
 	hex_byte_pack(panic_msg, nmistat);
-	nmi_panic(regs, panic_msg);
+	nmi_panic(regs, "%s", panic_msg);
 
 	return NMI_HANDLED;
 }
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 98dd7dfd27de..17e61b61c45f 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -13,7 +13,8 @@ __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 __printf(1, 0)
 void vpanic(const char *fmt, va_list args) __noreturn __cold;
-void nmi_panic(struct pt_regs *regs, const char *msg);
+__printf(2, 3)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
 extern void oops_exit(void);
diff --git a/kernel/panic.c b/kernel/panic.c
index 7388eb81a1c4..e240ca06faab 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -518,13 +518,19 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  * nmi_panic_self_stop() which can provide architecture dependent code such
  * as saving register state for crash dump.
  */
-void nmi_panic(struct pt_regs *regs, const char *msg)
+void nmi_panic(struct pt_regs *regs, const char *fmt, ...)
 {
+	va_list args;
+
+	va_start(args, fmt);
+
 	if (panic_try_start())
-		panic("%s", msg);
+		vpanic(fmt, args);
 
 	if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
+
+	va_end(args);
 }
 EXPORT_SYMBOL(nmi_panic);
 
-- 
2.47.3

