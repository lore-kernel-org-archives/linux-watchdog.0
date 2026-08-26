Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409B31D730
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725237; cv=none; b=nFR2gss5ccrBw8HLmau47vcDJDSIyghuyiDdLIiGZcJb/3zuqfY/lGruhKcBx7JqII5xggUwjJAuzoOmLNqHGI6ze9xXHVtp4Qizj4qde9wzxvM/0/vDGTRfW/x7AqKcv4teKTTlfDKpNzi6oukAEmZ/QSV83ud5Ta8BKHfjAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725237; c=relaxed/simple;
	bh=BLcm5ojMvPN19PraVQrzrBTml+2GQCZYDN0dG6T8U64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NUEByZXBiB1MKI0mmSPlP2RIsfZgEmX4O8xKc3eZgTlro6HrwoGyRPgWuDeH0aJIu6XLtQg1fqBJVNItMguvNyaoDPPusYBCVzO5MC4zia9UmKflE6VtotmcqxsSCBA123R3wKqkux8IkG1D6ebyhOOH46rnCox6PYn4faO3mqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2+bQoru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2+bQoru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7645D1F000E9;
	Wed, 26 Aug 2026 06:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787725235;
	bh=5eASaln/QBqCP2v7JsQRv60IO+KcsA99VR1dNCxgxMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m2+bQoruo1GBiBy9iUr/gbB5eWhqoF5OFoU87kgeXe2KPNX9f7TKzboKhz7f541mo
	 09j3vq7MPMAQfKcGqmMh9+NLqpXJXpttDbJSfmyGRd8eQx8yhsn5iZjCE2TXAoCU71
	 dM3C3YitdpG39lWHMzgl35MyPF2DuTJtFMdy+WtzYsukcA6IVKFKc8D4Jzd0A4tkng
	 1f/j89SpRAa8NquJrRl1k0588gehsozy9H87YjZb5E4FPR0tiYO5TVEpc5m23POISK
	 14rMezmUu7lvLnNu02GLj4A84y9mMh1tC3hmCV5cgKQKbCAQ8AEg5SanfkuM0zumtM
	 sOrRrTI+J4sUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] watchdog: msc313e_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Triet Hoang" <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260826060839.203297-5-triet.hoang.dev@gmail.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-5-triet.hoang.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 06:20:35 +0000
Message-Id: <20260826062035.7645D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing platform_set_drvdata() or dev_set_drvdata() in the probe f=
unction leads to a guaranteed NULL pointer dereference during suspend/resum=
e operations.
- [High] The driver accesses hardware registers without ensuring the requir=
ed clock is enabled, which can lead to a synchronous bus fault.
--

commit 906c6a1c7ebc485b90aee7c86e2994040111e762
Author: Triet Hoang <triet.hoang.dev@gmail.com>

watchdog: msc313e_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
   =20
Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
and pm_sleep_ptr(). This lets us drop the __maybe_unused annotations
from the resume callback.

> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wd=
t.c
> index 90171431fc594..b8edf85f10236 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -133,7 +133,7 @@ static int msc313e_wdt_probe(struct platform_device *=
pdev)
>  	return devm_watchdog_register_device(dev, &priv->wdev);
>  }
> =20
> -static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
> +static int msc313e_wdt_suspend(struct device *dev)
>  {
>  	struct msc313e_wdt_priv *priv =3D dev_get_drvdata(dev);

[Severity: High]
This isn't a bug introduced by this patch, but does this result in a NULL
pointer dereference when the system suspends?

The PM core invokes msc313e_wdt_suspend() and passes the platform device as=
 the
dev parameter. However, msc313e_wdt_probe() never calls platform_set_drvdat=
a()
or dev_set_drvdata() for the platform device:

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe() {
    ...
	watchdog_set_drvdata(&priv->wdev, priv);

	watchdog_init_timeout(&priv->wdev, timeout, dev);
	watchdog_stop_on_reboot(&priv->wdev);
	watchdog_stop_on_unregister(&priv->wdev);

	return devm_watchdog_register_device(dev, &priv->wdev);
}

Because the driver data is uninitialized, dev_get_drvdata(dev) evaluates to
NULL. The callback then computes an offset into this NULL pointer via
&priv->wdev and passes it to watchdog_active(), which unconditionally
dereferences it via test_bit(WDOG_ACTIVE, &wdd->status), causing a fatal
page fault.

The identical NULL pointer dereference logic also executes on the resume pa=
th
in msc313e_wdt_resume().

[Severity: High]
This is also a pre-existing issue, but does this driver access hardware
registers without ensuring the required clock is enabled?

The probe function reads from hardware registers without first calling
clk_prepare_enable(), which can crash if the clock is disabled by the
bootloader:

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe() {
    ...
	/* If the period is non-zero the WDT is running */
	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MA=
X_PRD_H) << 16))
		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
    ...
}

Additionally, because the clock is never enabled in the probe function, when
the Common Clock Framework's late_initcall executes, it physically disables
the unreferenced clock. If the watchdog is already running at boot time, the
watchdog core will periodically call the background ping callback:

drivers/watchdog/msc313e_wdt.c:msc313e_wdt_ping() {
    ...
	writew(1, priv->base + REG_WDT_CLR);
    ...
}

Writing to these unclocked watchdog registers will trigger a synchronous
bus fault.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826060839.2032=
97-1-triet.hoang.dev@gmail.com?part=3D4
