Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933724AbdCaRx5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 31 Mar 2017 13:53:57 -0400
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
        timur@codeaurora.org, graeme.gregory@linaro.org,
        al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Suravee.Suthikulpanit@amd.com, leo.duran@amd.com, wim@iguana.be,
        linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        tn@semihalf.com, christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v23 11/11] acpi/arm64: Add SBSA Generic Watchdog support in GTDT driver
Date: Sat,  1 Apr 2017 01:51:05 +0800
Message-Id: <20170331175105.8370-12-fu.wei@linaro.org>
In-Reply-To: <20170331175105.8370-1-fu.wei@linaro.org>
References: <20170331175105.8370-1-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

From: Fu Wei <fu.wei@linaro.org>

This driver adds support for parsing SBSA Generic Watchdog timer
in GTDT, parse all info in SBSA Generic Watchdog Structure in GTDT,
and creating a platform device with that information.

This allows the operating system to obtain device data from the
resource of platform device. The platform device named "sbsa-gwdt"
can be used by the ARM SBSA Generic Watchdog driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/acpi/arm64/gtdt.c | 103 ++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 3dd33f3..d73bb16 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/platform_device.h>
=20
 #include <clocksource/arm_arch_timer.h>
=20
@@ -60,6 +61,17 @@ static inline bool is_timer_block(void *platform_timer=
)
 	return gh->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK;
 }
=20
+static inline bool is_non_secure_watchdog(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh =3D platform_timer;
+	struct acpi_gtdt_watchdog *wd =3D platform_timer;
+
+	if (gh->type !=3D ACPI_GTDT_TYPE_WATCHDOG)
+		return false;
+
+	return !(wd->timer_flags & ACPI_GTDT_WATCHDOG_SECURE);
+}
+
 static int __init map_gt_gsi(u32 interrupt, u32 flags)
 {
 	int trigger, polarity;
@@ -301,3 +313,94 @@ int __init acpi_arch_timer_mem_init(struct arch_time=
r_mem *timer_mem,
=20
 	return 0;
 }
+
+/*
+ * Initialize a SBSA generic Watchdog platform device info from GTDT
+ */
+static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
+					int index)
+{
+	struct platform_device *pdev;
+	int irq =3D map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
+
+	/*
+	 * According to SBSA specification the size of refresh and control
+	 * frames of SBSA Generic Watchdog is SZ_4K(Offset 0x000 =E2=80=93 0xFF=
F).
+	 */
+	struct resource res[] =3D {
+		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
+		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
+		DEFINE_RES_IRQ(irq),
+	};
+	int nr_res =3D ARRAY_SIZE(res);
+
+	pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
+		 wd->refresh_frame_address, wd->control_frame_address,
+		 wd->timer_interrupt, wd->timer_flags);
+
+	if (!(wd->refresh_frame_address && wd->control_frame_address)) {
+		pr_err(FW_BUG "failed to get the Watchdog base address.\n");
+		acpi_unregister_gsi(wd->timer_interrupt);
+		return -EINVAL;
+	}
+
+	if (irq <=3D 0) {
+		pr_warn("failed to map the Watchdog interrupt.\n");
+		nr_res--;
+	}
+
+	/*
+	 * Add a platform device named "sbsa-gwdt" to match the platform driver=
.
+	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
+	 * The platform driver can get device info below by matching this name.
+	 */
+	pdev =3D platform_device_register_simple("sbsa-gwdt", index, res, nr_re=
s);
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
+	void *platform_timer;
+	struct acpi_table_header *table;
+	int ret, timer_count, gwdt_count =3D 0;
+
+	if (acpi_disabled)
+		return 0;
+
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_GTDT, 0, &table)))
+		return -EINVAL;
+
+	/*
+	 * Note: Even though the global variable acpi_gtdt_desc has been
+	 * initialized by acpi_gtdt_init() while initializing the arch timers,
+	 * when we call this function to get SBSA watchdogs info from GTDT, the
+	 * pointers stashed in it are stale (since they are early temporary
+	 * mappings carried out before acpi_permanent_mmap is set) and we need
+	 * to re-initialize them with permanent mapped pointer values to let th=
e
+	 * GTDT parsing possible.
+	 */
+	ret =3D acpi_gtdt_init(table, &timer_count);
+	if (ret || !timer_count)
+		return ret;
+
+	for_each_platform_timer(platform_timer) {
+		if (is_non_secure_watchdog(platform_timer)) {
+			ret =3D gtdt_import_sbsa_gwdt(platform_timer, gwdt_count);
+			if (ret)
+				break;
+			gwdt_count++;
+		}
+	}
+
+	if (gwdt_count)
+		pr_info("found %d SBSA generic Watchdog(s).\n", gwdt_count);
+
+	return ret;
+}
+
+device_initcall(gtdt_sbsa_gwdt_init);
--=20
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
