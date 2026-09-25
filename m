Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F153502A7;
	Fri, 25 Sep 2026 07:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322534; cv=none; b=rzywisWSiayiyBhUGrfinBeoBvDraKQLEpJEpydu0wn9fdXCLjS8XBGIWrjbyvEgm+KwEfqj2VDaQ6NBIk2E2mP4Ojlct31gO5s1/oineHoc+pAhTz7snMoZvCs6HwFaQuILO2fCYXT+ukAoYtMsCnYl3R6+UaUG+4UXY+3Kpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322534; c=relaxed/simple;
	bh=IOiTLpCzbwh5kfFEh1EBtEzupiePVB9uCAP31W9pvvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uXAA7MXnwHrxHrduZ8rls2J3KButfDTYerp5aYj6UU0S4Vx2kZbY5CyJtef0Ubeo5ZJES0dghe+wBA/4Yb4N+umA3mrxdvtJjFw69RQ4toE+glAH3QlCHbXemR1SCJEXciGuvv0gzhue84izghp60Htszg6J4+MGhnfSCkQslBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHoDb3Kl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHoDb3Kl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D2C1F00893;
	Fri, 25 Sep 2026 07:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322532;
	bh=+blcjwrBB0xFVey69zEwGWMEXl0s5+FMl34UhaVFoas=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IHoDb3KlNqakCxRtTKMOQp0onbS8090NLs7t/Am6RBSR3ybiqnxrJ8aN5T1N6YEf7
	 7p8wB+JQ+3cPRHjWUmXf6+G+xHCpUMZXEbnaH9w6RbzQPTbjkt/7EuiCBPMXa6/1Vv
	 ATWw0rZuzurRIqsgGkhUizgHyTWjl93k5EanESTAPp+xGzSfxEqLkdCXO6LIOmPv74
	 HvCIUV0o7sIvX1OGuJa6YPM+QT3nS8pgQXByPavVk2gHnHt2GNVCVcmX7FPTVhp2So
	 63uPn8Mmdyd9meGOCBUeusy8SWfakmWrQkvUj2xjgBnUrz6oq1MwAXwHOXivrG5w9c
	 g7YnH4TX/CL1w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:06 +0200
Subject: [PATCH RFC 07/11] ACPI/IORT: Convert IORT devices to IRQs
 software-node properties
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-7-2c62125d0085@kernel.org>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Robin Murphy <robin.murphy@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev, 
 linux-watchdog@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15.2

Static devices created out of IORT nodes might require GSI interrupts that
are routed to interrupt controllers that have not yet probed (so their
respective IRQ domain is not registered yet and therefore the GSI
mapping would fail if tried) to be mapped in current IORT code.

Instead of trying to map the GSIs at platform device creation time,
stash standard GSIs numbers, trigger/polarity and names properties into
the IORT static fwnode secondary swnodes so that they can be later
retrieved, in a uniform fashion, by the device drivers claiming them.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/acpi/arm64/iort.c | 250 ++++++++++++++++++++++++++--------------------
 1 file changed, 142 insertions(+), 108 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 1020ac953e42..9b7aa51aedc3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1567,47 +1567,52 @@ int iort_dma_get_ranges(struct device *dev, u64 *limit)
 		return nc_dma_get_range(dev, limit);
 }
 
