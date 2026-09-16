Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E899F4CEE71;
	Wed, 16 Sep 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583435; cv=none; b=RknWeCROVQkUOMfudlPvSZqOOGva3Y4lsZCvsVy6ZnCwFKeQCtvBaQOqfCeqKCoz1nwn4kIAzRCvlx6puYplQCIgyisHYIRpiQ01v9WZpMCfUedqR0N7l+P0UstyF3AM1Lgf72RMSiFaBCgavCy02ke9JRf3EcfJMxzGzUTfZ0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583435; c=relaxed/simple;
	bh=hEm57w3U1srjrUXVgnFd75veH+GaeujpYLvRzttPDwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUwI5yDoD/0f+WyEOcxhnefLWMgIHNOtIIh8sAXXP41wA7HrBPpCmMLAZXKhiwm/td3UMdJWzzL3M0x1MkYDO413NGiCpp+i5+5rkeY+Qd5tbllCdXlx3NFkqWrV3LgXDzaY9K2Uxx5IVF+8QRLD01RwcmU+UEIJJEuqEZwVEoI=
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
Subject: [PATCH v7 3/6] panic: fix va_list reuse in panic_try_force_cpu()
Date: Wed, 16 Sep 2026 18:29:54 +0000
Message-ID: <20260916182957.7788-4-brads@mainlining.org>
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

vsnprintf() consumes the caller's va_list. When the redirect fails,
vpanic() reuses it for the panic message, which is undefined
behavior. Use va_copy().

Fixes: 2e171ab29f91 ("panic: add panic_force_cpu= parameter to redirect panic to a specific CPU")
Cc: stable@vger.kernel.org
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/panic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 5646d4fb82b7..7388eb81a1c4 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -417,7 +417,12 @@ static bool panic_try_force_cpu(const char *fmt, va_list args)
 	 * fall back to static message for early boot panics or allocation failure.
 	 */
 	if (panic_force_buf) {
-		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, args);
+		va_list ap;
+
+		/* Do not consume args, the caller reuses it if we fail */
+		va_copy(ap, args);
+		vsnprintf(panic_force_buf, PANIC_MSG_BUFSZ, fmt, ap);
+		va_end(ap);
 		msg = panic_force_buf;
 	} else {
 		msg = "Redirected panic (buffer unavailable)";
-- 
2.47.3

