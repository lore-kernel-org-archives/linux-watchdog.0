Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D8F2BEFE8
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 22:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194741; cv=none; b=T2vHLXGCY8HIhu/kqD09d9xlTQNuKo1kUpfv7B2tLj3vrCS3O2ReestmD4Zuy25fPfIIwZ7MHCAEOqfyicTjU9g1x1t49qBix4bFnp5xTewm6DXvhXQA95U8JyRXFhTY46xL7rAe7PKaYBgzY7bQLzK8c7Sm1f2TnWeWI8MmQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194741; c=relaxed/simple;
	bh=2nAswmiCAC9Vw0JCXCNSY5Xd1Pwl24lTC3+eIFe8Mo0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UwU2TjPOSommU9fquA61Jj6tq3qsqptqnNVmSZAys+qzm9KKMdszvc0ZBey7fgNjZpL5kENut344LBe2V3HVLGG0EGZGR7oRoZV8AwKBFi04BqoGgVglYUfjvCtGA1gOr1QgAkph6ASmxWOKFND9YeDKgv40+FEUPplfDP5RUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5bYPAsY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5bYPAsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84210C2BCB2;
	Thu,  7 May 2026 22:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778194740;
	bh=2nAswmiCAC9Vw0JCXCNSY5Xd1Pwl24lTC3+eIFe8Mo0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S5bYPAsY5p1qOO4EguNf4qU/1xkhTVDSKEp1ccyrG8o6cuFwO4cQzc2CbNnVq8EUb
	 9o9lnhYsFRp37492OPrvOxj+WYd0b3jpXSisqdy7CO9tBMEk2w9JJh5XINxpl/X7ZN
	 TAAcFOkeoRhOJCvCtuPq+KaJMeluQHtCEp7ykuAXJvtoT9WS2BUvbJAgwRIUZuEnuv
	 wBbNSrSYmYAiDs4Q/2JIXIrSM8I2XGAC6j/+KSZCfNvaJanHvw5lEltOEfcTAa9zF8
	 iYHKeOO1cIdYtAmtMzuiVVi5AAl9v9XLuZ7dyHlhcsXz7aQlqqKFqJPbwyoIef1CGW
	 XRbdmrLCiVToQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] clocksource/drivers/timer-tegra186: Fix support for
 multiple watchdog instances
Reply-To: sashiko@lists.linux.dev
To: "Kartik Rajput" <kkartik@nvidia.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260507154557.2082697-2-kkartik@nvidia.com>
References: <20260507154557.2082697-2-kkartik@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 22:58:59 +0000
Message-Id: <20260507225900.84210C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The read-modify-write sequence on the shared TKEIE register lacks =
synchronization, causing a data race when multiple watchdogs are enabled co=
ncurrently.
--

commit b62fcb75a56d43aa9fdaf906df5a4e961258346d
Author: Kartik Rajput <kkartik@nvidia.com>

clocksource/drivers/timer-tegra186: Fix support for multiple watchdog insta=
nces

This commit fixes support for multiple watchdog instances on Tegra186 by
changing the interrupt enable register update to a read-modify-write sequen=
ce.
This preserves the interrupt enable bits for previously configured watchdog=
s.

> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/t=
imer-tegra186.c
> index 355558893e5f3..bfe16d2d5104e 100644
> --- a/drivers/clocksource/timer-tegra186.c
> +++ b/drivers/clocksource/timer-tegra186.c
> @@ -149,7 +149,8 @@ static void tegra186_wdt_enable(struct tegra186_wdt *=
wdt)
>  	u32 value;
> =20
>  	/* unmask hardware IRQ, this may have been lost across powergate */
> -	value =3D TKEIE_WDT_MASK(wdt->index, 1);
> +	value =3D readl(tegra->regs + TKEIE(wdt->tmr->hwirq));
> +	value |=3D TKEIE_WDT_MASK(wdt->index, 1);
> +	writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));

Does this read-modify-write sequence need synchronization?

All watchdogs share the same TKEIE register since wdt->tmr->hwirq is
hardcoded to 0. Operations across different watchdog devices are not
serialized by the watchdog core, which only uses a per-device mutex.

If a userspace watchdog is started concurrently while a kernel watchdog is
being enabled, the read-modify-write sequences can overlap. If this happens,
one watchdog's interrupt enable bit can be silently overwritten and cleared.

Without its interrupt, the kernel watchdog could fail to ping itself,
resulting in an unintended system POR reset.

Could this shared MMIO register update be protected with a driver-level
spinlock in struct tegra186_timer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507154557.2082=
697-1-kkartik@nvidia.com?part=3D1
