Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882037;
	b=mGL9fDwLvKxMiER6T9CWLpbF+V03XjzXLwC8npMkZdOWH0BjXcf83oiklmaB0vfUlVmg
	 7gd2tboX2BWfi4TMEWFSQ+Pk8+Gt7Myl1miOKWdAzt0N9y330lF4PbDUGcN27JaXJAt+u
	 yAQFmHTVGcfW4P9kaD8wpLTbrJaAYT/Ku6hATVaUBzBfBTNiHFZdEGc+z/c2hAmfFSYwM
	 8rOSi0WD0UwUJU6wC3iilZgqSPxO+x8/XB1Ti6oI7vyDVlXKBaiCsE+1UZ/gkU9J4LauH
	 RREik3lRg2C8EVRYs/YrOqe6WQsdpyhhCmO3YZBaIPymaBAssxvjpDYj40xtKM/eLuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882037;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UHXlgi38hYRFqw8QVDmuWn0q6Hkeh5kPBkAefbmP3TE=;
	b=xaCsCwysb2ruGrkzF02DwuSNA3slC4LRQFVaxx04oSOiBvKhNG6e7kV8gKh8jB1qDVQT
	 hU9yq74SctxbnpAL0qNJnX3SGj54u0bgEkRiLQNIvvIba8cujnVAUI/Ojq1fZYA3RTn4L
	 LZOnm4iNmg25pETuIoNNVee88Elz1WaMMXDQApZd/LrgY7ABEWx5gOR63hujKKAUyi+Ph
	 RygvuDFD203C2dyFsYIemv/ggDl+nOxHNGAtvX6RqyHpHOdLKm52UPH+wPNb9C82A9H6D
	 vhUny96ndDh3KF4E99gZu6QAKN3qI+7iH1A/gGT76zM4EseKPJTdxhdtIDfw1D40vHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAmPY3sv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288A606A31C
	for <linux-watchdog@vger.kernel.org>; Tue, 17 Nov 2026 02:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aAmPY3sv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27BF01F000C4;
	Tue, 17 Nov 2026 02:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794882037;
	bh=UHXlgi38hYRFqw8QVDmuWn0q6Hkeh5kPBkAefbmP3TE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aAmPY3svY3qAfMOlmHVDbRr/RyO7OY6Epgn37LbH0YI1E3G3d4pB+aXQMlXNppoz0
	 dNdlrHreVJEpx4peXa6Ym5QTPCEYp769SahcNfWLRYoVk3Nx+hey7dpXGGJcrAMMy+
	 djHfZfCI15dIkGrtU8OV9uO02UoTX/aLAqvcOABr9lpp1mRIfiFx91IipRFGik9F0n
	 P76jd4wxgRYiDPXx7I2WUGi6+HHYoZwBOwMKsq1j0pnv8K1SyUo+TQBTMbsydB2dI9
	 robRwJqb7MswmS94Qg1Yrd/+O4et4nA119Szi8tTo8FrwYm1HjmCEPr2ii+VPB1xBp
	 hKWswfudeQPDg==
Message-ID: <sashiko-outbox-218083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: renesas_wdt: avoid sleeping clock calls in
 restart handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luo Yifan" <luoyifan@cmss.chinamobile.com>, linux-watchdog@vger.kernel.org
In-Reply-To: <20261117020530.19973-1-luoyifan@cmss.chinamobile.com>
References: <20261117020530.19973-1-luoyifan@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 02:20:36 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] watchdog: renesas_wdt: missing Fixes trailer for atomic sleep
  fix
- [Low] watchdog: renesas_wdt: use devm_clk_get_prepared() in
  rwdt_probe()
--

commit 4ed48dd9a6e0be55587f40b05e00cb1b9e5da877
Author: Luo Yifan <luoyifan@cmss.chinamobile.com>

> watchdog: renesas_wdt: avoid sleeping clock calls in restart handler
>
> rwdt_restart() runs in atomic context, as the comment above the function
> points out, but it calls clk_prepare_enable().  clk_prepare() may sleep on
> the clock mutex, which is not allowed from a restart handler.
>
> Prepare the clock once in the probe function and only call clk_enable()
> from the restart handler.  clk_enable() does not sleep, so the restart
> path stays atomic.  Unprepare the clock in the probe error path and in
> rwdt_remove().
>
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>

[Severity: Low]
Since this fixes the sleeping clk_prepare_enable() call in rwdt_restart(),
should this include a Fixes tag?

  Fixes: fa01fa70039c ("watchdog: renesas_wdt: don't sleep in atomic contex=
t")

> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wd=
t.c
> index d9760f2a3b235..9630d05686461 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c

[ ... ]

> @@ -233,6 +233,14 @@ static int rwdt_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->clk))
>  		return PTR_ERR(priv->clk);
> =20
> +	/*
> +	 * The restart handler runs in atomic context and can only enable the
> +	 * clock, so prepare it here.
> +	 */
> +	ret =3D clk_prepare(priv->clk);
> +	if (ret)
> +		return ret;
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  	priv->clk_rate =3D clk_get_rate(priv->clk);
> @@ -290,6 +298,7 @@ static int rwdt_probe(struct platform_device *pdev)
> =20
>   out_pm_disable:
>  	pm_runtime_disable(dev);
> +	clk_unprepare(priv->clk);
>  	return ret;
>  }
> =20
> @@ -299,6 +308,7 @@ static void rwdt_remove(struct platform_device *pdev)
> =20
>  	watchdog_unregister_device(&priv->wdev);
>  	pm_runtime_disable(&pdev->dev);
> +	clk_unprepare(priv->clk);
>  }

[Severity: Low]
This isn't a bug, but could rwdt_probe() use devm_clk_get_prepared() instead
of devm_clk_get()?  That would prepare priv->clk on acquisition and
automatically unprepare it on probe failure or after rwdt_remove(), avoiding
the manual clk_prepare() and clk_unprepare() calls.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117020530.1997=
3-1-luoyifan@cmss.chinamobile.com?part=3D1
