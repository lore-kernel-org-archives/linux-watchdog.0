Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47211 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758330AbbCDOVs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Mar 2015 09:21:48 -0500
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v3 6/9] ARM: at91: time: move the system timer driver to drivers/clocksource
Date: Wed,  4 Mar 2015 15:21:34 +0100
Message-Id: <1425478897-27322-7-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425478897-27322-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Import at91rm9200_time.c from mach-at91 as timer-atmel-st.c. Further cleanup is
required to get rid of the mach-at91 headers.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/mach-at91/Makefile                                           | 2 +-
 drivers/clocksource/Kconfig                                           | 4 ++++
 drivers/clocksource/Makefile                                          | 1 +
 .../at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c         | 0
 4 files changed, 6 insertions(+), 1 deletion(-)
 rename arch/arm/mach-at91/at91rm9200_time.c => drivers/clocksource/timer-atmel-st.c (100%)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 827fdbcce1c7..963c29169242 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -7,7 +7,7 @@ obj-y		:= setup.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= sam9_smc.o
 
 # CPU-specific support
-obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o at91rm9200_time.o
+obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
 obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
 obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
 
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 1c2506f68122..d1d15985a4ec 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -138,6 +138,10 @@ config ATMEL_PIT
 	select CLKSRC_OF if OF
 	def_bool SOC_AT91SAM9 || SOC_SAMA5
 
+config ATMEL_ST
+	select CLKSRC_OF if OF
+	def_bool SOC_AT91RM9200
+
 config CLKSRC_METAG_GENERIC
 	def_bool y if METAG
 	help
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 752d5c70b0ef..5b85f6adb258 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_CLKSRC_OF)	+= clksrc-of.o
 obj-$(CONFIG_ATMEL_PIT)		+= timer-atmel-pit.o
+obj-$(CONFIG_ATMEL_ST)		+= timer-atmel-st.o
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/drivers/clocksource/timer-atmel-st.c
similarity index 100%
rename from arch/arm/mach-at91/at91rm9200_time.c
rename to drivers/clocksource/timer-atmel-st.c
-- 
2.1.0

