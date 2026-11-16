Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794856182;
	b=zzr9KOy4RWqitUpUlwxN9+2AIbbYGtP6kevKABB97e/XEHZhT6wuSvGfJiLFnC6DJ5Io
	 MuzxWo6lhMDOmhlpqep8GOMat3LJ3y0WTTMRm84zf7M1e13kIhrqS5gtfIs9Y0TWa4uys
	 y/5vY89FA1NM5LcuSnalwEMR41YjI0kABCrR0LGj49lcZJzDJLLOEwOMmEyzftbLZ8BYJ
	 4p6PqVaiz6sZNQfYwa09pkouGlx41itFdqz8o0zokeJNFRQ8IdbciTTQrZJ3RDad8MiQf
	 Ja+cuNbjNagcLj8EwfWwuOS40+jMeny3RMDapMfAxMFZZGj/GR9KIQFIRL9sF6acoSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856182;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9QaDa8YBy9Tq8oTqEbb2KDxWoDS1PEL1JtCMbpcniKY=;
	b=QX61sedjT6lSCm18apx0k0DnMlQQvcC4iFG8UyOjpnM0rBoaiMP18WwXTVoN1poNUzer
	 4RI2WIZbJyXFpHCqyDmODktxNRLbRAhLuYawRdVaR9XRQ8GuFkvVue5g+b1HgQ0tQao22
	 PZ7GyOTiTyZ8slFzQRl2zni5e6gZ2JISdJteogh7oKjhDu6uR/E6rTSB7bc3leEDOXlhM
	 Ap+r05WNHEOB/M0CpjA7cJ/yJhoftIzi6VbOUFPjOAsH5v7r0zSD8SStRbUKt+AllbE4w
	 E0BLRyqLW2qBVBj/m0VxWcbmgHLTUa24UEVmwCNTfM4KomMus4diYJ40wGKEEfXwypw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Miy3yIpP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97A4606A335
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Miy3yIpP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830501F000C9;
	Mon, 16 Nov 2026 19:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856182;
	bh=9QaDa8YBy9Tq8oTqEbb2KDxWoDS1PEL1JtCMbpcniKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Miy3yIpPPTyd5CAVqGjh+TAB/9x8sMyN7vN0foTorzztx6UI/Sp1/ys1we/47+aVW
	 +vi0vMeoRLv9lIs/NMrORQtBcLY6pO5NuzRbB5FhTt4Kf9lwcAWjh+MUUEnhMiRh+Z
	 7NLIflv+4GzDFclkw3hi9DDUzjuTtiLYmdavdrZLYSBJLpijmvtDzuj3qZ/MaCtq5x
	 l+pjE6AL1HJzbWNb7T+BfC3MITSr0gdr+a5+3EmNf+oElyxKJvTBTCeVBSr3/HmILx
	 BCrhmkxzTxEQpEmjnRxSACSFqEKXhEDS7M1pzGoWviFiIub2ty4fxVJyQNVKyWXLdN
	 Ls1kKcrH4Hhyg==
Message-ID: <sashiko-outbox-217543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: stm32_iwdg: use managed variant of
 dev_pm_set_wake_irq()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261116190130.1191501-1-antonio.borneo@foss.st.com>
References: <20261116190130.1191501-1-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:09:42 +0000
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
- [Medium] watchdog: stm32_iwdg: NULL pointer dereference in
  stm32_iwdg_isr() [1]
--

commit faff7513f5bea59db8a5e975f7eb126068ba7dc8
Author: Antonio Borneo <antonio.borneo@foss.st.com>

watchdog: stm32_iwdg: use managed variant of dev_pm_set_wake_irq()

This commit switches stm32_iwdg_irq_init() to use devm_pm_set_wake_irq()
so the wake IRQ is automatically detached on probe failure or driver
unbind.

Link: https://sashiko.dev/#/message/20261116132416.1184447-3-antonio.borneo=
%40foss.st.com
Link: https://sashiko.dev/#/log/249869

> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index a8d2db2d3cf8b..f1056f8100cf0 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -298,7 +298,7 @@ static int stm32_iwdg_irq_init(struct platform_device=
 *pdev,
>  		if (ret)
>  			return ret;
> =20
> -		ret =3D dev_pm_set_wake_irq(dev, irq);
> +		ret =3D devm_pm_set_wake_irq(dev, irq);
>  		if (ret)
>  			return ret;
>  	}

[Severity: Medium]
This problem wasn't introduced by this patch, but can stm32_iwdg_isr() hit
a NULL pointer dereference [1] if the interrupt fires before
watchdog_set_drvdata() runs?

stm32_iwdg_probe() calls stm32_iwdg_irq_init(), which requests the IRQ,
before populating wdd->driver_data:

drivers/watchdog/stm32_iwdg.c:stm32_iwdg_probe() {
    ...
	ret =3D stm32_iwdg_irq_init(pdev, wdt);
	if (ret)
		return ret;

	watchdog_set_drvdata(wdd, wdt);
    ...
}

If the watchdog is already running with the early-wakeup interrupt enabled
(for example across driver rebind) and the IRQ fires in that window,
stm32_iwdg_isr() gets NULL from watchdog_get_drvdata(wdd) and dereferences
wdt->regs.

[1] https://sashiko.dev/#/bug/linux-ebf60aef-da57-4fba-a11d-75c387866884

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190130.1191=
501-1-antonio.borneo@foss.st.com?part=3D1
