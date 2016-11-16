Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50478 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753542AbcKPNv5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 16 Nov 2016 08:51:57 -0500
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
Subject: [PATCH v16 13/15] acpi/arm64: Add memory-mapped timer support in GTDT driver
Date: Wed, 16 Nov 2016 21:49:06 +0800
Message-Id: <1479304148-2965-14-git-send-email-fu.wei@linaro.org>
In-Reply-To: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
References: <1479304148-2965-1-git-send-email-fu.wei@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

From: Fu Wei <fu.wei@linaro.org>

On platforms booting with ACPI, architected memory-mapped timers'
configuration data is provided by firmware through the ACPI GTDT
static table.

The clocksource architected timer kernel driver requires a firmware
interface to collect timer configuration and configure its driver.
this infrastructure is present for device tree systems, but it is
missing on systems booting with ACPI.

Implement the kernel infrastructure required to parse the static
ACPI GTDT table so that the architected timer clocksource driver can
make use of it on systems booting with ACPI, therefore enabling
the corresponding timers configuration.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/arm64/gtdt.c | 95 +++++++++++++++++++++++++++++++++++++++++=
++++++
 include/linux/acpi.h      |  1 +
 2 files changed, 96 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index 2de79aa..08d9506 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -51,6 +51,14 @@ static inline bool is_timer_block(void *platform_timer=
)
 	return gh->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK;
 }
=20
+static inline struct acpi_gtdt_timer_block *get_timer_block(unsigned int=
 index)
+{
+	if (index >=3D acpi_gtdt_desc.timer_block_count || !timer_block)
+		return NULL;
+
+	return timer_block[index];
+}
+
 static inline bool is_watchdog(void *platform_timer)
 {
 	struct acpi_gtdt_header *gh =3D platform_timer;
@@ -214,3 +222,90 @@ int __init acpi_gtdt_init(struct acpi_table_header *=
table)
 	acpi_gtdt_release();
 	return -EINVAL;
 }
+
+/*
+ * Get ONE GT block info for memory-mapped timer from GTDT table.
+ * @data: the GT block data (parsing result)
+ * @index: the index number of GT block
+ * Note: we already verify @data in caller, it can't be NULL here.
+ * Returns 0 if success, -EINVAL/-ENODEV if error.
+ */
+int __init gtdt_arch_timer_mem_init(struct arch_timer_mem *data,
+				    unsigned int index)
+{
+	struct acpi_gtdt_timer_block *block;
+	struct acpi_gtdt_timer_entry *frame;
+	int i;
+
+	block =3D get_timer_block(index);
+	if (!block)
+		return -ENODEV;
+
+	if (!block->timer_count) {
+		pr_err(FW_BUG "GT block present, but frame count is zero.");
+		return -ENODEV;
+	}
+
+	if (block->timer_count > ARCH_TIMER_MEM_MAX_FRAMES) {
+		pr_err(FW_BUG "GT block lists %d frames, ACPI spec only allows 8\n",
+		       block->timer_count);
+		return -EINVAL;
+	}
+
+	data->cntctlbase =3D (phys_addr_t)block->block_address;
+	/*
+	 * We can NOT get the size info from GTDT table,
+	 * but according to "Table * CNTCTLBase memory map" of
+	 * <ARM Architecture Reference Manual> for ARMv8,
+	 * it should be 4KB(Offset 0x000 =E2=80=93 0xFFC).
+	 */
+	data->size =3D SZ_4K;
+	data->num_frames =3D block->timer_count;
+
+	frame =3D (void *)block + block->timer_offset;
+	if (frame + block->timer_count !=3D (void *)block + block->header.lengt=
h)
+		return -EINVAL;
+
+	/*
+	 * Get the GT timer Frame data for every GT Block Timer
+	 */
+	for (i =3D 0; i < block->timer_count; i++, frame++) {
+		if (!frame->base_address || !frame->timer_interrupt)
+			return -EINVAL;
+
+		data->frame[i].phys_irq =3D map_gt_gsi(frame->timer_interrupt,
+						     frame->timer_flags);
+		if (data->frame[i].phys_irq <=3D 0) {
+			pr_warn("failed to map physical timer irq in frame %d.\n",
+				i);
+			return -EINVAL;
+		}
+
+		if (frame->virtual_timer_interrupt) {
+			data->frame[i].virt_irq =3D
+				map_gt_gsi(frame->virtual_timer_interrupt,
+					   frame->virtual_timer_flags);
+			if (data->frame[i].virt_irq <=3D 0) {
+				pr_warn("failed to map virtual timer irq in frame %d.\n",
+					i);
+				return -EINVAL;
+			}
+		}
+
+		data->frame[i].frame_nr =3D frame->frame_number;
+		data->frame[i].cntbase =3D frame->base_address;
+		/*
+		 * We can NOT get the size info from GTDT table,
+		 * but according to "Table * CNTBaseN memory map" of
+		 * <ARM Architecture Reference Manual> for ARMv8,
+		 * it should be 4KB(Offset 0x000 =E2=80=93 0xFFC).
+		 */
+		data->frame[i].size =3D SZ_4K;
+	}
+
+	if (acpi_gtdt_desc.timer_block_count)
+		pr_info("parsed No.%d of %d memory-mapped timer block(s).\n",
+			index, acpi_gtdt_desc.timer_block_count);
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a1611d1..44b8c1b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -582,6 +582,7 @@ int acpi_gtdt_init(struct acpi_table_header *table);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(int type);
 void acpi_gtdt_release(void);
+int gtdt_arch_timer_mem_init(struct arch_timer_mem *data, unsigned int i=
ndex);
 #endif
=20
 #else	/* !CONFIG_ACPI */
--=20
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
