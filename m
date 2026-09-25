Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D02A4582E7;
	Fri, 25 Sep 2026 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322545; cv=none; b=ly4HK4pqTRZ5uBtV+D603SbUt1HNBCCiWqUr6VfsaKSmeIgcpODTzqKEJJuQN5XVVWR9nHQR5Z4fLCD9rkSjRZ5I6OWP1cQVgkXM4zOkzENOKOQm/sQlPS/yUlkRiUsqLu8X7ViW9YFFuqTG4oUOmmGjriCJHYSB6itsju4yceU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322545; c=relaxed/simple;
	bh=FMY9m/9vekqnzd40lM/BIMSpzkxukbACmWfuNvJqkok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQgwr6VHwFUoXMDDbzJA2dZsdrspR3ZrrhCjz1XrQVWetyhHmwO1SVqYGellsDIFwMMhdKJu4BnDHLYK6/f/NNCNoGFmUuqD41qB/wNWdJ3l+bCC9fjDvgCEAQ4zHfJhbFNeCy7nekZJKWUx/jIiZsL7mBl5t6i49rMsLGGgmeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY2kkkVb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY2kkkVb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903B21F00893;
	Fri, 25 Sep 2026 07:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322543;
	bh=bbS6RVxPwSJkhIbaoq1cDhXQrT6Zk0hyEGnIaNM8PH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TY2kkkVbvwuQLcFikGbNiXx2TM/xYBOBVA/RwbDzi6SZOY0n3IPQgpfBCZ90+FH6V
	 QgYyFdmARNyN0aPpfsxBos5sfP4T/hQEaZUb0SoLzz5blq5CLqFqiSpjBzF3wI47XR
	 9dp3igO4g8VtwU701v1aBscSVkp1Lvzag54p0ODXDFUv8OVahZ2K8AdmnzAHgzHP60
	 tm8jAdHrULcsY3hJpTpjmlA/X7VNUWR/ybl5affhj2EIoKGJ+mXYl3V/jHfcnq4fTo
	 O3V+LSgLn1bS6RApaa8O8Jp1ESaLK7Bl4iEJLfBKTTJILz5cJ8AMwdhRioQHu6egPo
	 bHpbRZuHgsw2g==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:08 +0200
Subject: [PATCH RFC 09/11] iommu/arm-smmu: Add arm-smmu IRQ mapping
 -EPROBE_DEFER handling
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-9-2c62125d0085@kernel.org>
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

With the advent of GICv5, IRQs mapping can fail if the interrupt
controller the wired SMMU interrupts are routed to has not probed
yet when the SMMU driver probes.

Handle -EPROBE_DEFER gracefully for IRQ mappings failures.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 889a0966d36c..a111b80553da 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2154,6 +2154,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return PTR_ERR(smmu);
 
 	num_irqs = platform_irq_count(pdev);
+	if (num_irqs < 0)
+		return dev_err_probe(dev, num_irqs, "IRQ count failed\n");
 
 	smmu->num_context_irqs = num_irqs - global_irqs - pmu_irqs;
 	if (smmu->num_context_irqs <= 0)
@@ -2171,7 +2173,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		int irq = platform_get_irq(pdev, global_irqs + pmu_irqs + i);
 
 		if (irq < 0)
-			return irq;
+			return dev_err_probe(dev, irq, "failed to get context IRQ\n");
 		smmu->irqs[i] = irq;
 	}
 
@@ -2211,7 +2213,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		int irq = platform_get_irq(pdev, i);
 
 		if (irq < 0)
-			return irq;
+			return dev_err_probe(dev, irq, "failed to get global IRQ\n");
 
 		err = devm_request_irq(dev, irq, global_fault, IRQF_SHARED,
 				       "arm-smmu global fault", smmu);

-- 
2.54.0

