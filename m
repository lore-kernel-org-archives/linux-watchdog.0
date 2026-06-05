Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E06954739
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666076; cv=none; b=M0wLocq6eiME/PEmmlgXJHBut3Y687WF6F80Caogzc/sUI8U2YHsfRvC0borjg6Vfgvixs7XIwWLNVGTg8HQeNnFKOfYQiWcwJyQB9LdfyjGN3+/CotWcxXYrEgaPddd6Q3HvridfwlECJiNKFrMzk7GSJEPbB+iiDztopD78+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666076; c=relaxed/simple;
	bh=enwqT2ZgAS5Jg5iF0FFrgYkUT4nnR8O5dpDgEXTeQVQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tQ+dV/E0JvjigxIFcyGbsA6s1/G5XOQymyRyjhwXto8nkVixus6/OvonK/fsudy/M8qZA+JGr2357gQZ68IIs7TWI3oIjlkODY+UkSJ1PvtoBwRLouitHi+Wnd5AV/3membP3LbWNBIbjVMhqR1/EHwIYeY6jPM1q6QBhwxeldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro0JmXTy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro0JmXTy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8321F00893;
	Fri,  5 Jun 2026 13:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780666074;
	bh=tq3c8GJjegGxzh7zRVe+iQTMWZqm/rNgZVec7nu0A/k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ro0JmXTyLEGs5eaPxNxl4I7zuBnkvBPJtVBeOIFeCBTkGKD5wdxmbyKUf9Xxrrhul
	 Ui1sKUTRlNb7SvR4J2y42H+sIlGNPpuD1sgF7l3Jw+5bzjrsMqDkKTEyZkRtIMvUTk
	 xAGT/FStoRyN459vTjrZyRVLwYH9DFaRpEcec5E4denYrQU5Bni8vgP5ESCoNQcRMJ
	 MQNyHFsHzPLgy+Q+3Ohzy9+OtZIj6d4U87Rvxz8J8tWZk+4niMWNCPL0v1vA2HTFyI
	 0RQuv0kC+kuyriK8USiGfCW4Qgtfm2NVH52id9Y9Dg0BfejH/zWWdgB6p5bQNL84sj
	 80/TXI/v1JSyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] watchdog: starfive: guard system suspend/resume
 hardware access
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Theesfeld" <william@theesfeld.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <d65217907ee0eaff853e50c46658919436b9f1ef.1780664848.git.william@theesfeld.net>
References: <d65217907ee0eaff853e50c46658919436b9f1ef.1780664848.git.william@theesfeld.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:27:53 +0000
Message-Id: <20260605132754.7F8321F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A watchdog started via early_enable is permanently stopped after s=
ystem suspend/resume.
- [High] starfive_wdt_remove unconditionally accesses gated hardware, trigg=
ering a synchronous external abort.
--

commit c23d412b644d160f8e059fcbfd66f48b0a689897
Author: William Theesfeld <william@theesfeld.net>

watchdog: starfive: guard system suspend/resume hardware access

This commit guards hardware access in starfive_wdt_suspend() and
starfive_wdt_resume() with pm_runtime_status_suspended() checks. It prevents
register reads and writes when the device is runtime-suspended and its cloc=
ks
are gated, avoiding synchronous external aborts.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index 6539bf0893583..4926984bf1e93 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
[ ... ]
> @@ -574,8 +579,16 @@ static int starfive_wdt_resume(struct device *dev)
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * pm_runtime_force_resume() leaves the device in whichever runtime
> +	 * PM state it was in before system suspend.  Only restore hardware
> +	 * state when the device is actually resumed; otherwise the register
> +	 * writes below would race with gated clocks.
> +	 */
> +	if (pm_runtime_status_suspended(dev))
> +		return 0;
> +
>  	starfive_wdt_unlock(wdt);
> -	/* Restore watchdog state. */
>  	starfive_wdt_set_reload_count(wdt, wdt->reload);
>  	starfive_wdt_lock(wdt);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does this skip restarting the
hardware for early-enabled watchdogs?

Immediately following this block, the function checks:

    if (watchdog_active(&wdt->wdd))
        return starfive_wdt_start(wdt);

When early_enable is used but userspace hasn't opened the watchdog, the
framework state is WDOG_HW_RUNNING without WDOG_ACTIVE. Since
watchdog_active() only checks WDOG_ACTIVE, it evaluates to false here.

Does this leave the hardware watchdog permanently stopped after a system
resume?

[Severity: High]
This is a pre-existing issue, but I noticed a similar hardware access issue
can happen during driver unbind:

drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
    struct starfive_wdt *wdt =3D platform_get_drvdata(pdev);

    starfive_wdt_stop(wdt);
    ...
}

During driver unbind, the driver core (__device_release_driver() in
drivers/base/dd.c) drops the runtime PM usage counter to 0 immediately befo=
re
calling device_remove().

If the watchdog is not active (e.g. early_enable is false and userspace
never opened it), the device is suspended and its clocks are gated. Does
calling starfive_wdt_stop() here unconditionally access the WDOGCONTROL
and WDOGLOCK registers while clocks are gated, triggering a synchronous
external abort?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780664848.gi=
t.william@theesfeld.net?part=3D4
