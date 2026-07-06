Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3AF29ACFD;
	Mon,  6 Jul 2026 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350032; cv=none; b=pKSywdbtDAeoypGs/MHws9bZARocnVQepsP8Q7T3996+TS4Mq72zBPZGaICOa06SNnv3c5/Va3xwyxZj553UuqAXV85qsZxaBdSwUdnFg9mfTYPCAVb5x7Mj2eH+Gzv6blRPE0vwgIYkfVs4QSRaOJB/LUufvULZHIMTyTLVl0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350032; c=relaxed/simple;
	bh=GcuqGVARAN2P0Z38QSCLFf86LIxHJXHWpB4ihBoPsrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QYeJyX2wVOPx4W1s+hPMMVSYQ1sUYfcnEapw0g9HOGKCxH40hqho4WTYgf7TXvbE+pLz48Sl5uaYRscJ2KekJDpcY7kBHpk1OQkErHcywtqUtrhNrxfvobGpEdJ1VLt84UZSxAc4tEIYN/QTR+KNDnwCd7vHgVG3M/HK4JNX164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMWmXxLT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMWmXxLT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75751F000E9;
	Mon,  6 Jul 2026 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783350031;
	bh=QrFONjaRMgWLuXBPOo3+Xely/bDI8uFbLaTccxBNAF4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fMWmXxLT7A5G0iabjPSQNdCCxNU4Q3SDy0/Y2NtlMEepm0dYUoTuWlsOSAPsgrQ78
	 0+S2qKF0bzBDu1DHueGN4R5NXiCV6gzcbN3mTDpunE6PXKLnTdPQpgYnQ0+rO1YyAi
	 jMTPkfHzMXKkOuempMF0Ft0roYR4fdRd8VT4My92PEMQLJ2J5KPZHfiV8uNNIt6k3j
	 kbkbAX6jtGQgFjmlFsFS1JGejemr7VgFaAwaoOSGbk16y3J98NV2ImM4V47agOGBjW
	 5fXMcwkzdvUhL8jsSnymADltjjKzSQwx3S+r6N/5teQqo+07Jjts/3j7luXodtIXkG
	 LYwbechqbgK5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] watchdog: npcm: add bootstatus support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tomer Maimon" <tmaimon77@gmail.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260706144828.3517631-4-tmaimon77@gmail.com>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
 <20260706144828.3517631-4-tmaimon77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 15:00:29 +0000
Message-Id: <20260706150030.A75751F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Non-atomic read-modify-write on shared syscon registers (INTCR2/RE=
SSR) introduces a TOCTOU race and mishandles W1C semantics.
- [High] Overloading standard watchdog API boot status flags with generic S=
oC reset reasons violates UAPI semantics.
--

commit dac8bb6ae40a2614c654ebac31d7674dfeed0f47
Author: Tomer Maimon <tmaimon77@gmail.com>

watchdog: npcm: add bootstatus support

This commit adds bootstatus support to the NPCM watchdog driver. It reads
the RESSR and INTCR2 registers via the sysgcr regmap during probe and maps
them into watchdog bootstatus flags.

> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index e62ea054bc618..82ff3956dcf21 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c

[ ... ]

> +static const struct npcm_wdt_status_map npcm750_status_map[] =3D {
> +	{ NPCM_PORST, WDIOF_OVERHEAT },
> +	{ NPCM_CORST, WDIOF_FANFAULT },
> +	{ NPCM_SWR1RST, WDIOF_EXTERN1 },
> +	{ NPCM_SWR2RST, WDIOF_EXTERN2 },
> +	{ NPCM_SWR3RST, WDIOF_POWERUNDER },
> +	{ NPCM_SWR4RST, WDIOF_POWEROVER },
> +};

[Severity: High]
Does this map standard SoC resets to specific watchdog error conditions?

If NPCM_PORST (Power-On Reset) triggers WDIOF_OVERHEAT, and NPCM_CORST
(Core Reset) triggers WDIOF_FANFAULT, won't userspace daemons receive
fabricated hardware failure events on normal cold boots or warm reboots?

[ ... ]

> +static const struct npcm_wdt_status_map npcm845_status_map[] =3D {
> +	{ NPCM_PORST, WDIOF_OVERHEAT },
> +	{ NPCM_CORST, WDIOF_FANFAULT },
> +	{ NPCM_SWR1RST, WDIOF_EXTERN1 },
> +	{ NPCM_SWR2RST, WDIOF_EXTERN2 },
> +	{ NPCM_SWR3RST, WDIOF_POWERUNDER },
> +	{ NPCM8XX_TIP_RESET, WDIOF_POWEROVER },
> +};

[Severity: High]
Are these reset-to-status mappings similarly overloading the standard
watchdog API boot status flags for the NPCM845?

[ ... ]

> +	if (of_device_is_compatible(dev->of_node, "nuvoton,npcm845-wdt")) {
> +		ret =3D regmap_read(gcr_regmap, NPCM_INTCR2_OFFSET, &rstval);
> +		if (ret) {
> +			dev_warn(dev, "Failed to read INTCR2 reset status: %d\n",
> +				 ret);
> +			return;
> +		}
> +
> +		if (rstval & NPCM_RST) {
> +			ret =3D regmap_write(gcr_regmap, NPCM_INTCR2_OFFSET,
> +					   rstval & ~NPCM_RST);

[Severity: High]
Is it safe to use a non-atomic read-modify-write on this shared syscon
register?

If INTCR2 is a Read-Write register, this regmap_read() followed by
regmap_write() introduces a time-of-check to time-of-use race that could
overwrite and lose concurrent modifications made by other drivers sharing t=
his
sysgcr regmap.

Alternatively, if the reset bits are Write-1-to-Clear (W1C), writing
rstval & ~NPCM_RST writes 1s to all OTHER active status bits. This would
unintentionally clear them while writing 0 to the target watchdog bit, fail=
ing
to clear it.

> +			if (ret) {
> +				dev_warn(dev,
> +					 "Failed to clear INTCR2 reset status: %d\n",
> +					 ret);
> +				return;
> +			}

[ ... ]

> +	} else if (of_device_is_compatible(dev->of_node, "nuvoton,npcm750-wdt")=
) {
> +		ret =3D regmap_read(gcr_regmap, NPCM_RESSR_OFFSET, &rstval);
> +		if (ret) {
> +			dev_warn(dev, "Failed to read RESSR reset status: %d\n",
> +				 ret);
> +			return;
> +		}
> +
> +		if (rstval & NPCM_RST) {
> +			ret =3D regmap_write(gcr_regmap, NPCM_RESSR_OFFSET,
> +					   rstval & ~NPCM_RST);

[Severity: High]
Does this write to NPCM_RESSR_OFFSET have the same non-atomic
read-modify-write or W1C clearing issues as INTCR2 above?

> +			if (ret) {
> +				dev_warn(dev, "Failed to clear RESSR reset status: %d\n", ret);
> +				return;
> +			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706144828.3517=
631-1-tmaimon77@gmail.com?part=3D3
