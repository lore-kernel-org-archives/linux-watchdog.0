Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7C2DD5F6
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 12:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662955; cv=none; b=Ieih6eSp65J6lhHqNyyBPV5fk8eriZjfhQcF3Z5iP9q2VJJ11QDaIpPv0DaB90FVPz7HkgdQZb9pGJK77+evU1T+xTJ8trO5+Yb8gUM1WzEwrLwfXVhmgnZtKfHRViREn05HYcO6a4Jww1uUQsG1wcAss1OLlmwr9tU2zEbFWzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662955; c=relaxed/simple;
	bh=xwfwxrro4ZbKeOMyVO2PcuLs68N/7JnjkgmNK4xCGk8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hLXP+WmnlzhqWKE0q1Fb6LxjsV87+MfVr7v/kuqflhFteXGhfOupkfwcazzYP2HHiKV7eS8bkvUKv5tk8wp/R7sC2TGiWYGYRMYFrZ0EYyhag+2VaeupYGhO6oiyPRjPOs7epOJqNJYnGWmfStVh6lPAeiHNRIYCYxjdCq7lMEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dI31aw40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dI31aw40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FB11F00893;
	Fri,  5 Jun 2026 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780662954;
	bh=h5RseTlszrzE5ER2iqgL+VjDu7HYPb0zBGuqkjsyzIo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dI31aw40/pmtjxTMsKhDU8fy+GYV75Xn6tUq5SAOyMeiUdJwNtJpxFojdMJSWWxiH
	 rmbQxZnMw7IbVBebqz6UQcHwnPLopxXZM6AViEb7AeoIRhMbILXDApedhg9xAyoYJI
	 oWoot3u7HJTzsHGYwDm8uL+jIhQMTNygtZEy0G6Di8F2aLgysmW7RTzhICRyI+Z+VU
	 OpHuji6Xri9x2VKmrLNv/BfYMVv7CS3E9R1PszRKca2MrjeB5tRqHRpn1pK9s2UHNt
	 ueSOf+tp0uwark1dfTOSk7zqDESfdaNvBhf39Z7tC1P7xsFAVOmsydKPD6/24xOhpA
	 Ia1b1M1MhTIqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: starfive: use pm_runtime_resume_and_get() to
 fix refcount leak
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Theesfeld" <william@theesfeld.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260605122336.159546-1-william@theesfeld.net>
References: <20260605122336.159546-1-william@theesfeld.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:35:53 +0000
Message-Id: <20260605123553.D2FB11F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] System callbacks unconditionally access hardware registers whi=
le the device may be runtime-suspended, which will trigger a synchronous ex=
ternal abort.
- [High] starfive_wdt_pm_start() leaks the runtime PM usage counter if the =
hardware start operation fails, an edge case missed by the patch.
- [High] starfive_wdt_pm_stop() and starfive_wdt_probe() incorrectly handle=
 a return value of 1 from pm_runtime_put_sync(), interpreting a success cas=
e as an error.
- [High] Multiple error paths in starfive_wdt_probe() leak the PM usage cou=
nter and fail to disable PM runtime.
- [High] starfive_wdt_shutdown() unconditionally drops the runtime PM usage=
 counter, causing an underflow if the watchdog is not active.
- [High] Runtime PM usage counter leaks on module removal when early_enable=
 is true and the device was never opened.
--

commit 716832af83b52aac9fc1a5fdc00be97db3d21459
Author: William Theesfeld <william@theesfeld.net>

watchdog: starfive: use pm_runtime_resume_and_get() to fix refcount leak

starfive_wdt_pm_start() calls pm_runtime_get_sync(), but
pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error.  On the error path this function just
returns the error code without a matching pm_runtime_put_noidle(),
so the usage counter is leaked on every failed resume.

