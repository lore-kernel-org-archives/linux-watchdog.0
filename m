Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36066 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756537AbdCHABx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 7 Mar 2017 19:01:53 -0500
Received: by mail-qk0-f172.google.com with SMTP id 1so33753636qkl.3
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Mar 2017 16:01:11 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
To: Jessica Yu <jeyu@redhat.com>
Cc: Laura Abbott <labbott@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Takashi Iwai <tiwai@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCHv3 11/16] module: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:28 -0800
Message-Id: <1488920133-27229-12-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Acked-by: Jessica Yu <jeyu@redhat.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: #ifdef protection
---
 kernel/module.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 7eba6de..992a100 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -49,6 +49,9 @@
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#ifdef CONFIG_STRICT_MODULE_RWX
+#include <asm/set_memory.h>
+#endif
 #include <asm/mmu_context.h>
 #include <linux/license.h>
 #include <asm/sections.h>
-- 
2.7.4

