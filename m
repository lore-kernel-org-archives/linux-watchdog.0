Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40152E3B12;
	Fri, 17 Jul 2026 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309422; cv=none; b=kwsPtu+L4FLU/zKyuJMdRw20NJQwjUOGRNBYszhSSYz2f4vD8XeyDKgIDi6JhpJJLotnsUq9UD2aYY1bJPQnoDcskpbIOtnn2JRfywBVshSFofRpCqp1hEbdp0vw/TRNbEPGsAnUlMPqDM7vCbbiV9UT4QKtBmucrklPaB5wrEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309422; c=relaxed/simple;
	bh=ddg6sVPWqw9fzaAdHnCaEiNWokebTK5g25gtiN+74c0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e6NNZhh71wfm+5FYZhEF1AewC3prU97fBcy64dkBmtl9sfV/l6JJsGKAuVuCnDLl1H+rEVuvazlJYBxdtD/a1FvpS+Nt7oHukxYRIX2MsBOTOQhQCtS6thil6eCfi69F2L/84pfLhrLffdDJZaDa5bsyvUznAcLlNRQLhtkBL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahUyifga; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahUyifga"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3171F000E9;
	Fri, 17 Jul 2026 17:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784309421;
	bh=VP/zGb6D9nwdavgHitpQpPZzKnWF1S4qxmUkNkSqRas=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahUyifgaqsZXn2uOBOliEpLBt6zSUxtGL3Nwrs9nJYzn/JXljzmBYAIa5EJsgQ9L2
	 zODYjU1Be7BBrMNd9tR2qnz8YDCNIO8CVLYayb99lknpCoHzE8x4X3EMNAVUEGrAg4
	 yyyBR/BAmB7j+Eb4XO0rsGOdo1QiuQKJTEUtIW3IVMTu9zOrJEeWivofBJWHb/dJ4M
	 hHiPR80SAMje4mdGPGpcCkbqM9rgzNjCPFJmx5XuQDpzEQPg/FWCUJl5Y5gsDW/aH7
	 EGzrugdMR2/zmOw379o1a6sg1UKNzU9cRt8YlGcxoAiN2pD0cGLAFwE//mt8LyEXFv
	 NbtCVDCCEcDBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] watchdog: mediatek: Add wdt/toprgu resets for
 MT6589
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260717163959.714561-3-l.scorcia@gmail.com>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-3-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 17:30:20 +0000
Message-Id: <20260717173021.1E3171F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Reset controller is synchronously registered before its structural=
 configuration variable `has_swsysrst_en` is initialized.
--

--- Patch [2]: [PATCH v2 2/7] watchdog: mediatek: Add wdt/toprgu resets for=
 MT6589 ---
commit 3b51cb7125d43b8f8ea3a7996ec1844775ec36b1
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

watchdog: mediatek: Add wdt/toprgu resets for MT6589

This commit populates the toprgu_sw_rst_num field for the MT6589 watchdog d=
ata.
It maps the 12 reset bits available in the WDT_SWSYSRST register to allow
toprgu resets via the device tree.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 91d110646e16f..e61f6ae743276 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
[ ... ]
> @@ -88,6 +89,10 @@ static const struct mtk_wdt_data mt2712_data =3D {
>  	.toprgu_sw_rst_num =3D MT2712_TOPRGU_SW_RST_NUM,
>  };
> =20
> +static const struct mtk_wdt_data mt6589_data =3D {
> +	.toprgu_sw_rst_num =3D MT6589_TOPRGU_SW_RST_NUM,
> +};
> +
>  static const struct mtk_wdt_data mt6735_data =3D {
>  	.toprgu_sw_rst_num =3D MT6735_TOPRGU_RST_NUM,
>  };

[Severity: High]
This is a pre-existing issue, but registering the reset controller in
mtk_wdt_probe() happens before the structural configuration is fully
initialized:

drivers/watchdog/mtk_wdt.c:mtk_wdt_probe() {
    ...
	wdt_data =3D of_device_get_match_data(dev);
	if (wdt_data) {
		err =3D toprgu_register_reset_controller(pdev,
						       wdt_data->toprgu_sw_rst_num);
		if (err)
			return err;

		mtk_wdt->has_swsysrst_en =3D wdt_data->has_swsysrst_en;
	}
    ...
}

If a consumer driver probes concurrently and asserts the reset line, could =
it
execute before the has_swsysrst_en flag is set?

On SoCs requiring software reset enable, reading the uninitialized
has_swsysrst_en as false would cause the reset assertion to fail silently,
potentially leaving consumer devices in an undefined state.

Should mtk_wdt->has_swsysrst_en be initialized before calling
toprgu_register_reset_controller()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717163959.7145=
61-1-l.scorcia@gmail.com?part=3D2
