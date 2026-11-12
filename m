Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453407;
	b=ne9oylDYIEEERhqqwTuBBYZPnVCnLG60+AyGC1AIcsw2y5lovGlKiKbZBkQyF8HX8z/z
	 n0M9fMh4WGpKTCuY8q+tO175gR/kNDtZ+H6hAyvA6BMDO04xXAau188qw3QUWkOU592BT
	 H5pyx8GHMFJ9gJswHegDO7j7S4cfBZ76QTLHnDgeA7HsiHxiuSwJmuMlDo5bLYjZ5S9Ne
	 +g9EZBWp+F86OsSeEsyDMcMvqNK5kkWtmjTbC5iH7DBg78i85jV6TKOcn+96rsrpqfRKP
	 KAdM6XSWL9cp4bNQFI7s+mNS47rR/80aCrhrrGXLqwKUBxvGQBaFTOXumhRmWyvptJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=hWKawNdn0hEGYVFD9BxgfOol/1CwMbnzrNRl9vbJ07E=;
	b=2W9OLCF5rEYnlbqyP+t2O9/m3h/AKN8UZWVETuYQCPdJgi+OM8qRe3JxdilRvqWG/Zf2
	 Onk3lcUmH5kyRRDGpRfzmgCjN55j5LJ8Vg9SICv0Zfmq9SHbaNAjGGo4B/ViyJoDPSqe4
	 +wpcKVAQPfIq//7TniKWkhxaXvjNdrPzow7ZZOYQK2NnnBvoQwJoKiMCqDMG1c79BXaNj
	 MxSNil07Z6E4+9nQsHy9Y7iqkjf+wfCKbLFkpEnoa0hJRR7+qUPsecDXCeDTxnwgqVToS
	 z3PQGCDvmKvDL0T+ZXELi9N6i+XlHxTGf4vRB7uDLD+UomHmIrXIABf8x7JAAoOYOhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Ea/4LJ9Z";
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32160A260A
	for <linux-watchdog@vger.kernel.org>; Thu, 12 Nov 2026 03:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F32160A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mrungta.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ea/4LJ9Z
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so6300782eec.1
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 19:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794453405; x=1795058205; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hWKawNdn0hEGYVFD9BxgfOol/1CwMbnzrNRl9vbJ07E=;
        b=Ea/4LJ9Znxf+/qcCYyUIdcKwbpGKvfC60TUIuO/uVVJ0/eB+rPYs+bR1sTYDqnwMuL
         PWwwLjI9bdrFjY0VMhep+ociG/QLkAFmjhGcya0Ry/enx4auK3iUDRMS22ZjPrV0ctXZ
         liVO8HnuhUwtgaY6Cj63YQ5Mh/cncnMPEg9PjhvH+2ltRF7VoYatOvoYMCx+Sqh6w/aT
         WMy9Uus5GmaOHankSoEHnd8jV1Tg5WjztTLABi8kiuiXGbyi9btMBnRyrwS1UKP/XUfT
         mmFtiN1uymkVlmW0MqOGxCzdNDeTbNy4nMKhLssxXOlvvcaIV/2yD5yLl7ouZeUrzHyh
         E8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794453405; x=1795058205;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hWKawNdn0hEGYVFD9BxgfOol/1CwMbnzrNRl9vbJ07E=;
        b=YQpJc6UW6Qt58lutuOsipvgxbys37J2Z8KLvvo1heI9S3HQ5cWiRccHzFbydiKHAk2
         8hJ63Qz9/a16+iY0GRMd6O6Satb6j2y5hNglKFZ4NPP/B5bTNhyB1I+iz6skzvc7V0E9
         t9wXV1w8QeWHO5VlzaQrK/OmOCLNbfX6Zi65rZH5T6+R6+ywsMgC2i/gGc8WYUiGeOqH
         HblwF2NbOIo6W8NAkRNnJ5YJ9uIef/YOrJgWLuJpRfjSrkcDTxzoQZISw01GU8ACO+wP
         Oiz4uo88dh4QAxNzE+08fLcHly9llz2VhSH73dwTcvY/QPKzxqdadHYqZuYPVH+QGCyN
         eiMA==
X-Forwarded-Encrypted: i=1; AL+hErE60/hSqq9e5YxTxDXQaCdpFJSsqhDFX8hrVsbik+aT3q2iYn+8Wh+LOl5K4FPfmTBydhh6SDJrc8izs91DAQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Gjx3HqO8PcM2LBg2sz3WrC7o5qF7Nr7rsSmx2hYfbOMJutoKx
	vzf6PyZSUKAc53QgBdv61z39qdgMp6LoQBCqbjmL7s1G5QCtaC5889IeSbRqpaEPd3RfQSLIb6I
	izKnzkw45xQ==
X-Received: from dybry8.prod.google.com ([2002:a05:7301:4d08:b0:35f:390d:248a])
 (user=mrungta job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:87c1:20b0:36c:c483:7077
 with SMTP id 5a478bee46e88-377abbd9353mr1683715eec.14.1794453405137; Wed, 11
 Nov 2026 19:16:45 -0800 (PST)
Date: Wed, 11 Nov 2026 19:16:28 -0800
In-Reply-To: <20261112031629.396819-1-mrungta@google.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261112031629.396819-1-mrungta@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261112031629.396819-7-mrungta@google.com>
Subject: [PATCH v4 6/7] watchdog: pretimeout_panic: Use nmi_panic() when
 invoked from NMI context
From: Mayank Rungta <mrungta@google.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: Marc Zyngier <maz@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, "Kirill A . Shutemov" <kas@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>
Content-Type: text/plain; charset="UTF-8"

When a watchdog pretimeout interrupt is registered as an NMI (or
pseudo-NMI), pretimeout_panic() executes in NMI context. Calling plain
panic() from NMI context is unsafe if the current CPU was already inside
vpanic() with regular interrupts disabled (where the watchdog is no
longer fed): vpanic() assumes panic_cpu == raw_smp_processor_id() only
occurs when entered via nmi_panic(), so it falls through into a
recursive panic on the same CPU, corrupting the static panic buffer,
panic notifiers, and crash dump state.

Invoke nmi_panic() when in_nmi() is true so that an NMI interrupting a
CPU that is already panicking safely returns, or stops via
nmi_panic_self_stop() if another CPU is panicking.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 drivers/watchdog/pretimeout_panic.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
index 8c3ac674dc45..634ae3b6c961 100644
--- a/drivers/watchdog/pretimeout_panic.c
+++ b/drivers/watchdog/pretimeout_panic.c
@@ -5,7 +5,10 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/panic.h>
+#include <linux/preempt.h>
 #include <linux/watchdog.h>
+#include <asm/irq_regs.h>
 
 #include "watchdog_pretimeout.h"
 
@@ -17,7 +20,10 @@
  */
 static void pretimeout_panic(struct watchdog_device *wdd)
 {
-	panic("watchdog pretimeout event\n");
+	if (in_nmi())
+		nmi_panic(get_irq_regs(), "watchdog pretimeout event\n");
+	else
+		panic("watchdog pretimeout event\n");
 }
 
 static struct watchdog_governor watchdog_gov_panic = {
-- 
2.56.0.611.g1030f0b940-goog

