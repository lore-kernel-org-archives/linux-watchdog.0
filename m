Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43433 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756390AbcGZMVr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jul 2016 08:21:47 -0400
From: fu.wei@linaro.org
To: rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org,
	tglx@linutronix.de, marc.zyngier@arm.com,
	lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
	hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org,
	timur@codeaurora.org, graeme.gregory@linaro.org,
	al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de,
	wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com,
	Suravee.Suthikulpanit@amd.com, leo.duran@amd.com,
	linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	Fu Wei <fu.wei@linaro.org>
Subject: [PATCH v10 7/8] clocksource/drivers/arm_arch_timer: Add GTDT support for memory-mapped timer
Date: Tue, 26 Jul 2016 20:19:24 +0800
Message-Id: <1469535565-20924-8-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
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
 drivers/clocksource/arm_arch_timer.c | 127 +++++++++++++++++++++++++++++=
+++++-
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/a=
rm_arch_timer.c
index b10d84c..3f6a78c 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -870,7 +870,128 @@ CLOCKSOURCE_OF_DECLARE(armv7_arch_timer_mem, "arm,a=
rmv7-timer-mem",
 		       arch_timer_mem_init);
=20
 #ifdef CONFIG_ACPI_GTDT
-/* Initialize per-processor generic timer */
+static struct gt_timer_data __init *arch_timer_mem_get_timer(
+						struct gt_block_data *gt_blocks)
+{
+	struct gt_block_data *gt_block =3D gt_blocks;
+	struct gt_timer_data *best_frame =3D NULL;
+	void __iomem *cntctlbase;
+	u32 cnttidr;
+	int i;
+
+	/*
+	 * According to ARMv8 Architecture Reference Manual(ARM),
+	 * the size of CNTCTLBase frame of memory-mapped timer
+	 * is SZ_4K(Offset 0x000 =E2=80=93 0xFFF).
+	 */
+	cntctlbase =3D ioremap(gt_block->cntctlbase_phy, SZ_4K);
+	if (!cntctlbase) {
+		pr_err("Failed to map mem timer control frame base address\n");
+		return NULL;
+	}
+	cnttidr =3D readl_relaxed(cntctlbase + CNTTIDR);
+
+	/*
+	 * Try to find a virtual capable frame. Otherwise fall back to a
+	 * physical capable frame.
+	 */
+	for (i =3D 0; i < gt_block->timer_count; i++) {
+		int n;
+		u32 cntacr;
+
+		n =3D gt_block->timer[i].frame_nr;
+
+		/* Try enabling everything, and see what sticks */
+		cntacr =3D CNTACR_RFRQ | CNTACR_RWPT | CNTACR_RPCT |
+			 CNTACR_RWVT | CNTACR_RVOFF | CNTACR_RVCT;
+		writel_relaxed(cntacr, cntctlbase + CNTACR(n));
+		cntacr =3D readl_relaxed(cntctlbase + CNTACR(n));
+
+		if ((cnttidr & CNTTIDR_VIRT(n)) &&
+		    !(~cntacr & (CNTACR_RWVT | CNTACR_RVCT))) {
+			best_frame =3D &gt_block->timer[i];
+			arch_timer_mem_use_virtual =3D true;
+			break;
+		}
+
+		if (~cntacr & (CNTACR_RWPT | CNTACR_RPCT))
+			continue;
+
+		best_frame =3D &gt_block->timer[i];
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
+	void __iomem *timer_cntbase;
+	int ret =3D -EINVAL;
+	int timer_irq;
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
+
+		if (arch_timer_mem_use_virtual)
+			timer_irq =3D gt_timer->virtual_irq;
+		else
+			timer_irq =3D gt_timer->irq;
+		if (!timer_irq) {
+			pr_err("Failed to get %s irq for mem timer.",
+			       arch_timer_mem_use_virtual ? "virt" : "phys");
+			goto error;
+		}
+
+		/*
+		 * According to ARMv8 Architecture Reference Manual(ARM),
+		 * the size of CNTBaseN frames of memory-mapped timer
+		 * is SZ_4K(Offset 0x000 =E2=80=93 0xFFF).
+		 */
+		timer_cntbase =3D ioremap(gt_timer->cntbase_phy, SZ_4K);
+		if (!timer_cntbase) {
+			pr_err("Failed to map mem timer base address.\n");
+			goto error;
+		}
+
+		ret =3D arch_timer_mem_register(timer_cntbase, timer_irq);
+		if (ret) {
+			iounmap(timer_cntbase);
+			pr_err("Failed to register mem timer.\n");
+			goto error;
+		}
+
+		arch_counter_base =3D timer_cntbase;
+		arch_timers_present |=3D ARCH_MEM_TIMER;
+	}
+
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
@@ -894,8 +1015,8 @@ static int __init arch_timer_acpi_init(struct acpi_t=
able_header *table)
 	/* Get the frequency from CNTFRQ */
 	arch_timer_detect_rate(NULL, NULL);
=20
-	if (timer_count < 0)
-		pr_err("Failed to get platform timer info, skipping.\n");
+	if (timer_count < 0 || arch_timer_mem_acpi_init((size_t)timer_count))
+		pr_err("Failed to initialize memory-mapped timer, skipping.\n");
=20
 	return arch_timer_init();
 }
--=20
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
