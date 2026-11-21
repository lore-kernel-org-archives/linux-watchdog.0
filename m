Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795258835;
	b=UAaRQQPtB2JX10HOHuM+vkw4ugV2pXLnFqfNRApGqKt4byIf2AyID24iwVB7YbXGHiE2
	 dhomRd1jF4Gjyr8asqGalNWcK3W8BnGN+OGDXPHaNia6yYzSfXQNFTj6C01eeE3cLPoKq
	 OpEphuakd4m3f7wuuSusO6a5lLFU0TOn+tUQEAANWwc6CiC14EBKgmTMUfbSl7YA3sWN/
	 rzQUUIh+0NzdEQ51weFdT5G+MbT8eGFpP3qtZF5pplEZlYQZ+zgiSQMtYt+LFxUwrGbYJ
	 sm7OykhXT8/sjnI0O1WFIu3uuB/jR7CqJEn1z7fHuR26mIbydYOSchwfr/Nt3VGjzDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795258835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lwy74H+miAoczndr61CHY70F+44WyIC72Ick5ZWMBE4=;
	b=GH7CoXDkoZlTd5Qt5TiXztwr0NnYkvHBaLxJ9duP/q2ZpNPI8abpcYuAZZWvDKqRzZDc
	 Zf/kptJT50cRuDADp5lTUGvJA7cpksNFsHfG56ZTe5JIZgIPfifV+jDfwia4cKzvxP3YA
	 n3CU5CPzFUJLaU4gKSvpq28s8iLTu8LOuEEyiMv82ROxguDOUbNBMfqxb4krtEADH00Kv
	 1ap7H0SpAZ9J8TwvCJfcIISSJFqsN0dHLnmCENGkGF++8sVaKtyWbFIYSDKG2q9ZrrxLh
	 VC0HgaQj9iC6Br96RRMBTJG5CvyFxuz4l0K7r9Mcff1N0LDFpa1POgcYb84YFm9vg5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoMPzHZc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA6606A330
	for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QoMPzHZc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104451F000C4;
	Sat, 21 Nov 2026 11:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795258835;
	bh=lwy74H+miAoczndr61CHY70F+44WyIC72Ick5ZWMBE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QoMPzHZc1dcrWcIz4ofzjPJegcTiCA9lz39VPvxRoc62RtZBcOePj+TaVM7Q+KCFe
	 dtV7VdiRALrWetTLM8fJ3GrWR5DIDyduk/vNDaB1Gl6M7coW3J5DxIMXh81Hzq+jR6
	 fi9fqtL/tcdric4VoH/ORDBnKKu/W5JxEZVrCsujNbvxyOpapmPEhe3RHoBChaFsz7
	 tuvEi0RRZL6eQ1rTEgNx2vxRsWKFvOyYMlYUjf0S+BJooYt1jfOYc16X3XUvn1awsa
	 fO/CygVaP5QdE1MLb7/8dO6vhO0lptN3UQua1y2L4afNujDMwVL7Azxgl19fr7HrZZ
	 u2qzlsIB4akQA==
Message-ID: <sashiko-outbox-226965@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] watchdog: Add ARM TWD (MPCore private) watchdog
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fil Dunsky" <filipp.dunsky@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261121-arm-twd-wdt-v7-1-7757144dcf48@gmail.com>
References: <20261121-arm-twd-wdt-v7-1-7757144dcf48@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:00:34 +0000
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
- [Medium] watchdog: arm_twd_wdt: stale deadline in twd_wdt_resume()
  causes reset
--

commit 233fd28bdb50f0195aee9760c111c785c11b011f
Author: Fil Dunsky <filipp.dunsky@gmail.com>

watchdog: Add ARM TWD (MPCore private) watchdog driver

This commit adds a watchdog driver for the ARM11 MPCore, Cortex-A5, and
Cortex-A9 MPCore private (TWD) watchdog, using the CPU0 watchdog as the
system watchdog.

> diff --git a/drivers/watchdog/arm_twd_wdt.c b/drivers/watchdog/arm_twd_wd=
t.c
> new file mode 100644
> index 0000000000000..6d16c461f6553
> --- /dev/null
> +++ b/drivers/watchdog/arm_twd_wdt.c
> @@ -0,0 +1,678 @@

[ ... ]

> +static u32 twd_wdt_ticks(struct twd_wdt *wdt)
> +{
> +	s64 left =3D atomic64_read(&wdt->expires) - ktime_get_ns();
> +	u64 ticks;
> +
> +	if (left <=3D 0)
> +		return 1;
> +
> +	ticks =3D mul_u64_u64_div_u64(READ_ONCE(wdt->rate), left,
> +				    (u64)NSEC_PER_SEC * (TWD_WDT_PRESCALE + 1));
> +
> +	return clamp_t(u64, ticks, 1, U32_MAX);
> +}

[ ... ]

> +/*
> + * Stop the hardware for system sleep while the core stops its ping work=
er.
> + * These callbacks retain the deadline; core PM keepalives can refresh it
> + * before suspend and after resume.
> + */
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
Can retaining the absolute monotonic timestamp in wdt->expires across
suspend cause an immediate watchdog reset in twd_wdt_resume()?

twd_wdt_suspend() stops the hardware counter without recording the
remaining time until wdt->expires.  Whenever ktime_get_ns() continues to
advance while the watchdog is suspended (for example during
suspend-to-idle on platforms without cpuidle enter_s2idle to freeze
timekeeping, or across slow device suspend/resume and hibernation stages),
ktime_get_ns() can pass wdt->expires before dpm_resume() runs
twd_wdt_resume().

Because twd_wdt_resume() runs before the PM_POST_SUSPEND notifier calls
watchdog_dev_resume() to issue a post-resume ping, twd_wdt_cpu_start() ->
twd_wdt_ticks() sees left <=3D 0 and loads TWD_WDT_LOAD with 1 tick,
resetting the system immediately.  Saving the remaining delta in
twd_wdt_suspend() and recomputing wdt->expires from ktime_get_ns() in
twd_wdt_resume() would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121-arm-twd-wd=
t-v7-1-7757144dcf48@gmail.com?part=3D1
