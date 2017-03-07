Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36357 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932867AbdCGVbr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 7 Mar 2017 16:31:47 -0500
Received: by mail-qk0-f181.google.com with SMTP id 1so26981820qkl.3
        for <linux-watchdog@vger.kernel.org>; Tue, 07 Mar 2017 13:31:46 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
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
        Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCHv3 12/16] PM / hibernate: Use set_memory.h header
Date: Tue,  7 Mar 2017 12:55:29 -0800
Message-Id: <1488920133-27229-13-git-send-email-labbott@redhat.com>
In-Reply-To: <1488920133-27229-1-git-send-email-labbott@redhat.com>
References: <1488920133-27229-1-git-send-email-labbott@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v3: #ifdef protection
---
 kernel/power/snapshot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d79a38d..3b1e0f3 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -36,6 +36,9 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
+#ifdef CONFIG_STRICT_KERNEL_RWX
+#include <asm/set_memory.h>
+#endif
 
 #include "power.h"
 
-- 
2.7.4

