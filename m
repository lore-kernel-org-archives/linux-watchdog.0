Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9273321B1
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725110; cv=none; b=hWfZwYH4pUFf9Vg8ECszHkWroNFTRSQK7LPn6a8Ll8Avx/1Ve3FUr2pR97VCzaEqUEDziZA7ZpYtyaCnVTlOHQP88EPIgEcJ60A8JzxH3fb5Pxv5HCb3Kvyo8iVSD2965UoydreAZJ13WwlbRcMh34iNbiCON/PhHgx+WA+uNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725110; c=relaxed/simple;
	bh=n1CeY8kdVNvu9g4zGyMO/tPjk7I8SH+DjxCVZ4aJuY8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DEpLAd/yaAK/wBUv396VP1iQB2E+wep3RuW+EO0Caz2+Q7Cu9yA/cJ8+iFwhiCVSv759/WZ0sUlnQmeeLMnW4QiCVkoCMheq+cIZ6fKvOgCXy1FlbXAvLEIhEKZM/sLtXxJiAiytXnmUqmwnx9RJGg0Go79OdAUMhctYSxVaFwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbK4kUPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbK4kUPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 074911F000E9;
	Wed, 26 Aug 2026 06:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787725109;
	bh=SGQAeDnTjAvOB0CS7BRQ8OlGUwY5mIbndLuj6W/mc2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbK4kUPPaX9oeq2gmr5zrMeDARzz/LeR6rBOw+tTLewAXo5n+WWr2MC8YguuIdOqG
	 aTqyDzkJHRHVZsSOpRPKoOf5xmH/NlTsAOetomN4hTIP9xUJVLyjc5temR4DJ9fvoa
	 KN0TYlO6St0gPRUD3rTPv6To2WiOlITXjF0PC8+nBAHPFOpaHIt0LSBEG72Kj+jgtJ
	 qsV1yfPI1z79rwpvyTSSDJsNjzLZj1T/VMK1U3iqSs4y4dASZkYRuvCvGF4WTRhJji
	 xoLbJChvzjnrj3CS6ZuyS7BkOzjYY6mxeMG/9UI3zO7K0pS7lG4FXlIxlzu83cQkNQ
	 keZ8z81/0TmEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] watchdog: sp805_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260826060839.203297-8-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-8-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 06:18:28 +0000
Message-Id: <20260826061829.074911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Incorrect PM macro used for dev_pm_ops structure pointer
--

commit 9fbd3f6262590348a0368f82478f6de749787ec2
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: sp805_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()

This commit converts the deprecated SIMPLE_DEV_PM_OPS() to
DEFINE_SIMPLE_DEV_PM_OPS() and wraps the struct pointer. This allows the
removal of __maybe_unused annotations from the callbacks.

> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index c2125f204a137..7b01011a5bc86 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c

[ ... ]

> @@ -361,7 +361,7 @@ MODULE_DEVICE_TABLE(amba, sp805_wdt_ids);
>  static struct amba_driver sp805_wdt_driver =3D {
>  	.drv =3D {
>  		.name	=3D MODULE_NAME,
> -		.pm	=3D &sp805_wdt_dev_pm_ops,
> +		.pm	=3D pm_sleep_ptr(&sp805_wdt_dev_pm_ops),

[Severity: Low]
Should this use pm_ptr() instead of pm_sleep_ptr() for the structure pointe=
r?

According to the power management guidelines, dev_pm_ops structure pointers
should be wrapped with pm_ptr() rather than pm_sleep_ptr(). Using
pm_sleep_ptr() here drops the entire dev_pm_ops structure when CONFIG_PM_SL=
EEP
is disabled. If runtime PM callbacks are added to this structure in the fut=
ure,
they will be incorrectly discarded even when CONFIG_PM is enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826060839.2032=
97-1-triet.hoang.dev@gmail.com?part=3D7