-static void __init acpi_iort_register_irq(int hwirq, const char *name,
-					  int trigger,
-					  struct resource *res)
+static void __init acpi_iort_add_irq(u32 hwirq, const char *name, unsigned int trigger_val,
+				     u32 *gsi, u32 *trigger,
+				     u32 *polarity, const char **names,
+				     unsigned int *index)
 {
-	int irq = acpi_register_gsi(NULL, hwirq, trigger,
-				    ACPI_ACTIVE_HIGH);
-
-	if (irq <= 0) {
-		pr_err("could not register gsi hwirq %d name [%s]\n", hwirq,
-								      name);
+	if (!hwirq)
 		return;
-	}
 
-	res->start = irq;
-	res->end = irq;
-	res->flags = IORESOURCE_IRQ;
-	res->name = name;
+	gsi[*index] = hwirq;
+	trigger[*index] = trigger_val;
+	polarity[*index] = ACPI_ACTIVE_HIGH;
+	if (names)
+		names[*index] = name;
+	(*index)++;
+}
+
+static int __init acpi_iort_get_irq_props(const u32 *gsi,
+					  const u32 *trigger,
+					  const u32 *polarity,
+					  const char * const *names,
+					  unsigned int irq_count,
+					  const struct property_entry **props)
+{
+	struct property_entry entries[5] = {};
+	int next_prop = 0;
+
+	if (!irq_count)
+		return 0;
+
+	entries[next_prop++] = PROPERTY_ENTRY_U32_ARRAY_LEN(ACPI_IRQ_PROP_GSI,
+							     gsi, irq_count);
+	entries[next_prop++] = PROPERTY_ENTRY_U32_ARRAY_LEN(ACPI_IRQ_PROP_GSI_TRIGGER,
+							     trigger, irq_count);
+	entries[next_prop++] = PROPERTY_ENTRY_U32_ARRAY_LEN(ACPI_IRQ_PROP_GSI_POLARITY,
+							     polarity, irq_count);
+	if (names)
+		entries[next_prop++] = PROPERTY_ENTRY_STRING_ARRAY_LEN("interrupt-names",
+									names, irq_count);
+
+	*props = property_entries_dup(entries);
+	return PTR_ERR_OR_ZERO(*props);
 }
 
 static int __init arm_smmu_v3_count_resources(struct acpi_iort_node *node)
 {
-	struct acpi_iort_smmu_v3 *smmu;
-	/* Always present mem resource */
-	int num_res = 1;
-
-	/* Retrieve SMMUv3 specific data */
-	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
-
-	if (smmu->event_gsiv)
-		num_res++;
-
-	if (smmu->pri_gsiv)
-		num_res++;
-
-	if (smmu->gerr_gsiv)
-		num_res++;
-
-	if (smmu->sync_gsiv)
-		num_res++;
-
-	return num_res;
+	return 1;
 }
 
 static bool arm_smmu_v3_is_combined_irq(struct acpi_iort_smmu_v3 *smmu)