Switch to pm_runtime_resume_and_get(), which decrements the usage
counter automatically on failure, leaving the caller with the simple
"check return value and propagate" pattern that the existing code
was already trying to follow.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index af55adc4a3c69..5a3254c83d3bb 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -371,7 +371,7 @@ static void starfive_wdt_stop(struct starfive_wdt *wd=
t)
>  static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>  {
>  	struct starfive_wdt *wdt =3D watchdog_get_drvdata(wdd);
> -	int ret =3D pm_runtime_get_sync(wdd->parent);
> +	int ret =3D pm_runtime_resume_and_get(wdd->parent);
> =20
>  	if (ret < 0)
>  		return ret;
> =20
>  	return starfive_wdt_start(wdt);

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the runt=
ime
PM usage counter if starfive_wdt_start() fails? It appears that the function
returns the error directly without calling pm_runtime_put(), keeping the
reference acquired by pm_runtime_resume_and_get().


While reviewing this file, I noticed a few other pre-existing issues.

drivers/watchdog/starfive-wdt.c:starfive_wdt_pm_stop() {
    ...
	starfive_wdt_stop(wdt);
	return pm_runtime_put_sync(wdd->parent);
}

[Severity: High]
This is a pre-existing issue, but does this break the watchdog core's
expectation of returning 0 on success?

According to Runtime PM API contracts, pm_runtime_put_sync() returns 1 if t=
he
device is already in the RPM_SUSPENDED state, which indicates success, not =
an
error. By returning this raw result, it seems we force the watchdog core to
assume the stop operation failed.


drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
    ...
	if (!early_enable) {
		if (pm_runtime_enabled(&pdev->dev)) {
			ret =3D pm_runtime_put_sync(&pdev->dev);
			if (ret)
				goto err_unregister_wdt;
    ...

[Severity: High]
This is a pre-existing issue, but does this erroneously fail the probe if
pm_runtime_put_sync() returns 1?


drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
    ...
	pm_runtime_enable(&pdev->dev);
	if (pm_runtime_enabled(&pdev->dev)) {
		ret =3D pm_runtime_resume_and_get(&pdev->dev);
		if (ret < 0)
			return ret;
    ...

[Severity: High]
This is a pre-existing issue, but do these direct return paths bypass the
required pm_runtime_disable() cleanup after pm_runtime_enable() was called?


drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
    ...
err_exit:
	starfive_wdt_disable_clock(wdt);
	pm_runtime_disable(&pdev->dev);

	return ret;
}

[Severity: High]
This is a pre-existing issue, but does the err_exit label miss dropping the
runtime PM reference acquired via pm_runtime_resume_and_get() earlier in the
probe?


drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
    ...
static void starfive_wdt_remove(struct platform_device *pdev)
{
	struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);

	starfive_wdt_stop(wdt);
    ...

drivers/watchdog/starfive-wdt.c:starfive_wdt_shutdown() {
    ...
static void starfive_wdt_shutdown(struct platform_device *pdev)
{
	struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);

	starfive_wdt_pm_stop(&wdt->wdd);
    ...

drivers/watchdog/starfive-wdt.c:starfive_wdt_suspend() {
    ...
static int starfive_wdt_suspend(struct device *dev)
{
	struct starfive_wdt *wdt =3D dev_get_drvdata(dev);

	/* Save watchdog state, and turn it off. */
	wdt->reload =3D starfive_wdt_get_count(wdt);

	/* Note that WTCNT doesn't need to be saved. */
	starfive_wdt_stop(wdt);
    ...

drivers/watchdog/starfive-wdt.c:starfive_wdt_resume() {
    ...
static int starfive_wdt_resume(struct device *dev)
{
    ...
	starfive_wdt_unlock(wdt);
	/* Restore watchdog state. */
	starfive_wdt_set_reload_count(wdt, wdt->reload);
	starfive_wdt_lock(wdt);
    ...

[Severity: Critical]
These are pre-existing issues, but do these system callbacks risk triggerin=
g a
synchronous external abort by unconditionally accessing hardware registers
while the device might be runtime-suspended and unclocked?


drivers/watchdog/starfive-wdt.c:starfive_wdt_shutdown() {
    ...
static void starfive_wdt_shutdown(struct platform_device *pdev)
{
	struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);

	starfive_wdt_pm_stop(&wdt->wdd);
}

[Severity: High]
This is a pre-existing issue, but does unconditionally calling
starfive_wdt_pm_stop() (which contains pm_runtime_put_sync()) cause a PM
usage counter underflow if the watchdog is already inactive and its counter
is 0?


drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
    ...
	if (pm_runtime_enabled(&pdev->dev))
		pm_runtime_disable(&pdev->dev);
	else
		/* disable clock without PM */
		starfive_wdt_disable_clock(wdt);
}

[Severity: High]
This is a pre-existing issue, but does the remove function fail to decrement
the PM usage counter if early_enable is true and the device was never opened
by userspace?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605122336.1595=
46-1-william@theesfeld.net?part=3D1
