Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CF340D9A;
	Thu, 16 Jul 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219856; cv=none; b=seFZ8I6L8DMw91Ctz6T1p867fxQsCS0Nj1Hqtw5Qwmyp6BLwSHTpadw2W/vcA0sSGVIGk5jmqVRYIJtE2BenD0KEus3lUh+INTZ8GnKkHC5x7JIbg0cz60W2p+jh5590QzhjZ/7ZkoM26MchzTCCfkFJbOGuWvRhIq1DZKL0uZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219856; c=relaxed/simple;
	bh=5YDGoGw4bw187r9/1zeeQvV3kc805/e8bf0fLNuvEsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IqlOIULHll3mj1B3FkQ8MZRmSuuC/mTYRUxpTYgJ2WWUti8VhBCy1jR/yxpn3sD47+Ybt9ZR2gLW6cJIz9wE3f1zXOAmEsPBDE+QvQKhUnVkDeJZdJWbOgqjHib4pD52Qk6iawnG1txKqUW+i9AqtH3pKsr/1ONENAAUIp7cno8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0FfLmJP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0FfLmJP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A068C1F000E9;
	Thu, 16 Jul 2026 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219840;
	bh=pPb7MRYGqzMNG1yKEhlTe1zO85v6O2FdS8OZOizYqHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0FfLmJPT7VicdzDkdLHmuoUgNZlfHgPCyhCXkjm7W/I7kHk5UHTibL0YVHsE79sd
	 6EYy9Gc4PyGtOnhZTRR4PwQ5KLP0g5AvU8FWyz2N2reyjONSZObzaSOZ8K0uCV/5GJ
	 F7N+kFxA+KaoahF2jUa5ENzlZh7++b0Fw9h6dtu5ZgyxSvXCDIYSM7tyZM1JUPJY5T
	 00o5ESEUXhnz1XzvW+AqKbAi3d/fMM6FHOriq6U7mcKV1YBFsCI/2mTTajrmE1H3sP
	 pgQFSCECqu3c/o1ATMeDemnIpf9ATsV2r7YW0DHy1y27H69/ieMumqKW/ULvZY/wqa
	 kSpwdcqdMekkA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] watchdog: mtk_wdt: add explicit compatibles for
 SoCs using mt6589 fallback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akari Tsuyukusa" <akkun11.open@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260716161923.266315-2-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-2-akkun11.open@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 16:37:19 +0000
Message-Id: <20260716163719.A068C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Watchdog is registered to userspace before its state is fully init=
ialized from the device tree.
- [High] Watchdog hardware is not stopped during system suspend if it was r=
unning before boot but not opened by userspace.
--

--- Patch [1]: [PATCH 1/7] watchdog: mtk_wdt: add explicit compatibles for =
SoCs using mt6589 fallback ---
commit d59566877973f13ae59e846770f459a7512fd9eb
Author: Akari Tsuyukusa <akkun11.open@gmail.com>

watchdog: mtk_wdt: add explicit compatibles for SoCs using mt6589 fallback

This patch adds dedicated of_device_id entries for several SoCs that
currently rely on the "mediatek,mt6589-wdt" fallback compatible. This
allows the driver to match directly on the SoC-specific string, which is
a prerequisite for removing the fallback string from DTS files.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 91d110646e16f..345d2e89f414e 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -492,17 +492,28 @@ static int mtk_wdt_resume(struct device *dev)
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential
problem with how the watchdog is handled during system suspend and resume.

In mtk_wdt_suspend() and mtk_wdt_resume(), the driver only checks
watchdog_active(), which is true if userspace has opened the device:

drivers/watchdog/mtk_wdt.c:mtk_wdt_suspend() {
    ...
	if (watchdog_active(&mtk_wdt->wdt_dev))
		mtk_wdt_stop(&mtk_wdt->wdt_dev);
    ...
}

Will this cause the system to reboot unexpectedly during suspend if the
hardware watchdog was already running before boot (WDOG_HW_RUNNING) but
hasn't been opened by userspace?

Should these functions also ensure the hardware is properly stopped even
when the device hasn't been opened?

[Severity: High]
This is also a pre-existing issue, but does mtk_wdt_probe() expose the
device to userspace too early?

drivers/watchdog/mtk_wdt.c:mtk_wdt_probe() {
    ...
	err =3D devm_watchdog_register_device(dev, &mtk_wdt->wdt_dev);
	if (unlikely(err))
		return err;

	// ... [code omitted] ...

	mtk_wdt->disable_wdt_extrst =3D
		of_property_read_bool(dev->of_node, "mediatek,disable-extrst");

	mtk_wdt->reset_by_toprgu =3D
		of_property_read_bool(dev->of_node, "mediatek,reset-by-toprgu");
    ...
}

If userspace opens and starts the watchdog immediately after
devm_watchdog_register_device() completes, could it be started with
incorrect configurations before the device tree properties are parsed?

Additionally, if toprgu_register_reset_controller() fails after the watchdog
is registered, the probe will fail. Could this cause the watchdog to be
deregistered while it is actively in use by userspace?

> =20
>  static const struct of_device_id mtk_wdt_dt_ids[] =3D {
> +	{ .compatible =3D "mediatek,mt2701-wdt" },
>  	{ .compatible =3D "mediatek,mt2712-wdt", .data =3D &mt2712_data },

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716161923.2663=
15-1-akkun11.open@gmail.com?part=3D1
