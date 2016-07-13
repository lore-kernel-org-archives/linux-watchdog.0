Return-path: <fu.wei@linaro.org>
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org,
        jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, davem@davemloft.net,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kvalo@codeaurora.org, mchehab@kernel.org, jslaby@suse.cz,
        christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v7 9/9] acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver
Date: Thu, 14 Jul 2016 01:53:22 +0800
Message-Id: <1468432402-4872-10-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
References: <1468432402-4872-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing SBSA Generic Watchdog timer
in GTDT, parse all info in SBSA Generic Watchdog Structure in GTDT,
and creating a platform device with that information.

This allows the operating system to obtain device data from the
resource of platform device. The platform device named "sbsa-gwdt"
can be used by the ARM SBSA Generic Watchdog driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/acpi_gtdt.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 drivers/watchdog/Kconfig       |  1 +
 2 files changed, 84 insertions(+)

diff --git a/drivers/acpi/arm64/acpi_gtdt.c b/drivers/acpi/arm64/acpi_gtdt.c
index ff62953..eb3edac 100644
--- a/drivers/acpi/arm64/acpi_gtdt.c
+++ b/drivers/acpi/arm64/acpi_gtdt.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 #include <clocksource/arm_arch_timer.h>
 
@@ -258,3 +259,85 @@ int __init gtdt_arch_timer_mem_init(struct gt_block_data *data)
 
 	return index;
 }
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ */
+static int __init gtdt_import_sbsa_gwdt(void *platform_timer, int index)
+{
+	struct platform_device *pdev;
+	struct acpi_gtdt_watchdog *wd = platform_timer;
+	int irq = map_generic_timer_interrupt(wd->timer_interrupt,
+					      wd->timer_flags);
+	int no_irq = 1;
+
+	/*
+	 * According to SBSA specification the size of refresh and control
+	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 – 0xFFF).
+	 */
+	struct resource res[] = {
+		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
+		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
+		DEFINE_RES_IRQ(irq),
+	};
+
+	pr_debug("a Watchdog GT(0x%llx/0x%llx gsi:%u flags:0x%x).\n",
+		 wd->refresh_frame_address, wd->control_frame_address,
+		 wd->timer_interrupt, wd->timer_flags);
+
+	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
+		pr_err(FW_BUG "failed getting the Watchdog GT frame addr.\n");
+		return -EINVAL;
+	}
+
+	if (!wd->timer_interrupt)
+		pr_warn(FW_BUG "failed getting the Watchdog GT GSIV.\n");
+	else if (irq <= 0)
+		pr_warn("failed to map the Watchdog GT GSIV.\n");
+	else
+		no_irq = 0;
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
+	 * The platform driver (like drivers/watchdog/sbsa_gwdt.c)can get device
+	 * info below by matching this name.
+	 */
+	pdev = platform_device_register_simple("sbsa-gwdt", index, res,
+					       ARRAY_SIZE(res) - no_irq);
+	if (IS_ERR(pdev)) {
+		acpi_unregister_gsi(wd->timer_interrupt);
+		return PTR_ERR(pdev);
+	}
+
+	return 0;
+}
+
+static int __init gtdt_sbsa_gwdt_init(void)
+{
+	struct acpi_table_header *table;
+	void *platform_timer;
+	int index = 0;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+		return -EINVAL;
+
+	if (acpi_gtdt_desc_init(table) < 0)
+		return -EINVAL;
+
+	for_each_platform_timer(platform_timer) {
+		if (is_watchdog(platform_timer) &&
+		    !gtdt_import_sbsa_gwdt(platform_timer, index))
+			index++;
+	}
+
+	if (index)
+		pr_info("found %d SBSA generic Watchdog.\n", index);
+
+	return 0;
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b4b3e25..105f059 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -207,6 +207,7 @@ config ARM_SBSA_WATCHDOG
 	depends on ARM64
 	depends on ARM_ARCH_TIMER
 	select WATCHDOG_CORE
+	select ACPI_GTDT if ACPI
 	help
 	  ARM SBSA Generic Watchdog has two stage timeouts:
 	  the first signal (WS0) is for alerting the system by interrupt,
-- 
2.5.5
