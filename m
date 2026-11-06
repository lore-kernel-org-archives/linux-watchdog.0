Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959147;
	b=ZTaoy20ti0NQsmVGUZHBvERnwFjIaQE7unp61TrBDogotQhCWoB0fAx4XcHw6JrAgz+u
	 h/v0xs+oYj+8RSBpYyyAbTVEPwvKEokMtdCGGr2PcWASBDRtWy0tpmAdv2n4COKH6h6RX
	 h+fvdtqsokIb41+4MnWAJT0qHhnAsr0o+wGyyA7xC0snh+bzqEj3cW3YGmw+KL1vDg8HX
	 sfvq75wml5LOZKSU83rXQcyEL5dCG+chHVLSNbcddTynMRMkuyoSAQ/MUheVahdlKSvlu
	 h8zttNvwbqWJ1MSrmBbZxQaeLauTo1uQboEnzcrVGgNSNofdDr2lJ6lolo9LrZtDXuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959147;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=URtsFZrOncTBadDaPbRBozwKL5R8OwhE2UgxEKs7KTQ=;
	b=5tuPFqRX/V8j8hvrut8rrSFWHJB3cHRI0Z0FABJL8LYMHSUdOwAns5Cos5qvrxWvxIvM
	 EVVi6eu3UtOuo1hThT2uKb/eFZ0ZNjAbiFoEsDdt0Deaq3AVEJhNf+C7bsDUtfj6tWiT+
	 oFUnchbRY+PrC1Ef/F6Qn7dCuswN1Up2/L7/q2PBFHo+z0hiNdwF//raSXxCTPX8cYxVg
	 sqin6epPQ8yGk28EFQqw3M1OGbnhMx9N9iRSbfFzZmymrV17GAEPMrEMxisijmkmeNH5Q
	 DdAlnRluW+ca817sKDOm/SOv0efI4pU/Cf4fX80JoFU9GrKMQYgm9MOXVMhzgpyk1Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQl+nO6E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00374606A32D;
	Fri,  6 Nov 2026 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dQl+nO6E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12A931F008A1;
	Fri,  6 Nov 2026 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793959146;
	bh=URtsFZrOncTBadDaPbRBozwKL5R8OwhE2UgxEKs7KTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dQl+nO6E40aTdSZOvAHhiESg8uo2SvxKnudxK4416vR2YqkIy5Mja/W4FoKsq34V4
	 90Fqi0kSok5RZNlUf36DklI+GkQ+Hbc94GmTolIW7Ub4EE7oYG+ICfDm/Oi21Rvg/b
	 YhQqNyRUVEB6lR2MuPwuvC5GMiEFsLn9N8qfqAkXG/vNjKahI7pLjIP8vv5ZwXiLjj
	 7HFAetA6VPboTwe9JR+80zEBUAkJa0xnSnPbvZGsmr+Y8dkg0yv+D2rV9cc/SjnsKR
	 qjAmFOf0paqiw+WML7PpVWfCY+s9Y4B0bsJ0f/aeDJgNB+Q3VJVLqHDhYggKmIOGjJ
	 YXjmUeqkFSXoA==
Message-ID: <sashiko-outbox-201165@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/25] mmc: sdhci-of-dwcmshc: add MT2824 tuning and
 HS400 support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmVub8OudCBNb25pbg==?= <benoit.monin@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-phy@lists.infradead.org, linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com
In-Reply-To: <20261106-mt2824-v1-21-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
 <20261106-mt2824-v1-21-86087eaf5af4@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 09:59:05 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] mmc: sdhci-of-dwcmshc: improper HS400 PHY DLL handling in
  mt2824_set_clock()
- [Medium] mmc: sdhci-of-dwcmshc: incomplete error rollback in
  mt2824_execute_tuning()
- [Low] mmc: sdhci-of-dwcmshc: duplicate PHY DLL register macros for
  MT2824
--

commit 6e69732340199284e68817329ed4f3bf3f474149
Author: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

mmc: sdhci-of-dwcmshc: add MT2824 tuning and HS400 support

This commit adds software tuning over the 128-tap sampling delay line, a
filter for stray data interrupts during tuning, and manual PHY DLL locking
for HS400 mode on the Metanoia MT2824 controller.

> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci=
-of-dwcmshc.c
> index cb248fc572e21..324ae93295af0 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
[ ... ]
> @@ -98,6 +103,10 @@
>  #define MT2824_PHY_TXSLEW_P_STROBE		0x3
>  #define MT2824_PHY_SMPLDL_CNFG			0x0c
>  #define MT2824_PHY_ATDL_CNFG			0x0c
> +#define MT2824_PHY_DLL_CNFG1			0x20
> +#define MT2824_PHY_DLLDL_CNFG			0x60
> +#define MT2824_PHY_DLL_LOCKED			BIT(0)
> +#define MT2824_PHY_DLL_LOCK_ERR			BIT(1)

[Severity: Low]
This isn't a bug, but these macros duplicate the Synopsys DWC MSHC PHY DLL
definitions already present in this file (PHY_DLL_CNFG1_SLVDLY_MASK /
PHY_DLL_CNFG1_SLVDLY, PHY_DLLDL_CNFG_SLV_INPSEL_MASK /
PHY_DLLDL_CNFG_SLV_INPSEL, DLL_LOCK_STS, and DLL_ERROR_STS), while
mt2824_set_dll() already uses the shared PHY_DLL_*_R register offsets.

[ ... ]

