Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795205951;
	b=K3TLQZvGWCJvXSxF3SZQhNEZnyJzlqRS9a4Du8Bmcm9PKr3mPZS3wuHuhG/P1SzSGdz9
	 P21FKryrWIFV/QeQfpbsSaS1BNYt6RvLBF0hiNxz93jo/kOQaRGSFric8sUpmCpNg154I
	 CkGdXP2iFwT+wLHNfaSWKjGRDtZbjiRKItUKrNZJ+ZYFcsY6d+Erjxn20gWXbnPD307+j
	 XWi8YRjQJReJXeyU07KVVyHd6ccI1kdMHZ+Yt/UFruxRkcSZlSiuh5cFhZ8icGWj1GP4x
	 gqrX30URXB0WmRaUZj45zslOLWnEj7oPbMY8sPYy1Dh7Dyw25al9Fx++w9YGRLHTfcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795205951;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ln9TCKu4OUh7XIieI2sv04OsrhZ+dQENCnmItiBJ9ls=;
	b=HXaRQeDbLj4Oju7m9FUoln2/8oHjRZn7rUQzgQZL50FvuV6O41ojOJwwr/SEbEZv6cju
	 ctfwYJy2YhnEE5WV/VnmLcR60bfoIFtwtwqIJt1e1SjkXl+gQSICAnWrB3utapHpaJUtE
	 ncX1ti/hQPJQxppbRR6Zh919OQYattYdvYtGj6q46nSOGchkEQmoFTx/BfzG3xH39xVNH
	 UxUzRO8OW24G2ELfvoWf+/bvPv0LBUVZp3ZmuzuTbMuDz98Id0ldKw0m104fAtYSvQa0q
	 EtuE6n7SfP2RcJD0UkmTPvxEne2wht7lEukbzFO/3UkLcqXpP37ebpk2F4pUy69C0Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVFe2Ka5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06DF606A6CB
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 20:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVFe2Ka5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FF11F000C0;
	Fri, 20 Nov 2026 20:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795205951;
	bh=ln9TCKu4OUh7XIieI2sv04OsrhZ+dQENCnmItiBJ9ls=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XVFe2Ka5TEnf4Ma8NILTKQD5aPJxYRHavl35W4vjL95gcsa31jg+hBlutMda/2kvO
	 fNw0fnXG+GKxjGvgqtUpaT4m2DpTpTM1XBDwkTbA3uGPjP53rDpiVZYG/hsh5ouwtV
	 Tm0ksI8lWlXnwvjoi+p/C3ktDMOvbondr2HtWNXuaT4K76Rk/U6s4piFqlZVmVdZzk
	 3GrGWTxm/wCrkM+28laNl9XclAf+qquRM+Ofe0q4wh1XUBRIWov9LKDNR0tQYNasMC
	 5o0+FHc4TfkeFnbpBgEjU6hHghzE2BAIf8wPmiIpWutL83oppCX/hyDOvfzxfy6wVI
	 8Mdlew7ggd3Aw==
Message-ID: <sashiko-outbox-226033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: sp805_wdt: re-enable the clock in the restart
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Yang" <mmyangfl@gmail.com>, linux-watchdog@vger.kernel.org
In-Reply-To: <20261120201029.1685193-1-mmyangfl@gmail.com>
References: <20261120201029.1685193-1-mmyangfl@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 20:19:10 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] watchdog: sp805_wdt: sleeping clk_prepare_enable() call in
  wdt_restart()
- [Low] watchdog: sp805_wdt: missing Fixes trailer for wdt_restart()
  clock fix
--

commit 800a9ee3ac4d2d74f9b4e848c39474209c8cef7f
Author: David Yang <mmyangfl@gmail.com>

> watchdog: sp805_wdt: re-enable the clock in the restart handler
>
> wdt_restart() fail to reboot the system if the watchdog counter clock
> was previously disabled: If userspace cleanly stops the watchdog, the
> core calls wdt_disable() which disables wdt->clk. No reset comes.
>
> Re-enable the clock in it as in npcm_wdt.
>
> Link: https://lore.kernel.org/r/20260911031916.A8E051F000FF@smtp.kernel.o=
rg
> Signed-off-by: David Yang <mmyangfl@gmail.com>

[Severity: Low]
Should this bug fix include a Fixes tag for the commit that introduced
wdt_restart()?

  Fixes: 6c5c0d48b686 ("watchdog: sp805: add restart handler")

> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index a14ff7ac0db48..20b2fbb7334db 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -138,6 +138,9 @@ wdt_restart(struct watchdog_device *wdd, unsigned lon=
g mode, void *cmd)
>  {
>  	struct sp805_wdt *wdt =3D watchdog_get_drvdata(wdd);
> =20
> +	/* For reset, we start the WDT clock and leave it running. */
> +	clk_prepare_enable(wdt->clk);

[Severity: High]
Can wdt_restart() call clk_prepare_enable()?

do_kernel_restart() invokes restart handlers via
atomic_notifier_call_chain(&restart_handler_list, ...) under
rcu_read_lock() with local interrupts disabled, whereas clk_prepare()
acquires the sleeping prepare_lock mutex and calls ->prepare() callbacks.
When wdt->clk is unprepared (either because the watchdog was never started
or because wdt_disable() called clk_disable_unprepare()), this sleeps in
atomic context and can deadlock or hang system reboot.

Unlike sp805_wdt, npcm_wdt prepares its clock at probe time via
devm_clk_get_optional_prepared() and uses clk_enable() / clk_disable() at
runtime so that npcm_wdt_restart() only calls atomic-safe clk_enable().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120201029.1685=
193-1-mmyangfl@gmail.com?part=3D1
