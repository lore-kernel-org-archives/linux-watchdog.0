Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65D44C67E;
	Wed, 19 Aug 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135383; cv=none; b=k0oyLWSfIZweKuoze9UPvwlzGH74Mjxg564sYMWJBLmzuFgDhtonQU5vyWoBRApvBFouMMEV6qf2WBIoz5EJHDdRS8BY2K2+ihcedI/l3v1+sGMd+2g9DMPr0YvCxKs7mRlKcrR05bk/1zhVmkOBAZN7D4aP1oFO6IdRZMiya+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135383; c=relaxed/simple;
	bh=yGraQ9VIKmRtnJSM0YqotGIENCUuK65PabPGXbBKePc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NwWyfmOGUtxwrz3Ip0QI1de2DvC+fNWrI9A3v76SrZ82yjaWQdgbRyP1JIu+dWvw0ReKoOT6emLBNB0tTR3ZZzgIdwTFFInuIzJ0F9FPwr5Gk5FLdx8Wu3bQtTO8P8f26gRhDNYe4HXUA6qUm8SPHWvsTXmFB1ZvZJBaHDyPzFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH8qXF2f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH8qXF2f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1841F1F000E9;
	Wed, 19 Aug 2026 10:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787135382;
	bh=9lCeiHc23DYQSiS4dNY3Norc4v3gW1bp14VnUhRT0B8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nH8qXF2fLgyDqFNk5BPVnnUmnwIi8ApCeb/AssQ9TFv6THN0vDdqvsGgGQjPyEMeA
	 xvIw4U8oEkH1rDElaabUDW7QinYaOjVDy4d0q3HmH+fj83+lkpxf/LwviytGpKCu2w
	 H0/w43Kr0fz8bPOkWg1eIahh3IL0z63dg2OK3cJ64gByaeP2kmFCEp6JhgLdw2/egS
	 RGiP792HE4PXyXSAyUunM3L9WYEK+OZC65oNf9Ywxf2Fv1x7ZMwOBsKxNWGUF81XSm
	 APYzYj5AhVfLiS08TM2UMhALylq2/Oz2fi3QEaklUGuptIyWrj+uRsYk2K9g54G4Y2
	 owBGkQYQjMUKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/7] watchdog: mediatek: Add support for mt8167
 toprgu/watchdog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260819101853.44681-6-l.scorcia@gmail.com>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
 <20260819101853.44681-6-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:29:41 +0000
Message-Id: <20260819102942.1841F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition in watchdog registration exposing uninitialized dev=
ice properties.
--

--- Patch [5]: [PATCH v4 5/7] watchdog: mediatek: Add support for mt8167 to=
prgu/watchdog ---
commit 918b68ccd6f0fbc5fe13cfd642a3baccbeddc0ed
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

watchdog: mediatek: Add support for mt8167 toprgu/watchdog

This commit adds support for the Top Reset Generation Unit/Watchdog Timer
found on the mt8167 SoC. It uses a reset table to handle non-contiguous
reset bits and ensures the reset controller is registered with the correct
configuration.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index f8208fb0f7234..fa522fd80dd45 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c

[ ... ]

> @@ -457,12 +493,14 @@ static int mtk_wdt_probe(struct platform_device *pd=
ev)
> =20
>  	wdt_data =3D of_device_get_match_data(dev);
>  	if (wdt_data) {

[ ... ]

>  		err =3D toprgu_register_reset_controller(pdev,
>  						       wdt_data->toprgu_sw_rst_num);
>  		if (err)
>  			return err;
> -
> -		mtk_wdt->has_swsysrst_en =3D wdt_data->has_swsysrst_en;
>  	}
> =20
>  	mtk_wdt->disable_wdt_extrst =3D

[Severity: High]
This is a pre-existing issue, but does the ordering in mtk_wdt_probe()
create a race condition with userspace?

Looking at the probe function, devm_watchdog_register_device() is called
and exposes the device to userspace before the hardware-specific properties
disable_wdt_extrst and reset_by_toprgu are populated.

If udev or another userspace process opens the watchdog device immediately
upon registration, could mtk_wdt_start() execute before these properties
are initialized?

If so, mtk_wdt_start() would evaluate the properties as false:

mtk_wdt_start() {
        ...
        if (mtk_wdt->disable_wdt_extrst)
                reg &=3D ~WDT_MODE_EXRST_EN;
        if (mtk_wdt->reset_by_toprgu)
                reg |=3D WDT_MODE_CNT_SEL;
        ...
}

Could this lead to incorrectly asserting external reset signals or failing
to trigger the proper TOPRGU reset path? Should the watchdog registration
be deferred until all device tree properties are fully parsed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819101853.4468=
1-1-l.scorcia@gmail.com?part=3D5