@@ -1644,44 +1649,47 @@ static void __init arm_smmu_v3_init_resources(struct resource *res,
 					      struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu_v3 *smmu;
-	int num_res = 0;
 
 	/* Retrieve SMMUv3 specific data */
 	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
-	res[num_res].start = smmu->base_address;
-	res[num_res].end = smmu->base_address +
-				arm_smmu_v3_resource_size(smmu) - 1;
-	res[num_res].flags = IORESOURCE_MEM;
+	res[0].start = smmu->base_address;
+	res[0].end = smmu->base_address + arm_smmu_v3_resource_size(smmu) - 1;
+	res[0].flags = IORESOURCE_MEM;
+}
+
+static int __init arm_smmu_v3_init_irq_props(const struct property_entry **props,
+					     struct acpi_iort_node *node)
+{
+	u32 gsi[4], trigger[4], polarity[4];
+	struct acpi_iort_smmu_v3 *smmu;
+	unsigned int irq_count = 0;
+	const char *names[4];
+
+	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
 
-	num_res++;
 	if (arm_smmu_v3_is_combined_irq(smmu)) {
-		if (smmu->event_gsiv)
-			acpi_iort_register_irq(smmu->event_gsiv, "combined",
-					       ACPI_EDGE_SENSITIVE,
-					       &res[num_res++]);
+		acpi_iort_add_irq(smmu->event_gsiv, "combined",
+				  ACPI_EDGE_SENSITIVE, gsi, trigger,
+				  polarity, names, &irq_count);
 	} else {
+		acpi_iort_add_irq(smmu->event_gsiv, "eventq",
+				  ACPI_EDGE_SENSITIVE, gsi, trigger,
+				  polarity, names, &irq_count);
 
-		if (smmu->event_gsiv)
-			acpi_iort_register_irq(smmu->event_gsiv, "eventq",
-					       ACPI_EDGE_SENSITIVE,
-					       &res[num_res++]);
-
-		if (smmu->pri_gsiv)
-			acpi_iort_register_irq(smmu->pri_gsiv, "priq",
-					       ACPI_EDGE_SENSITIVE,
-					       &res[num_res++]);
-
-		if (smmu->gerr_gsiv)
-			acpi_iort_register_irq(smmu->gerr_gsiv, "gerror",
-					       ACPI_EDGE_SENSITIVE,
-					       &res[num_res++]);
-
-		if (smmu->sync_gsiv)
-			acpi_iort_register_irq(smmu->sync_gsiv, "cmdq-sync",
-					       ACPI_EDGE_SENSITIVE,
-					       &res[num_res++]);
+		acpi_iort_add_irq(smmu->pri_gsiv, "priq",
+				  ACPI_EDGE_SENSITIVE, gsi, trigger,
+				  polarity, names, &irq_count);
+		acpi_iort_add_irq(smmu->gerr_gsiv, "gerror",
+				  ACPI_EDGE_SENSITIVE, gsi, trigger,
+				  polarity, names, &irq_count);
+		acpi_iort_add_irq(smmu->sync_gsiv, "cmdq-sync",
+				  ACPI_EDGE_SENSITIVE, gsi, trigger,
+				  polarity, names, &irq_count);
 	}
+
+	return acpi_iort_get_irq_props(gsi, trigger, polarity, names,
+				       irq_count, props);
 }
 
 static void __init arm_smmu_v3_dma_configure(struct device *dev,
@@ -1732,54 +1740,55 @@ static int  __init arm_smmu_v3_set_proximity(struct device *dev,
 
 static int __init arm_smmu_count_resources(struct acpi_iort_node *node)
 {
-	struct acpi_iort_smmu *smmu;
-
-	/* Retrieve SMMU specific data */
-	smmu = (struct acpi_iort_smmu *)node->node_data;
-
-	/*
-	 * Only consider the global fault interrupt and ignore the
-	 * configuration access interrupt.
-	 *
-	 * MMIO address and global fault interrupt resources are always
-	 * present so add them to the context interrupt count as a static
-	 * value.
-	 */
-	return smmu->context_interrupt_count + 2;
+	return 1;
 }
 
 static void __init arm_smmu_init_resources(struct resource *res,
 					   struct acpi_iort_node *node)
 {
 	struct acpi_iort_smmu *smmu;
-	int i, hw_irq, trigger, num_res = 0;
-	u64 *ctx_irq, *glb_irq;
 
 	/* Retrieve SMMU specific data */
 	smmu = (struct acpi_iort_smmu *)node->node_data;
 
-	res[num_res].start = smmu->base_address;
-	res[num_res].end = smmu->base_address + smmu->span - 1;
-	res[num_res].flags = IORESOURCE_MEM;
-	num_res++;
+	res[0].start = smmu->base_address;
+	res[0].end = smmu->base_address + smmu->span - 1;
+	res[0].flags = IORESOURCE_MEM;
+}
+
+static int __init arm_smmu_init_irq_props(const struct property_entry **props,
+					  struct acpi_iort_node *node)
+{
+	struct acpi_iort_smmu *smmu;
+	unsigned int irq_count = 0;
+	u64 *ctx_irq, *glb_irq;
+	int i;
+
+	smmu = (struct acpi_iort_smmu *)node->node_data;
+
+	u32 *gsi __free(kfree) = kcalloc(smmu->context_interrupt_count + 1,
+					 sizeof(*gsi), GFP_KERNEL);
+	u32 *trigger __free(kfree) = kcalloc(smmu->context_interrupt_count + 1,
+					     sizeof(*trigger), GFP_KERNEL);
+	u32 *polarity __free(kfree) = kcalloc(smmu->context_interrupt_count + 1,
+					      sizeof(*polarity), GFP_KERNEL);
+	if (!gsi || !trigger || !polarity)
+		return -ENOMEM;
 
 	glb_irq = ACPI_ADD_PTR(u64, node, smmu->global_interrupt_offset);
-	/* Global IRQs */
-	hw_irq = IORT_IRQ_MASK(glb_irq[0]);
-	trigger = IORT_IRQ_TRIGGER_MASK(glb_irq[0]);
+	acpi_iort_add_irq(IORT_IRQ_MASK(glb_irq[0]), NULL,
+			  IORT_IRQ_TRIGGER_MASK(glb_irq[0]), gsi,
+			  trigger, polarity, NULL, &irq_count);
 
-	acpi_iort_register_irq(hw_irq, "arm-smmu-global", trigger,
-				     &res[num_res++]);
-
-	/* Context IRQs */
 	ctx_irq = ACPI_ADD_PTR(u64, node, smmu->context_interrupt_offset);
 	for (i = 0; i < smmu->context_interrupt_count; i++) {
-		hw_irq = IORT_IRQ_MASK(ctx_irq[i]);
-		trigger = IORT_IRQ_TRIGGER_MASK(ctx_irq[i]);
-
-		acpi_iort_register_irq(hw_irq, "arm-smmu-context", trigger,
-				       &res[num_res++]);
+		acpi_iort_add_irq(IORT_IRQ_MASK(ctx_irq[i]), NULL,
+				  IORT_IRQ_TRIGGER_MASK(ctx_irq[i]), gsi,
+				  trigger, polarity, NULL, &irq_count);
 	}
+
+	return acpi_iort_get_irq_props(gsi, trigger, polarity, NULL,
+				       irq_count, props);
 }
 
 static void __init arm_smmu_dma_configure(struct device *dev,
@@ -1803,16 +1812,7 @@ static void __init arm_smmu_dma_configure(struct device *dev,
 
 static int __init arm_smmu_v3_pmcg_count_resources(struct acpi_iort_node *node)
 {
-	struct acpi_iort_pmcg *pmcg;
-
-	/* Retrieve PMCG specific data */
-	pmcg = (struct acpi_iort_pmcg *)node->node_data;
-
-	/*
-	 * There are always 2 memory resources.
-	 * If the overflow_gsiv is present then add that for a total of 3.
-	 */
-	return pmcg->overflow_gsiv ? 3 : 2;
+	return 2;
 }
 
 static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
@@ -1837,10 +1837,22 @@ static void __init arm_smmu_v3_pmcg_init_resources(struct resource *res,
 		res[1].end = pmcg->page1_base_address + SZ_4K - 1;
 		res[1].flags = IORESOURCE_MEM;
 	}
+}
 
-	if (pmcg->overflow_gsiv)
-		acpi_iort_register_irq(pmcg->overflow_gsiv, "overflow",
-				       ACPI_EDGE_SENSITIVE, &res[2]);
+static int __init arm_smmu_v3_pmcg_init_irq_props(const struct property_entry **props,
+						  struct acpi_iort_node *node)
+{
+	u32 gsi[1], trigger[1], polarity[1];
+	struct acpi_iort_pmcg *pmcg;
+	unsigned int irq_count = 0;
+	const char *names[1];
+
+	pmcg = (struct acpi_iort_pmcg *)node->node_data;
+
+	acpi_iort_add_irq(pmcg->overflow_gsiv, "overflow", ACPI_EDGE_SENSITIVE,
+			  gsi, trigger, polarity, names, &irq_count);
+	return acpi_iort_get_irq_props(gsi, trigger, polarity, names,
+				       irq_count, props);
 }
 
 static struct acpi_platform_list pmcg_plat_info[] __initdata = {
@@ -1884,6 +1896,8 @@ struct iort_dev_config {
 	int (*dev_count_resources)(struct acpi_iort_node *node);
 	void (*dev_init_resources)(struct resource *res,
 				     struct acpi_iort_node *node);
+	int (*dev_init_irq_props)(const struct property_entry **props,
+				  struct acpi_iort_node *node);
 	int (*dev_set_proximity)(struct device *dev,
 				    struct acpi_iort_node *node);
 	int (*dev_add_platdata)(struct platform_device *pdev);
@@ -1894,6 +1908,7 @@ static const struct iort_dev_config iort_arm_smmu_v3_cfg __initconst = {
 	.dev_dma_configure = arm_smmu_v3_dma_configure,
 	.dev_count_resources = arm_smmu_v3_count_resources,
 	.dev_init_resources = arm_smmu_v3_init_resources,
+	.dev_init_irq_props = arm_smmu_v3_init_irq_props,
 	.dev_set_proximity = arm_smmu_v3_set_proximity,
 };
 
@@ -1902,12 +1917,14 @@ static const struct iort_dev_config iort_arm_smmu_cfg __initconst = {
 	.dev_dma_configure = arm_smmu_dma_configure,
 	.dev_count_resources = arm_smmu_count_resources,
 	.dev_init_resources = arm_smmu_init_resources,
+	.dev_init_irq_props = arm_smmu_init_irq_props,
 };
 
 static const struct iort_dev_config iort_arm_smmu_v3_pmcg_cfg __initconst = {
 	.name = "arm-smmu-v3-pmcg",
 	.dev_count_resources = arm_smmu_v3_pmcg_count_resources,
 	.dev_init_resources = arm_smmu_v3_pmcg_init_resources,
+	.dev_init_irq_props = arm_smmu_v3_pmcg_init_irq_props,
 	.dev_add_platdata = arm_smmu_v3_pmcg_add_platdata,
 };
 
@@ -1937,6 +1954,7 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 					   const struct iort_dev_config *ops)
 {
 	struct fwnode_handle *fwnode;
+	const struct property_entry *props = NULL;
 	struct platform_device *pdev;
 	struct resource *r;
 	int ret, count;
@@ -1994,6 +2012,20 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 	platform_device_set_fwnode(pdev, fwnode);
 
+	if (ops->dev_init_irq_props) {
+		ret = ops->dev_init_irq_props(&props, node);
+		if (ret)
+			goto dev_put;
+
+		if (props) {
+			ret = device_create_managed_software_node(&pdev->dev,
+								 props, NULL);
+			property_entries_free(props);
+			if (ret)
+				goto dev_put;
+		}
+	}
+
 	if (ops->dev_dma_configure)
 		ops->dev_dma_configure(&pdev->dev, node);
 
@@ -2007,6 +2039,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
 
 dma_deconfigure:
 	arch_teardown_dma_ops(&pdev->dev);
+	device_remove_software_node(&pdev->dev);
+	platform_device_set_fwnode(pdev, NULL);
 dev_put:
 	platform_device_put(pdev);
 

-- 
2.54.0

