Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208712;
	b=TI1kOL+fnlPehSpDSY6lu6hSo8KZHJsQiyQT8YZ2x+d+jL9FWZOmlUwdE6vBxXSbvcqV
	 cQ568dsxD1k6DzEM9Wc9ZnV8JEDC5lgHXZO4H75m2hNBtPWL43Ati5b+RtMqYxkppi8yI
	 EPIm0w88kjfmi4GISAPExS++9fVpZbWTJD8MPHUNZYsKDrW6EHfKiME0cJd4rwYFiF44X
	 zGfNveaCq+oObRUazfC3dDmFuoiVtf3xbNS7yAZI4zG3RvhxG9lTzaU4kOQsIO4A4/TeV
	 mkschyFLbG+QBvjrPfoQw/sbv2eADBzNc0VX66xp0tE8lZvwcXqGtmP3D3i2QOMbRYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208712;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=U0S6H2kc+JUzM1zPBPQH0qlzJILrCCmo0bPO2jTovxU=;
	b=diIFow/KjNEqOo2+DVXFSPVC8MPrUocKKqS57QUHIW8ytuidK7CCmfYZkMK0JnTZEESh
	 cOGRC3I2FkEj0YA3mmNKFJUVQHb9rZN/LvfC1Ecji21nAG13wmhlsg1fcw5bpb4McxqrI
	 cy+kcIhyIKNxSecL7mziM4YK5AuU8rNGxddmv21PST/JRiY1XHBEITm86ioxmYtid58je
	 66BmS0zJea+h8omjSKiR1RGCdFBjr/jpiLI1IuB0wpqQwL+Y3HpeIR6VoiPFQ878wO9id
	 gIqPOdx27Mz/6iAdG6K694KSfDlmBsLD41vY83oYAvh2sLCmM4bFi4QjtKXGGlD2j5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwgKuNYV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62655606A325
	for <linux-watchdog@vger.kernel.org>; Mon,  9 Nov 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwgKuNYV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D399E1F008A2;
	Mon,  9 Nov 2026 07:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794208712;
	bh=U0S6H2kc+JUzM1zPBPQH0qlzJILrCCmo0bPO2jTovxU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nwgKuNYVa5Wi1hZbWuegepXXiJTcy8kDgih1ANw15Jcy7v+HZu3S2UkkdPLdu7Cnr
	 dDoTUwDTId66Hu+fFcEVc7xby26boGcdACXRKKgwKGkQMRUSE9DQjjMJD1EX7I6g/n
	 ssSmYJQSHQ8t/fBQi4dE4v5JJ51O3nVR4/o2UGUwwMaCag5BJHKBcW1ftXlj7cVT6b
	 gnt3Ag5fjagL7tGBU9Ocuu1ooCufyG1UT+T47xlu5e2SLtaguXzY3LEs+obE5n4fo1
	 SzG5pJyqXhhzn7cbJnY3AUrRyjTy9/fNRaRDpt73RR8uTPkLcsuvqPSqyWlrx9fNi2
	 8pZFBe4pYR9Iw==
Message-ID: <sashiko-outbox-204537@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: npcm: fix clock prepare leak when setting
 timeout on a running watchdog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhao Feng" <zhaofeng2@cmss.chinamobile.com>, linux-watchdog@vger.kernel.org
In-Reply-To: <20261109071004.1506-1-zhaofeng2@cmss.chinamobile.com>
References: <20261109071004.1506-1-zhaofeng2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 07:18:31 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] watchdog: npcm: sleep in atomic context in npcm_wdt_restart()
  [1]
--

commit 17842ca84b08ec6bbd438017f39f767a1910936b
Author: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

watchdog: npcm: fix clock prepare leak when setting timeout on a running wa=
tchdog

This commit splits register programming out of npcm_wdt_start() into
__npcm_wdt_start() so that npcm_wdt_set_timeout() does not acquire an
extra clock reference when updating the timeout on an active watchdog.

> diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> index 51348969bf492..31253fd7bad5b 100644
> --- a/drivers/watchdog/npcm_wdt.c
> +++ b/drivers/watchdog/npcm_wdt.c
> @@ -145,13 +145,11 @@ static int npcm_wdt_ping(struct watchdog_device *wd=
d)
>  	return 0;
>  }
> =20
> -static int npcm_wdt_start(struct watchdog_device *wdd)
> +static void __npcm_wdt_start(struct watchdog_device *wdd)
>  {
>  	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
>  	u32 val;
> =20
> -	clk_prepare_enable(wdt->clk);
> -
>  	if (wdd->timeout < 2)
>  		val =3D 0x800;
>  	else if (wdd->timeout < 3)
> @@ -176,6 +174,15 @@ static int npcm_wdt_start(struct watchdog_device *wd=
d)
>  	val |=3D NPCM_WTRE | NPCM_WTE | NPCM_WTR | NPCM_WTIE;
> =20
>  	writel(val, wdt->reg);
> +}
> +
> +static int npcm_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);
> +
> +	clk_prepare_enable(wdt->clk);
> +
> +	__npcm_wdt_start(wdd);
> =20
>  	return 0;
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can npcm_wdt_restart()
sleep in atomic context when calling clk_prepare_enable(wdt->clk)
[1]?

drivers/watchdog/npcm_wdt.c:npcm_wdt_restart() {
	struct npcm_wdt *wdt =3D to_npcm_wdt(wdd);

	/* For reset, we start the WDT clock and leave it running. */
	clk_prepare_enable(wdt->clk);
    ...
}

do_kernel_restart() invokes restart handlers via
atomic_notifier_call_chain() under an RCU read lock, whereas
clk_prepare_enable() calls clk_prepare() and takes the sleeping
prepare_lock mutex.  This triggers a scheduling-while-atomic bug and can
deadlock during reboot or panic recovery.

[1] https://sashiko.dev/#/bug/linux-d877d7dc-83e2-4c44-b88a-c3f7ea954cd4

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109071004.1506=
-1-zhaofeng2@cmss.chinamobile.com?part=3D1
