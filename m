Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34248 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753585AbdCBAWs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 19:22:48 -0500
Received: by mail-qk0-f172.google.com with SMTP id s186so98858101qkb.1
        for <linux-watchdog@vger.kernel.org>; Wed, 01 Mar 2017 16:22:11 -0800 (PST)
From: Laura Abbott <labbott@redhat.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
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
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jessica Yu <jeyu@redhat.com>, Takashi Iwai <tiwai@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCHv2 08/14] intel_th: Use set_memory.h header
Date: Wed,  1 Mar 2017 16:15:00 -0800
Message-Id: <1488413706-9739-9-git-send-email-labbott@redhat.com>
In-Reply-To: <1488413706-9739-1-git-send-email-labbott@redhat.com>
References: <1488413706-9739-1-git-send-email-labbott@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


set_memory_* functions have moved to set_memory.h. Switch to this
explicitly.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index e88afe1..f0e36c8 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -27,7 +27,7 @@
 #include <linux/io.h>
 #include <linux/dma-mapping.h>
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 #include "intel_th.h"
 #include "msu.h"
-- 
2.7.4

