Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:36121 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933206AbbFWQBX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Jun 2015 12:01:23 -0400
Received: by pdcu2 with SMTP id u2so10048215pdc.3
        for <linux-watchdog@vger.kernel.org>; Tue, 23 Jun 2015 09:01:23 -0700 (PDT)
From: fu.wei@linaro.org
To: Suravee.Suthikulpanit@amd.com, linaro-acpi@lists.linaro.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: tekkamanninja@gmail.com, graeme.gregory@linaro.org,
	al.stone@linaro.org, hanjun.guo@linaro.org, timur@codeaurora.org,
	ashwin.chaugule@linaro.org, arnd@arndb.de, linux@roeck-us.net,
	vgandhi@codeaurora.org, wim@iguana.be, jcm@redhat.com,
	leo.duran@amd.com, corbet@lwn.net, mark.rutland@arm.com,
	catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net,
	dyoung@redhat.com, panand@redhat.com, Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v6 8/8] clocksource: simplify ACPI code in arm_arch_timer.c
Date: Tue, 23 Jun 2015 23:59:41 +0800
Message-Id: <1435075182-20182-4-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1435075182-20182-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1435075182-20182-1-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

The patch update arm_arch_timer driver to use the function
provided by the new GTDT driver of ACPI.
By this way, arm_arch_timer.c can be simplified, and separate
all the ACPI GTDT knowledge from this timer driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/time.c             |  4 +--
 drivers/acpi/gtdt.c                  | 43 ++++++++++++++++++++++++++
 drivers/clocksource/Kconfig          |  1 +
 drivers/clocksource/arm_arch_timer.c | 60 +++++++-----------------------------
 include/clocksource/arm_arch_timer.h |  8 +++++
 include/linux/acpi.h                 |  5 +++
 include/linux/clocksource.h          |  4 +--
 7 files changed, 72 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/kernel/time.c b/arch/arm64/kernel/time.c
index 42f9195..2cabea6 100644
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -75,9 +75,9 @@ void __init time_init(void)
 
 	/*
 	 * Since ACPI or FDT will only one be available in the system,
-	 * we can use acpi_generic_timer_init() here safely
+	 * we can use arch_timer_acpi_init() here safely
 	 */
-	acpi_generic_timer_init();
+	arch_timer_acpi_init();
 
 	arch_timer_rate = arch_timer_get_rate();
 	if (!arch_timer_rate)
diff --git a/drivers/acpi/gtdt.c b/drivers/acpi/gtdt.c
index a92abf2..699c9fd 100644
--- a/drivers/acpi/gtdt.c
+++ b/drivers/acpi/gtdt.c
@@ -17,6 +17,8 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+#include <clocksource/arm_arch_timer.h>
+
 static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 {
 	int trigger, polarity;
@@ -33,6 +35,47 @@ static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
 	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }
 
+struct arch_timer_data __initdata *arch_timer_data_p;
+
+static int __init arch_timer_data_init(struct acpi_table_header *table)
+{
+	struct acpi_table_gtdt *gtdt;
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+
+	arch_timer_data_p->phys_secure_ppi =
+		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
+					    gtdt->secure_el1_flags);
+
+	arch_timer_data_p->phys_nonsecure_ppi =
+		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
+					    gtdt->non_secure_el1_flags);
+
+	arch_timer_data_p->virt_ppi =
+		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
+					    gtdt->virtual_timer_flags);
+
+	arch_timer_data_p->hyp_ppi =
+		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
+					    gtdt->non_secure_el2_flags);
+
+	arch_timer_data_p->c3stop = !(gtdt->non_secure_el1_flags &
+				      ACPI_GTDT_ALWAYS_ON);
+
+	return 0;
+}
+
+/* Initialize the arch_timer_data struct for arm_arch_timer by GTDT info */
+int __init gtdt_arch_timer_data_init(struct arch_timer_data *data)
+{
+	if (acpi_disabled || !data)
+		return -EINVAL;
+
+	arch_timer_data_p = data;
+
+	return acpi_table_parse(ACPI_SIG_GTDT, arch_timer_data_init);
+}
+
 /*
  * Initialize a SBSA generic Watchdog platform device info from GTDT
  * According to SBSA specification the size of refresh and control
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 51d7865f..ea94a6f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -109,6 +109,7 @@ config CLKSRC_EFM32
 config ARM_ARCH_TIMER
 	bool
 	select CLKSRC_OF if OF
+	select ACPI_GTDT if ACPI
 
 config ARM_ARCH_TIMER_EVTSTREAM
 	bool "Support for ARM architected timer event stream generation"
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 0aa135d..99505bb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -817,68 +817,30 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,armv7-timer-mem",
 		       arch_timer_mem_init);
 
 #ifdef CONFIG_ACPI
-static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
-{
-	int trigger, polarity;
-
-	if (!interrupt)
-		return 0;
-
-	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
-			: ACPI_LEVEL_SENSITIVE;
-
-	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
-			: ACPI_ACTIVE_HIGH;
-
-	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
-}
-
 /* Initialize per-processor generic timer */
