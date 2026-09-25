Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B247124D
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323358; cv=none; b=Vt+8KodK4DQNP3HNath5OKa+DQju48kGLEcr4zeXA82yuFVtTUxQ4t6oNAp+MDGv8Iy0ablEtdQ3fOtX6ZHPWsRCM+LHR/p+6gauViOw+hqgv4R8fxXQ3DWJFrt5tSNFVNVw4NETn2ifBe4XX1sY2CJhWYsaN1FON2EfgeBX2PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323358; c=relaxed/simple;
	bh=6ZsO5kYLFAVnH4TZrGoWDHVcqHxvmY3HIuBgwAlKpY4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hryi4FLDfa5KnZQMO90C3oF+uIhWXhdOqYkIxHa/S9pLZeYOlSWi2X1m1VbQzMsqquICcYtYy2jSJigIuFZ0yN1xP8v4mGDBUj5LULG/0WFh/4+7fvWKW5L0xKtc2c8ishohHw2iT6f+VjBrBmwZsuaPE3+Kmj6Cak4073d1INc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7HsF++t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7HsF++t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B621F000FF;
	Fri, 25 Sep 2026 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790323356;
	bh=ktGfl9zkYxzpagTZAcuiFPqTjjK6+R9TRnZnq+cXHig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7HsF++tzh/AIO+ZGVHB1Wi+9XkFL9F+nP0uJnIt5J10EbLHL04t6pK/ZgSY/A4sS
	 +vamXWUm1nN3yL3ppxRsT6Irl/46oTUTn545kiZ+j65HnMwje4ou1KQxujaTYS/K5v
	 eakAiwGBu7ksqQR8Z142dzKoRByvcZKzWvf2K8mUTkKN6OcS1t1BPnZ5+lG7wH2kF8
	 D35VDQ7oJ8dJjVnjTJfumwI4AAr4VCIomoIXy8ZLwUBJ8sCDNrXnJ6VzT3ftUpO+Is
	 JVLF5Umrv3ZNHM40KhJkTj6UsbJGMdMXvWTb9yMBjH47SKrqf4eeCjOpttQ1yOwgtE
	 IjKOhbKeLR02w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/11] ACPI: irq: Return -EPROBE_DEFER on missing
 IRQ domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-1-2c62125d0085@kernel.org>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-1-2c62125d0085@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 08:02:35 +0000
Message-Id: <20260925080236.46B621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] acpi: pci_irq: log spam on probe deferral in acpi_pci_irq_enable()
--

commit 0667d81cb886a83f2b22bddf3b8658a6b06b8549
Author: Lorenzo Pieralisi <lpieralisi@kernel.org>

ACPI: irq: Return -EPROBE_DEFER on missing IRQ domain

This commit modifies acpi_register_gsi() to return -EPROBE_DEFER when
the requested IRQ domain has not yet been registered. This allows
drivers to retry mapping the IRQ later once the interrupt controller
is available.

> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c

[ ... ]

> @@ -66,6 +68,10 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int=
 trigger,
>  		return -EINVAL;
>  	}
> =20
> +	domain =3D irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
> +	if (!domain)
> +		return -EPROBE_DEFER;

[Severity: Low]
Will this new return value cause log spam during probe deferral?

Looking at acpi_pci_irq_enable() in drivers/acpi/pci_irq.c, it seems
to log an unconditional warning for any negative return code from
acpi_register_gsi():

	rc =3D acpi_register_gsi(&dev->dev, gsi, triggering, polarity);
	if (rc < 0) {
		dev_warn(&dev->dev, "PCI INT %c: failed to register GSI\n",
			 pin_name(pin));
		kfree(entry);
		return rc;
	}

Could this path be updated to handle -EPROBE_DEFER silently so it
doesn't generate spurious warnings during a normal boot sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-acpi-stati=
c-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org?part=3D1
