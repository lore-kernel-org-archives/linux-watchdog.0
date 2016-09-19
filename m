Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:33612 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbcISTUC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 15:20:02 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 4/4] ARM: sa11x0/pxa: get rid of get_clock_tick_rate
Date: Mon, 19 Sep 2016 21:12:15 +0200
Message-Id: <1474312335-20997-5-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The last user of this function is gone, so remove it. The clock API
should now be used to get clock rates.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/mach-pxa/generic.c                  | 15 ---------------
 arch/arm/mach-pxa/include/mach/hardware.h    |  2 --
 arch/arm/mach-sa1100/include/mach/hardware.h |  4 ----
 3 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-pxa/generic.c b/arch/arm/mach-pxa/generic.c
index 2a9297991d74..cb73a9723d0e 100644
--- a/arch/arm/mach-pxa/generic.c
+++ b/arch/arm/mach-pxa/generic.c
@@ -43,21 +43,6 @@ void clear_reset_status(unsigned int mask)
 	}
 }
 
-unsigned long get_clock_tick_rate(void)
-{
-	unsigned long clock_tick_rate;
-
-	if (cpu_is_pxa25x())
-		clock_tick_rate = 3686400;
-	else if (machine_is_mainstone())
-		clock_tick_rate = 3249600;
-	else
-		clock_tick_rate = 3250000;
-
-	return clock_tick_rate;
-}
-EXPORT_SYMBOL(get_clock_tick_rate);
-
 /*
  * For non device-tree builds, keep legacy timer init
  */
diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index 8d63c211b22f..55064124ca4e 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -303,8 +303,6 @@
  */
 extern unsigned int get_memclk_frequency_10khz(void);
 
-/* return the clock tick rate of the OS timer */
-extern unsigned long get_clock_tick_rate(void);
 #endif
 
 #endif  /* _ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-sa1100/include/mach/hardware.h b/arch/arm/mach-sa1100/include/mach/hardware.h
index cbedd75a9d65..474844a93e29 100644
--- a/arch/arm/mach-sa1100/include/mach/hardware.h
+++ b/arch/arm/mach-sa1100/include/mach/hardware.h
@@ -61,10 +61,6 @@
 # define __REG(x)	(*((volatile unsigned long __iomem *)io_p2v(x)))
 # define __PREG(x)	(io_v2p((unsigned long)&(x)))
 
-static inline unsigned long get_clock_tick_rate(void)
-{
-	return 3686400;
-}
 #else
 
 # define __REG(x)	io_p2v(x)
-- 
2.1.4

