Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52826 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753926Ab1FGPPT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2011 11:15:19 -0400
Date: Tue, 7 Jun 2011 16:17:12 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Donald Johnson <donald.k.johnson@intel.com>,
	linux-watchdog@vger.kernel.org, Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] Intel SCU Watchdog: Fix build failure and duplicate
 include
Message-ID: <20110607161712.46f18dff@lxorguk.ukuu.org.uk>
In-Reply-To: <20110607145407.GA12177@infomag.iguana.be>
References: <20110607145407.GA12177@infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


> diff --git a/arch/x86/include/asm/apb_timer.h b/arch/x86/include/asm/apb_timer.h
> index 2fefa50..af60d8a 100644
> --- a/arch/x86/include/asm/apb_timer.h
> +++ b/arch/x86/include/asm/apb_timer.h
> @@ -62,7 +62,7 @@ extern int sfi_mtimer_num;
>  #else /* CONFIG_APB_TIMER */
>  
>  static inline unsigned long apbt_quick_calibrate(void) {return 0; }
> -static inline void apbt_time_init(void) {return 0; }
> +static inline void apbt_time_init(void) { }

This bit looks right

>  
>  #endif
>  #endif /* ASM_X86_APBT_H */
> diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
> index 919bdd1..ba43860 100644
> --- a/drivers/watchdog/intel_scu_watchdog.c
> +++ b/drivers/watchdog/intel_scu_watchdog.c
> @@ -42,7 +42,6 @@
>  #include <linux/sched.h>
>  #include <linux/signal.h>
>  #include <linux/sfi.h>
> -#include <linux/types.h>
>  #include <asm/irq.h>
>  #include <asm/atomic.h>
>  #include <asm/intel_scu_ipc.h>

Ditto

> diff --git a/drivers/watchdog/intel_scu_watchdog.h b/drivers/watchdog/intel_scu_watchdog.h
> index d2b074a..a9ca0d7 100644
> --- a/drivers/watchdog/intel_scu_watchdog.h
> +++ b/drivers/watchdog/intel_scu_watchdog.h
> @@ -62,5 +62,5 @@ struct intel_scu_watchdog_dev {
>  
>  extern int sfi_mtimer_num;
>  
> -/* extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint); */
> +extern struct sfi_timer_table_entry *sfi_get_mtmr(int hint);

But this is wrong. It's defined in arch/x86/include/asm/apb_timer.h

Fix I think is too make INTEL_SCU_WATCHDOG also depend on X86_MRST


