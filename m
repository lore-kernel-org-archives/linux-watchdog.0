Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8C3CB560;
	Wed, 23 Sep 2026 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160770; cv=none; b=rXuw/L6waZ9hJLYZL6TCRqtFmC0aoqcW6/j/KnUF4ykzZFJCquxduk5lSATJyByyIkOdg+BY2zFF0ixao6rhm0AYkbpdxQOdLmCpzvUkNmy/b5XHG1jaxP2mPS5s0rFsBp6fHqdDp18mw/FMA5X/dUSIcMCnF5o4SZry+6SOyV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160770; c=relaxed/simple;
	bh=fXC7LSy1JnsibxzFHLcXEiJVVDJTX7GUrYdbzs82IRM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cmcFgDDYatZhfPqCKQGA1fuO4U2/9Rceu4tCGeZZHAi87E32+quLwO50Y6rfkRo64sGWwAmWZ63XBw5UMC85CXiJ5OmRuOJdkfk+M0DgAveN4jYYkTjG3MLaIJUL3u1xZaS1vid1iZl0eLc5pPftaV/2CzhQ9BTfY9gyEjzlNho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbySN59r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbySN59r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B87D1F00893;
	Wed, 23 Sep 2026 10:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790160757;
	bh=92/ElpDMlBZgaBQ5uGzKx0uoF63WiGA9KSHDnkIehqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HbySN59rQiIdL1Z3vbaggWijGaHh1QA9mHvveAUQY9c0we2awqfBU1SuoMTr03oca
	 1ojpMqgJLcJ0h9CJa/Ndkz9AKmqF7sXIcjCDUlGhpe5gbjuu1VpEiOSkioGjUPr63U
	 PkSz2obdQrk1H8w5+TvGznKnxxojw8el/HGuKiSVHRziujIX33wdJV39bIU+tRMRSw
	 zpaEzFBH9cbS7+o/4WS1WF/BLkufHqTPr5Cvs5D8hhUc91YTAU/2I/eTckfSWPBNdY
	 ZRdl43TIItDj5Lg+5MwoHd9detw4IQ5oLwqU2B5JN1r/Y6IqgJcQ1xhlia51rXytZ4
	 BQfAjMqAhXP1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/8] watchdog: rzv2h: Add syscon support for WDTDCR
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org
In-Reply-To: <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:52:37 +0000
Message-Id: <20260923105237.7B87D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: rzv2h: Deadlock in restart handler via syscon regmap loc=
king
--

commit 1e1b26069f70735a537750b22a51257bb422c2e4
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Add syscon support for WDTDCR

The commit adds support for accessing the WDTDCR register via a syscon
regmap interface for RZ/T2H and RZ/N2H SoCs. It looks up the SYSC regmap
using the "renesas,sysc" property or falls back to MMIO access if absent.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index 76c1d315b0e77..30b0b70fecaa9 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -93,18 +104,22 @@ static int rzv2h_wdt_ping(struct watchdog_device *wd=
ev)
> =20
>  static int rzt2h_wdt_wdtdcr_count_stop(struct rzv2h_wdt_priv *priv)
>  {
> -	guard(spinlock_irqsave)(&priv->regmap_lock);
> -	return regmap_set_bits(priv->wdtdcr_regmap, WDTDCR, WDTDCR_WDTSTOPCTRL);
> +	struct rzv2h_sysc_wdtdcr *sysc =3D &priv->sysc;
> +
> +	guard(spinlock_irqsave)(&sysc->regmap_lock);
> +	return regmap_set_bits(sysc->regmap, sysc->offset, WDTDCR_WDTSTOPCTRL);
>  }

[Severity: High]
Is the external sysc->regmap_lock still necessary here?

When using the syscon regmap returned by syscon_regmap_lookup_by_phandle_ar=
gs(),
the regmap has internal locking enabled by default. Since regmap_set_bits()
already performs an atomic read-modify-write using the syscon's internal lo=
ck,
this external wrapper lock appears redundant for the syscon path.

> =20
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
Could this lead to a deadlock during a system panic or restart?

This function is called by the rzv2h_wdt_restart() handler, which executes =
in
atomic or panic context and must remain strictly lockless to prevent deadlo=
cks.

While bypassing the driver's local sysc->regmap_lock was safe in the legacy
MMIO fallback case (where rzv2h_wdtdcr_regmap_config disables locking), the
syscon regmap has internal locking enabled.

Calling regmap_clear_bits() unconditionally attempts to acquire the syscon
regmap's internal spinlock. If the system panics while another CPU is acces=
sing
the shared syscon block, the restart handler could hang trying to acquire t=
his
lock, defeating the purpose of the watchdog restart recovery.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923104054.3324=
830-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
