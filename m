Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D4840E8C7
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665969; cv=none; b=fHtUpHHV3wvScYyPlQF54fxlcQV1JmjW7dQ3AOV1C4mxzxtkXB5fO/ZlZSy8wfnUX60tyTBowYnOPuKNLMLEF8AVAKX0sL2BtwL19IQRehTrHNCGIcIEbIEAG7/RqAZi/5YeS7ykBeUYaRnH05hIToRifzDVsRPx2hfvadPd7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665969; c=relaxed/simple;
	bh=Ht5vRTW0svFQq6S0bsbJjzx/Z2WZYS2HgANd8yx8Vm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q3Qt088s/Tb3G694D0gF6kwEsXdseiQkI2eoY6d7qhCa+edXnJO9EI56XtflRr6p6BCNMgHslp3bkyChxuOjeicScL3EBUSlyEYrhFyJjaUE3vqTgguHTSUOcSv4v+NWmNFLmGNildRvsB661glYYYu1hRKBB9Xjyb/yibOBpp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz8HElMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz8HElMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5001F00893;
	Fri,  5 Jun 2026 13:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780665968;
	bh=bvn2OmNHeNQA8djHRkjEtnbHRxYksNi+jbeocc8J/J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lz8HElMpF1OIrnjrb7Yf8ujcmGkTnASpQlXj37maHFxs8K3YXfQUfQoqJ0U3kAShb
	 iAZf7l1dyHNiTL86J4hblv2h57N9/73JFrxzaURoAgTOaxGLd2gL9t3CDmciqv3Ixu
	 WGbGnQBAS4jNaxtzeb2DeLh7Wma4NpI18V+sd5noUvKrF9uN0xcxuWFv7NTdeYaO0L
	 R2bZ7gaRSfwP/ur9kU43awKoYCQDTykW+635VihoV3vGeoNGl+E5nyAlgSG/b8fDJS
	 Yn+AUmvbx3LAlNepJvjfrBsl0XieysBrgHYxIqmC/tFdJ99e5dU1gaoLk5jiOvzWyY
	 PqXn35iJI7Qig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] watchdog: starfive: treat pm_runtime_put_sync()
 positive return as success
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Theesfeld" <william@theesfeld.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <bc91d669bb732784d1e28d4bd259612b6dd07342.1780664848.git.william@theesfeld.net>
References: <bc91d669bb732784d1e28d4bd259612b6dd07342.1780664848.git.william@theesfeld.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:26:07 +0000
Message-Id: <20260605132607.DB5001F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] The commit message and inline comment justify the code change wi=
th a fundamentally incorrect explanation of Runtime PM return values.

Pre-existing issues:
- [High] Propagating normal negative returns from `pm_runtime_put_sync()` a=
s errors breaks the watchdog state machine and probe function.
- [High] The error path in `starfive_wdt_probe` calls `pm_runtime_put_sync(=
)` twice when the initial PM put fails, leading to a usage count underflow.
- [High] The driver unconditionally accesses hardware registers during driv=
er removal without guaranteeing the clocks are enabled, risking bus faults.
--

commit ff0d7567f1fad840688f8c89badc9b0278568af6
Author: William Theesfeld <william@theesfeld.net>

watchdog: starfive: treat pm_runtime_put_sync() positive return as success

This commit updates the watchdog driver to mask off positive return values
from pm_runtime_put_sync() in starfive_wdt_pm_stop() and tightens the error
check in starfive_wdt_probe() to only catch negative returns. The intention
is to stop treating the non-suspended state as an error condition.

> watchdog: starfive: treat pm_runtime_put_sync() positive return as success
>=20
> pm_runtime_put_sync() returns 1 when the device cannot be suspended
> because it is still in use (typically due to other runtime PM users
> holding references); only negative return values are real errors.

[Severity: Medium]
Is this description of the return value accurate?

