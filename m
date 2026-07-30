Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BB3921D5;
	Thu, 30 Jul 2026 22:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448827; cv=none; b=qAJ87jvqm4yMrEGmpWRW0eGDpxUBEozv8Dhf5XhMIltB6Q3FeRRpohkh0eb0DFS8igyl2JQuNUWRb5erAbHDKWRnFyMWLj+uF3hihxPnFJTmC6xqfJFd330RDA2rzzNByDCylK9vbJI3zDhAmlLVJGJ3J3gReN2HpQVXngbuzXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448827; c=relaxed/simple;
	bh=EipvQ5mYeuNpcCo3P9FuesFp/O23xmkoDim+IM2CFRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIbv0hWsxDfb8AbtSKBlBEXySZG+BdrNW1ubnVtswhvVpURamJlRj0AfSiN+3fyI4UVpRqe8FiAHU6YZQtR28e8W3PSn1NYyd+QcECqSHp8pqdau4mtFXsvz3zbXWq86kHahYC5g9hLAofWO4UzxiK4IWZ7SbntoHjpnwhzzC3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEJNyTIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEJNyTIc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15798C2BCF7;
	Thu, 30 Jul 2026 22:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785448827;
	bh=EipvQ5mYeuNpcCo3P9FuesFp/O23xmkoDim+IM2CFRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vEJNyTIcW22o103emiXeTC13NUHCOkYNafyzojnF0fqM/wm+JTVnM9S2EprEn0WY/
	 OYgmpKnTu2R+tN/Oilzx7OmTOzkPa/wfOAV17N6Vg69b8sai/2HmlBEYKBvYq7BH3N
	 Ju6uKDFrs4RxAEuJTOTtZ1FcLPfVwFyfEzz9xEaV4Tsd0/7hii8/ZbsqO7Sni3tXqd
	 BHWb4ZA+KmxoqUTxFkT5JLxe2aidW8MPsvl+U9aO6S4MDS3E07bqt+gjWTvnj7zM8l
	 8aw7cod8oYvj+8mGq5dYBl2lMf2csjBqiaRSxRFD/PUYD/VIsOvWljUl3vZXS9MqMJ
	 2x0rpycM9ANwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE70C55167;
	Thu, 30 Jul 2026 22:00:26 +0000 (UTC)
From: Mayank Rungta via B4 Relay <devnull+mrungta.google.com@kernel.org>
Date: Thu, 30 Jul 2026 15:00:21 -0700
Subject: [PATCH 1/2] nmi: Export CPU backtrace APIs for loadable modules
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-export-cpu-backtrace-apis-v1-1-bace8e1cb817@google.com>
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, 
 linux-watchdog@vger.kernel.org, Mayank Rungta <mrungta@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785448826; l=2490;
 i=mrungta@google.com; s=20260212; h=from:subject:message-id;
 bh=yO7dla8OdRAGDJOgeFRh56pLyD/tLBa0X3xKf/FbK2c=;
 b=fZnl8zJuugvMxagsjQCujYIWixxEfkl6fQWt/pxRw9TN04PYzeGTyfG8d0j+mSI25RG/3t5sQ
 A3EFOaEBhxcCMilu55Q9tGaIlQYfPkH423SByvIA7ReoKNK+82UXf4m
X-Developer-Key: i=mrungta@google.com; a=ed25519;
 pk=2Bjwbv/ibL10QnyvK9G7DoKpffXy7z6+M4NawEYgYDI=
X-Endpoint-Received: by B4 Relay for mrungta@google.com/20260212 with
 auth_id=634
X-Original-From: Mayank Rungta <mrungta@google.com>
Reply-To: mrungta@google.com

From: Mayank Rungta <mrungta@google.com>

Currently, CPU backtrace functions cannot be called from loadable
modules because the underlying helper arch_trigger_cpumask_backtrace()
is not exported.

Instead of exporting arch_trigger_cpumask_backtrace() individually
across every supported architecture, introduce and export a common
helper, cpumask_backtrace(), in lib/nmi_backtrace.c. Update the four
inline CPU backtrace macros in include/linux/nmi.h to route through this
centralized helper.

Signed-off-by: Mayank Rungta <mrungta@google.com>
---
 include/linux/nmi.h | 10 ++++++----
 lib/nmi_backtrace.c |  7 +++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 89c5465e2524..af69712df5f4 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -157,27 +157,29 @@ static inline void touch_nmi_watchdog(void)
  * to allow calling code to fall back to some other mechanism:
  */
 #ifdef arch_trigger_cpumask_backtrace
+void cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+
 static inline bool trigger_all_cpu_backtrace(void)
 {
-	arch_trigger_cpumask_backtrace(cpu_online_mask, -1);
+	cpumask_backtrace(cpu_online_mask, -1);
 	return true;
 }
 
 static inline bool trigger_allbutcpu_cpu_backtrace(int exclude_cpu)
 {
-	arch_trigger_cpumask_backtrace(cpu_online_mask, exclude_cpu);
+	cpumask_backtrace(cpu_online_mask, exclude_cpu);
 	return true;
 }
 
 static inline bool trigger_cpumask_backtrace(struct cpumask *mask)
 {
-	arch_trigger_cpumask_backtrace(mask, -1);
+	cpumask_backtrace(mask, -1);
 	return true;
 }
 
 static inline bool trigger_single_cpu_backtrace(int cpu)
 {
-	arch_trigger_cpumask_backtrace(cpumask_of(cpu), -1);
+	cpumask_backtrace(cpumask_of(cpu), -1);
 	return true;
 }
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index a3bfa9360b23..f39c9eca8888 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -19,6 +19,7 @@
 #include <linux/stringify.h>
 #include <linux/nmi.h>
 #include <linux/cpu.h>
+#include <linux/export.h>
 #include <linux/sched/debug.h>
 
 #ifdef arch_trigger_cpumask_backtrace
@@ -129,4 +130,10 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 	return false;
 }
 NOKPROBE_SYMBOL(nmi_cpu_backtrace);
+
+void cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
+{
+	arch_trigger_cpumask_backtrace(mask, exclude_cpu);
+}
+EXPORT_SYMBOL_GPL(cpumask_backtrace);
 #endif

-- 
2.55.0.508.g3f0d502094-goog


