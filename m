Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E17417BEBF
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666195; cv=none; b=XgXstbY0QA2pQi6zgHomm8NmMPvt3g47UD13vWm10bVCow+N43Hnukf5vZKOMO0g2hnLB0EVHT3n77tPqK/Ys34HKtRoOmLN2eD/dbiJMcwu5/xOG2FC8jhfwbkx1zIIrfhPaiZURqXIB6+yTqOej5QGn57sDVLphV91VGZ30fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666195; c=relaxed/simple;
	bh=MDJl1gFmfskJOr/u343qeLg5WXsGiITM8XVRBkWlUKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SNuxntBPeZ7tSu99wBaHCZg96LA1fvwTDmclMr3TpMoitZ9DQCJrVN9zKaEGkuZnJwDRiraCFSOLBWFnjLjZlaBZBNiLhgqjqObvgtN0xIZpZvn/ecu22UmRAT1+2rjbHDUrA98UsoZ9Lt8dfKOpqIbfr0Jqo5jKznoY4lpdznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbkkdTyg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbkkdTyg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2391F00893;
	Fri,  5 Jun 2026 13:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780666193;
	bh=IJwn44JRWh66zA4vqzlpphFCwyFYkyTqxcy8WevvM3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbkkdTygen6Id54A2Ed2IIxKNKzgd2LHQ+NVbP8j+mWQv+j0igB1L6aNNd3tISJkM
	 xxBvYO3VAxq8XKfZhNWHOCm5hK4UBYUiV2ah+On8U4KnOShoTive3LViQjWRoeSw5H
	 F63j6teyOJiJEVyP/42fTZ1/CZpUmnUUnyn6qsf/DSfAmmwHO/VIb8iKDE8dguzSJY
	 yiWTKwTqSVoIsIojxy4rho3z6EdI77iC1MtQmoGfc5VH9vaVEQpNyjB4sP6z5kiE5K
	 tbxWGNhTLHq9rb9b/j++sdCTlI+UvmyPPT8dO5cEvJV06UTSZgP1YJ26gPA2jq0cHn
	 QCXEhi53KrnUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] watchdog: starfive: avoid PM refcount underflow
 in shutdown
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Theesfeld" <william@theesfeld.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <c7398cba84ea85ed041fe5fe7868ad445b40685f.1780664848.git.william@theesfeld.net>
References: <c7398cba84ea85ed041fe5fe7868ad445b40685f.1780664848.git.william@theesfeld.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:29:53 +0000
Message-Id: <20260605132953.BD2391F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Race condition in `starfive_wdt_shutdown()` causes an external abo=
rt due to prematurely gating clocks and TOCTOU.

Pre-existing issues:
- [High] Unconditional hardware access in `starfive_wdt_remove()` causes an=
 external abort when the device is runtime-suspended.
- [High] Double-put of the runtime PM usage counter in the `starfive_wdt_pr=
obe` error path.
- [High] The watchdog is left permanently disabled after a system resume if=
 started via `early_enable` but not yet opened by userspace.
- [High] The `starfive_wdt_shutdown()` callback causes a double runtime PM =
put and a synchronous external abort by duplicating the watchdog core reboo=
t notifier.
- [High] `starfive_wdt_pm_stop` incorrectly propagates `-EAGAIN` when the d=
evice is still in use, breaking the watchdog core state machine.
--

commit a92c83041e6a1832c846458c02228e9b4ab617c8
Author: William Theesfeld <william@theesfeld.net>
Subject: watchdog: starfive: avoid PM refcount underflow in shutdown

This commit prevents a runtime pm reference counter underflow in the
shutdown path by only dropping the reference if the watchdog is actively
running. It checks WDOG_ACTIVE and WDOG_HW_RUNNING to conditionally stop
the hardware or drop the runtime pm reference.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index 4926984bf1e93..848935dc6dca6 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -549,7 +549,19 @@ static void starfive_wdt_shutdown(struct platform_de=
vice *pdev)
>  {
>  	struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);
> =20
> -	starfive_wdt_pm_stop(&wdt->wdd);
> +	/*
> +	 * Only drop a runtime PM reference when we actually hold one.  The
> +	 * watchdog framework increments it via pm_start() on open; when
> +	 * early_enable started the hardware without an open, the reference
> +	 * was taken at probe time and the framework state reads as
> +	 * WDOG_HW_RUNNING without WDOG_ACTIVE.  In the inactive-and-not-
> +	 * running case there is nothing for us to do and dropping the
> +	 * counter unconditionally would underflow it.
> +	 */
> +	if (watchdog_active(&wdt->wdd))
[Severity: High]
Can this lockless check race with watchdog_release() closing the watchdog
concurrently?