According to the Runtime PM guidelines, pm_runtime_put_sync() returns 1 when
the device is already suspended, not when it is still in use. When a device
is still in use (i.e., usage counter is non-zero), it returns -EAGAIN.

Documenting incorrect API semantics here could misguide future maintainers.

[ ... ]

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index ed8c5711a3853..c821b38d26d22 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -386,9 +386,17 @@ static int starfive_wdt_pm_start(struct watchdog_dev=
ice *wdd)
>  static int starfive_wdt_pm_stop(struct watchdog_device *wdd)
>  {
>  	struct starfive_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +	int ret;
> =20
>  	starfive_wdt_stop(wdt);
> -	return pm_runtime_put_sync(wdd->parent);
> +	ret =3D pm_runtime_put_sync(wdd->parent);
> +	/*
> +	 * pm_runtime_put_sync() can return 1 when the device is still in
> +	 * use (and therefore did not actually suspend).  That is not an
> +	 * error from the caller's point of view; only propagate negative
> +	 * return values.
> +	 */

[Severity: Medium]
Is the comment's description of the return value correct?

As mentioned regarding the commit message, pm_runtime_put_sync() returns 1
when the device is already suspended, not when it is still in use.

> +	return ret < 0 ? ret : 0;

[Severity: High]
This isn't a bug introduced by this patch, but does propagating normal
negative returns as errors break the watchdog state machine?

If the device cannot immediately suspend due to a non-zero usage counter,
pm_runtime_put_sync() correctly returns -EAGAIN or -EBUSY.

By propagating these negative values as errors, the watchdog core assumes t=
he
hardware stop failed. It will leave the WDOG_ACTIVE bit set and continue the
background ping worker.

Because the driver has already successfully disabled the hardware and dropp=
ed
its PM reference, the device will eventually suspend. The rogue ping worker
would then access unclocked MMIO registers and trigger a fatal bus fault.

Should this return 0 if the hardware was successfully stopped?

>  }
> =20
>  static int starfive_wdt_set_timeout(struct watchdog_device *wdd,

[ ... ]

> @@ -503,7 +511,7 @@ static int starfive_wdt_probe(struct platform_device =
*pdev)
>  	if (!early_enable) {
>  		if (pm_runtime_enabled(&pdev->dev)) {
>  			ret =3D pm_runtime_put_sync(&pdev->dev);
> -			if (ret)
> +			if (ret < 0)

[Severity: High]
This is a pre-existing issue, but does treating -EAGAIN as a failure cause
the probe to fail unnecessarily?

If pm_runtime_put_sync() returns -EAGAIN due to a concurrent sysfs access,
propagating it via ret < 0 turns a harmless concurrency race into a fatal
failure, unregistering a working watchdog.

[Severity: High]
This is a pre-existing issue, but does this error path cause a usage count
underflow?

If pm_runtime_put_sync() returns an error (like -EAGAIN), the code branches
to err_unregister_wdt and falls through to the err_put_pm label:

err_unregister_wdt:
	watchdog_unregister_device(&wdt->wdd);
err_put_pm:
	if (pm_runtime_enabled(&pdev->dev))
		pm_runtime_put_sync(&pdev->dev);

Since the initial pm_runtime_put_sync() unconditionally decrements the usage
count regardless of its return value, calling it a second time here causes
an unbalanced decrement.

>  				goto err_unregister_wdt;
>  		}
>  	}

[Severity: High]
This is a pre-existing issue, but does starfive_wdt_remove() risk bus faults
by unconditionally accessing hardware registers without ensuring clocks are
active?

drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
...
	struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);

	starfive_wdt_stop(wdt);
...
}

If the watchdog was never opened by userspace and early_enable was false, t=
he
device is in the RPM_SUSPENDED state with its clocks gated. Accessing
unclocked MMIO registers in starfive_wdt_stop() triggers a synchronous
external abort.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780664848.gi=
t.william@theesfeld.net?part=3D2
