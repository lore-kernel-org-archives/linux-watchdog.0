Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1602733B6F9
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197119; cv=none; b=FB59QwJrg6hLZ9JvfiPB/pjZ3+T0rk0vTApnsriWSDQ9MW5MT6dQ/YveFxCLUkT2FAL4+Ma1Ogh6pvycUgYDm5e+h5bTS1UVG4QWQri81K07SLS9D9t0fg1N2A9ziArfqxoWdrs9vudcQMXJoouB3E3ltmeJ8V7gBbsSuDe6gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197119; c=relaxed/simple;
	bh=o4rA0L1GhtJHJ9UkMs7QRbGwjx1tXhDVmUCF9E3ttsk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gBfd4p9sKaKGP7KjP41rQt77sdZSkAIRL6mDXlSHm9UlsMDANxV8NJZIOV4cmtxr1KTJC5YXuI1YGySkTwj+51VepEuWINzOy8fLJlzsmG36/yucOy0G9sU/1O0rmve1n2Bit/wWZY6qivXwtZNAJz6LDdULEsqd3L38bf0hCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mnB7LJ1w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mnB7LJ1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9669CC2BCB2;
	Thu,  7 May 2026 23:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197118;
	bh=o4rA0L1GhtJHJ9UkMs7QRbGwjx1tXhDVmUCF9E3ttsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mnB7LJ1wMoJ2eoFdGkbyH3gfTJUVMJrWtSvxhjQJkZDSrzUYM2GyVDpdR8C0IONJE
	 HYSksidxCEsgULGICIFMFPRn2TMfTw1KRXKn68ZPDvdyyuAIMt1ozjMoOCQ5rpiZlh
	 tevLbgq0sr35zlzgMTMVdyJw0HzkY2EiWGWSCPF3bO5q8yfql76d+KphVOo1T6RRX0
	 WNAGic/An8AOPa2wc4E3OFeVpBWkO3onXNs3COncKVIyNF1ExRSdf1y7/TZLIbOyVQ
	 uzslyPraWi5BOi9TOeL3w7wEzyR+mq631Ea1AcmC9OHD9yi6ZYZ79VxYeehDJQYEwy
	 /Vori2HmcHcMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] clocksource/drivers/timer-tegra186: Register all
 accessible watchdog timers
Reply-To: sashiko@lists.linux.dev
To: "Kartik Rajput" <kkartik@nvidia.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260507154557.2082697-4-kkartik@nvidia.com>
References: <20260507154557.2082697-4-kkartik@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 23:38:38 +0000
Message-Id: <20260507233838.9669CC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Data race on the shared TKEIE register during watchdog enable.
- [High] Hardware timer collision allows multiple watchdogs to clobber the =
same physical timer registers.
- [High] Missing bounds check on the timer source index allows out-of-bound=
s MMIO accesses.
--

commit 173c64a9e63a9e27e2f2b9544cfaa4b12f9d5f9c
Author: Kartik Rajput <kkartik@nvidia.com>

clocksource/drivers/timer-tegra186: Register all accessible watchdog timers

Tegra186+ SoCs expose multiple watchdog timers, but the driver only
registers WDT(0). Iterate over num_wdts and, for each WDT, check the SCR
(firewall) registers in the TKE block to determine whether Linux has read
and write access. Register the watchdogs that are accessible.

> diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/t=
imer-tegra186.c
> index fd82a73ab2d27..dd1d1a0dd63eb 100644
> --- a/drivers/clocksource/timer-tegra186.c
> +++ b/drivers/clocksource/timer-tegra186.c

[ ... ]

> @@ -442,12 +467,20 @@ static int tegra186_timer_probe(struct platform_dev=
ice *pdev)
>  	if (err < 0)
>  		return err;
> =20
> -	/* create a watchdog using a preconfigured timer */
> -	tegra->wdt =3D tegra186_wdt_create(tegra, 0);
> -	if (IS_ERR(tegra->wdt)) {
> -		err =3D PTR_ERR(tegra->wdt);
> -		dev_err(dev, "failed to create WDT: %d\n", err);
> -		return err;
> +	tegra->wdts =3D devm_kcalloc(dev, tegra->soc->num_wdts, sizeof(*tegra->=
wdts), GFP_KERNEL);
> +	if (!tegra->wdts)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < tegra->soc->num_wdts; i++) {
> +		if (!tegra186_wdt_is_accessible(tegra, i)) {
> +			dev_warn(dev, "WDT%u is not accessible\n", i);
> +			continue;
> +		}
> +
> +		tegra->wdts[i] =3D tegra186_wdt_create(tegra, i);

If the bootloader hasn't configured the watchdogs, could multiple watchdogs
extract the exact same source index and clobber each other's timer register=
s?

Looking at tegra186_wdt_create():

    value =3D wdt_readl(wdt, WDTCR);
    ...
    source =3D value & WDTCR_TIMER_SOURCE_MASK;
    wdt->tmr =3D tegra186_tmr_create(tegra, source);

If WDTCR contains its default reset value, multiple watchdogs could be
assigned the identical physical timer MMIO region, allowing userspace to
concurrently overwrite the same TMRCR and TMRCSSR registers.

Is a bounds check needed to prevent out-of-bounds MMIO accesses?
The WDTCR_TIMER_SOURCE_MASK allows values up to 15, but
tegra->soc->num_timers is only 10 for Tegra186. If a value like 14 or 15
is provided, the computed MMIO offset in tegra186_tmr_create() could fall
entirely outside the valid mapped memory region.

Finally, can concurrent watchdog operations race on the shared TKEIE regist=
er?

Looking at tegra186_wdt_enable():

    value =3D readl(tegra->regs + TKEIE(wdt->tmr->hwirq));
    value |=3D TKEIE_WDT_MASK(wdt->index, 1);
    writel(value, tegra->regs + TKEIE(wdt->tmr->hwirq));

Since hwirq is 0, all watchdogs access the exact same physical register. The
watchdog core's wdd->lock mutex only serializes operations on a per-device
basis. Concurrent start or ping operations to different watchdog devices
could cause one CPU's read-modify-write sequence to overwrite another's,
losing interrupt unmasks.

> +		if (IS_ERR(tegra->wdts[i]))
> +			return dev_err_probe(dev, PTR_ERR(tegra->wdts[i]),
> +					     "failed to create WDT%u\n", i);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507154557.2082=
697-1-kkartik@nvidia.com?part=3D3
