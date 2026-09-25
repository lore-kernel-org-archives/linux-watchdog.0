Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C04570C7
	for <linux-watchdog@vger.kernel.org>; Fri, 25 Sep 2026 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790323206; cv=none; b=pkGpLi/m0FSmAe26uD5Y4kJ95bD+tuobxOAAVpEc9Us+Gd8iV0c7TF3pCb6Vpv/YK6pO9o+/T1sF6p6q3JmVNWWasdylem1OAixgwOYftsscqWbMQYFAXM/BFvlvMd8UYbQy9zbAfpsSHb1kZ0vIiQnu9Fx6lGcBEJfr8IaGMaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790323206; c=relaxed/simple;
	bh=6LFv67EG2P0TSmhWGmNhd+i41TxnNaXrieAHZaTGr/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CX4bKiQb44gmWqp54syAUWtv0yIe5yq7OblCvXjwUWNQkYPG6BdBNWWM4eZTVmrN3P24JtdPPq263unu3MV0ocP17AIFpp5389byOtJJ8VadvGEY17VsZA1y7mBVwDyZWzx3HvNt0lHe3eitoggp/EVJNpP8+Q7FZ0vHa29utVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRKgGtx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRKgGtx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1691F000FF;
	Fri, 25 Sep 2026 08:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790323205;
	bh=xKwQNfsYCqVRI8aWoCB+DuW9mS5V9ltCJIlQBgP5nbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRKgGtx6OjsHxi7GFYB9nN02oyv0mAsjOjRjXHQz1WrTdE/niIVNQ5VHNPG5PtWa2
	 ecXVnMQjf1sEBQoJ62h1YY0Mfr7Ak1ukjsz+tYytcuQhjKQmRYQiJrdkWCTOUl1kka
	 zHXTKOvE4TFIyrWCp6nbjFnqUwqPPlGGcNXEDfvPuKkukuDUdspJgBMuG28W9yXguB
	 45ISlNtZx204KqaI0uYQaFn8gqwix6AONVwV8h/4pFoWufyJcf4dxDBDibkRyWVDI8
	 UpgpTj288qSRlYS2MUFsjtilVr9E2b7YaW0YCuO9Wv8iwnnZlvmSApn7zMw4ny1C2Z
	 HYdbdz9HC47Tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/11] driver core: platform: Add static ACPI nodes
 IRQ retrieval/mapping code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Pieralisi" <lpieralisi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260925-acpi-static-table-irq-probe-defer-v1-3-2c62125d0085@kernel.org>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-3-2c62125d0085@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 08:00:02 +0000
Message-Id: <20260925080004.DE1691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] build: missing stub for is_acpi_static_node() without CONFIG_ACPI
--

commit b41affe79039335ffe21336e9e4a7ec0763dd61a
Author: Lorenzo Pieralisi <lpieralisi@kernel.org>

driver core: platform: Add static ACPI nodes IRQ retrieval/mapping code

This commit adds support for retrieving and mapping IRQs for static ACPI
fwnodes by modifying platform_get_irq_affinity() to call fwnode_irq_get().

> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 66f9ec73d47e9..413c73332308e 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -228,6 +228,12 @@ int platform_get_irq_affinity(struct platform_device=
 *dev, unsigned int num,
>  		goto out;
>  	}
> =20
> +	if (is_acpi_static_node(fwnode)) {

[Severity: Low]
Does this cause a build failure when CONFIG_ACPI is disabled?

It looks like is_acpi_static_node() is called unconditionally in
platform_get_irq_affinity(), but the definition in acpi/acpi_bus.h is
strictly guarded and only included when CONFIG_ACPI is enabled.

Should a stub for is_acpi_static_node() be added to linux/acpi.h in the
!CONFIG_ACPI block (similar to is_acpi_device_node()) to prevent an implicit
declaration error on non-ACPI configurations?

> +		ret =3D fwnode_irq_get(fwnode, num);
> +		if (ret > 0 || ret =3D=3D -EPROBE_DEFER)
> +			goto out;
> +	}
> +
>  	/*
>  	 * For the index 0 interrupt, allow falling back to GpioInt

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-acpi-stati=
c-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org?part=3D3
