Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022245;
	b=jx4dONmtZotuOEWZBbqi3xORcEDAtZBX8kKsyu9GZJ9nu8rzf2gQrrxTqbu8nIiG/+ov
	 QMHmyf1GjiZKny6zoOEm7UnszeR7Z2BXucLZ4a2zNdzFlleUr/ftMJekCrTZ9GZ7CiRpQ
	 0s6LdyeEF+g02DIV9pfaZXs60be6Mqlenb04JObLudlwxN+A+pm9d7cu/nm+TcEEp3PJR
	 9TwnojG5iL6I8cL7OD6cukeEeQ0ax+ByQw8YkgCguAsLxTXkfOeq631DZU5bYp6Lg7M+W
	 LPImhwf2d7Ed90f8FGVbSCQOEgrTVo/q5BPmBYH95zb6J6CRD9hko2Tmd9kWJSahU8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022245;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=29YuO3kvrSiDhNOnutLBpvLPM3N73jAY6n2TobXDa1c=;
	b=z8w+KX19+Wz96QyavSZ5Z21mE30Y4IaSj92eSs6t4bZES4Jkfmzn6lbBYiOmXSKVId59
	 DIdqRfLe/Ii/FWdP/Jg08rxkbssSQs0bfzKjOOaYnyqk5Bxf54Q0QMIY1tlHZ9xQgY3FZ
	 kiq8BdzQe0hY19JEhxDFiXgph4lK3lbq51hRoSC9sru28rurO6xLWlesdTFplbCYqGMTG
	 7TaOqh9ti/Y3isIi4oysKAThk1OCY7asdy6e5y5daWOaWciHHTIqei8mjwLXzrh1W6Xmh
	 NF7YXqKT6Ma8vBLoKnURuOJUG3ZHD2L3e/CdB0SYXBXr2bRjNx6LMuFzGfLXqD+HuVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0Lbwri4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E6E606A330
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d0Lbwri4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9FA1F000C5;
	Wed, 18 Nov 2026 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022245;
	bh=29YuO3kvrSiDhNOnutLBpvLPM3N73jAY6n2TobXDa1c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0Lbwri4N4VYYLFYbr3mwWPvJ+QFUoV3UrjdkFy5T8cdfcgCBnv8AtGB19ao1WcZJ
	 Rpv1+Rg41TQxO5B+zgjVJPqeFieSz9GPGKG0vi9nOwhzIga7Kf6YBDyCzZWSgwMvqD
	 KM1klo9OcrdA8sNV0kDslOQvd5XElaKdyO5DaOBjqJtp3QZBasw6BH7IjNcUxLQhzY
	 qgi3WVzhRfGfjzT+OJJY3OzgwlbgStCTRVxDVhywNxF5snrWHgX7wMXXRnmXMvaKXi
	 rUwxUGzT9F8kRFM+J7bXWq9tirEOwUYJdDUm3iBpSeXuf57I4p9LMzi8HvSM0aibGR
	 TdQGhiPrI4ITw==
Message-ID: <sashiko-outbox-221636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] watchdog: Add ARM TWD (MPCore private) watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261118-arm-twd-wdt-v6-1-ce5c85b45c63@gmail.com>
References: <20261118-arm-twd-wdt-v6-1-ce5c85b45c63@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 17:17:24 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] watchdog: arm_twd_wdt: deadline overwritten on suspend/resume
  by PM ping
--

commit 8603b686668545855ad05ceff3a65c5bccb1efde
Author: Fil Dunsky <filipp.dunsky@gmail.com>

watchdog: Add ARM TWD (MPCore private) watchdog driver

This commit adds a watchdog driver for the ARM11 MPCore, Cortex-A5 and
Cortex-A9 private (TWD) watchdog, using CPU0's watchdog as the system
watchdog and preserving the expiration deadline across clock rate changes,
CPU idle power down and system suspend/resume.

> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wd=
t.c
> new file mode 100644
> index 0000000000000..84e56ab8beea7
> --- /dev/null
> +++ b/drivers/watchdog/arm_twd_wdt.c

[ ... ]

> +static int twd_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct twd_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +
> +	guard(mutex)(&wdt->lock);
> +
> +	if (!wdt->armed)
> +		return 0;
> +
> +	atomic64_set(&wdt->expires, ktime_get_ns() +
> +		     (s64)wdd->timeout * NSEC_PER_SEC);
> +	twd_wdt_call(wdt, twd_wdt_cpu_ping);
> +
> +	return 0;
> +}

[ ... ]

> +	watchdog_stop_on_reboot(&wdt->wdd);
> +	watchdog_stop_on_unregister(&wdt->wdd);
> +	watchdog_stop_ping_on_suspend(&wdt->wdd);
> +	watchdog_set_drvdata(&wdt->wdd, wdt);

[ ... ]

> +/* The watchdog loses its state in suspend, set it up again at resume */
> +static int twd_wdt_suspend(struct device *dev)
> +{
> +	struct twd_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +	guard(mutex)(&wdt->lock);
> +
> +	wdt->resume_armed =3D wdt->armed;
> +	/* Keep CPU PM from restoring the watchdog while it is suspended. */
> +	smp_store_release(&wdt->armed, false);
> +	if (wdt->resume_armed)
> +		twd_wdt_call(wdt, twd_wdt_cpu_stop);
> +
> +	return 0;
> +}
> +
> +static int twd_wdt_resume(struct device *dev)
> +{
> +	struct twd_wdt *wdt =3D dev_get_drvdata(dev);
> +
> +	guard(mutex)(&wdt->lock);
> +
> +	if (wdt->resume_armed) {
> +		/* Publish the saved deadline before allowing CPU PM to restore it. */
> +		smp_store_release(&wdt->armed, true);
> +		twd_wdt_call(wdt, twd_wdt_cpu_start);
> +		wdt->resume_armed =3D false;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does calling watchdog_stop_ping_on_suspend() cause wdt->expires to be
overwritten with a full timeout on suspend and resume instead of preserving
the saved deadline?

watchdog_stop_ping_on_suspend() registers watchdog_pm_notifier(), which
calls watchdog_dev_suspend() -> __watchdog_ping() -> twd_wdt_ping() at
PM_SUSPEND_PREPARE before twd_wdt_suspend() clears wdt->armed, and calls
watchdog_dev_resume() -> __watchdog_ping() -> twd_wdt_ping() at
PM_POST_SUSPEND after twd_wdt_resume() sets wdt->armed back to true.
Whenever the watchdog is active (or boot-running before open_deadline),
both calls run while wdt->armed is true, resetting wdt->expires to
ktime_get_ns() + wdd->timeout * NSEC_PER_SEC and reloading the counter with
a full timeout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-arm-twd-wd=
t-v6-1-ce5c85b45c63@gmail.com?part=3D1
