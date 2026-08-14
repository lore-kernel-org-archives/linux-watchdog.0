Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8538C423
	for <linux-watchdog@vger.kernel.org>; Fri, 14 Aug 2026 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786735600; cv=none; b=VVRoNWler0CvNYFebDZ6EmKr1IgsSAtaC4/Sj89VHkUu45ZdBQtZlQ8wd/1n3AEWSoqvftcxokCU1kTz2cNhOeo6DgYpMOVvflhKcEQqPr+EW33g5Wui7CgzR8ECQmrxXkyaaYDsGAM70grtDcJL4W0pKpthjAJX7ZpgIkD6a4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786735600; c=relaxed/simple;
	bh=T2sHK8eoT6taqkJsy/GINBPswbNBSeHRwh2V9CM8Qbs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bM69gPWr5lTSqozGj28pFgn5rshNZlT1kGoraaVOsduVzcEcuKaAJLKX64/2/zWlDHns/ORoqNH+dJWg6nbLVBsf0diQYmXiubdsJsGtoWFT3eunvbaPauPpaiFjy7POIi5RuINKaw/QS20FJFS3BfPaQq4/FWDLJw1QrbnneXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvEdcSMT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvEdcSMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA99A1F000E9;
	Fri, 14 Aug 2026 19:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786735599;
	bh=dW6nPKlAHUHuhB0tCZa3U5tNGQQH4KTnmXRlQ9mUk9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvEdcSMTS0i8WwVW3JE559KbrrtWjP+X/T7YiuvlFQGVXZmdCn2LNJNphy4uHMDyI
	 bj7g+6iiq2krDemrMMCA2oBRi+yq7GuHnfO2cNA25N7kixOOpK2xR5ylxbO8MTPO7a
	 hKgM8jfEUJnLog+3nphlYdhTiDm5mFH6JG5VhF6EYvq1tagJHl+l+BHLBM6strQ3hp
	 rYQhzFRNt00UY5YygpLqvC1uIDYHVsKs2P882v2aYcbpIH7/ppv+ldV1/pD6gDYu21
	 b3Lfe7s0r7pzLbBQ3jR0Ti3vo0HqOOmdK32pLmluA6Cg+Xxn9FmZRm7mIWInqrfi9g
	 8ts6kmJRQcySA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR access
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org
In-Reply-To: <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260814191415.2110732-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 19:26:38 +0000
Message-Id: <20260814192638.EA99A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Error path unwinding in `rzv2h_wdt_stop()` leaves the watchdog har=
dware unconfigured, causing an unintended immediate system reboot.
- [High] Aborting the `restart` handler upon register access failure preven=
ts system reboot and hangs the system.
- [Medium] Using asynchronous `pm_runtime_put()` on the probe error path le=
aves the device permanently powered on.
--

--- Patch [1]: [PATCH v3 1/3] watchdog: rzv2h_wdt: Propagate WDTDCR access =
errors ---
commit ffabc27a1b8e9074dcd4cdaba7bc802a6d661fcc
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h_wdt: Propagate WDTDCR access errors

The WDTDCR helpers currently access the register directly using readl()/wri=
tel()
and therefore cannot report failures to their callers. Make the helpers ret=
urn
an error so their callers can propagate failures.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> index 3b6abb66a1da0..b770226f785ea 100644
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -171,8 +181,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wd=
ev)
>  	if (ret)
>  		return ret;
> =20
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_stop(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> +		if (ret) {
> +			reset_control_deassert(priv->rstc);
> +			return ret;
> +		}
> +	}
> =20
>  	pm_runtime_put(wdev->parent);

[Severity: High]
If rzt2h_wdt_wdtdcr_count_stop() fails, this unwinding leaves the hardware
out of reset but unconfigured.=20

If the stop operation returns an error, the watchdog core assumes the
hardware is still running and immediately issues a fallback ping. Will this
ping against zeroed, unconfigured registers start a zero-length timeout and
cause an unintended immediate system reboot?

[ ... ]

> @@ -234,8 +250,19 @@ static int rzv2h_wdt_restart(struct watchdog_device =
*wdev,
>  	rzv2h_wdt_setup(wdev, priv->of_data->cks_min | WDTCR_RPSS_25 |
>  			WDTCR_RPES_75 | WDTCR_TOPS_1024);
> =20
> -	if (priv->of_data->wdtdcr)
> -		rzt2h_wdt_wdtdcr_count_start(priv);
> +	if (priv->of_data->wdtdcr) {
> +		ret =3D rzt2h_wdt_wdtdcr_count_start(priv);
> +		if (ret) {
> +			if (!active) {
> +				reset_control_assert(priv->rstc);
> +				clk_disable(priv->oscclk);
> +				clk_disable(priv->pclk);
> +			} else {
> +				reset_control_reset(priv->rstc);
> +			}
> +			return ret;
> +		}
> +	}
> =20
>  	rzv2h_wdt_ping(wdev);

[Severity: High]
Does returning an error here prevent the system from resetting?

The watchdog core's restart notifier wrapper translates an error return into
NOTIFY_BAD. Since NOTIFY_BAD includes the NOTIFY_STOP_MASK bit, this aborts
the restart notifier chain entirely, skipping any fallback handlers and
causing the system to hang indefinitely.

Should this restart handler make a best-effort attempt (perhaps ignoring the
WDTDCR start failure) instead of returning an error?

[ ... ]

> @@ -266,11 +293,11 @@ static int rzt2h_wdt_wdtdcr_init(struct platform_de=
vice *pdev,
>  	if (ret)
>  		return ret;
> =20
> -	rzt2h_wdt_wdtdcr_count_stop(priv);
> +	ret =3D rzt2h_wdt_wdtdcr_count_stop(priv);
> =20
>  	pm_runtime_put(&pdev->dev);
> =20
> -	return 0;
> +	return ret;
>  }

[Severity: Medium]
When rzt2h_wdt_wdtdcr_count_stop() fails, this returns an error that fails
the probe function.

Does using the asynchronous pm_runtime_put() here leave the device powered
on?

Since probe failed, devres immediately calls pm_runtime_disable(), which
cancels any pending asynchronous power-management work. Should this be
pm_runtime_put_sync() instead, to ensure the device powers down before the
disable occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814191415.2110=
732-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
