Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7511A3B8939
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 03:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096758; cv=none; b=ZFUIk5UebKrJryiCWzsZ3P0XAbq1sKav1n4U5mFuJmKGbvKgFAlNf4h2nx8TQhPw3Jnap91eDv2cI2BXeiPxqU+aCJXXEKz1qTz8Gh+tOzOJncTQeqpaGjvzLlJ6rnEXikNM7PUpg0+M3AVPJyH9eJpcDlvWEdpc4yApt2x2Us8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096758; c=relaxed/simple;
	bh=C6QZZSf+/tCnfXjnNQBBYJQ5DbLPqVj57Z4D5CJe2Gs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W4qStDQy/SGep2h/u315etO/3QWZw4Y/sMxR+BlkL1YhAm0sS7H4jaKhBMUBM47IZt385M4AYkhGfOIgF4UGzTWvxERNAQfbaMd6zxWnf49cUn8NXBeSijcJakXTmtsVQ6VnH7zLhDQzX3APXRm4wCgxKBZyQbVocFfEzYhBLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP0jP3G0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP0jP3G0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E051F000FF;
	Fri, 11 Sep 2026 03:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789096756;
	bh=/DwQ1OjBsLSi3WwaZ+qj6d6ndU9Rtcqgu0wrNtaVY1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CP0jP3G0rOVlkyJFBswoWXoQ06AFMVpRYcF+RtSjgkudpwb2DZ8NBGvj7Vuv8r5Ww
	 ABYuoo1yNec5BvgjSdAukVv/YUZjxwykwSEMm+lfn6LcGKnSR4RSpwYA7QPmk/qzFx
	 pmdV34DKd6ycyYD5AdLaa4ibthMmbqQkpEdst86Ms113IPU0/DiUcIdri5tduFDAsi
	 mqdPyjDb8RWQP+YIlLgW/HsD6WzaCDxeu15B1HM6ctikOa9W/AKFQ5C4CgnrY6HrFA
	 N7NaFx/nasuLTVJTspApcNiLaHX8GHidXX66JehXuZ/U24Yrx7K7yNTOToFXokz93c
	 F+vXYWS8hw6jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: sp805_wdt: fix suspend/resume handling of
 HW_RUNNING watchdog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jun" <lijun01@kylinos.cn>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260911030531.837140-1-lijun01@kylinos.cn>
References: <20260911030531.837140-1-lijun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 03:19:16 +0000
Message-Id: <20260911031916.A8E051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] wdt_restart() fails to reboot the system if the watchdog counter c=
lock (wdt->clk) was previously disabled.
--

commit 5341b327de5a15d0411852abc081601a0f32ac49
Author: Li Jun <lijun01@kylinos.cn>

watchdog: sp805_wdt: fix suspend/resume handling of HW_RUNNING watchdog

sp805_wdt_suspend() and sp805_wdt_resume() only check watchdog_active(),
when the watchdog is left running by the driver sets WDOG_HW_RUNNING.
This ensures wdt_disable() is called in suspend.

> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index c2125f204a137..2ddb754f3b4a1 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -325,7 +325,8 @@ static int __maybe_unused sp805_wdt_suspend(struct de=
vice *dev)
>  {
>  	struct sp805_wdt *wdt =3D dev_get_drvdata(dev);
> =20
> -	if (watchdog_active(&wdt->wdd))
> +	if (watchdog_active(&wdt->wdd) ||
> +	    watchdog_hw_running(&wdt->wdd))
>  		return wdt_disable(&wdt->wdd);
> =20
>  	return 0;
>  }

[ ... ]

> @@ -335,7 +336,8 @@ static int __maybe_unused sp805_wdt_resume(struct dev=
ice *dev)
>  {
>  	struct sp805_wdt *wdt =3D dev_get_drvdata(dev);
> =20
> -	if (watchdog_active(&wdt->wdd))
> +	if (watchdog_active(&wdt->wdd) ||
> +	    watchdog_hw_running(&wdt->wdd))
>  		return wdt_enable(&wdt->wdd);
> =20
>  	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does wdt_restart() fail to
reboot the system if the watchdog counter clock was previously disabled?

If userspace cleanly stops the watchdog, the core calls wdt_disable() which
disables wdt->clk. If a reboot command is subsequently issued, wdt_restart()
writes to WDTCONTROL to assert RESET_ENABLE:

drivers/watchdog/sp805_wdt.c:wdt_restart() {
        ...
        writel_relaxed(UNLOCK, wdt->base + WDTLOCK);
        writel_relaxed(0, wdt->base + WDTCONTROL);
        writel_relaxed(0, wdt->base + WDTLOAD);
        writel_relaxed(INT_ENABLE | RESET_ENABLE, wdt->base + WDTCONTROL);
        ...
}

Because the counter clock is disabled, the hardware timer will not count do=
wn,
and the hardware reset signal is never generated. Since wdt_restart() retur=
ns
0 without re-enabling the clock, does the reboot silently fail and hang the
system?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911030531.8371=
40-1-lijun01@kylinos.cn?part=3D1
