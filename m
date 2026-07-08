Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37AA3BCD02
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783489005; cv=none; b=QwfODUyup6+6xhYgZcVk449+0ZfDLrcUpVFakD+9gnnexLq/mrNNaXnt1wBp1nbrKfNqKzfieQy1Iu0d7MiKS6DMP4KIFlk/SHydV+uU9i6UYaqMHSz88hzbFIvrpDPWsvFuxeyw6DmbwYbq+YU7WAPLl1pqZ1SzZijC68DvJHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783489005; c=relaxed/simple;
	bh=88rtdB+34t3WPi9hWfM1hI/w4MwRXkUeIy+HUtWl/tc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eeLktYw3TUwVEx4XNJLx04mFuic2RWdtmyQQCH9JS45hvce7X4DNrP4R8emsZTPrT4a7ptRwULhXaa8IDjs+lyHjpfRNyzBj3B1oiGPCQYZqLkkjzSQJ9MIxE70JCn64M1/UEflzO0RHDdGJMeF/eSQVt4Cw+viqPR+hskWRF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSwgOtJz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSwgOtJz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6392B1F00ADF;
	Wed,  8 Jul 2026 05:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783489003;
	bh=daXF+Bbre5Hcgt5K9/OlZ5wHFB+VLqwXQx5QMahXBoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nSwgOtJzbiC1J6xMD6gQrSZlWqNVWuC1i+rUExdFtCExkArStmeC33gwRVzM3yLPC
	 D61k7EWhdf1sPTOd5wNTpa2CQeMK3bx3csRg7xkdTyMDvhNHz1/XAfJaDOth8wYHsd
	 s43DjKnsxitZwPmleZPVM+AK2wSu8fXvONmdskt3tIUi2wnkgcMfwJzt8pkFS3r+Qg
	 JpijH30ZuDCgaEUBPTpH+Ecj+JCTh1o72uJ66tOt21buY9wVQZd/UmU7TzDghLyrhk
	 elcPifMvEm+EP3sCI4HAk+5kMtN7r82jfeqhFd59vaUNX0X+iSI4iw7q68EKRoTO3H
	 8+W6UP2kOl/Uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: airoha: validate heartbeat module parameter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wayen Yan" <win847@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <178348833669.86438.10575372757097263872@gmail.com>
References: <178348833669.86438.10575372757097263872@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 05:36:42 +0000
Message-Id: <20260708053643.6392B1F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch removes the direct assignment of `wdog_dev->timeout =3D =
heartbeat;` to fix an overflow issue, and relies on `watchdog_init_timeout(=
)` for validation. However, if the `heartbeat` parameter is invalid and the=
re is no `timeout-sec` DT property, `watchdog_init_timeout()` returns `-EIN=
VAL` and leaves `wdog_dev->timeout` unmodified. Because `wdog_dev` is alloc=
ated via `devm_kzalloc()`, `timeout` is 0. The driver ignores the `-EINVAL`=
 return value and registers the watchdog with a timeout of 0. When `/dev/wa=
tchdog` is subsequently opened, `airoha_wdt_start()` writes `0 * airoha_wdt=
->wdt_freq` (0) to `WDT_TIMER_LOAD_VALUE`. This instantly expires the timer=
 and triggers an immediate hardware reboot. The driver must pre-initialize =