-static int __init arch_timer_acpi_init(struct acpi_table_header *table)
+void __init arch_timer_acpi_init(void)
 {
-	struct acpi_table_gtdt *gtdt;
+	struct arch_timer_data data;
 
 	if (arch_timers_present & ARCH_CP15_TIMER) {
 		pr_warn("arch_timer: already initialized, skipping\n");
-		return -EINVAL;
+		return;
 	}
 
-	gtdt = container_of(table, struct acpi_table_gtdt, header);
-
 	arch_timers_present |= ARCH_CP15_TIMER;
 
-	arch_timer_ppi[PHYS_SECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->secure_el1_interrupt,
-		gtdt->secure_el1_flags);
-
-	arch_timer_ppi[PHYS_NONSECURE_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el1_interrupt,
-		gtdt->non_secure_el1_flags);
-
-	arch_timer_ppi[VIRT_PPI] =
-		map_generic_timer_interrupt(gtdt->virtual_timer_interrupt,
-		gtdt->virtual_timer_flags);
+	if (gtdt_arch_timer_data_init(&data))
+		return;
 
-	arch_timer_ppi[HYP_PPI] =
-		map_generic_timer_interrupt(gtdt->non_secure_el2_interrupt,
-		gtdt->non_secure_el2_flags);
+	arch_timer_ppi[PHYS_SECURE_PPI] = data.phys_secure_ppi;
+	arch_timer_ppi[PHYS_NONSECURE_PPI] = data.phys_nonsecure_ppi;
+	arch_timer_ppi[VIRT_PPI] = data.virt_ppi;
+	arch_timer_ppi[HYP_PPI] = data.hyp_ppi;
+	/* Always-on capability */
+	arch_timer_c3stop = data.c3stop;
 
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
-
-	/* Always-on capability */
-	arch_timer_c3stop = !(gtdt->non_secure_el1_flags & ACPI_GTDT_ALWAYS_ON);
-
 	arch_timer_init();
-	return 0;
-}
-
-/* Initialize all the generic timers presented in GTDT */
-void __init acpi_generic_timer_init(void)
-{
-	if (acpi_disabled)
-		return;
-
-	acpi_table_parse(ACPI_SIG_GTDT, arch_timer_acpi_init);
 }
 #endif
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 9916d0e..5deed9d 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -43,6 +43,14 @@ enum arch_timer_reg {
 
 #define ARCH_TIMER_EVT_STREAM_FREQ	10000	/* 100us */
 
+struct arch_timer_data {
+	int phys_secure_ppi;
+	int phys_nonsecure_ppi;
+	int virt_ppi;
+	int hyp_ppi;
+	bool c3stop;
+};
+
 #ifdef CONFIG_ARM_ARCH_TIMER
 
 extern u32 arch_timer_get_rate(void);
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 598f0f1..7213c0d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -458,6 +458,11 @@ void acpi_walk_dep_device_list(acpi_handle handle);
 struct platform_device *acpi_create_platform_device(struct acpi_device *);
 #define ACPI_PTR(_ptr)	(_ptr)
 
+#ifdef CONFIG_ACPI_GTDT
+struct arch_timer_data;
+int __init gtdt_arch_timer_data_init(struct arch_timer_data *data);
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d27d015..264e553 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -254,9 +254,9 @@ static inline void clocksource_of_init(void) {}
 #endif
 
 #ifdef CONFIG_ACPI
-void acpi_generic_timer_init(void);
+void arch_timer_acpi_init(void);
 #else
-static inline void acpi_generic_timer_init(void) { }
+static inline void arch_timer_acpi_init(void) { }
 #endif
 
 #endif /* _LINUX_CLOCKSOURCE_H */
-- 
1.9.1

