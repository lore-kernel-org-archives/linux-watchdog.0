Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D338C423
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 19:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735584; cv=none; b=Cjnbm/3Sx+/2QrRIJgf2DbDeQs9flhPx0vQSLwexBGVkRGJ1DD+8eCgmZSzz90AnXyz113rJ8dvzBTr5CxGDiMbmJ8rEr7UaaQmwKJp3tv87uxkL2CIYRXNXdEdNqXAcRyKuo2BNFgfQGYNscHs09DwBKCcvTp9r/y5+bMMApKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735584; c=relaxed/simple;
	bh=Nskg3BPbcC6s1Yjk2aTf3f96WVOWwT+VtHUqakJUeyo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gQXdHszur561+odYMFzAfJjEmWgL4Bhc+2WIjYPNM7RYs8jzQOXPF9FENuuI8Tu6z18PpPv7YqD9WWzS2JLwj9FUf4NOTx1FYdpXzK4fhYvNXYXuo6CAORrvhr2kRDTV2C3LEn/9PX0tCpJuV1NuAye4rYP8WT5XYBHwLkwqydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad7f5xmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad7f5xmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9251F000E9;
	Fri, 14 Aug 2026 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786735583;
	bh=zMn9+TPxYOkxqyW3my67nsPqDcAZ40bEU+WalBoZm6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ad7f5xmSaxuw9ygZyw/DSvQRIAdk5M7DsTn61NbzaQvjXrrEXIRzkBko4Jvhn+lT5
	 wot/uEssBoFKG7OnzWhogJWp5dqzN/nCb8HW0RkT0KUaxrZCadHp0HwYRqPQeOiq5s
	 hdE4ZcJpSYJ46WglYLSq4oHVHgjpbzYVMABBQu8M9jkhCKtCApYcRDm22Vd09pKaMd
	 pEuFn4dMuj501F+TF6SOWSZ+Eek/a5/SNF88Fr/PPgWYb8a3FjsarwhvXU0TQV8/69
	 pRD7q8qcGh4j2kHfcJI9klfe3GTiDpsWrxiccLYWQvcVzL8nzxUS2HbCbRPDtd+JtA
	 zszAhSIbGy1tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] watchdog: rzv2h: Convert WDTDCR handling to
 regmap
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260814191415.2110732-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814191415.2110732-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 19:26:22 +0000
Message-Id: <20260814192623.2A9251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Using a regmap configured with `use_raw_spinlock =3D true` in the =
watchdog restart handler introduces a deadlock if a panic occurs while anot=
her CPU holds the regmap lock.
- [High] The watchdog restart handler inappropriately aborts on regmap erro=
rs, silently preventing system reboot.

Pre-existing issues:
- [High] Calling `clk_enable()` from `rzv2h_wdt_restart()` can cause deadlo=
cks if another CPU holds the corresponding framework spinlocks during a pan=
ic.
--

--- Patch [2]: [PATCH v3 2/3] watchdog: rzv2h: Convert WDTDCR handling to r=
egmap ---
commit 81d528488e87b317129eaa95c0076e2e770f3265
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: watchdog: rzv2h: Convert WDTDCR handling to regmap

This commit converts the WDTDCR register access from raw readl/writel
variants over to the regmap framework using devm_regmap_init_mmio(). This
refactoring allows the driver to subsequently support syscon-based system
controllers natively.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index b770226f785ea..cf28caef31e8e 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c
[ ... ]
> @@ -91,20 +92,12 @@ static int rzv2h_wdt_ping(struct watchdog_device *wde=
v)
> =20
>  static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
>  {
> -	u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> -
> -	writel(reg | WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> -
> -	return 0;
> +	return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
>  }
> =20
>  static int rzt2h_wdt_wdtdcr_count_start(struct rzv2h_wdt_priv *priv)
>  {
> -	u32 reg =3D readl(priv->wdtdcr + WDTDCR);
> -
> -	writel(reg & ~WDTDCR_WDTSTOPCTRL, priv->wdtdcr + WDTDCR);
> -
> -	return 0;
> +	return regmap_clear_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTR=
L);
>  }

[Severity: High]
Since rzt2h_wdt_wdtdcr_count_start() is called by rzv2h_wdt_restart() during
a system panic, returning regmap_clear_bits() here means the restart handler
can now fail if the regmap access fails.

If rzt2h_wdt_wdtdcr_count_start() returns an error, the restart handler abo=
rts
early:

    rzv2h_wdt_restart()
        if (priv->of_data->wdtdcr) {
            ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
            if (ret) {
                ...
                return ret;
            }
        }
        rzv2h_wdt_ping(wdev);

Does this silently prevent the watchdog ping and hang the system indefinite=
ly
during a panic instead of rebooting? Should the restart handler ignore the
error to ensure the watchdog ping always occurs?

[Severity: High]
This is a pre-existing issue, but I noticed the restart handler calls
clk_enable() when the watchdog is not active:

    rzv2h_wdt_restart()
        if (!active) {
            ret =3D clk_enable(priv->pclk);
            if (ret)
                return ret;
        }

Since rzv2h_wdt_restart() is called in an atomic panic context where other =
CPUs
are halted via smp_send_stop(), can this cause a deadlock? If another CPU is
halted while holding the clock framework's global enable_lock spinlock, the
panicking CPU will spin indefinitely waiting for it.

[ ... ]
> @@ -280,14 +273,30 @@ static const struct watchdog_ops rzv2h_wdt_ops =3D {
>  	.restart =3D rzv2h_wdt_restart,
>  };
> =20
> +static const struct regmap_config rzv2h_wdtdcr_regmap_config =3D {
> +	.name =3D "wdtdcr",
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D 4,
> +	.max_register =3D WDTDCR,
> +	.fast_io =3D true,
> +	.use_raw_spinlock =3D true,
> +};

[Severity: High]
Since rzt2h_wdt_wdtdcr_count_start() uses regmap_clear_bits() and is called
by the panic restart handler, can this raw spinlock introduce a deadlock?

If a panic occurs while another CPU is executing rzv2h_wdt_start() or
rzv2h_wdt_stop() and holds this regmap's raw spinlock, the other CPU is
halted by smp_send_stop(). When the panicking CPU executes rzv2h_wdt_restar=
t(),
it will attempt to acquire the exact same raw spinlock and hang forever
instead of rebooting.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814191415.2110=
732-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
