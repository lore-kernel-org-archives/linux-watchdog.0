Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11DE2F8EB0;
	Sat,  9 May 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778347669; cv=none; b=pMdLVA97axiXexUmSUMyaDDIZfdkoW+RZcejJwUAkjdHQ+Q4hxFiUYeDd5sYkVl1tbuj95ocz57p0gR3C1te3bV3lusG7jafa0UnL4prnLEkAqUlNfJAe+0ooI1yBqmTJYHiCtZfn2YNK3TZ/NrSkXQxoW12538u78bKVHYOli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778347669; c=relaxed/simple;
	bh=hMPjQBgfEYnKDogqqXy0vIBawh5fuGxKdeHMMpN+u4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qxsFjln9mdrihLPETvfwwD2pQ0r10lqmRgJcLKSCq0usx2tUCTb10GxBScf37tQ66BE5gz0zCO2Psf69Y7aPZ0sjWUlzOlxycjaXDAbaE3gn7uuwSNRgzoRLDrlWSyORgzorFSyOIbfsyxfWO1WpRPB5pVn6VdfHS2/GmoqZpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogHmft3Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogHmft3Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B33C2BCB2;
	Sat,  9 May 2026 17:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778347668;
	bh=hMPjQBgfEYnKDogqqXy0vIBawh5fuGxKdeHMMpN+u4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ogHmft3QiJ4xlr9I+o4p+i7YHW96SAErwi7asQdGpFowasb/FMA8s0IxC+YoJwdWu
	 J/gkMocGtVEPYfOZEC0q7FT5ZJbH9yxNgtWIseUdq8XCfSzE0YD9ZrChLs+XPdAfF/
	 0Hz/oUApWQI/1FVdFSVpKkdCVLl3uB6JMf/R/xUPs4g3C3RCllcaYQckAuWbaAVCMW
	 QrxHQBhC4hfDn5hV9GX78uQVW4nJJO69xwyPcSUPp45LmO0ItnZgtcCHMdOgcfG15+
	 J2SATVvaJ7/5IkZE+bRH2U2isyc2arZlOJySmjCL2lEJK30bch39JEwd/VrC17cSwo
	 2IzCQtcG9AdZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] watchdog: realtek-otto: add RTL9607C support
Reply-To: sashiko@lists.linux.dev
To: "Rustam Adilov" <adilov@disroot.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260509163101.722793-4-adilov@disroot.org>
References: <20260509163101.722793-4-adilov@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 09 May 2026 17:27:47 +0000
Message-Id: <20260509172748.54B33C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Registers accessed before peripheral clock is enabled
- [High] Sleeping function `disable_irq()` called in atomic restart handler
- [High] Integer underflow in timeout calculation causes massively delayed =
watchdog reset
--

commit be1a33571f33f241ada324d2648ec90cdf1e9b91
Author: Rustam Adilov <adilov@disroot.org>

watchdog: realtek-otto: add RTL9607C support

The RTL9607C SoC has a watchdog timer identical to the already
supported SoCs. The peripheral is memory mapped at 0x18003260
and driven by the Lexra bus clock.

> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realt=
ek_otto_wdt.c
> index e5e9cb480f4f9..7ad196802eeb5 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
> @@ -355,6 +355,7 @@ static const struct of_device_id otto_wdt_ids[] =3D {
>  	{ .compatible =3D "realtek,rtl8390-wdt" },
>  	{ .compatible =3D "realtek,rtl9300-wdt" },
>  	{ .compatible =3D "realtek,rtl9310-wdt" },
> +	{ .compatible =3D "realtek,rtl9607-wdt" },

This isn't a bug introduced by this patch, but enabling this driver for the
new SoC exposes a few existing regressions in the code.

For example, can the driver safely access the peripheral's memory-mapped
registers before its clock domain is enabled?

otto_wdt_probe() {
[ ... ]
	/* Clear any old interrupts and reset initial state */
	regmap_write(ctrl->regmap, OTTO_WDT_REG_INTR,
		     OTTO_WDT_INTR_PHASE_1 | OTTO_WDT_INTR_PHASE_2);
	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, OTTO_WDT_CTRL_DEFAULT);

	ret =3D otto_wdt_probe_clk(ctrl);
[ ... ]
}

Writing to OTTO_WDT_REG_INTR and OTTO_WDT_REG_CTRL before calling
otto_wdt_probe_clk() might violate hardware access requirements and could
cause a synchronous external bus abort or system hang during driver probe.

Also, does the system restart handler sleep in an atomic context?

otto_wdt_restart() {
[ ... ]
	disable_irq(ctrl->irq_phase1);
[ ... ]
}

The otto_wdt_restart() function is a system restart handler executed in an
atomic context with local interrupts disabled. Since disable_irq() internal=
ly
invokes synchronize_irq(), which uses wait_event() to wait for executing
interrupt handlers to finish, it can sleep.

Calling a sleeping function with local interrupts disabled triggers a kernel
panic, and waiting for an IRQ handler to complete while other CPUs are stop=
ped
during a machine restart can result in a hard deadlock. Should this use
disable_irq_nosync() instead?

Finally, is there an integer underflow in the timeout calculation?

otto_wdt_determine_timeouts() {
[ ... ]
		total_ticks =3D div_round_ticks(timeout_ms, tick_ms, 2);
		phase1_ticks =3D div_round_ticks(timeout_ms - pretimeout_ms, tick_ms, 1);
		phase2_ticks =3D total_ticks - phase1_ticks;
[ ... ]
	val |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
[ ... ]
}

If the pretimeout is configured to 0 (or a value small enough that it maps =
to
the same tick interval), total_ticks and phase1_ticks evaluate to the exact
same value, resulting in phase2_ticks =3D 0.

Since phase2_ticks is an unsigned integer, 0 - 1 underflows to 0xFFFFFFFF,
which FIELD_PREP masks to the maximum field value of 31. Does this configure
the hardware to delay the system reset by 32 ticks (over 5 seconds) instead
of the intended minimum of 1 tick?

>  	{ }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260509163101.7227=
93-1-adilov@disroot.org?part=3D3
