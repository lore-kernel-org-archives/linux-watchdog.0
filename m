Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B149F100;
	Wed, 23 Sep 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160499; cv=none; b=XxK8hMswuTXpeJKuPD/4vTvYYRr8+RQwAVsc/JgrwgVDVBFnX8YtmtjgEXS6JKKRY7hi9PZNHANTJ3gv3EO5PJeF0S7AopG9PtX5MuQrzjFFxVlJq3tfLCxDgsVkqptIv7GLAS6y2D0J3HItcNLzpFpsNVGkshRvCLWu8+PVbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160499; c=relaxed/simple;
	bh=6UNnv0RGuKknPdAwNWe+SNf/KLUPzPubb3WoRtLDMMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lgOBmRjoNa0llaMhSTzQd378M5Ty49OEKJiVAsOqBM/JSJz3KUH3y6QegfpX1em6heN1DfMXwxvPPrSshd1UKIfdC7mTkHyAohsOmMAy3LwNLnUabStn02+hFpwbrBi99mmlbFvIGwhBZK8bEWiLkyShm52+DJfGWtbfHyJgXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRY6hC+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRY6hC+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C230E1F000FF;
	Wed, 23 Sep 2026 10:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790160485;
	bh=lvgnx5Bsy6z7U3Qzpl0zAA40Zwek3ILIHjx2E0PhP9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRY6hC+WdOklq3VGkYtjYiW9d11JPJAgJVs1VcJFSmR1F2/HS+BKwmOxs26Ee2D5S
	 X5oxac4kHkOH/dlavgPXgz4fBjQqZqhyirBmwbw0wrq/LaMSjvugw127/D+VJno8mG
	 Ty8N7qtGo+XRoZ8v+c952fuu7UEDsLPyIndXKrVjXNvxCu+7vz1vM4LUBn9/1qk13A
	 Tl5yXQ2J5vO/yLveN+NTjDUhrZPOD0l/WrB6jJ9GYwxGZaRA7UzlBr58fOFHhq13XW
	 CbSeTxZtgSu8XNjyXTlytxipPkTogKIqweulQGkiSjLZdbsObnBS0Zgwm0F5OAFW3S
	 e7g9m9J89Rb2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] watchdog: rzv2h: Propagate WDTDCR access errors
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260923104054.3324830-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:48:04 +0000
Message-Id: <20260923104804.C230E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: rzv2h: unconfigured hardware reset on stop error path
--

commit b536187da1b8888ce4af583c2cf2a8479cfaaa53
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

watchdog: rzv2h: Propagate WDTDCR access errors

This commit updates the watchdog start and stop paths to handle WDTDCR
register access errors. It propagates failures back to the caller and
unwinds acquired resources, attempting to restore the reset state.

> diff --git a/drivers/watchdog/rzv2h_wdt.c b/drivers/watchdog/rzv2h_wdt.c
> --- a/drivers/watchdog/rzv2h_wdt.c
> +++ b/drivers/watchdog/rzv2h_wdt.c

[ ... ]

> @@ -169,8 +179,13 @@ static int rzv2h_wdt_stop(struct watchdog_device *wd=
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

[Severity: High]
Does this error path unwind leave the hardware in an unconfigured state?

Earlier in rzv2h_wdt_stop(), reset_control_assert() places the watchdog IP
into reset, which clears its configuration registers to default values. If
rzt2h_wdt_wdtdcr_count_stop() fails, this path deasserts the reset line but
does not restore the previous running configuration, missing the required
udelay(3) and rzv2h_wdt_setup() initialization.

Since rzv2h_wdt_stop() returns an error, won't the watchdog core assume the
device is still active and continue to issue keepalive pings?

If the core pings the newly-deasserted but unconfigured watchdog, it seems
this would start the down-counter with default reset register values,
triggering an immediate unintended hardware reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923104054.3324=
830-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4