> @@ -2271,6 +2281,38 @@ static int mt2824_phy_init(struct sdhci_host *host=
, bool v1v8)
>  	return 0;
>  }
> =20
> +/* HS400 needs the PHY DLL locked on the card clock; lock it by hand */
> +static void mt2824_set_dll(struct sdhci_host *host)
> +{
> +	u16 clk;
> +	u8 status;
> +	int ret;
> +
> +	clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +	clk &=3D ~SDHCI_CLOCK_CARD_EN;
> +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +	sdhci_writeb(host, MT2824_PHY_DLL_CNFG1, PHY_DLL_CNFG1_R);
> +	sdhci_writeb(host, MT2824_PHY_DLLDL_CNFG, PHY_DLLDL_CNFG_R);
> +
> +	sdhci_enable_clk(host, clk);
> +	usleep_range(10, 20);
> +
> +	sdhci_writeb(host, PHY_DLL_CTRL_ENABLE, PHY_DLL_CTRL_R);
> +	ret =3D read_poll_timeout(sdhci_readb, status,
> +				status & MT2824_PHY_DLL_LOCKED, 10, 150000,
> +				false, host, PHY_DLL_STATUS_R);
> +	if (ret) {
> +		dev_err(mmc_dev(host->mmc), "PHY DLL did not lock: 0x%02x\n",
> +			status);
> +		return;
> +	}
> +
> +	if (status & MT2824_PHY_DLL_LOCK_ERR)
> +		dev_err(mmc_dev(host->mmc), "PHY DLL locked with error: 0x%02x\n",
> +			status);
> +}
[ ... ]
> @@ -2332,6 +2374,11 @@ static void mt2824_set_clock(struct sdhci_host *ho=
st, unsigned int clock)
>  	if (clock)
>  		mt2824_enable_clk(host, sdhci_calc_clk(host, clock,
>  						       &mmc->actual_clock));
> +
> +	if (clock && host->timing =3D=3D MMC_TIMING_MMC_HS400) {
> +		mt2824_set_dll(host);
> +		dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +	}
>  }

[Severity: High]
Does mt2824_set_clock() try to lock the HS400 PHY DLL at 52 MHz and then
fail to re-lock it when the clock is raised to 200 MHz?

During HS400 selection in mmc_select_hs400() (and mmc_select_hs400es()),
the MMC core calls mmc_set_timing(host, MMC_TIMING_MMC_HS400) while
host->clock is still 52 MHz, before calling mmc_set_bus_speed(card) to
switch to 200 MHz.  Because mt2824_set_clock() only checks for a non-zero
clock in MMC_TIMING_MMC_HS400, the first call enables PHY_DLL_CTRL_R at
52 MHz.  Neither mt2824_set_clock() nor mt2824_set_dll() ever writes
PHY_DLL_CTRL_DISABLE to PHY_DLL_CTRL_R, so when mmc_set_bus_speed() later
calls mt2824_set_clock() at 200 MHz, the clock is stopped and changed
while the DLL stays enabled, and writing PHY_DLL_CTRL_ENABLE again never
creates a 0-to-1 enable transition to lock onto the 200 MHz clock.
Leaving HS400 (such as via mmc_hs400_to_hs200()) also leaves the DLL
enabled at lower speeds.

Should PHY_DLL_CTRL_R be disabled before changing the clock, and only
configured and enabled when host->timing is MMC_TIMING_MMC_HS400 and the
clock is above 52 MHz?

[ ... ]

> @@ -2460,6 +2507,156 @@ static void mt2824_hw_reset(struct sdhci_host *ho=
st)
[ ... ]
> +	/*
> +	 * AT_CTRL_R must not be written while SAMPLE_CLK_SEL is set: enable
> +	 * software tuning first, then select the tuned sampling clock.
> +	 */
> +	at_ctrl =3D sdhci_readl(host, at_ctrl_reg);
> +	sdhci_writel(host, at_ctrl | AT_CTRL_SW_TUNE_EN, at_ctrl_reg);
> +	ctrl2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	sdhci_writew(host, ctrl2 | SDHCI_CTRL_TUNED_CLK, SDHCI_HOST_CONTROL2);
> +	/*
> +	 * That HOST_CONTROL2 write breaks the response of the next command:
> +	 * send one tuning command for nothing before the scan.
> +	 */
> +	mmc_send_tuning(host->mmc, opcode, NULL);
> +	host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
[ ... ]
> +fail:
> +	/* clear SAMPLE_CLK_SEL before AT_CTRL_R is written again */
> +	sdhci_reset_tuning(host);
> +	sdhci_writel(host, at_ctrl, at_ctrl_reg);
> +	host->ops->reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +	sdhci_end_tuning(host);
> +	WRITE_ONCE(dwc_priv->flags, dwc_priv->flags & ~FLAG_SW_TUNING);
> +	return ret;
> +}

[Severity: Medium]
If a re-tuning pass fails after an earlier tuning pass succeeded, does the
fail path leave AT_CTRL_SW_TUNE_EN enabled with the delay line stuck at the
last scanned phase?

A successful mt2824_execute_tuning() call leaves AT_CTRL_SW_TUNE_EN set in
at_ctrl_reg, so on a subsequent tuning run at_ctrl is read with
AT_CTRL_SW_TUNE_EN already set.  If that scan fails, writing at_ctrl back
verbatim does not clear AT_CTRL_SW_TUNE_EN, leaving software tuning active
with DWCMSHC_AT_STAT set to phase 127.  In addition, sdhci_reset_tuning()
modifies the low byte of SDHCI_HOST_CONTROL2 while the card clock is
enabled without a dummy command or stopping the card clock around the
reset, which on this controller breaks the response of the next command.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-mt2824-v1-=
0-86087eaf5af4@bootlin.com?part=3D21
