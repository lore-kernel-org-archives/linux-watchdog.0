Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518DF33D4E4
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 04:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806668; cv=none; b=J8xsmbOuwMJOXxbDt/s56XPBftXUSQgXMyZbPYb/jexHZjUVGNA9ddrbkV/26ixXlZQ9J43eXgHHxKqqHBLgjwt7O01XuDJ9vwW/jzCSYq/ADcOo3SpdaZ8ckE3RVtbNhfNEj82XXA5Oru33W9NimPBR2D00kl/I3/PeQAfZOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806668; c=relaxed/simple;
	bh=1/NpcR44VIaaYuX1cZW+OXpbadHRBiAK80cOErAoZUc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V8d4DDsPQkBp7hTirxpJHU66et2Q+NB3JeQlp9lFnyb8npo1K/nICJtZhFna3wgziELlXAMR/baM5tkGigYNG62KbapA8Qg+c/jtGp1wlDSG7hw/3hVJPUhDnyNfLs0ZbmUIYbn8b5GAjmVMW1crKVluQJ2vEIN/ypouU+ETlHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE5z0tWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE5z0tWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79091F000E9;
	Thu, 27 Aug 2026 04:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787806666;
	bh=1kVXR6H4Bci5TLOcWhBnDi8dmSDwxC50goqprZ/tUnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mE5z0tWN0npzG6GzvGow/PXDUysx2HX5Sb+7/MXD5BVS4N9vsBZACU/n76QeEYDUy
	 +QjwMyIvOBGeR72UB2RTILAXf8tv1MiHdES0Thtsk3dTxEgWVZ7jTutG+FRUEHE9SA
	 Ilu2yo+N4JgY7+cnpqlaukkwqpD7JaBtZOyHMfN5oEirnXUh/XsKdc0dUdUfXFAg7t
	 asNgFOWjQBjmlEJ/B4QuxSYLGIKOB5TMaYuJ11D2Eny5QS4mAdbnJJwpcmR9SOrWqF
	 Qnle6+myHSMWolc96dJPmEPrkd0Od8LRdc+GP8vGhY/bbn2Hx3JsW98E+1bJmtOD0I
	 j/nZY+xvoi5ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] watchdog: msc313e: Fix NULL pointer dereference in
 PM callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tzung-Bi Shih" <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260827044700.554333-2-tzungbi@kernel.org>
References: <20260827044700.554333-1-tzungbi@kernel.org>
 <20260827044700.554333-2-tzungbi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 04:57:46 +0000
Message-Id: <20260827045746.C79091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Hardware watchdog is not properly stopped during system suspend if=
 it was started by the bootloader but not opened by userspace.
- [High] The resume callback ignores the return value of msc313e_wdt_start(=
).
- [High] Potential division by zero during `max_timeout` calculation.
- [High] Clock reference count leak and unintended hardware activation in `=
msc313e_wdt_settimeout`.
- [Low] Struct initialization uses commas instead of semicolons.
--

commit c2fa09163e4f9bd75f052d03568c2d22f22158f0
Author: Tzung-Bi Shih <tzungbi@kernel.org>

watchdog: msc313e: Fix NULL pointer dereference in PM callbacks

The commit fixes a NULL pointer dereference in the power management callbac=
ks
of the msc313e watchdog driver. It ensures that the driver data is properly
set for the platform device in the probe function so it can be retrieved
during suspend and resume.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 90171431fc594..3b62650375628 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -125,6 +125,7 @@ static int msc313e_wdt_probe(struct platform_device *=
pdev)
>  		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> =20
>  	watchdog_set_drvdata(&priv->wdev, priv);
> +	platform_set_drvdata(pdev, priv);
> =20
>  	watchdog_init_timeout(&priv->wdev, timeout, dev);
>  	watchdog_stop_on_reboot(&priv->wdev);

While reviewing this code, I noticed a few pre-existing issues in the drive=
r:

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_suspend()
    if (watchdog_active(&priv->wdev))
        msc313e_wdt_stop(&priv->wdev);

[Severity: High]
This is a pre-existing issue, but does this bypass stopping the hardware
watchdog if userspace hasn't opened the device?

If the hardware was started by the bootloader but not yet opened by userspa=
ce,
the ping worker is frozen during suspend. Since watchdog_active() checks if
userspace has opened it, will the active hardware timer continue running and
trigger a spurious system reset during system suspend?

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_resume()
    if (watchdog_active(&priv->wdev))
        msc313e_wdt_start(&priv->wdev);

[Severity: High]
This is a pre-existing issue, but is it safe to ignore the return value of
msc313e_wdt_start()?

If the clock enable fails inside msc313e_wdt_start(), the function will
silently discard the error. Will subsequent register operations in the watc=
hdog
then access unclocked memory and cause a system crash?

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe()
    priv->wdev.info =3D &msc313e_wdt_ident,
    priv->wdev.ops =3D &msc313e_wdt_ops,
    priv->wdev.parent =3D dev;

[Severity: Low]
This isn't a bug introduced by this patch, but are these assignments using
comma operators intentionally instead of semicolons?

While syntactically valid, this violates standard kernel coding style and
could cause unintended behavior during refactoring.

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe()
    priv->wdev.min_timeout =3D MSC313E_WDT_MIN_TIMEOUT;
    priv->wdev.max_timeout =3D U32_MAX / clk_get_rate(priv->clk);
    priv->wdev.timeout =3D MSC313E_WDT_DEFAULT_TIMEOUT;

[Severity: High]
This is a pre-existing issue, but could this calculation result in a divisi=
on
by zero panic?

If clk_get_rate() returns 0 for an uninitialized clock, using it directly a=
s a
denominator here will trigger a division by zero exception during probe.

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_settimeout()
    wdev->timeout =3D new_time;

    return msc313e_wdt_start(wdev);

[Severity: High]
This is a pre-existing issue, but does unconditionally calling
msc313e_wdt_start() here cause a clock reference leak or unintended hardware
activation?=20

If the watchdog is already active, this would increment the clock reference
count redundantly. If it is stopped, it inadvertently starts the hardware t=
imer
without the watchdog core tracking it, which could cause an unexpected syst=
em
reset.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827044700.5543=
33-1-tzungbi@kernel.org?part=3D1
