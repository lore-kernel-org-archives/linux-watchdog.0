Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AA38B12A
	for <linux-watchdog@vger.kernel.org>; Sun, 23 Aug 2026 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484788; cv=none; b=sEoqCgjVm5jvfyc3FWdpxh0199/X7wTBaxbbQE6zIRVFdFrRLQpp/r7F+Vn3cOphDahDf5BsnkktLemKEXfo4NxmmTt0uBuzJMeLjbjRW5RH7ZCfEwKCDC9inGNp3HOrBlYBUgWq+EKCVGKUl87u+B17/HLaoRR8pDojxxefAZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484788; c=relaxed/simple;
	bh=1FtnTizWIlEn7Kvw+bSNsrsYGkrVj//nOYylV6S5jIs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LpggD7dhvQeYHQ6TBIAOCXJTJziPqKDq4bQPWIh71QdzdaGwgwVndoUpvp7L3LbMI2UU3+wFeVoWEoaidBASdLutA3CwwNpHJNel1UHJF5cP9VvX7SujyZ++eGFoHUE+2DJRV0tc/f7d3nNtNCoGS8LLLuXCI58tfFATvunTYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSPFqxnv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSPFqxnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0A21F000E9;
	Sun, 23 Aug 2026 11:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787484787;
	bh=WlOxMewRCKY+V447G+GkmXSTF/jj3Q66L6n149unAiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dSPFqxnvCCMqFDwjsf3DHL0vbp1ZWDJgriUJw8lHCgHhrs0ZsdR7fZg1RpwFUqFQG
	 iIqGVN0FUnKRyZj46VS5jHu/7k1lbX1eQ38iiMQmE7w6Nm/yyWblq03xPQASiamarR
	 YxnQzzqDbjwiHw2BqdlH0+leCoOFkOGEVUjIjlcUGDjcM7yUqtJ1ymSUnpRabkpezh
	 sWCa4wbRJRVlACN71eHvAwuhMN6g3efPJ/lvpzMiggLIwb+AMCa6v6rlmelS59JF+7
	 WfyPUNA7TMDYUoJMtbRKjyGmC8FTsD3Iw5VRntZWap36nS1giVZZTQOftJoADAPjRq
	 ORlYUwcJ/sHaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: starfive: fix runtime PM usage counter leak
 in pm_start
Reply-To: sashiko-reviews@lists.linux.dev
To: manushprajwal <manushprajwal555@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260823112225.1107-1-manushprajwal555@gmail.com>
References: <20260823112225.1107-1-manushprajwal555@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 11:33:06 +0000
Message-Id: <20260823113307.1A0A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unprotected hardware access in get_timeleft sysfs callback all=
ows unprivileged local DoS.
- [High] The patch fixes a runtime PM usage counter leak when pm_runtime_ge=
t_sync() fails, but leaves an identical leak when the subsequent starfive_w=
dt_start() fails.
- [High] Unclocked hardware register accesses in suspend, shutdown, and rem=
ove paths cause bus faults.
- [High] Leaked runtime PM usage counter and missing pm_runtime_disable() i=
n starfive_wdt_probe() error paths.
- [High] Runtime PM usage counter and clocks are permanently leaked in remo=
ve if early_enable is true and the watchdog was never opened.
- [High] The hardware watchdog is not restarted on system resume if early_e=
nable is true but the device was not opened.
--

--- Patch [1]: [PATCH] watchdog: starfive: fix runtime PM usage counter lea=
k in pm_start ---
commit 6f33b73ef6f14abdd5d861e7b791ec5774bc787e
Author: manushprajwal <manushprajwal555@gmail.com>

watchdog: starfive: fix runtime PM usage counter leak in pm_start

This commit fixes a runtime PM usage counter leak in starfive_wdt_pm_start(=
).
It ensures pm_runtime_put_noidle() is called when pm_runtime_get_sync()
returns an error.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index af55adc4a3c69..ecb704b2e9a3d 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -373,8 +373,10 @@ static int starfive_wdt_pm_start(struct watchdog_dev=
ice *wdd)
>  	struct starfive_wdt *wdt =3D watchdog_get_drvdata(wdd);
>  	int ret =3D pm_runtime_get_sync(wdd->parent);
> =20
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(wdd->parent);
>  		return ret;
> +	}
> =20
>  	return starfive_wdt_start(wdt);
>  }

