Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A72749DC
	for <linux-watchdog@vger.kernel.org>; Thu, 13 Aug 2026 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593556; cv=none; b=WCfq/dpNXxrjs/WwznJm0g9UTTQlHBQt3FjYIZ1cvXQbV01ma1HnO/S9GxrUYpVoHu8OANwXzcK9vRS26+l2BUJhNozh6f0zFFubsmHQ+Zoy/M0Wcvqlla5hNqxf0iE1SskpqvF/vhCl56dgo6NxSwS7wC0kswjOn0dHwajDHXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593556; c=relaxed/simple;
	bh=OFZhXu1SIrUk74sgx11Sk4T12yP9NoIOwNW3GosLwM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b4NIVIHK47cupxLosyZeXKyp9Kknwzf2stcEEb5jtfy/nfDKEsfq8DNo10QfJtsabFAkFJRqcwbRgWkLy6tQ2nr8UwJAexy85LCf8aXRm+2j5zqqGt7wBKeRFT130pY8lxJUAKpDhOI+bZ3mjXjGJIZcSojVo+isLgd1ZFcyk/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LGJuGDU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LGJuGDU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AD91F000E9;
	Thu, 13 Aug 2026 03:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593554;
	bh=02mVLEuD8kJ/4o7kRjMBEXWkdbtKgnaziN0HAEX9o2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LGJuGDU2Okm6dMkuOal1ly7vBCprh0ZBk9UJCjWCjd6XhCzbhBjaZCPjthU5Q1V82
	 JFjs90MS+4X94z7PvW0Up3VKdILkuGKOXoC5+bsuAEtFwItR7+LWl08ekT+qmY+dJe
	 hNUIQjDuBCH1LYl3lHiq2WXnxE33CjO8VLYRJ58+6Lt2q2UZNuE86BuXx3yjmEiVDA
	 TsEH+KicjPdhKksieUzDpInv+ubYGmwRYlvZw/GepnIe0M/eHUP6EgDunFUu2Qjc6U
	 CCe/aD6dCeEM5cIvbI7O05i1jtdwBO0d35w5yQTPu39xlDDQqYuAOyvDw2Rcn4b8rI
	 1MwvYUMhQ7UhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: sbsa_gwdt: add early_enable module
 parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zexin Wang" <ot_zexin.wang@mediatek.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260813034900.20235-1-ot_zexin.wang@mediatek.com>
References: <20260813034900.20235-1-ot_zexin.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:59:14 +0000
Message-Id: <20260813035914.A8AD91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly added module parameter `early_enable` is incorrectly inde=
nted in the documentation, which will cause it to render as part of the des=
cription for the `nowayout` parameter.

Pre-existing issues:
- [High] If the `action=3D1` (two-stage mode) parameter is requested but th=
e WS0 interrupt is missing, the driver falls back to single-stage mode but =
fails to recalculate the WS0 race workaround, leaving the device vulnerable=
 to race-induced panics/resets.
--

--- Patch [1]: [PATCH v2] watchdog: sbsa_gwdt: add early_enable module para=
meter ---
commit 53d84fbbff2306e50b5e3a377d06b179b96d99f7
Author: Zexin Wang <ot_zexin.wang@mediatek.com>

watchdog: sbsa_gwdt: add early_enable module parameter

This commit adds an early_enable module parameter to the sbsa_gwdt driver.
It allows the watchdog to be re-enabled immediately during probe to prevent
a protection gap between firmware handover and userspace daemon startup.

> diff --git a/Documentation/watchdog/watchdog-parameters.rst b/Documentati=
on/watchdog/watchdog-parameters.rst
> --- a/Documentation/watchdog/watchdog-parameters.rst
> +++ b/Documentation/watchdog/watchdog-parameters.rst
> @@ -515,6 +515,8 @@ sbsa_gwdt:
>      nowayout:
>  	Watchdog cannot be stopped once started
>  	(default=3Dkernel config parameter)
> +	early_enable:
> +	Watchdog is started on module insertion (default=3D0)

[Severity: Low]
This isn't a bug, but will this indentation cause early_enable to render
nested under the nowayout parameter description in the generated Sphinx
documentation? It looks like it uses a tab instead of being aligned with
the other parameter names.

> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
[ ... ]
> @@ -386,14 +392,27 @@ static int sbsa_gwdt_probe(struct platform_device *=
pdev)
>  	 */
>  	sbsa_gwdt_set_timeout(wdd, wdd->timeout);

[Severity: High]
This is a pre-existing issue, but does the driver leave the device vulnerab=
le
to race-induced panics if it falls back to single-stage mode?

Looking at sbsa_gwdt_probe(), the workaround condition for=20
need_ws0_race_workaround is evaluated early based on the initial action sta=
te
during sbsa_gwdt_get_version(wdd). If the WS0 interrupt is missing, the dri=
ver
falls back by setting action to 0:

sbsa_gwdt_probe() {
    ...
    if (action) {
        irq =3D platform_get_irq(pdev, 0);
        if (irq < 0) {
            action =3D 0;
            dev_warn(dev, "unable to get ws0 interrupt.\n");
        }
    ...
}

However, it doesn't recalculate need_ws0_race_workaround after this fallbac=
k.
If a system boots with action=3D1 but fails to find the IRQ, could the
watchdog core schedule keepalives that align with the hardware's WS0
assertion, triggering the known race condition where the ping is ignored?

> +	early_action =3D early_enable && !(status & SBSA_GWDT_WCS_EN);
> +	if (early_action) {
> +		sbsa_gwdt_start(wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +		dev_info(dev, "Watchdog early enabled.\n");
> +	}
> +
>  	watchdog_stop_on_reboot(wdd);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813034900.2023=
5-1-ot_zexin.wang@mediatek.com?part=3D1
