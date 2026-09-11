Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDA3CF211;
	Fri, 11 Sep 2026 11:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126094; cv=none; b=jqXXU7PVuhXGS+4XYoYO9Lgow/bP2LeUrCbiqnV+nKwvptowzY5Z0kuGxH9f5sVWo5J8Zeay7Fmtd9IRRxaaM//l1yp6ciGvvg1QL12I/R5WLSjE7SnNfKfDINHJxlA/p94mqA4xQS3SsHR9XmVZVL+lZ/CFJKTQ5SqPlu/OWgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126094; c=relaxed/simple;
	bh=xbnxK4tLRkxl8Gp4C/P9lmiim5qYnJUBCXLJ/WiMIoY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kYnsdbDRLRfn5u0fJl1weHbXM5tG76Eh/7jKKPIsmKJlb6tTbJbu/NKFHEyrNpuJwSZoospI8jiEB+gqFoEZP1Yj22ZCQM8HuTNVUdY02a2BtFS6yDyH4Y3hluar9gYrqPspqrxryR8FxVn3uJJl7WkXKSb9eJQn8txV3Vq71DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0/Fjj8G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0/Fjj8G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EA91F000FF;
	Fri, 11 Sep 2026 11:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126084;
	bh=+6VZTcR9KFIMbU2hhLfOKg+bWCK6Zt/d8g44O4ss7Ec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D0/Fjj8GuXdTDPQl0pnyslCc4YZAKRR3kBJuUmogTlyHKKi+4btqrMqBO6tAPVr2F
	 bANFw5+4jjTDdtyojLbsFzjEdFeapTgTct7NQrIVGmtSd9uSBVufUdX3WftXJZEgGn
	 v3xra6JK/TX6WrVERn1TZb8Yg+oYwlBQMKu3iZkgjEiP2awsYmhUToZWv2CxcfICke
	 xzNE72uDaGUgIOQkFJVDPAkoE1M/mOOg7l6kt7pxw55vD0mMXvDxoN+gCgC8YB2b03
	 xq7QDapK37+sJxCZr9Eb7tJf5JhwgSq8qjWClBbp2jDga0iUsTo1xajJZabcGOpXei
	 OGd5Ld0HNvPVw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260911111731.3404308-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:28:03 +0000
Message-Id: <20260911112804.39EA91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Watchdog restart handler may deadlock during system panic because =
it executes a locked regmap operation on a syscon regmap.
--

commit a3a7e98fdd4da0cb2994accaf697498b31aba4d4
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Add syscon support for WDTDCR

This commit introduces syscon regmap support for the WDTDCR (WDT Debug Cont=
rol
Register) on RZ/T2H and RZ/N2H SoCs. It retrieves the SYSC regmap using the
"renesas,sysc" property and derives the WDTDCR offset from the watchdog
instance index, while preserving MMIO compatibility when the property is ab=
sent.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index 550112446db49..9dee410ab7f31 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

>  static inline int rzt2h_wdt_wdtdcr_count_start_nolock(struct rzv2h_wdt_p=
riv *priv)
>  {
> -	return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTR=
L);
> +	struct rzv2h_sysc_wdtdcr *sysc =3D &priv->sysc;
> +
> +	return regmap_clear_bits(sysc->regmap, sysc->offset, WDTDCR_WDTSTOPCTRL=
);
>  }

[Severity: High]
Does this introduce a deadlock risk during a system panic?

The watchdog restart handler, rzv2h_wdt_restart(), expects an unlocked
execution path to avoid deadlocks and specifically calls this nolock varian=
t:

	if (priv->of_data->wdtdcr) {
		/*
		 * Best effort, ignore return value and use the unlocked
		 * variant of the function to avoid potential deadlocks.
		 */
		rzt2h_wdt_wdtdcr_count_start_nolock(priv);
	}

Previously, the driver used a dedicated MMIO regmap with
.disable_locking =3D true. Now that sysc->regmap can be a syscon regmap,
which is shared and uses internal spinlocks, regmap_clear_bits() will attem=
pt
to acquire the syscon lock.

If the system panics while another CPU holds this shared syscon spinlock,
will attempting to acquire it here cause the panic handler to hang instead =
of
resetting the system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911111731.3404=
308-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
