Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8874384CC3
	for <linux-watchdog@vger.kernel.org>; Tue, 15 Sep 2026 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443198; cv=none; b=QgYSUpsylxkDEn2sM5yFfkhajaoRVHUDx2rUWkkDnXWGpvSdMGAm8GPdHyEYvLaT+JPqGcORG0CBJ/81NXQuE3le0yRxpC8shyCQZTardArizHjKdbQr0JVsYNQNC7L5L+qbB1aLGjv4ieOjbltF6MVF/eBfrd9lg0rdb9nz12k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443198; c=relaxed/simple;
	bh=/NaV7fzug7T9KIteaYq4fPuT+gLPQU6fW5GPYyVYur0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YZ0Z7WNWuVb7Oz2WbRkvrfjQR3ZVNFnHooE6Xg5jlAm593Z2Zk+EWbUFBvDShspelCzA/rlJkz41QDay2g0Z9yukYAiXWE+YKOwYzqNtSXGwoIe9s1q8+iFQ/yaXu9zu+ksmtrwHPwADtXuxW4IX7R4bZgGz7njH0O8KAnpKuFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WF+6Hxs+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WF+6Hxs+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657481F000FF;
	Tue, 15 Sep 2026 03:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789443185;
	bh=aMxKDfI2+E/cp82ohGesqr+zyvfK11WFqQHOd30eEew=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WF+6Hxs+sHNen618lbM6DTg1QM2/rvke+8hakbrVHIl4wtMgkWMBnn4k/6F5YyV37
	 Oo+5+isKgk05QQJs6TRHe0yCOemNQEmhIcoJL+rDiG7zQ2WIVXanc9YX9yFd84PXzP
	 rDeekgE+MKcb4slFkrppsOpTF9xDLDMlDkIos66zA2Mmz08YLof6eYY8p+qrWbAKZQ
	 C33wj+644/8FFAzymCD0QhFl6z/Fl5iDkD+aULzFMh8g3AOwsF4lPnh1eaybnZRh8J
	 aelEdXMGNeac8RsmScnQZEHU/4f3lCiVMsrdvg+tsHG/T1kx6Vx5+ihTfH3vD1upVc
	 AoqWO1GuX1TWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] watchdog: starfive-wdt: fix PM reference leak in
 probe error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivy Lopez" <skunkolee@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260915032032.222665-1-skunkolee@gmail.com>
References: <20260914165022.169877-1-skunkolee@gmail.com>
 <20260915032032.222665-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 03:33:05 +0000
Message-Id: <20260915033305.657481F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pm: desynchronize PM state by manually disabling clocks on put fai=
lure
--

commit 5ff7d303ba1caba3e17ed0a2e51c79514ccbc5c5
Author: Ivy Lopez <skunkolee@gmail.com>

watchdog: starfive-wdt: fix PM reference leak in probe error path

This commit addresses a PM reference leak in the probe error path by tracki=
ng
whether a PM reference is held and whether clocks are enabled, ensuring they
are properly released on exit.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index af55adc4a3c69..4ad587732bdaa 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c

[ ... ]

> @@ -509,7 +517,12 @@ static int starfive_wdt_probe(struct platform_device=
 *pdev)
>  err_unregister_wdt:
>  	watchdog_unregister_device(&wdt->wdd);
>  err_exit:
> -	starfive_wdt_disable_clock(wdt);
> +	if (pm_ref_held) {
> +		if (pm_runtime_put_sync(&pdev->dev))
> +			starfive_wdt_disable_clock(wdt);

[Severity: High]
Does manually disabling the clock here risk desynchronizing the PM state if
pm_runtime_put_sync() intentionally fails?

If a concurrent operation (like userspace sysfs interaction) bumps the PM
usage count during this window, pm_runtime_put_sync() in starfive_wdt_probe=
()
returns an error such as -EAGAIN. This indicates the PM core has decided to
keep the device active.

By manually disabling the clocks here, the hardware is turned off while the
PM core still considers the device to be RPM_ACTIVE.

If a concurrent thread or a subsequent driver reprobe accesses the peripher=
al
registers while unclocked (since a later pm_runtime_resume_and_get() would
find the device already active and skip the resume callback), could this le=
ad
to a bus error or system crash?

> +	} else if (clocks_on) {
> +		starfive_wdt_disable_clock(wdt);
> +	}
>  	pm_runtime_disable(&pdev->dev);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915032032.2226=
65-1-skunkolee@gmail.com?part=3D1
