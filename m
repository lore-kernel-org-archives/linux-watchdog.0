Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0F1449997;
	Fri, 25 Sep 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790322501; cv=none; b=pCxjFKnYriXL5WtIDiXJ7cPL/SE+Nw3gplCMY2ccit00a1/+gmnnHhc0P94Uq0cGUHQ67hbg/UKBPGJ+H8igykEhTvDo5SstEIEXxjaytdPgdFn0pit/Xy/QNrxZwB3D3Lw/vgqK2eWeLBX8FBZEFMCRfV3qSqV7qvh8ccW6/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790322501; c=relaxed/simple;
	bh=EMIPLRBMei4Zbcu9YR/n8KjREbq8tJBDG72/MPfUCLk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAZhF1Ff5Fr1QGUGEDtlOsrsbg4k7Q5fR9aTbg8G9gxO5ZftwjXCEJaDICnpTfyCmnKVUob9YRNBIGxlecmFc/7Xz0PUKPULfacImkA39nrwpOlptghB9cLF2ZHfA3L0pYyWBGH86+PhMOhA3fDF3+0vMVEnJH2ThN64Uub/F/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Xea86y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Xea86y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595131F00893;
	Fri, 25 Sep 2026 07:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790322500;
	bh=FHWMNT3PPvKZVD3OrrYw2bJ/4OkVhqGq7qA3NsaEVms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W+Xea86yoT/vqZxhkS2jDSThHP1mQgJVf5EKnlFjUQ3ifH4w3YeCFBP1W8z24XjjX
	 K4GX8MYCHcQmUxfjEuYiDhbt69ojn9HnJQ3JHqugAgCXDEvz4pAv9kViHktUPnZv0q
	 s3s/lLp5y4D5Nz4DbddcepTtJekk8EBoIiqkdUGNwHSIN1W0Y9xbt22e5zMv8HGbLn
	 //KGSvWItTHo0iDtvW+MiXqbEVzFpknqzP+eWEoyJl3haLbvIwoleQws7OFWkj6ZmE
	 ktAg0icGIByE0XJvSIPBP0k8x87FriRZMg9pxHQE/W853xbYIEOL28V8ciCam6YNvu
	 vPCtm9NYoH0cA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Fri, 25 Sep 2026 09:48:00 +0200
Subject: [PATCH RFC 01/11] ACPI: irq: Return -EPROBE_DEFER on missing IRQ
 domain
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpi-static-table-irq-probe-defer-v1-1-2c62125d0085@kernel.org>
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

acpi_register_gsi() might fail if the IRQ domain a GSI belongs to has
not been registered yet by the respective interrupt controller driver.

Return -EPROBE_DEFER in this case so that the mapping can be retried
later by deferring the probe for the driver that requested the IRQ
mapping.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/acpi/irq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index e4293458bf61..d1f1938c83bf 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -52,11 +52,13 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
  * @polarity: polarity of the GSI to be mapped
  *
  * Returns: a valid linux IRQ number on success
+ *          -EPROBE_DEFER when the domain was not yet registered
  *          -EINVAL on failure
  */
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
+	struct irq_domain *domain;
 	struct irq_fwspec fwspec;
 	unsigned int irq;
 
@@ -66,6 +68,10 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		return -EINVAL;
 	}
 
+	domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
+	if (!domain)
+		return -EPROBE_DEFER;
+
 	fwspec.param[0] = gsi;
 	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
 	fwspec.param_count = 2;

-- 
2.54.0

