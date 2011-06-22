Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay004.isp.belgacom.be ([195.238.6.170]:50629 "EHLO
	mailrelay004.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758876Ab1FVUeF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jun 2011 16:34:05 -0400
Date: Wed, 22 Jun 2011 22:34:03 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Jesper Juhl <jj@chaosbits.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Donald Johnson <donald.k.johnson@intel.com>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] Intel SCU Watchdog: Fix build failure and duplicate
	include
Message-ID: <20110622203403.GI26745@infomag.iguana.be>
References: <20110607145407.GA12177@infomag.iguana.be> <20110607161712.46f18dff@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110607161712.46f18dff@lxorguk.ukuu.org.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Jesper,

> > diff --git a/drivers/watchdog/intel_scu_watchdog.h b/drivers/watchdog/intel_scu_watchdog.h
> > index d2b074a..a9ca0d7 100644
> > --- a/drivers/watchdog/intel_scu_watchdog.h
> > +++ b/drivers/watchdog/intel_scu_watchdog.h
> > @@ -62,5 +62,5 @@ struct intel_scu_watchdog_dev {
> >  
> >  extern int sfi_mtimer_num;
> >  
> > -/* extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint); */
> > +extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint);
> 
> But this is wrong. It's defined in arch/x86/include/asm/apb_timer.h
> 
> Fix I think is too make INTEL_SCU_WATCHDOG also depend on X86_MRST

Can you look at attached patch and see what works best? Either we use
the X86_MRST dependancy or either we need the INTEL_SCU_IPC && APB_TIMER one.

Thanks in advance,
Wim.

diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_timer.h
index 2fefa50..af60d8a 100644
--- a/arch/x86/include/asm/apb_timer.h
+++ b/arch/x86/include/asm/apb_timer.h
@@ -62,7 +62,7 @@ extern int sfi_mtimer_num;
 #else /* CONFIG_APB_TIMER */
 
 static inline unsigned long apbt_quick_calibrate(void) {return 0; }
-static inline void apbt_time_init(void) {return 0; }
+static inline void apbt_time_init(void) { }
 
 #endif
 #endif /* ASM_X86_APBT_H */
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 022f9eb..f202707 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -535,8 +535,8 @@ config I6300ESB_WDT
 
 config INTEL_SCU_WATCHDOG
 	bool "Intel SCU Watchdog for Mobile Platforms"
-	depends on WATCHDOG
-	depends on INTEL_SCU_IPC
+	depends on X86_MRST
+	depends on INTEL_SCU_IPC && APB_TIMER
 	---help---
 	  Hardware driver for the watchdog time built into the Intel SCU
 	  for Intel Mobile Platforms.
diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
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