`wdog_dev->timeout` to a valid default (e.g., `WDT_HEARTBEAT`) before calli=
ng `watchdog_init_timeout()`.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the driver leave=
s `wdog_dev->min_timeout` uninitialized (0). The watchdog core's `watchdog_=
timeout_invalid()` relies on `min_timeout` to validate lower bounds. With `=
min_timeout` set to 0, userspace can successfully execute `ioctl(WDIOC_SETT=
IMEOUT)` with a timeout of 0. The `airoha_wdt_set_timeout()` function assig=
ns this 0 to `wdog_dev->timeout` and restarts the hardware timer. This caus=
es `airoha_wdt_start()` to write 0 to the timer load register, which trigge=
rs an instantaneous hardware reset without proper shutdown. The driver shou=
ld explicitly set `wdog_dev->min_timeout =3D 1`.
--

--- Patch [1]: [PATCH] watchdog: airoha: validate heartbeat module paramete=
r ---
commit 1b1b24f68ee022a802b613038f9562b2f86dffc9
Author: Wayen Yan <win847@gmail.com>

watchdog: airoha: validate heartbeat module parameter

This patch replaces a direct assignment of the heartbeat module parameter
with a call to watchdog_init_timeout() to properly validate the timeout
range. This prevents an integer overflow in the timer load calculation
that could otherwise cause the watchdog to expire immediately.

> diff --git a/drivers/watchdog/airoha_wdt.c b/drivers/watchdog/airoha_wdt.c
> index dc8ca11c14d81..67160d760d844 100644
> --- a/drivers/watchdog/airoha_wdt.c
> +++ b/drivers/watchdog/airoha_wdt.c
> @@ -150,13 +150,13 @@ static int airoha_wdt_probe(struct platform_device =
*pdev)
> =20
>  	/* Initialize struct watchdog device */
>  	wdog_dev =3D &airoha_wdt->wdog_dev;
> -	wdog_dev->timeout =3D heartbeat;
>  	wdog_dev->info =3D &airoha_wdt_info;
>  	wdog_dev->ops =3D &airoha_wdt_ops;
>  	/* Bus 300MHz, watchdog 150MHz, 28 seconds */
>  	wdog_dev->max_timeout =3D FIELD_MAX(WDT_TIMER_VAL) / airoha_wdt->wdt_fr=
eq;
>  	wdog_dev->parent =3D dev;

[Severity: High]
This is a pre-existing issue, but should the driver also explicitly=20
initialize wdog_dev->min_timeout?

Because min_timeout is currently left uninitialized (0), the watchdog core's
watchdog_timeout_invalid() function allows a timeout of 0. If userspace
calls ioctl(WDIOC_SETTIMEOUT) with 0, airoha_wdt_set_timeout() will assign 0
to wdog_dev->timeout.

This results in airoha_wdt_start() writing 0 to the timer load register,
which triggers an immediate, ungraceful hardware reset:

drivers/watchdog/airoha_wdt.c:airoha_wdt_start() {
        ...
        val =3D wdog_dev->timeout * airoha_wdt->wdt_freq;
        writel(val, airoha_wdt->base + REG_WDT_TIMER_LOAD_VALUE);
        ...
}

Setting wdog_dev->min_timeout =3D 1 would prevent userspace from configurin=
g a
zero timeout.

> +	watchdog_init_timeout(wdog_dev, heartbeat, dev);

[Severity: High]
If watchdog_init_timeout() fails, does this leave wdog_dev->timeout set=20
to 0?

The kzalloc allocation zero-initializes wdog_dev, and the patch removes
the direct assignment of wdog_dev->timeout. If the heartbeat parameter is
invalid and there is no timeout-sec device tree property,=20
watchdog_init_timeout() returns -EINVAL and leaves wdog_dev->timeout as 0.

Because the return value is ignored, the watchdog registers successfully.
When a userspace daemon subsequently opens /dev/watchdog, airoha_wdt_start(=
)=20
runs:

drivers/watchdog/airoha_wdt.c:airoha_wdt_start() {
        ...
        val =3D wdog_dev->timeout * airoha_wdt->wdt_freq;
        writel(val, airoha_wdt->base + REG_WDT_TIMER_LOAD_VALUE);
        ...
}

This calculates a load value of 0, immediately expiring the timer and
rebooting the system.

Would it be better to initialize wdog_dev->timeout to a valid default
value before calling watchdog_init_timeout(), or explicitly handle the=20
error return value?

>  	watchdog_set_drvdata(wdog_dev, airoha_wdt);
>  	watchdog_set_nowayout(wdog_dev, nowayout);
>  	watchdog_stop_on_unregister(wdog_dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178348833669.86438.=
10575372757097263872@gmail.com?part=3D1
