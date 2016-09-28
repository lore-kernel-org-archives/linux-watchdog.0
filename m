Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33091 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753550AbcI1SSq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Sep 2016 14:18:46 -0400
Received: by mail-pf0-f179.google.com with SMTP id 21so19922850pfy.0
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Sep 2016 11:18:46 -0700 (PDT)
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
Subject: [PATCH v14 8/9] clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped timer
Date: Thu, 29 Sep 2016 02:17:16 +0800
Message-Id: <1475086637-1914-9-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

From: Fu Wei <fu.wei@linaro.org>

The patch add memory-mapped timer register support by using the informati=
on
provided by the new GTDT driver of ACPI.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 92 ++++++++++++++++++++++++++++++=
+++---
 1 file changed, 85 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/a=
rm_arch_timer.c
index e78095f..8482fba 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -660,6 +660,7 @@ out:
 static int __init arch_timer_mem_register(struct device_node *np, void *=
frame)
 {
 	struct device_node *frame_node =3D NULL;
+	struct gt_timer_data *frame_data =3D NULL;
 	struct arch_timer *t;
 	void __iomem *base;
 	irq_handler_t func;
@@ -678,8 +679,17 @@ static int __init arch_timer_mem_register(struct dev=
ice_node *np, void *frame)
 		else
 			irq =3D irq_of_parse_and_map(frame_node, PHYS_SPI);
 	} else {
-		pr_err("Device node is missing.\n");
-		return -EINVAL;
+		frame_data =3D (struct gt_timer_data *)frame;
+		/*
+		 * According to ARMv8 Architecture Reference Manual(ARM),
+		 * the size of CNTBaseN frames of memory-mapped timer
+		 * is SZ_4K(Offset 0x000 =E2=80=93 0xFFF).
+		 */
+		base =3D ioremap(frame_data->cntbase_phy, SZ_4K);
+		if (arch_timer_mem_use_virtual)
+			irq =3D frame_data->virtual_irq;
+		else
+			irq =3D frame_data->irq;
 	}
=20
 	if (!base) {
@@ -840,13 +850,16 @@ static int __init arch_timer_of_init(struct device_=
node *np)
 CLOCKSOURCE_OF_DECLARE(armv7_arch_timer, "arm,armv7-timer", arch_timer_o=
f_init);
 CLOCKSOURCE_OF_DECLARE(armv8_arch_timer, "arm,armv8-timer", arch_timer_o=
f_init);
=20
-static int __init get_cnttidr(struct device_node *np, u32 *cnttidr)
+static int __init get_cnttidr(struct device_node *np,
+			      struct gt_block_data *gt_block, u32 *cnttidr)
 {
 	if (!cnttidr)
 		return -EINVAL;
=20
 	if (np)
 		cntctlbase =3D of_iomap(np, 0);
+	else if (gt_block)
+		cntctlbase =3D ioremap(gt_block->cntctlbase_phy, SZ_4K);
 	else
 		return -EINVAL;
=20
@@ -885,7 +898,7 @@ static int __init arch_timer_mem_init(struct device_n=
ode *np)
=20
 	arch_timers_present |=3D ARCH_MEM_TIMER;
=20
-	ret =3D get_cnttidr(np, &cnttidr);
+	ret =3D get_cnttidr(np, NULL, &cnttidr);
 	if (ret)
 		return ret;
=20
@@ -921,7 +934,72 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,ar=
mv7-timer-mem",
 		       arch_timer_mem_init);
=20
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static struct gt_timer_data __init *arch_timer_mem_get_timer(
+						struct gt_block_data *gt_blocks)
+{
+	struct gt_block_data *gt_block =3D gt_blocks;
+	struct gt_timer_data *best_frame =3D NULL;
+	u32 cnttidr;
+	int i;
+
+	if (get_cnttidr(NULL, gt_block, &cnttidr))
+		return NULL;
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (i =3D 0; i < gt_block->timer_count; i++) {
+		if (is_best_frame(cnttidr, gt_block->timer[i].frame_nr)) {
+			best_frame =3D &gt_block->timer[i];
+			if (arch_timer_mem_use_virtual)
+				break;
+		}
+	}
+	iounmap(cntctlbase);
+
+	return best_frame;
+}
+
+static int __init arch_timer_mem_acpi_init(size_t timer_count)
+{
+	struct gt_block_data *gt_blocks;
+	struct gt_timer_data *gt_timer;
+	int ret =3D -EINVAL;
+
+	/*
+	 * If we don't have any Platform Timer Structures, just return.
+	 */
+	if (!timer_count)
+		return 0;
+
+	/*
+	 * before really check all the Platform Timer Structures,
+	 * we assume they are GT block, and allocate memory for them.
+	 * We will free these memory once we finish the initialization.
+	 */
+	gt_blocks =3D kcalloc(timer_count, sizeof(*gt_blocks), GFP_KERNEL);
+	if (!gt_blocks)
+		return -ENOMEM;
+
+	if (gtdt_arch_timer_mem_init(gt_blocks) > 0) {
+		gt_timer =3D arch_timer_mem_get_timer(gt_blocks);
+		if (!gt_timer) {
+			pr_err("Failed to get mem timer info.\n");
+			goto error;
+		}
+		ret =3D arch_timer_mem_register(NULL, gt_timer);
+		if (ret) {
+			pr_err("Failed to register mem timer.\n");
+			goto error;
+		}
+	}
+	arch_timers_present |=3D ARCH_MEM_TIMER;
+error:
+	kfree(gt_blocks);
+	return ret;
+}
+
+/* Initialize per-processor generic timer and memory-mapped timer(if pre=
sent) */
 static int __init arch_timer_acpi_init(struct acpi_table_header *table)
 {
 	int timer_count;
@@ -945,8 +1023,8 @@ static int __init arch_timer_acpi_init(struct acpi_t=
able_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
=20
-	if (timer_count < 0)
-		pr_err("Failed to get platform timer info.\n");
+	if (timer_count < 0 || arch_timer_mem_acpi_init((size_t)timer_count))
+		pr_err("Failed to initialize memory-mapped timer.\n");
=20
 	return arch_timer_init();
 }
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
