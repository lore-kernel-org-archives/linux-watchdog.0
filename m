Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E179472084;
	Fri, 25 Sep 2026 07:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322539; cv=none; b=U03x8Jh5De2BnAik7poewppm0KH2P+pX6s2rdeYz8DhtFHN6eLDCXtHtCEufbhH/0BeoEYKKUlDpenBf8aKMZbhKmbdzKtBh1862E2A8aWAkH9aSHJ4lHR8J87g6UswDorRsKVJfSPEkQ3U1kFn+oIC7ZrTu7p8bcmAqzJRn/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322539; c=relaxed/simple;
	bh=lmiaQsFOeoq1gGI6UcePP3szDVF43L1R6Q7Sj9EUSC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dutwv4RIpxN+HRiEICPxeIkdSaePmQVMcKVE2jV+Sv+Ja8WRtFnNP7Fl5EkUB1xi7IOhogAUEQbYXuLL9m6YlxvyQXZwT8s0ijtsrOORtJDoVgdDiKNTQvTBqN01bimZvkRO/5OPfpll33DrOL+Wu8guNLoWM4HBRAscRB+s4N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKrj8br+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKrj8br+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB0E1F000FF;
	Fri, 25 Sep 2026 07:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322538;
	bh=sF0dixNrgeRrqEBHGwyG3rSBg8PFvcFXKVkqUoBGccE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oKrj8br+yyMGql6WAL28O44NGK9xg8+/0v/QTJcWDf9KP3WBbObLMOYATX4qBOdX7
	 VVjPsOTLmNNU7ZMHKf3B1AKww1WJ7sYjHbGEn5PQIM7Wx4zEKS6HGL+l6/ZTrAmrii
	 uutf+YHiOGMFiaY53JnxWU1xTi7Fs98aZcEXhD3NbY728tEkMffIGUvsejxkSBGisw
	 T0HXt4uPQrgGMKJGu6ON3dSM7OLieUukGWaeekCJ6eVons3/fguR2xFEAqZZ0vjjQX
	 w8IfLVzdPfoPEWlnf8kA05rOF/hmQL0y/jvld+6202JvbmR7HKs9Lzgxoj/eu6QXTg
	 MUdBDTM/E23aA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:07 +0200
Subject: [PATCH RFC 08/11] watchdog: sbsa: Handle IRQ probe deferral
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-8-2c62125d0085@kernel.org>
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

The SBSA watchdog might be wired up to an interrupt controller whose
device driver has not probed yet at SBSA watchdog driver probe time.

Handle probe deferral in the IRQ mapping code path.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
---
 drivers/watchdog/sbsa_gwdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index e04d42cc7774..f4491409caf5 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -352,6 +352,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 
 	if (action) {
 		irq = platform_get_irq(pdev, 0);
+		if (irq == -EPROBE_DEFER)
+			return dev_err_probe(dev, irq, "failed to get ws0 interrupt\n");
 		if (irq < 0) {
 			action = 0;
 			dev_warn(dev, "unable to get ws0 interrupt.\n");

-- 
2.54.0

