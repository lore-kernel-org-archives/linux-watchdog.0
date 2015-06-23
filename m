Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32828 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbbFWQAv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 23 Jun 2015 12:00:51 -0400
Received: by padev16 with SMTP id ev16so9698879pad.0
        for <linux-watchdog@vger.kernel.org>; Tue, 23 Jun 2015 09:00:50 -0700 (PDT)
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
Subject: [PATCH v6 6/8] ACPI: add GTDT table parse driver into ACPI driver
Date: Tue, 23 Jun 2015 23:59:39 +0800
Message-Id: <1435075182-20182-2-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1435075182-20182-1-git-send-email-fu.wei@linaro.org>
References: <=fu.wei@linaro.org>
 <1435075182-20182-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing SBSA Generic Watchdog
Structure in GTDT, and creating a platform device with that
information. This allows the operating system to obtain device
data from the resource of platform device.

The platform device named "sbsa-gwdt" can be used by the
ARM SBSA Generic Watchdog driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/Kconfig  |   9 ++++
 drivers/acpi/Makefile |   1 +
 drivers/acpi/gtdt.c   | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 147 insertions(+)
 create mode 100644 drivers/acpi/gtdt.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1bbaa3d..e125698 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -433,4 +433,13 @@ config XPOWER_PMIC_OPREGION
 
 endif
 
+config ACPI_GTDT
+	bool "ACPI GTDT Support"
+	depends on ARM64
+	help
+	  GTDT (Generic Timer Description Table) provides information
+	  for per-processor timers and Platform (memory-mapped) timers
+	  for ARM platforms. Select this option to provide information
+	  needed for the timers init.
+
 endif	# ACPI
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 431e587..2c5a194 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -96,3 +96,4 @@ obj-$(CONFIG_ACPI_EXTLOG)	+= acpi_extlog.o
 obj-$(CONFIG_PMIC_OPREGION)	+= pmic/intel_pmic.o
 obj-$(CONFIG_CRC_PMIC_OPREGION) += pmic/intel_pmic_crc.o
 obj-$(CONFIG_XPOWER_PMIC_OPREGION) += pmic/intel_pmic_xpower.o
+obj-$(CONFIG_ACPI_GTDT)		+= gtdt.o
diff --git a/drivers/acpi/gtdt.c b/drivers/acpi/gtdt.c
new file mode 100644
index 0000000..a92abf2
--- /dev/null
+++ b/drivers/acpi/gtdt.c
@@ -0,0 +1,137 @@
+/*
+ * ARM Specific GTDT table Support
+ *
+ * Copyright (C) 2015, Linaro Ltd.
+ * Author: Fu Wei <fu.wei@linaro.org>
+ *         Hanjun Guo <hanjun.guo@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static int __init map_generic_timer_interrupt(u32 interrupt, u32 flags)
+{
+	int trigger, polarity;
+
+	if (!interrupt)
+		return 0;
+
+	trigger = (flags & ACPI_GTDT_INTERRUPT_MODE) ? ACPI_EDGE_SENSITIVE
+			: ACPI_LEVEL_SENSITIVE;
+
+	polarity = (flags & ACPI_GTDT_INTERRUPT_POLARITY) ? ACPI_ACTIVE_LOW
+			: ACPI_ACTIVE_HIGH;
+
+	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
+}
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ * According to SBSA specification the size of refresh and control
+ * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 – 0xFFF).
+ */
+static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
+					int index)
+{
+	struct platform_device *pdev;
+	int irq = map_generic_timer_interrupt(wd->timer_interrupt,
+					      wd->timer_flags);
+	struct resource res[] = {
+		DEFINE_RES_IRQ_NAMED(irq, "ws0"),
+		DEFINE_RES_MEM_NAMED(wd->refresh_frame_address, SZ_4K,
+				     "refresh"),
+		DEFINE_RES_MEM_NAMED(wd->control_frame_address, SZ_4K,
+				     "control"),
+	};
+
+	pr_debug("GTDT: a Watchdog GT(0x%llx/0x%llx gsi:%u flags:0x%x)\n",
+		 wd->refresh_frame_address, wd->control_frame_address,
+		 wd->timer_interrupt, wd->timer_flags);
+
+	if (!(wd->refresh_frame_address &&
+	      wd->control_frame_address &&
+	      wd->timer_interrupt)) {
+		pr_err("GTDT: failed geting the device info.\n");
+		return -EINVAL;
+	}
+
+	if (irq < 0) {
+		pr_err("GTDT: failed to register GSI of the Watchdog GT.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
+	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
+	 * info below by matching this name.
+	 */
+	pdev = platform_device_register_simple("sbsa-gwdt", index, res,
+					       ARRAY_SIZE(res));
+	if (IS_ERR(pdev)) {
+		acpi_unregister_gsi(wd->timer_interrupt);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+static int __init gtdt_platform_timer_parse(struct acpi_table_header *table)
+{
+	struct acpi_gtdt_header *header;
+	struct acpi_table_gtdt *gtdt;
+	void *gtdt_subtable;
+	int i, gwdt_index;
+	int ret = 0;
+
+	if (table->revision < 2) {
+		pr_warn("GTDT: Revision:%d doesn't support Platform Timers.\n",
+			table->revision);
+		return 0;
+	}
+
+	gtdt = container_of(table, struct acpi_table_gtdt, header);
+	if (!gtdt->platform_timer_count) {
+		pr_info("GTDT: No Platform Timer structures.\n");
+		return 0;
+	}
+
+	gtdt_subtable = (void *)gtdt + gtdt->platform_timer_offset;
+
+	for (i = 0, gwdt_index = 0; i < gtdt->platform_timer_count; i++) {
+		if (gtdt_subtable > (void *)table + table->length) {
+			pr_err("GTDT: subtable pointer overflows, bad table\n");
+			return -EINVAL;
+		}
+		header = (struct acpi_gtdt_header *)gtdt_subtable;
+		if (header->type == ACPI_GTDT_TYPE_WATCHDOG) {
+			ret = gtdt_import_sbsa_gwdt(gtdt_subtable, gwdt_index);
+			if (ret)
+				pr_err("GTDT: failed to import subtable %d\n",
+				       i);
+			else
+				gwdt_index++;
+		}
+		gtdt_subtable += header->length;
+	}
+
+	return ret;
+}
+
+static int __init gtdt_platform_timer_init(void)
+{
+	if (acpi_disabled)
+		return 0;
+
+	return acpi_table_parse(ACPI_SIG_GTDT, gtdt_platform_timer_parse);
+}
+
+device_initcall(gtdt_platform_timer_init);
-- 
1.9.1

