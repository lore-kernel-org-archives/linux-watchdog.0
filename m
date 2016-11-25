Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754285AbcKYItF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 25 Nov 2016 03:49:05 -0500
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
Subject: [PATCH v17 13/15] acpi/arm64: Add memory-mapped timer support in GTDT driver
Date: Fri, 25 Nov 2016 16:46:21 +0800
Message-Id: <20161125084623.22515-14-fu.wei@linaro.org>
In-Reply-To: <20161125084623.22515-1-fu.wei@linaro.org>
References: <20161125084623.22515-1-fu.wei@linaro.org>
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
 drivers/acpi/arm64/gtdt.c | 124 ++++++++++++++++++++++++++++++++++++++++=
++++++
 include/linux/acpi.h      |   1 +
 2 files changed, 125 insertions(+)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index d93a790..91ea6cb 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -37,6 +37,28 @@ struct acpi_gtdt_descriptor {
=20
 static struct acpi_gtdt_descriptor acpi_gtdt_desc __initdata;
=20
+static inline void *next_platform_timer(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh =3D platform_timer;
+
+	platform_timer +=3D gh->length;
+	if (platform_timer < acpi_gtdt_desc.gtdt_end)
+		return platform_timer;
+
+	return NULL;
+}
+
+#define for_each_platform_timer(_g)				\
+	for (_g =3D acpi_gtdt_desc.platform_timer; _g;	\
+	     _g =3D next_platform_timer(_g))
+
+static inline bool is_timer_block(void *platform_timer)
+{
+	struct acpi_gtdt_header *gh =3D platform_timer;
+
+	return gh->type =3D=3D ACPI_GTDT_TYPE_TIMER_BLOCK;
+}
+
 static int __init map_gt_gsi(u32 interrupt, u32 flags)
 {
 	int trigger, polarity;
@@ -155,3 +177,105 @@ int __init acpi_gtdt_init(struct acpi_table_header =
*table,
=20
 	return ret;
 }
+
+static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *b=
lock,
+					 struct arch_timer_mem *data)
+{
+	int i;
+	struct acpi_gtdt_timer_entry *frame;
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
+	 * According to "Table * CNTCTLBase memory map" of
+	 * <ARM Architecture Reference Manual> for ARMv8,
+	 * The size of the CNTCTLBase frame is 4KB(Offset 0x000 =E2=80=93 0xFFC=
).
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
+		data->frame[i].virt_irq =3D
+			map_gt_gsi(frame->virtual_timer_interrupt,
+				   frame->virtual_timer_flags);
+		if (data->frame[i].virt_irq <=3D 0) {
+			pr_warn("failed to map virtual timer irq in frame %d.\n",
+				i);
+			acpi_unregister_gsi(frame->timer_interrupt);
+			return -EINVAL;
+		}
+
+		data->frame[i].frame_nr =3D frame->frame_number;
+		data->frame[i].cntbase =3D frame->base_address;
+		/*
+		 * According to "Table * CNTBaseN memory map" of
+		 * <ARM Architecture Reference Manual> for ARMv8,
+		 * The size of the CNTBaseN frame is 4KB(Offset 0x000 =E2=80=93 0xFFC)=
.
+		 */
+		data->frame[i].size =3D SZ_4K;
+	}
+
+	return 0;
+}
+
+/**
+ * acpi_arch_timer_mem_init() - Get the info of all GT blocks in GTDT ta=
ble.
+ * @data:	the pointer to the array of struct arch_timer_mem for returnin=
g
+ *		the result of parsing. The element number of this array should
+ *		be platform_timer_count(the total number of platform timers).
+ * @count:	The pointer of int variate for returning the number of GT
+ *		blocks we have parsed.
+ *
+ * Return: 0 if success, -EINVAL/-ENODEV if error.
+ */
+int __init acpi_arch_timer_mem_init(struct arch_timer_mem *data,
+				    int *timer_count)
+{
+	int ret;
+	void *platform_timer;
+
+	*timer_count =3D 0;
+	for_each_platform_timer(platform_timer) {
+		if (is_timer_block(platform_timer)) {
+			ret =3D gtdt_parse_timer_block(platform_timer, data);
+			if (ret)
+				return ret;
+			data++;
+			(*timer_count)++;
+		}
+	}
+
+	if (*timer_count)
+		pr_info("found %d memory-mapped timer block(s).\n",
+			*timer_count);
+
+	return 0;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d201ce4..f5881de 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -581,6 +581,7 @@ int acpi_reconfig_notifier_unregister(struct notifier=
_block *nb);
 int acpi_gtdt_init(struct acpi_table_header *table, int *platform_timer_=
count);
 int acpi_gtdt_map_ppi(int type);
 bool acpi_gtdt_c3stop(int type);
+int acpi_arch_timer_mem_init(struct arch_timer_mem *data, int *timer_cou=
nt);
 #endif
=20
 #else	/* !CONFIG_ACPI */
--=20
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
