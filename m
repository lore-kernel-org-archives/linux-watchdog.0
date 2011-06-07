Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:62921 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753221Ab1FGOyL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2011 10:54:11 -0400
Date: Tue, 7 Jun 2011 16:54:07 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Donald Johnson <donald.k.johnson@intel.com>
Cc: linux-watchdog@vger.kernel.org, Jesper Juhl <jj@chaosbits.net>
Subject: Fw: [PATCH] Intel SCU Watchdog: Fix build failure and duplicate
	include
Message-ID: <20110607145407.GA12177@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi Alan, Donald,

Can you look at this?

Thanks in advance,
Wim.

----- Forwarded message from Jesper Juhl <jj@chaosbits.net> -----

Delivery-date: Fri, 27 May 2011 04:42:02 +0200
From: Jesper Juhl <jj@chaosbits.net>
To: linux-kernel@vger.kernel.org
cc: linux-watchdog@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Robert Richter <robert.richter@amd.com>,
	Donald Johnson <donald.k.johnson@intel.com>
Subject: [PATCH] Intel SCU Watchdog: Fix build failure and duplicate
	include

Trying to build the Intel SCU Watchdog fails for me with gcc 4.6.0 -
$ gcc --version | head -n 1
gcc (GCC) 4.6.0 20110513 (prerelease)

like this :
  CC      drivers/watchdog/intel_scu_watchdog.o
In file included from drivers/watchdog/intel_scu_watchdog.c:49:0:
/home/jj/src/linux-2.6/arch/x86/include/asm/apb_timer.h: In function =E2=80=
=98apbt_time_init=E2=80=99:
/home/jj/src/linux-2.6/arch/x86/include/asm/apb_timer.h:65:42: warning: =E2=
=80=98return=E2=80=99 with a value, in function returning void [enabled b=
y default]
drivers/watchdog/intel_scu_watchdog.c: In function =E2=80=98intel_scu_wat=
chdog_init=E2=80=99:
drivers/watchdog/intel_scu_watchdog.c:468:2: error: implicit declaration =
of function =E2=80=98sfi_get_mtmr=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]
drivers/watchdog/intel_scu_watchdog.c:468:32: warning: assignment makes p=
ointer from integer without a cast [enabled by default]
cc1: some warnings being treated as errors

make[1]: *** [drivers/watchdog/intel_scu_watchdog.o] Error 1
make: *** [drivers/watchdog/intel_scu_watchdog.o] Error 2

Additionally, linux/types.h is needlessly being included twice in=20
drivers/watchdog/intel_scu_watchdog.c

This patch fixes it all and I can now build the code.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 arch/x86/include/asm/apb_timer.h      |    2 +-
 drivers/watchdog/intel_scu_watchdog.c |    1 -
 drivers/watchdog/intel_scu_watchdog.h |    2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

 Patch has been compile tested only.

diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_=
timer.h
index 2fefa50..af60d8a 100644
--- a/arch/x86/include/asm/apb_timer.h
+++ b/arch/x86/include/asm/apb_timer.h
@@ -62,7 +62,7 @@ extern int sfi_mtimer_num;
 #else /* CONFIG_APB_TIMER */
=20
 static inline unsigned long apbt_quick_calibrate(void) {return 0; }
-static inline void apbt_time_init(void) {return 0; }
+static inline void apbt_time_init(void) { }
=20
 #endif
 #endif /* ASM_X86_APBT_H */
diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/int=
el_scu_watchdog.c
index 919bdd1..ba43860 100644
--- a/drivers/watchdog/intel_scu_watchdog.c
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -42,7 +42,6 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/sfi.h>
-#include <linux/types.h>
 #include <asm/irq.h>
 #include <asm/atomic.h>
 #include <asm/intel_scu_ipc.h>
diff --git a/drivers/watchdog/intel_scu_watchdog.h b/drivers/watchdog/int=
el_scu_watchdog.h
index d2b074a..a9ca0d7 100644
--- a/drivers/watchdog/intel_scu_watchdog.h
+++ b/drivers/watchdog/intel_scu_watchdog.h
@@ -62,5 +62,5 @@ struct intel_scu_watchdog_dev {
=20
 extern int sfi_mtimer_num;
=20
-/* extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint); */
+extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint);
 #endif /* __INTEL_SCU_WATCHDOG_H */


--=20
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.


----- End forwarded message -----
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