[Severity: High]
This is a pre-existing issue, but does this still leak the runtime PM usage
counter if starfive_wdt_start() fails?

If starfive_wdt_start() returns a negative error (for example, if it
times out waiting for an interrupt clear), the error is returned directly.
Since the pm_runtime_get_sync() succeeded, doesn't this return path skip
dropping the PM reference, permanently preventing the device from suspendin=
g?


[Severity: High]
This is a pre-existing issue, but do the suspend, remove, and shutdown paths
access hardware registers while the device is suspended?

In starfive_wdt_suspend(), the registers are accessed unconditionally:

    drivers/watchdog/starfive-wdt.c:starfive_wdt_suspend() {
        ...
        wdt->reload =3D starfive_wdt_get_count(wdt);
        /* Note that WTCNT doesn't need to be saved. */
        starfive_wdt_stop(wdt);
        ...
    }

If the watchdog was not opened by userspace and early_enable is false, the
device resides in a runtime-suspended state with clocks disabled. Could
accessing its registers in this state trigger a synchronous external abort
(bus fault)? Similarly, the remove and shutdown paths also call
starfive_wdt_stop() directly.


[Severity: High]
This is a pre-existing issue, but do the error paths in starfive_wdt_probe()
leak the runtime PM usage counter or miss disabling PM?

If pm_runtime_resume_and_get() fails:

    drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
        ...
        ret =3D pm_runtime_resume_and_get(&pdev->dev);
        if (ret < 0)
            return ret;
        ...
    }

Should this call pm_runtime_disable() before returning?

Additionally, if a subsequent step fails, it jumps to err_exit:

    drivers/watchdog/starfive-wdt.c:starfive_wdt_probe() {
        ...
    err_exit:
        starfive_wdt_disable_clock(wdt);
        pm_runtime_disable(&pdev->dev);

        return ret;
    }

Does this path need to call pm_runtime_put_noidle() to drop the usage
counter before disabling PM?


[Severity: High]
This is a pre-existing issue, but does starfive_wdt_remove() leak the
runtime PM reference and clocks if early_enable is true?

If early_enable is set, the probe function leaves the PM usage count at 1.
If userspace never opens the watchdog, WDOG_ACTIVE remains false.
During remove:

    drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
        ...
        if (pm_runtime_enabled(&pdev->dev))
            pm_runtime_disable(&pdev->dev);
        ...
    }

Since watchdog_unregister_device() bypasses the stop callback when
WDOG_ACTIVE is false, and remove() only disables runtime PM without dropping
the usage counter, does this prevent the device from ever suspending and
leave the clocks running indefinitely?


[Severity: High]
This is a pre-existing issue, but does starfive_wdt_resume() fail to
restart the hardware if early_enable is true but the device is unopened?

    drivers/watchdog/starfive-wdt.c:starfive_wdt_resume() {
        ...
        if (watchdog_active(&wdt->wdd))
            return starfive_wdt_start(wdt);

        return 0;
    }

If the watchdog was started via early_enable but not opened by userspace,
watchdog_active() is false. Since starfive_wdt_suspend() unconditionally
stops the hardware, does this leave the system without hardware watchdog
protection after resuming?


[Severity: Critical]
This is a pre-existing issue, but does starfive_wdt_get_timeleft()
allow an unprivileged local denial of service?

    drivers/watchdog/starfive-wdt.c:starfive_wdt_get_timeleft() {
        ...
        count =3D starfive_wdt_get_count(wdt);
        ...
    }

This function is called when a user reads the 0444 sysfs attribute
timeleft. If the watchdog is closed and the device is runtime-suspended,
its clocks are disabled. Could an unprivileged user reading this sysfs
attribute cause an immediate bus fault (kernel panic) by accessing
unclocked registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823112225.1107=
-1-manushprajwal555@gmail.com?part=3D1
