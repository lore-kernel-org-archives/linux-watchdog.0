Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3503442364;
	Wed, 19 Aug 2026 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135450; cv=none; b=fkbIZUYyjX6mDW9zjpE58Jhzma/kmzj3tbo/fQTAVwZk3W3m9BxXFnSryDi6M5E0epHDSQ7Hwy3CZbhsKuJmjrgaOek/vqN4wKPyJlXHgJ2r/1xNlB0L4rfsd6uQw3WuJpEwCTZ9jjkANJCDFKCiUVheXQVzHwPasyFKBHXtU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135450; c=relaxed/simple;
	bh=4NJaQWGQG26PIQnoDdbq1+fMi3UqmMN1VFtCN2VCVR0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gBlRXna90AEQKRxVdUbkEibmFJIjH+Eibppto5s83kgXK/AmtKcFrBaIvWzl8izehMxh1ze0ImNXOu1OO6TzAHaznkEU96BAYhcbsE3uMq5xPAXetvrn625R9Wd9gfO/4d8Qr+NRMLdOevmILfyTXlBsi79fnrCY62A+/jvGk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIapoAuQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIapoAuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BBC1F000E9;
	Wed, 19 Aug 2026 10:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787135448;
	bh=H0b5hz5Jv0MazburOEa18gbJuaqkoNPI7jix/frppps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JIapoAuQcBlQP4RlxXPZalkolKDN2IYkh04Km55rgUQSqkvrrihZvMcHTPe3Fl/nJ
	 GLUsf0QTRGMZbPzgD1M4mOlrDzcy1shIuRg10yYQczzj6cJsW9ACkO7GHQqu18AVsU
	 4FKHAobUodDp0PVBxRrXlKVJDX8sIqGZ/jqSV+RFIzbmxj+RdX2rBIKjUbgfo5Yz61
	 tfs97HtF9f/zMcPptr9qfqNj6Y/LtZrnT7B6XrFiEseSnRgOFCsZLxlp2a/35+aONg
	 TPXMPJNmFrR3KnVqryONjhDdZ+7MFhqLRLQP8PNYTioZjhxMD2BWI26DMMc71zqxkt
	 VJ2Dl141Lis/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] watchdog: mediatek: Add wdt/toprgu resets for
 mt6589
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260819101853.44681-3-l.scorcia@gmail.com>
References: <20260819101853.44681-1-l.scorcia@gmail.com>
 <20260819101853.44681-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 10:30:48 +0000
Message-Id: <20260819103048.57BBC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Watchdog device is registered before its driver data is fully init=
ialized, allowing userspace to trigger `mtk_wdt_start()` with uninitialized=
 flags.
- [High] Reset controller is registered before `has_swsysrst_en` is initial=
ized, causing a race condition where reset operations use incorrect configu=
rations.
--

--- Patch [2]: [PATCH v4 2/7] watchdog: mediatek: Add wdt/toprgu resets for=
 mt6589 ---
commit 62a8c76fbad14150f6f3dabaecc0a569e1dfdcb5
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

watchdog: mediatek: Add wdt/toprgu resets for mt6589

According to Android sources, mt6589 has 12 reset bits in the
WDT_SWSYSRST register. Populate toprgu_sw_rst_num to allow toprgu resets
in device trees of the many compatible devices.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 91d110646e16f..f8208fb0f7234 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c

[ ... ]

> @@ -493,7 +498,7 @@ static int mtk_wdt_resume(struct device *dev)
> =20
>  static const struct of_device_id mtk_wdt_dt_ids[] =3D {
>  	{ .compatible =3D "mediatek,mt2712-wdt", .data =3D &mt2712_data },
> -	{ .compatible =3D "mediatek,mt6589-wdt" },
> +	{ .compatible =3D "mediatek,mt6589-wdt", .data =3D &mt6589_data },

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a potential race
condition during probe that might affect all watchdog devices here.

In mtk_wdt_probe(), the watchdog device is registered before its configurat=
ion
flags are read:

        err =3D devm_watchdog_register_device(dev, &mtk_wdt->wdt_dev);
        if (unlikely(err))
                return err;
       =20
        ...

        mtk_wdt->disable_wdt_extrst =3D
                of_property_read_bool(dev->of_node, "mediatek,disable-extrs=
t");

        mtk_wdt->reset_by_toprgu =3D
                of_property_read_bool(dev->of_node, "mediatek,reset-by-topr=
gu");

If userspace (like systemd) opens the device immediately after registration,
could mtk_wdt_start() run before these flags are initialized?

Since these flags are written to the WDT_MODE register and not re-applied
later, could this permanently misconfigure the watchdog for the system upti=
me
and cause a hang instead of a reboot upon timeout?


[Severity: High]
This is also a pre-existing issue, but while reviewing the probe path that
uses the newly assigned device data, I noticed a potential race condition
with the reset controller.

In mtk_wdt_probe(), the reset controller is registered before the
has_swsysrst_en flag is initialized:

        wdt_data =3D of_device_get_match_data(dev);
        if (wdt_data) {
                err =3D toprgu_register_reset_controller(pdev,
                                                       wdt_data->toprgu_sw_=
rst_num);
                if (err)
                        return err;

                mtk_wdt->has_swsysrst_en =3D wdt_data->has_swsysrst_en;
        }

If a consumer device requests and asserts a reset line immediately upon
registration (e.g. from a concurrent deferred probe), could
toprgu_reset_update() observe has_swsysrst_en as false before it is
assigned?

If so, would it skip calling toprgu_reset_sw_en_unlocked() and fail to
enable software control for the reset bit in WDT_SWSYSRST_EN, leading to a
probe failure for the consumer device?

>  	{ .compatible =3D "mediatek,mt6735-wdt", .data =3D &mt6735_data },
>  	{ .compatible =3D "mediatek,mt6795-wdt", .data =3D &mt6795_data },
>  	{ .compatible =3D "mediatek,mt7986-wdt", .data =3D &mt7986_data },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819101853.4468=
1-1-l.scorcia@gmail.com?part=3D2
