Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5462BE639
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666421; cv=none; b=ciT7kERu4YTr+B1WglhRUHieBh9qqww0AzMxJuozofSuyhbE4o1O7IRYk3SppX5GlU1oOWy4ojq8KLjvuLG6RV/MiyqdyQEyjIQWjp5DSAvjvRcI2qS8nEjvRhNQQRlCuima14jShYfQQkE48NFPPxnRED674uZRF05D8RxgDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666421; c=relaxed/simple;
	bh=AccRfUbW636P2TWIZw4ngLbkMguJuz8wbGd/7EWglc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ed/OhKDnLS5DEIwS9/CS9gkl+wUT2Cx7ageJ1OEyF6tQg97x85ciyZ+UK8ugp9k6VsMwz5vKT5jv+bBsy7+3bXtxVR4xxld1/ZOj4vmVAsW44J4DgHQ1Hnm6kJLiwCv/ztqMREvrXKf2LhZ1D7sT1tsXnxaCmMLk6BOlUkgacjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LstftysM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LstftysM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03381F00893;
	Fri,  5 Jun 2026 13:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780666418;
	bh=aGlp8bGZHgak+0SX5cPyC8p6Vx+HwCcff6hcQUo8IyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LstftysM7R/3xuf0Ry+qZNo3t1A3AG8s8m5F86b0Es65EIaAqX5VuGJ5VS5GxrS6v
	 L4ayg/1LowHkg0PEXPIJ3o/4nRbxZvdeY2TzL/cNiMfkauGby8Bm5NAKM2NAOqpADy
	 e6AnjL217+4w1jaCCLw+KiqqhdSXqaDJUbdMNWP6hb6dv4a36EG1DYi8t3NJDCCoux
	 RJL5LLI8ZLKk/ojR/nQpRdoWIwh5P6hg4seBuAOiMFVvAymDCcqcXCSzqz2g7dSY2n
	 ehUIHmvm5nS3DJVeo7bXFYT9AEsY8xfws0rjSlI/XluGlauoWsPx04vH2z+Wpv8iWU
	 4W1cgP25ZUoTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] watchdog: starfive: release early_enable PM
 refcount on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Theesfeld" <william@theesfeld.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <57fe44ec9b838cdde9245b706f42053472efcade.1780664848.git.william@theesfeld.net>
References: <57fe44ec9b838cdde9245b706f42053472efcade.1780664848.git.william@theesfeld.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:33:38 +0000
Message-Id: <20260605133338.B03381F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `starfive_wdt_remove` unconditionally accesses hardware registers =
before checking PM state, causing a crash on unbind if the device is PM-sus=
pended.
- [High] System resume fails to restart the hardware watchdog if it was run=
ning purely due to `early_enable`.
- [Medium] Double decrement of runtime PM usage counter in `starfive_wdt_pr=
obe` error path.
--

commit 2328d244e274598a728c0306f052404720065d11
Author: William Theesfeld <william@theesfeld.net>

watchdog: starfive: release early_enable PM refcount on remove

This commit drops the runtime PM reference taken at probe time if the
watchdog was started by early_enable but never opened by userspace. It
ensures the usage counter does not leak when the driver is removed.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index 848935dc6dca6..d9175b045d60f 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -538,6 +538,19 @@ static void starfive_wdt_remove(struct platform_devi=
ce *pdev)
>  {
>  	struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);
> =20
>  	starfive_wdt_stop(wdt);
>  	watchdog_unregister_device(&wdt->wdd);

[Severity: High]
This isn't a bug introduced by this patch, but does starfive_wdt_stop()
access hardware registers before checking the PM state?

If the device is runtime suspended (for example, early_enable is false and
the watchdog is not open), its clocks would be gated. Calling
starfive_wdt_stop() without waking up the device via pm_runtime_get_sync()
could access memory-mapped registers with the clock gated.

Could this trigger a synchronous external abort or bus fault during driver
unbind?

[ ... ]

While reviewing the early_enable and PM logic in this driver, I noticed a f=
ew
other pre-existing issues:

[Severity: High]
This is a pre-existing issue, but looking at the suspend and resume
behavior with early_enable:

drivers/watchdog/starfive-wdt.c:starfive_wdt_resume() {
    ...
    if (watchdog_active(&wdt->wdd))
        return starfive_wdt_start(wdt);

    return 0;
}

During suspend, starfive_wdt_suspend() unconditionally stops the hardware if
it's active. On resume, the code above only restarts the hardware if
WDOG_ACTIVE is set. If the watchdog was running solely due to early_enable,
WDOG_ACTIVE is false, so it is left stopped, but WDOG_HW_RUNNING remains
set in the watchdog core.

If userspace later opens the watchdog, would the core only ping it via
starfive_wdt_keepalive() instead of explicitly starting it? It seems this
might leave the hardware watchdog disabled indefinitely.

[Severity: Medium]
This is also a pre-existing issue, but looking at the error path in
starfive_wdt_probe():

drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
        ...
            ret =3D pm_runtime_put_sync(&pdev->dev);
            if (ret < 0)
                goto err_unregister_wdt;
        ...
err_unregister_wdt:
    watchdog_unregister_device(&wdt->wdd);
err_put_pm:
    if (pm_runtime_enabled(&pdev->dev))
        pm_runtime_put_sync(&pdev->dev);
}

If the initial pm_runtime_put_sync() returns an error (like -EAGAIN), the
code jumps to err_unregister_wdt and falls through to err_put_pm, where it
calls pm_runtime_put_sync() a second time.

Because __pm_runtime_idle() decrements the usage counter regardless of its
return value, could this cause a usage counter underflow warning in the PM
core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780664848.gi=
t.william@theesfeld.net?part=3D6