If device_shutdown() runs concurrently with a user-space process closing
the watchdog, processor 0 could execute watchdog_stop and call
starfive_wdt_pm_stop() to gate clocks, but might not have cleared
WDOG_ACTIVE yet.

If processor 1 running starfive_wdt_shutdown() sees watchdog_active() is
still true, could it call starfive_wdt_pm_stop() again and access gated
clocks, triggering a synchronous external abort?

[Severity: High]
This is a pre-existing issue, but does this shutdown callback duplicate the
watchdog core reboot notifier and cause a double runtime pm put?

The watchdog core registers a reboot notifier that calls wdd->ops->stop()
during reboot, gating the clocks and dropping the runtime pm reference, but
it does not clear the WDOG_ACTIVE or WDOG_HW_RUNNING flags.

When device_shutdown() subsequently invokes starfive_wdt_shutdown(), it
checks these uncleared flags. Could this erroneously call
starfive_wdt_pm_stop() or starfive_wdt_stop() a second time, triggering a
bus fault by accessing memory-mapped registers after clocks are gated?

> +		starfive_wdt_pm_stop(&wdt->wdd);
> +	else if (test_bit(WDOG_HW_RUNNING, &wdt->wdd.status))
> +		starfive_wdt_stop(wdt);
>  }

[ ... ]

While reviewing this code, I noticed a few pre-existing issues in other
functions of this driver.

[Severity: High]
This isn't a bug introduced by this patch, but does the unconditional
hardware access in starfive_wdt_remove() trigger an external abort when
clocks are gated?

drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
    ...
    starfive_wdt_stop(wdt);
    watchdog_unregister_device(&wdt->wdd);
    ...
}

If the watchdog was not started via early_enable and was never opened, or
was opened and subsequently closed, its runtime pm usage counter drops to 0,
causing the device to enter runtime suspend and its clocks to be gated.

When the driver is unbound, starfive_wdt_remove() unconditionally calls
starfive_wdt_stop(), which attempts to write to memory-mapped registers.

Could accessing these registers while clocks are gated trigger a synchronous
external abort?

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
starfive_wdt_probe() double-put the runtime pm usage counter?

drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
    ...
    ret =3D pm_runtime_put_sync(&pdev->dev);
    if (ret < 0)
        goto err_unregister_wdt;
    ...
}

If pm_runtime_put_sync() returns an error like -EAGAIN or -EBUSY, the usage
counter was already unconditionally decremented.

The code jumps to err_unregister_wdt and falls through to err_put_pm, where
pm_runtime_put_sync() is called a second time. Can this cause the usage
counter to underflow?

[Severity: High]
This isn't a bug introduced by this patch, but is the watchdog left
permanently disabled after a system resume if started via early_enable
but not yet opened by userspace?

drivers/watchdog/starfive-wdt.c:starfive_wdt_resume() {
    ...
    if (watchdog_active(&wdt->wdd))
        return starfive_wdt_start(wdt);

    return 0;
}

When early_enable is true, probe enables the hardware and sets
WDOG_HW_RUNNING, but watchdog_active() remains false until userspace opens
the device.

On system resume, starfive_wdt_resume() only calls starfive_wdt_start() if
watchdog_active() is true, leaving the hardware disabled.

Could the core's ping worker see WDOG_HW_RUNNING and continue to call
starfive_wdt_keepalive(), reloading the counter but not enabling the
hardware? Does this leave the system unprotected after a suspend/resume
cycle?

[Severity: High]
This isn't a bug introduced by this patch, but does starfive_wdt_pm_stop()
incorrectly propagate -EAGAIN when the device is still legitimately in use?

drivers/watchdog/starfive-wdt.c:starfive_wdt_pm_stop() {
    ...
    return ret < 0 ? ret : 0;
}

If early_enable is true, probe leaves an outstanding runtime pm usage count.
When the watchdog is opened, the count increments to 2.

When closed, starfive_wdt_pm_stop() drops the count to 1 via
pm_runtime_put_sync(), which returns -EAGAIN because the device is still
active.

If this -EAGAIN is propagated back to the watchdog core, does
watchdog_release() treat this as an error, leaving WDOG_ACTIVE set and
spinning the background ping worker indefinitely, even though the driver
actually stopped the hardware?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780664848.gi=
t.william@theesfeld.net?part=3D5
