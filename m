Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from am1ehsobe003.messaging.microsoft.com ([213.199.154.206]:28330
	"EHLO AM1EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752851Ab0ITQiv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 20 Sep 2010 12:38:51 -0400
From: Timur Tabi <timur@freescale.com>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org,
	jwboyer@gmail.com
Subject: [PATCH 1/2] [v2] powerpc: export ppc_proc_freq and ppc_tb_freq as GPL symbols
Date: Mon, 20 Sep 2010 11:23:41 -0500
Message-ID: <1284999822-24753-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Export the global variable 'ppc_tb_freq', so that modules (like the Book-E
watchdog driver) can use it.  To maintain consistency, ppc_proc_freq is changed
to a GPL-only export.  This is okay, because any module that needs this symbol
should be an actual Linux driver, which must be GPL-licensed.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This export is necessary for the Book-E watchdog driver to be compiled as a
module.

 arch/powerpc/kernel/time.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 8533b3b..0c0c241 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -161,8 +161,9 @@ extern struct timezone sys_tz;
 static long timezone_offset;
 
 unsigned long ppc_proc_freq;
-EXPORT_SYMBOL(ppc_proc_freq);
+EXPORT_SYMBOL_GPL(ppc_proc_freq);
 unsigned long ppc_tb_freq;
+EXPORT_SYMBOL_GPL(ppc_tb_freq);
 
 static DEFINE_PER_CPU(u64, last_jiffy);
 
-- 
1.7.2.3


