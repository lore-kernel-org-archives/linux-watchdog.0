Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A1390C84;
	Thu, 16 Jul 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219598; cv=none; b=hl3iHD2/TYAvToNnXiPUcr2KzfKbZnKLDApFdyUXvIKxSsw9ZYUKMGvNAYU74Kxle0cgHu/FqsOqN/eNKRyg8zKWMU2yBbW7E6uwABBeaMei0kNVePdrTFDV6L+Xeqvt5YQsqwzIp1TBCIbVMOrDg1brmC7idaZkoU0qBvl+3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219598; c=relaxed/simple;
	bh=ph14uZSX5+HIhq08DmWaQXK72UTjhS6kcFOv6SlTWj4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m53tVo2aTJ1mAdsTN7Dmf0jQhKWw5Eqsi557Vce29ElGAhHORl7AKF+m8CzTBH7avasxxW7RlWgpL98UrAjHFHuuYRWzkFlxvXD04w91oYblxhVqir8H6WzwTsJWwmg8N0NL1JScePZPaXJivqfW4ePj3R5KqL3NBeZLNLz2GHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvMN+vkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvMN+vkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E5D1F000E9;
	Thu, 16 Jul 2026 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219593;
	bh=cSg94AWBfZrhQgnck/aIelN2TtGd1+5xhJUL+fxRrx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvMN+vkK8Wlsb+UZ9P/Gw7TsnJrewBmPaMwpYzosHL+CBL8OuofEckH0vowZNpq3g
	 zMTcxTS+f2o98l99b7CA2lcmukk4FjC4v6oDN2GOUX1nuVmUbOiGxsoYm9fDC/Ko8b
	 o1BD9IajYiNN5mCVQobKpxvnaXcOPZzcnzxVITOLpLeZLC9HLP6th7kaLkeKQRDAaQ
	 A7BnPGXldZ2lxELS7ZWOm3SVXnopZmTf7NalcPCgfPgvc9xu3GEo4AgOYy+nljQvOq
	 TtsBwQWiP/xSb5jxu5iAUUjGjBFG85hZZ0cy7RSsp/lVabMVd/h0yQHkzupSpYqGPS
	 nC59/TynKKfVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] watchdog: mtk_wdt: add reset controller support for
 MT6589
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akari Tsuyukusa" <akkun11.open@gmail.com>
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260716161923.266315-7-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-7-akkun11.open@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 16:33:12 +0000
Message-Id: <20260716163313.19E5D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The watchdog device and reset controller are registered before the=
 driver has finished reading its configuration from the device tree.
--

--- Patch [6]: [PATCH 6/7] watchdog: mtk_wdt: add reset controller support =
for MT6589 ---
commit f121306c9b4fd3b69e7cdcb03d9c4a147f872914
Author: Akari Tsuyukusa <akkun11.open@gmail.com>

watchdog: mtk_wdt: add reset controller support for MT6589
   =20
This commit adds reset data for the MT6589 fallback, assigning the proper
reset controller information to the mt6589 entry in the device tree match
table.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 345d2e89f414e..c8ce45a597956 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c

[ ... ]

> @@ -496,7 +501,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] =3D=
 {
>  	{ .compatible =3D "mediatek,mt2712-wdt", .data =3D &mt2712_data },
>  	{ .compatible =3D "mediatek,mt6572-wdt" },
>  	{ .compatible =3D "mediatek,mt6582-wdt" },
> -	{ .compatible =3D "mediatek,mt6589-wdt" },
> +	{ .compatible =3D "mediatek,mt6589-wdt", .data =3D &mt6589_data },

[Severity: High]
This is a pre-existing issue, but while reviewing the watchdog data
initialization, I noticed a potential race condition during device probe.

Is it possible for the watchdog device or reset controller to be accessed=20
before their configuration flags are fully initialized?

In drivers/watchdog/mtk_wdt.c:mtk_wdt_probe():

	err =3D devm_watchdog_register_device(dev, &mtk_wdt->wdt_dev);
	if (unlikely(err))
		return err;

	dev_info(dev, "Watchdog enabled (timeout=3D%d sec, nowayout=3D%d)\n",
		 mtk_wdt->wdt_dev.timeout, nowayout);

	wdt_data =3D of_device_get_match_data(dev);
	if (wdt_data) {
		err =3D toprgu_register_reset_controller(pdev,
						       wdt_data->toprgu_sw_rst_num);
		if (err)
			return err;

		mtk_wdt->has_swsysrst_en =3D wdt_data->has_swsysrst_en;
	}

	mtk_wdt->disable_wdt_extrst =3D
		of_property_read_bool(dev->of_node, "mediatek,disable-extrst");

	mtk_wdt->reset_by_toprgu =3D
		of_property_read_bool(dev->of_node, "mediatek,reset-by-toprgu");

If a userspace process opens the watchdog character device immediately afte=
r=20
devm_watchdog_register_device() completes, or a concurrently probing driver=
=20
acquires the reset controller after toprgu_register_reset_controller()=20
returns, could they operate with uninitialized state variables=20
(disable_wdt_extrst, reset_by_toprgu, and has_swsysrst_en)?

This could potentially misconfigure the hardware, failing to disable extern=
al=20
resets or missing software reset enables, which might cause system lockups =
or=20
failed peripheral resets.

>  	{ .compatible =3D "mediatek,mt6735-wdt", .data =3D &mt6735_data },
>  	{ .compatible =3D "mediatek,mt6795-wdt", .data =3D &mt6795_data },
>  	{ .compatible =3D "mediatek,mt6797-wdt" },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716161923.2663=
15-1-akkun11.open@gmail.com?part=3D6
