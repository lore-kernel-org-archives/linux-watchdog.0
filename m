Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103A331A6E
	for <linux-watchdog@vger.kernel.org>; Tue,  4 Aug 2026 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785836459; cv=none; b=t6+zsKootAP30w9trJWJ/HTV21yKTaB9pjo+hxmyh97L8Iairem4LR53Z6IjIGIpUHOUNE3pCCvA2vWXTBk+tdzMRec5RuOeA7dE6UFvlASdcTm4uKrIzMustG/JCQBqaaWls+CwY56saXcUu/JQklQ/2lLj07jAwEJ0H6GL0VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785836459; c=relaxed/simple;
	bh=ohYeTY9fvZxvfaqlTO59y0qvyL9i65k0kpI+QgugQ7w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fJpZDZGehDbKTP/nrfsYqqFIq1xEl0TNlk4x+rLF5V0UGaH8sTtsm8jQoBCex3SQHbkQFDneJHb3TzeYGTFwogYz01gXk0O6DB3qCgYUsej9n1i/bz5W7akRa4YnxGHzN3lUndtQc/g8IXtuIlEh4mCwSXL7en+X+7OsxeG+ZJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmIc/vxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmIc/vxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71951F000E9;
	Tue,  4 Aug 2026 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785836458;
	bh=/Cs23YDHedlKQvDhIUBw9gZOHhfgxr406tAe7C9eg4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kmIc/vxiCzVN7ECH7NpN2UkLKuiFF9zF2TDsYd3C75pLyUZBl0CQySIM9Z3LQpfp2
	 M0YdQRxzafZDH/thj9sXfJUF/UBUYZy9iqrz5dV4WXN6t3dFxvYKFfvNLlRvJydXip
	 8NqCqnkFbk+8Fm/54gne4fVaBXK+LaT7pXR7cEvePcwtHwjccOnxGWvriHTWGU3CH2
	 le5zhCS6lpmfDMoFyLj+RX6Z+xELpxeWVQQuueV07llwpGmqKPU8lrEPgXBJ66Uby2
	 lYXMYd/+3VHaypmKrbJrC6f3x6OOkGDoNXaRWjtZiYV7rU8VeOGJ63Acl/8dKSiPFi
	 LHoVBkoD5lpqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: wdat_wdt: map registers that fall inside ACPI
 NVS
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UmVuw6ogZGUgU291emEgUGludG8=?= <rene@renesp.com.br>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260804092337.3556947-1-rene@renesp.com.br>
References: <20260804092337.3556947-1-rene@renesp.com.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 09:40:56 +0000
Message-Id: <20260804094057.C71951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Calling `devm_ioremap_resource()` triggers an unconditional `dev=
_err()` when it fails with `-EBUSY`, causing confusing and spurious errors =
in the kernel log on systems with ACPI NVS.
--

--- Patch [1]: [PATCH] watchdog: wdat_wdt: map registers that fall inside A=
CPI NVS ---
commit fe186a236b35b9dc11c6a76632ffa54de7cc01ba
Author: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>

watchdog: wdat_wdt: map registers that fall inside ACPI NVS

This commit fixes an issue where the WDAT watchdog fails to probe on system=
s=20
where its registers reside in ACPI NVS memory (like the OnLogic Karbon 524)
by falling back to devm_memremap() when devm_ioremap_resource() returns -EB=
USY.

> diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
> index dd3c2d69c9df1..a56224cf8d22d 100644
> --- a/drivers/watchdog/wdat_wdt.c
> +++ b/drivers/watchdog/wdat_wdt.c

[ ... ]

> @@ -309,6 +311,33 @@ static struct watchdog_ops wdat_wdt_ops =3D {
>  	.set_timeout =3D wdat_wdt_set_timeout,
>  };
> =20
> +static void __iomem *wdat_wdt_map_mem(struct device *dev, struct resourc=
e *res)
> +{
> +	resource_size_t size =3D resource_size(res);
> +	void __iomem *reg;
> +	void *addr;
> +
> +	/* Try standard reservation + ioremap first */
> +	reg =3D devm_ioremap_resource(dev, res);
> +	if (!IS_ERR(reg) || PTR_ERR(reg) !=3D -EBUSY)
> +		return reg;

[Severity: Medium]
Since devm_ioremap_resource() internally calls dev_err() when it fails,
will this unconditional call log a spurious error before the driver has
a chance to execute the expected ACPI NVS fallback?

Could this be avoided by checking region_intersects() for=20
IORES_DESC_ACPI_NV_STORAGE before attempting the reservation, rather than
relying on devm_ioremap_resource() to fail first?

> +
> +	/* If busy, check if conflict is due to ACPI NVS memory */
> +	if (region_intersects(res->start, size, IORESOURCE_MEM,
> +			      IORES_DESC_ACPI_NV_STORAGE) !=3D REGION_INTERSECTS)
> +		return reg; /* Real conflict, return -EBUSY */
> +
> +	dev_warn(dev, "%pR is inside ACPI NVS, mapping without reservation\n", =
res);
> +
> +	addr =3D devm_memremap(dev, res->start, size, MEMREMAP_WB);
> +	if (IS_ERR(addr)) {
> +		dev_err(dev, "failed to map resource %pR\n", res);
> +		return IOMEM_ERR_PTR(PTR_ERR(addr));
> +	}
> +
> +	return (void __iomem __force *)addr;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804092337.3556=
947-1-rene@renesp.com.br?part=3D1
