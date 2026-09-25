Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532447126D;
	Fri, 25 Sep 2026 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322550; cv=none; b=kl5OQf3vWWDbfyPdOWc0LOvAIKeYnF8xkhHUo0AB/uAJ+aNy5HftT2bsDOAdXltCcM3xmiipUAQuDiKzFZRsa+zO9gcH7TlB7JLLbMVWRMQjn7bNjF9hfXeeI2ZBu+EYOCuU/M0FnbNG0nL8SwPWnzhfz1E4mRaXKGJFsZ43rg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322550; c=relaxed/simple;
	bh=ezOBSU0uFSpEDHTDU5gfPMtd7UyNgDzEZKkzSpeL+co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uv1ZW0uKbIcK9zlE9kPsQmCgfrD4kPM2iH+tfsJXqVHonnlBxNDuB2tynZYa2CfAyxoZrM6TOQOoOkuCHT85pIdn+E5krnmygMWuF7jhRgwQab85AwMpRnsbel1iKAmKx7w3sJ3e8C+N3KJoHSTaEl56BNDibl9mOYnjZioEuaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV61sFDm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV61sFDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4111F000FF;
	Fri, 25 Sep 2026 07:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322549;
	bh=AAVRqCmTFl1INQ4GWLQBmb/9F8qh8Im4ZaqVBVS7Nk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iV61sFDmiXtKzqIoYYMzCr/gNo/Xbp02ea54IKoci0Bnxo4nPmxATJM96hCW6EzMs
	 Ugc+s2DzBuenaujXmxpCFOiU2p6oKYM+jh2Rs65yCdGJOEyk2EK+B4mcUOpdFEYOd9
	 XnBn/NMD3FI0HbcXmiF1O5bUyH7z5OURjmoYjkIRimHjIANjv/r+H9g9HeIMtuhJLz
	 sxVdqAtvXtqOwt8ZfEPgbLn3rK1HqNgoM6Eh2gpYJv1DkptQn/kfF3pw9/Y9XFL3EY
	 x2u61sCfQe9Ts+oidTPsC9kpEt/t7vtcEF9R285wYWRUnL7muS9HRYu3MPSQpnyeZ8
	 EisWYoFEUD3BA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:09 +0200
Subject: [PATCH RFC 10/11] iommu/arm-smmu-v3: Add IRQ mapping -EPROBE_DEFER
 handling
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-10-2c62125d0085@kernel.org>
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
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5732f3ba0122..1832389916a4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5562,18 +5562,26 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 	/* Interrupt lines */
 
 	irq = platform_get_irq_byname_optional(pdev, "combined");
+	if (irq == -EPROBE_DEFER)
+		return dev_err_probe(dev, irq, "failed to get combined IRQ\n");
 	if (irq > 0)
 		smmu->combined_irq = irq;
 	else {
 		irq = platform_get_irq_byname_optional(pdev, "eventq");
+		if (irq == -EPROBE_DEFER)
+			return dev_err_probe(dev, irq, "failed to get eventq IRQ\n");
 		if (irq > 0)
 			smmu->evtq.q.irq = irq;
 
 		irq = platform_get_irq_byname_optional(pdev, "priq");
+		if (irq == -EPROBE_DEFER)
+			return dev_err_probe(dev, irq, "failed to get priq IRQ\n");
 		if (irq > 0)
 			smmu->priq.q.irq = irq;
 
 		irq = platform_get_irq_byname_optional(pdev, "gerror");
+		if (irq == -EPROBE_DEFER)
+			return dev_err_probe(dev, irq, "failed to get gerror IRQ\n");
 		if (irq > 0)
 			smmu->gerr_irq = irq;
 	}

-- 
2.54.0

