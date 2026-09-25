Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D23C396565;
	Fri, 25 Sep 2026 07:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322528; cv=none; b=g4KxnjoZGV7fLQQ0pnKDXPTlWb8k77vn/oLi7uII/l2+sFBsmhbYG/3C3AQU822AT+Cy2qbLUfzxflFhCqGFeteLEU1b3zG4OhmzdfOYlk/OqCCDH79LtRVLa24EOQk4KQ4GJgB7k92Q+kF1F1m5ogvkRrlHx7YYwVqLuryj/jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322528; c=relaxed/simple;
	bh=06UMUUUZdD+vN8e7M7aEs7jmJZWpCnGWQVzSI31UjXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cqj5UcIcWIPDnuN8IltK7c0aELH2krcmpM9beNLslkc4AjOwBAu4cfupeUTwozrUPgdamwNJjohtxaRQANEoaxzQ55Ww6bzuERGZ2BJANQ0enVBwlrnMjIi5MM67r9m+B34l6HeniEyTEcA2uQXmEGvdAKx7DQCx/WkgO3yfD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0oImPua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0oImPua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1361F000FF;
	Fri, 25 Sep 2026 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322527;
	bh=apu+eWIFih4GKT/9zim27bmrNdjaXSLS/ggUiM6AIgo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a0oImPua4rQg6d5MbC3NAIYACTwFhQT10f+SAHXyIWkdLglIvUCaMd0XY0Q+92/gV
	 UUVDk8qj+DoEmmPcBTe54TuY8I4Jz2q12bAGVoWrJc5i/vv6rMT4XqyOGFrQsTvEHJ
	 rC6i/ZXvttkG1n97JbicYHj8WF2edAXLRssIbuG9x/rhmzy84QrKklkFHQkJdqJBci
	 2O54pBzMM9IUGJ6/kTInLBZO0J1ZfUfVB1e3kcJiiHbY8ml+wkZ8XPXr+/Hwpr8TBa
	 2o2pcCbEY2zig6rdxYJTeVG1iPu5I03MIflcg4EFlDtMvUSYiNhKGAfnC3Z4qTB6Nx
	 frsZYDqro2y8w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:05 +0200
Subject: [PATCH RFC 06/11] ACPI: GTDT: Convert SBSA watchdog to IRQ
 properties
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-6-2c62125d0085@kernel.org>
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

SBSA watchdog IRQs might be wired to interrupt controllers that are
probed after the SBSA watchdog is probed and therefore the IRQ mappings
cannot be carried out at platform device creation but deferred to
SBSA watchdog probing through the platform_get_irq*() set of APIs.

To do that, stash the GSI number, trigger, polarity into standard
properties attached to a software node that is attached to the
platform device ACPI static fwnode, allowing the SBSA driver to
retrieve those properties and map the IRQ when the SBSA driver
is probed.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/acpi/arm64/gtdt.c | 63 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/arm64/gtdt.c b/drivers/acpi/arm64/gtdt.c
index d7248684b2c5..8629895d18c2 100644
--- a/drivers/acpi/arm64/gtdt.c
+++ b/drivers/acpi/arm64/gtdt.c
@@ -336,8 +336,11 @@ static int __init gtdt_parse_timer_block(struct acpi_gtdt_timer_block *block,
 static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 					int index)
 {
+	struct property_entry props[4] = {};
 	struct platform_device *pdev;
-	int irq;
+	u32 gsi[1], triggering[1], polarity[1];
+	struct fwnode_handle *fwnode;
+	int ret, nr_res = 2;
 
 	/*
 	 * According to SBSA specification the size of refresh and control
@@ -346,9 +349,7 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 	struct resource res[] = {
 		DEFINE_RES_MEM(wd->control_frame_address, SZ_4K),
 		DEFINE_RES_MEM(wd->refresh_frame_address, SZ_4K),
-		{},
 	};
-	int nr_res = ARRAY_SIZE(res);
 
 	pr_debug("found a Watchdog (0x%llx/0x%llx gsi:%u flags:0x%x).\n",
 		 wd->refresh_frame_address, wd->control_frame_address,
@@ -359,26 +360,58 @@ static int __init gtdt_import_sbsa_gwdt(struct acpi_gtdt_watchdog *wd,
 		return -EINVAL;
 	}
 
-	irq = map_gt_gsi(wd->timer_interrupt, wd->timer_flags);
-	res[2] = DEFINE_RES_IRQ(irq);
-	if (irq <= 0) {
-		pr_warn("failed to map the Watchdog interrupt.\n");
-		nr_res--;
-	}
-
 	/*
 	 * Add a platform device named "sbsa-gwdt" to match the platform driver.
 	 * "sbsa-gwdt": SBSA(Server Base System Architecture) Generic Watchdog
 	 * The platform driver can get device info below by matching this name.
 	 */
-	pdev = platform_device_register_simple("sbsa-gwdt", index, res, nr_res);
-	if (IS_ERR(pdev)) {
-		if (irq > 0)
-			acpi_unregister_gsi(wd->timer_interrupt);
-		return PTR_ERR(pdev);
+	pdev = platform_device_alloc("sbsa-gwdt", index);
+	if (!pdev)
+		return -ENOMEM;
+
+	ret = platform_device_add_resources(pdev, res, nr_res);
+	if (ret)
+		goto dev_put;
+
+	fwnode = acpi_alloc_fwnode_static();
+	if (!fwnode) {
+		ret = -ENOMEM;
+		goto dev_put;
 	}
 
+	platform_device_set_fwnode(pdev, fwnode);
+
+	if (wd->timer_interrupt) {
+		gsi[0] = wd->timer_interrupt;
+		triggering[0] = (wd->timer_flags & ACPI_GTDT_INTERRUPT_MODE) ?
+			ACPI_EDGE_SENSITIVE : ACPI_LEVEL_SENSITIVE;
+		polarity[0] = (wd->timer_flags & ACPI_GTDT_INTERRUPT_POLARITY) ?
+			ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
+
+		props[0] = PROPERTY_ENTRY_U32_ARRAY(ACPI_IRQ_PROP_GSI, gsi);
+		props[1] = PROPERTY_ENTRY_U32_ARRAY(ACPI_IRQ_PROP_GSI_TRIGGER,
+						    triggering);
+		props[2] = PROPERTY_ENTRY_U32_ARRAY(ACPI_IRQ_PROP_GSI_POLARITY,
+						    polarity);
+
+		ret = device_create_managed_software_node(&pdev->dev, props, NULL);
+		if (ret)
+			goto fwnode_free;
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto fwnode_free;
+
 	return 0;
+
+fwnode_free:
+	device_remove_software_node(&pdev->dev);
+	platform_device_set_fwnode(pdev, NULL);
+	acpi_free_fwnode_static(fwnode);
+dev_put:
+	platform_device_put(pdev);
+	return ret;
 }
 
 static int __init gtdt_platform_timer_init(void)

-- 
2.54.0

