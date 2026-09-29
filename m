Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14185304BF
	for <linux-watchdog@vger.kernel.org>; Tue, 29 Sep 2026 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690400; cv=none; b=Te4VVqQ9sCcZmv2jhWIukLR2zQtpNSh+X5tBRG7MANhb3afmtcH3zObGFF/fEHSjm5n2nSn0LA42JehzLS5/EffU4x+44NxaYWmcPMblgc4yURKmbmrFP1gUK4jdQRTFDiDV1/94ywrhpPR+btNYm7rSlG60B+kby3M20X+m8nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690400; c=relaxed/simple;
	bh=U8/HRgh5fO66Lrb4edmeCWx5ypNRvwU30R3EgTxyilY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KUgBa0SuTzP003OjmVnN1UpY8qGV5R0AQ5NfDxlJ6OmZGhePH3S5mnaNJdet+ECuZA/K6PcVgyLZQlRgek5h2il3DMc4PJAKMIF683w6FrfnNiv2q5yQaC3huQErDy+IJIzn9IDrK1AeZiHD+u1Xb/O+ZPp5VpeJ6THHpyw/erc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7oLRgL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7oLRgL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530611F0089B;
	Tue, 29 Sep 2026 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690398;
	bh=cO7d3OSiA3AMEYNTJn7SHGXEUaQg1M9S8PAP8Q6cy9k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7oLRgL5AtYvq3NM2IDpC2WSPFnOupheEsy0emAZFMkuARs5VgvUtatPHIbEihNUD
	 dRQRsaBKfD6nitmmEsaFA4CxpMCLMHSFuvxrBxO897xcflJBAp8qkwJCYZLIqPwF9d
	 hNwGZa5Eejdw7qfpEmH/DuesYBgopzZe+vi1y/y4msdUOowglkbjKt/EBnk2Pq7Vbb
	 CiaSrubn3BSSeS86rZXG2fsm7Y+Z1TowhehtDmlTQCBZIFUDuAjCn9Hj6T7gBXILJ6
	 rzUZ7bwxB6jSK4m6VsumHanW6dlvptZmuJOjpTlW8c0RtanINpzIcx0GYnm3S1xqeX
	 64IwiW93c6FHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] watchdog: core: Stop pretimeout hrtimer on suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guenter Roeck" <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260929134635.2567137-5-linux@roeck-us.net>
References: <20260929134635.2567137-1-linux@roeck-us.net>
 <20260929134635.2567137-5-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:59:57 +0000
Message-Id: <20260929135958.530611F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: missed software pretimeout on resume due to timer desync=
hronization
--

commit b401093697a53f53413364d61f3bff8840d84ffc
Author: Guenter Roeck <linux@roeck-us.net>

watchdog: core: Stop pretimeout hrtimer on suspend

This commit stops the pretimeout hrtimer during system suspend and ensures
it is correctly restarted on resume if the hardware watchdog is running. It
also prevents the timer from starting while the watchdog is suspended.

> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_=
dev.c
> index d652d6e137c43..f1d14ac433fd9 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c

[ ... ]

> @@ -1350,6 +1351,8 @@ int watchdog_dev_resume(struct watchdog_device *wdd)
>  	clear_bit(_WDOG_SUSPENDED, &wd_data->status);
>  	if (watchdog_worker_should_ping(wd_data))
>  		ret =3D __watchdog_ping(wd_data->wdd);
> +	if (watchdog_hw_running(wdd) && !ret)
> +		watchdog_hrtimer_pretimeout_start(wdd);

[Severity: High]
Could this explicit restart push the software pretimeout out of sync with t=
he
hardware counter?

If the watchdog is past the open deadline, watchdog_worker_should_ping()
returns false. The kernel intentionally stops pinging the hardware watchdog
so it will reset the system.

When suspended and resumed in this state, __watchdog_ping() is skipped, but
watchdog_hw_running() remains true. Since ret is 0, we restart the pretimeo=
ut
timer.

Does this assume the hardware counter was just reset to now, artificially
delaying the software pretimeout beyond the actual hardware reset?

>  	mutex_unlock(&wd_data->lock);
> =20
>  	return ret;

[ ... ]

> diff --git a/drivers/watchdog/watchdog_hrtimer_pretimeout.c b/drivers/wat=
chdog/watchdog_hrtimer_pretimeout.c
> index 49a05ea60c979..5c88e6467994b 100644
> --- a/drivers/watchdog/watchdog_hrtimer_pretimeout.c
> +++ b/drivers/watchdog/watchdog_hrtimer_pretimeout.c
> @@ -31,7 +31,8 @@ void watchdog_hrtimer_pretimeout_start(struct watchdog_=
device *wdd)
>  {
>  	if (!(wdd->info->options & WDIOF_PRETIMEOUT) &&
>  	    wdd->pretimeout &&
> -	    !watchdog_pretimeout_invalid(wdd, wdd->pretimeout))
> +	    !watchdog_pretimeout_invalid(wdd, wdd->pretimeout) &&
> +	    !test_bit(_WDOG_SUSPENDED, &wdd->wd_data->status))
>  		hrtimer_start(&wdd->wd_data->pretimeout_timer,
>  			      ktime_set(wdd->timeout - wdd->pretimeout, 0),
>  			      HRTIMER_MODE_REL);

[Severity: High]
Since hrtimer_start() here uses HRTIMER_MODE_REL, the timer is always
scheduled strictly relative to now.

If the hardware watchdog was last pinged before the suspend cycle, it will
reboot the system at last_hw_keepalive + timeout.

If the elapsed time (which includes the suspend duration) exceeds pretimeou=
t,
will this relative timer be scheduled to fire after the hardware reset occu=
rs,
causing the pretimeout event to be completely missed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929134635.2567=
137-1-linux@roeck-us.net?part=3D4
