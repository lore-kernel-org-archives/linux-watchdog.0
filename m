Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACE40E8D5
	for <linux-watchdog@vger.kernel.org>; Fri,  5 Jun 2026 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780665846; cv=none; b=ZG+2UxHsNQfzPoq6pvIrwMbmQpQRnVwF44YCh/P+J4XCoHVbsqtKLAaMfCWc2PqqH93nLuLj3rpMTqqWACNHaG7hCioQBDYPCqdxkgeDElN+b7rlJsj4ZECyCRu7XrUKFh0zVi1qCl04T5ZF3nOTNZNiPuVRUb4Xf5v32AKvAEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780665846; c=relaxed/simple;
	bh=ihBJ6GvEb2yzp8Bxlq+9xKqGPKDFVeybhfoBZETj9yg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WL7FgBdRiW44d0DJn0zNmMDlulq6aKq6UcMaa2eoXg+ZadTprvplyHrOFYS13OCqlaretod/H2s9f5dIZB49yqfkSBIwbTyrxU/Kif8wx6qJWiSqI5rUIPaCEznR1QH5gwwwSFIl7iF6PFUr6t6IpmM8etsSI/J2Z1QlX6qHAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQ9ppI6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQ9ppI6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB501F00893;
	Fri,  5 Jun 2026 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780665845;
	bh=4VfW9kbZAgGc56oB/VsXF1ckf6AoAuBkHxYV9crtk3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQ9ppI6kzf+wrihevUNuAX6ZqQPZsZyJ+mIWzsirAxZcYsL3kPzMeWu9QNfytZryY
	 0CKyAEKxpTwbxrUrTDafqpZxfU5HwwTOhTxj33zGKPpGLAbil2cqJFdgQnDmUT9uwq
	 yIL+pR68/xZOvuwte9ja26ZVopnjpYYTsFtzLset/kQHXUJz2CClXBkfghPhYAP4JQ
	 NzI7hSHwQpYlZGtgudFI6DKTyBRNWPwVu0VF8tfDGLZ4GgBt4BlPbVsAUUlJywnfMa
	 9uiRsY+P6KmIWfJXaPvXR86AGxjmkLywfk1U/fSIFlZZYnjFSCNNxOtSlzlFEEjL6C
	 ARmOMW3Jtyowg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] watchdog: starfive: balance PM refcount and
 disable in probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Theesfeld" <william@theesfeld.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <21de4987785fbde29d23f5fde53dc1012e0ae768.1780664848.git.william@theesfeld.net>
References: <21de4987785fbde29d23f5fde53dc1012e0ae768.1780664848.git.william@theesfeld.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:24:04 +0000
Message-Id: <20260605132404.CAB501F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Treating pm_runtime_put_sync() return value as a fatal error cause=
s spurious probe failures and a double PM refcount drop.

Pre-existing issues:
- [High] Missing runtime PM synchronization in remove() leads to unclocked =
hardware access and potential kernel panic.
--

commit b65fb45d5687c6419949ad39d8553aec8eec2e77
Author: William Theesfeld <william@theesfeld.net>

watchdog: starfive: balance PM refcount and disable in probe error paths

The commit restructures the error handling in the probe function of the
starfive watchdog driver. It adds specific labels to ensure runtime PM
refcounts and clocks are properly balanced and disabled during failures.

> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-=
wdt.c
> index c821b38d26d22..6539bf0893583 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
[ ... ]
> @@ -506,7 +506,7 @@ static int starfive_wdt_probe(struct platform_device =
*pdev)
> =20
>  	ret =3D watchdog_register_device(&wdt->wdd);
>  	if (ret)
> -		goto err_exit;
> +		goto err_put_pm;
> =20
>  	if (!early_enable) {
>  		if (pm_runtime_enabled(&pdev->dev)) {
> @@ -520,8 +520,12 @@ static int starfive_wdt_probe(struct platform_device=
 *pdev)
> =20
>  err_unregister_wdt:
>  	watchdog_unregister_device(&wdt->wdd);
> -err_exit:
> -	starfive_wdt_disable_clock(wdt);
> +err_put_pm:
> +	if (pm_runtime_enabled(&pdev->dev))
> +		pm_runtime_put_sync(&pdev->dev);

[Severity: High]
Is there a risk of a double put and refcount underflow here?

If pm_runtime_put_sync() returns a negative value like -EAGAIN=20
because another thread incremented the usage count before the idle check,=20
it successfully decremented the refcount.

If we jump to err_unregister_wdt, the code will fall through to err_put_pm
and call pm_runtime_put_sync() a second time.

Does this cause an unbalanced put and spurious probe failures?

[Severity: High]
This isn't a bug introduced by this patch, but looking at the PM handling
in starfive_wdt_remove():

drivers/watchdog/starfive-wdt.c:starfive_wdt_remove() {
    ...
    starfive_wdt_stop(wdt);
    watchdog_unregister_device(&wdt->wdd);
    ...
}

Is there missing runtime PM synchronization here?

starfive_wdt_remove() unconditionally calls starfive_wdt_stop(), which
accesses hardware registers. If the watchdog is not open, the device might
be runtime-suspended with its APB and core clocks gated.

Could accessing unclocked hardware registers here trigger a synchronous
external abort and a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780664848.gi=
t.william@theesfeld.net?part=3D3
