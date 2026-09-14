Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2124247F765
	for <linux-watchdog@vger.kernel.org>; Mon, 14 Sep 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390136; cv=none; b=L8BIXT/djRh8x1jfeAE/KXkVhHm2IDlSVm7/tpmiNWrKf7SSJKUH/JwCNf7oKfvXNxG/JbHS/+Zf74oqyXGBWcN2ZnVPm9jBFTY4KgqlmxNpYBww8jUGtqWSYdzLHnv0t+D6s4P6w1sqcl4GVmbH/jRBgREMXq6NfPaqUIOHqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390136; c=relaxed/simple;
	bh=F7EhOdvBD7YWUuwCm58G89eFYdy0NMq9J47NNEoY9DU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iOJDNPiAPtDI//93bhVgA2z1mXM7CcLL5m5RnHQpoEnLLd7EMHKFAgoAyTFxQNmu6iIHKaR4or44s/zMvnNBPU7iPo2JOLiwoEP7JwSfMOnpRg0Fvb+zl0Upvt0JULIKRhcIsNxAnvW1KVnFQrRqwsK8/acWauyhNCaMBJ5pV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNJ1OHbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNJ1OHbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA241F00893;
	Mon, 14 Sep 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390133;
	bh=UeD/c8PPnGc7GJW4agWsifvS0xDa25/fr5oEoS3hV38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YNJ1OHbvehBiIKsrt3whSFbUZBKP7GtQ74Vy1iUtTBgm2bMSFFq7wJhEaTBkoEDPq
	 bMjJBpi4ehG3wAt9OOvQZMrlb69eIY3/X5sl5u9pbjiXafWDardXP+gX2+lZseOaKH
	 bKphzqvOpO2Javgm2q8wz79F5EPOVH6X767cDVgZYo4EKPjhM0H0/NXAcqMG5H+1eR
	 1GQUQpmPzZsB5mokE/gzbvAtxkLFQ/K4W2lobVrOPtZyO4gHaQKHs3v8uIH3ZhyKZA
	 igIsIc43cMpQ6zq6Ruubn1jHfvD4T3lN25tACB2KCFoNdyahlZ1uvOegv5z2NQXI/O
	 P9FvGB7gmv/3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: shwdt: register device only after full driver
 init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Cong Nguyen" <congnt264@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260914123609.2186477-1-congnt264@gmail.com>
References: <20260914123609.2186477-1-congnt264@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:48:52 +0000
Message-Id: <20260914124853.6EA241F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing timer synchronization in `sh_wdt_remove` leads to a use-af=
ter-free when the `wdt` structure is automatically freed.
- [High] Calling non-synchronous `timer_delete` while holding `wdt->lock` i=
n `sh_wdt_stop` allows the timer callback to execute concurrently, accessin=
g suspended hardware and re-arming itself.
- [High] `sh_wdt_start` ignores the return values of `pm_runtime_get_sync` =
and `clk_enable`, potentially accessing hardware registers while powered do=
wn.
--

commit f766a8cc3f43e37c436ed7a87ffc702a473f6839
Author: Cong Nguyen <congnt264@gmail.com>

watchdog: shwdt: register device only after full driver init
   =20
sh_wdt_probe() calls watchdog_register_device() -- exposing
/dev/watchdogN -- before timer_setup() and pm_runtime_enable() run. A
start command landing in that window calls mod_timer() on an
uninitialized timer (NULL ->function) and resumes via
pm_runtime_get_sync() before PM is enabled.
   =20
Move timer_setup() and pm_runtime_enable() before the register call,
matching the order already used by rzg2l_wdt.c/rzv2h_wdt.c. Add
pm_runtime_disable() on the now-possible post-enable register-failure
path.

> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index 719f100aae60d..c22b8e7604765 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -263,19 +263,20 @@ static int sh_wdt_probe(struct platform_device *pde=
v)
>  	dev_info(&pdev->dev, "configured with heartbeat=3D%d sec (nowayout=3D%d=
)\n",
>  		 sh_wdt_dev.timeout, nowayout);
> =20
> +	timer_setup(&wdt->timer, sh_wdt_ping, 0);
> +	wdt->timer.expires	=3D next_ping_period(clock_division_ratio);
> +
> +	pm_runtime_enable(&pdev->dev);
> +
>  	rc =3D watchdog_register_device(&sh_wdt_dev);
>  	if (unlikely(rc)) {
>  		dev_err(&pdev->dev, "Can't register watchdog (err=3D%d)\n", rc);
> +		pm_runtime_disable(&pdev->dev);
>  		return rc;
>  	}
> =20
> -	timer_setup(&wdt->timer, sh_wdt_ping, 0);
> -	wdt->timer.expires	=3D next_ping_period(clock_division_ratio);
> -
>  	dev_info(&pdev->dev, "initialized.\n");
> =20
> -	pm_runtime_enable(&pdev->dev);
> -
>  	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but missing timer synchronization in
sh_wdt_remove() could lead to a use-after-free when the wdt structure is
automatically freed:

drivers/watchdog/shwdt.c:sh_wdt_remove() {
	watchdog_unregister_device(&sh_wdt_dev);

	pm_runtime_disable(&pdev->dev);
}

If the driver is unbound while the watchdog timer is active, sh_wdt_remove()
completes and returns without stopping or synchronizing the timer. The devr=
es
framework then immediately frees the wdt structure allocated via
devm_kzalloc().

Could the lingering asynchronous timer eventually fire and dereference the
freed memory in sh_wdt_ping()? Would it be safer to explicitly stop and
synchronize the timer here before returning?

[Severity: High]
This isn't a bug introduced by this patch, but calling non-synchronous
timer_delete() while holding wdt->lock in sh_wdt_stop() allows the timer
callback to execute concurrently:

drivers/watchdog/shwdt.c:sh_wdt_stop() {
...
	spin_lock_irqsave(&wdt->lock, flags);

	timer_delete(&wdt->timer);

	csr =3D sh_wdt_read_csr();
	csr &=3D ~WTCSR_TME;
	sh_wdt_write_csr(csr);

	spin_unlock_irqrestore(&wdt->lock, flags);

	clk_disable(wdt->clk);
	pm_runtime_put_sync(wdt->dev);
...
}

If sh_wdt_ping() runs on CPU 1 just as sh_wdt_stop() runs on CPU 0, CPU 1
blocks on wdt->lock. CPU 0 calls timer_delete(), disables the clock,
drops the lock, and calls pm_runtime_put_sync().

CPU 1 then acquires the lock and continues execution in sh_wdt_ping():

drivers/watchdog/shwdt.c:sh_wdt_ping() {
...
		csr =3D sh_wdt_read_csr();
		csr &=3D ~WTCSR_IOVF;
		sh_wdt_write_csr(csr);

		sh_wdt_write_cnt(0);

		mod_timer(&wdt->timer, next_ping_period(clock_division_ratio));
...
}

Can this sequence allow CPU 1 to access the now unclocked and suspended
hardware registers, and then call mod_timer() to blindly re-arm the callbac=
k?
Note that simply changing timer_delete() to timer_delete_sync() inside the
spinlock would cause a deadlock against the callback.

[Severity: High]
This is a pre-existing issue, but sh_wdt_start() ignores the return values =
of
pm_runtime_get_sync() and clk_enable():

drivers/watchdog/shwdt.c:sh_wdt_start() {
...
	pm_runtime_get_sync(wdt->dev);
	clk_enable(wdt->clk);

	spin_lock_irqsave(&wdt->lock, flags);
...
}

If either fails, the device remains suspended or unclocked, but the code
proceeds to read and write to wdt->base.

Could this result in a bus fault due to accessing unclocked or powered-down
hardware if power or clock management fails when the device is opened?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914123609.2186=
477-1-congnt264@gmail.com?part=3D1
