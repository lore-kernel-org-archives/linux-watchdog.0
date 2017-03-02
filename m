Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34899 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbdCBCv3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 21:51:29 -0500
Received: by mail-qk0-f173.google.com with SMTP id u188so103428055qkc.2
        for <linux-watchdog@vger.kernel.org>; Wed, 01 Mar 2017 18:51:28 -0800 (PST)
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
Subject: [PATCHv2 12/14] PM / hibernate: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:15:04 -0800
Message-Id: <1488413706-9739-13-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 kernel/power/snapshot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 905d5bb..4302815 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/io.h>
+#include <asm/set_memory.h>
 
 #include "power.h"
 
-- 
2.7.4

