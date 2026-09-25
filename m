Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D492472074;
	Fri, 25 Sep 2026 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322555; cv=none; b=PlZ8JJRmPwswDy0xUVLAA5eiqw5UKI7JnN/imH83+owA/D79X1r3WckzZQXbqikLuaObsBFoxG7dvMfjUo4Suoo4M1DB6s8/KyBjdpZRxQzeT2npHXCtvL6/Sp6AbT8AhdNfauU9A3MLyebZO9OvsRsKXUQJWqCkzTMdOdSK260=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322555; c=relaxed/simple;
	bh=r+D/BvKQct0YxVBqwtWQQhYdUnLFagDSNBTO4DRRw0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GO4eiQ/hxryzjNDbMHwzfqjJp4/pLWVaU9fOdVu7U+NRzuXUXSiJYhHCvZeyp4iSlEScAhNPTioBZNS3m52Ntj9ENcq/nlPNc/g7absV4QTCHHgfKKTcp7sp5fh1+kfSeCfiPVc/cyhCc9z7xIGKFB6dibfPtVOGA0Y7KeoZVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqaHETUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqaHETUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F96F1F00893;
	Fri, 25 Sep 2026 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322554;
	bh=ThxKXBdcGAVa3HEFR93seFrJ2tte9ths6R+UnHKtC8k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YqaHETUL2eC40mdJHh0euOmNn5P445obFRq5dZhIW9t9NHF3lShYPPwEc6hyuhIP0
	 fnXRYnux+hQQhIAt/HGA8WEqJVs7GM4h13BtRiETyEFXmbX5tHpXBn8U490qbaDD8q
	 0tghAg3bsI/brL3iCBm5L2jpYWPQxdtHVpb6KMIYyjrVJcpJDU3vjhu1Dp6naTEbqn
	 rwOlcUYRDfJWFhauJK7tTVykrP0okP/rxeG89yuU4bMzhlSfOh6HqvtlmcsWspalLS
	 oEUDs6Wcd97m8YFxocn4+rZyevt48fSfqdcpVVngIyvESpwRBt4ESKYT7aTF8av3eO
	 itQjsJlG2Gl5w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:10 +0200
Subject: [PATCH RFC 11/11] perf/arm-smmu-v3-pmu: Add IRQ mapping
 -EPROBE_DEFER handling
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-11-2c62125d0085@kernel.org>
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
controller the wired SMMU PMCG interrupts are routed to has not probed
yet when the SMMU PMCG driver probes.

Handle -EPROBE_DEFER gracefully for IRQ mappings failures.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 8ce34e6bb82b..d8d977c13ab9 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -893,6 +893,9 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_optional(pdev, 0);
+	if (irq == -EPROBE_DEFER)
+		return dev_err_probe(dev, irq, "failed to get PMCG IRQ\n");
+
 	if (irq > 0)
 		smmu_pmu->irq = irq;
 

-- 
2.54.0

