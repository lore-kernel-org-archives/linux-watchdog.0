Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB279396565;
	Fri, 25 Sep 2026 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322518; cv=none; b=Qc8x+KvwV0rpgfbF40l6cUWZfEgiWn2Q1ew2rv3+WXd4k11WCCbiN17QtRBTUATYso2jj4WavPCnAWUX+EBaMZ7qObz1eVg1zpt4HoWEslWPe3LreJAYFQc2vl859PpO5APoMMREUPBXp3/fsvaiAd+Qa2gyeR6HSFbiXvbDIzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322518; c=relaxed/simple;
	bh=bteHt1N81hFbq1U3KECSm5eGFA8A2QGbB3GTmwRQK3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4+wUGgExaCD0PNADdrvgYWfvw5rS1Kw1g3vInLG1iVk4zDs8Mpq4qfqOaGyjbutTmlOVQ57IX8dAKQYMxZjvgXLMXISJgDKqAy/mqOaNQ2b7FUlssql2gfq2BwyhvbpnzMaRYhq4GedZTtXk22/KJBs2J8UuJWOWzDEdX1bWQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpEHIegP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpEHIegP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6FF1F000FF;
	Fri, 25 Sep 2026 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322516;
	bh=/OOfgjQxMjGX08q/r6dj/8dQnsOf9sej1vvHwcv9Vck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LpEHIegPKzUVlrkOLNpoL0ngOMJlprMq1b+rdJXcMA6wbG/crOWY74u3z1m3oByaF
	 IRsb+JvYJE/il9O2UF7+fR1bX9vSFlZAVp2Ds12u4AGs5HYwFTr58/nEI7aE27V44R
	 ZoubgELe2oPQ5HT9s/duVu5mhrqElkaCpB5lM6THMfiAR5gMBVxyrCl0ThfoYMnahl
	 e3FIoLEABvWS61Nen+BUaDu2kUppexJysr+4aNiiz8U7kjGUuvax/Ai67WxCvcmbGY
	 w8WnaYgjpv47z2Lx+HsYwBCHUF5zzEafTJHLFhKfXnHE3h77mXSAgpzzp0Tmg2td/K
	 TiZsvgBXBt6xw==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:03 +0200
Subject: [PATCH RFC 04/11] clocksource/drivers/arm_arch_timer_mmio: Dispose
 IRQ mappings on probe failure
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-4-2c62125d0085@kernel.org>
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

On probe failure the driver does not dispose the IRQ mappings that
were carried out before the probe function hit an error condition.

Add code to dispose the IRQ mappings on driver probe failure.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/clocksource/arm_arch_timer_mmio.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/arm_arch_timer_mmio.c
index d678f764d3bb..c3f2fe39bdd2 100644
--- a/drivers/clocksource/arm_arch_timer_mmio.c
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -191,6 +191,34 @@ static irqreturn_t arch_timer_mmio_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+static void arch_timer_mmio_unmap_irq(int *irq)
+{
+	if (irq && *irq) {
+		irq_dispose_mapping(*irq);
+		*irq = 0;
+	}
+}
+
+static void arch_timer_mmio_unmap_frame_irqs(struct arch_timer_mem_frame *frame)
+{
+	arch_timer_mmio_unmap_irq(&frame->phys_irq);
+	arch_timer_mmio_unmap_irq(&frame->virt_irq);
+}
+
+static void arch_timer_mmio_unmap_irqs(struct arch_timer_mem *gt_block)
+{
+	int i;
+
+	for (i = 0; i < ARCH_TIMER_MEM_MAX_FRAMES; i++) {
+		struct arch_timer_mem_frame *frame = &gt_block->frame[i];
+
+		if (!frame->valid)
+			continue;
+
+		arch_timer_mmio_unmap_frame_irqs(frame);
+	}
+}
+
 static struct arch_timer_mem_frame *find_best_frame(struct platform_device *pdev)
 {
 	struct arch_timer_mem_frame *frame, *best_frame = NULL;
@@ -398,6 +426,7 @@ static int arch_timer_mmio_probe(struct platform_device *pdev)
 
 	frame = find_best_frame(pdev);
 	if (!frame) {
+		arch_timer_mmio_unmap_irqs(at->gt_block);
 		dev_err(&pdev->dev,
 			"Unable to find a suitable frame in timer @ %pa\n",
 			&at->gt_block->cntctlbase);

-- 
2.54.0

