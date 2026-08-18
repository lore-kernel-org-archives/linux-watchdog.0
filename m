Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AC42123F;
	Tue, 18 Aug 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068414; cv=none; b=SevsnklCacVeFc111dWFHYspnh8gAOydXOZyqGt7Q8SU04oWAGf/AbqfvDRwVz9bZrI+hQ8yzntrr+pQG7Zf6tkkcaJJtYckydzzVunbfKiD2+ZP9Zszqgxk/3xTjfxzcYcVqpDaaOqjDn2w9zEeISRJNSM9BiEWxlQ94UWpBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068414; c=relaxed/simple;
	bh=zM7Kw335RtLMwMQZRjhL6GkGaL8GektEtShfwuox9RU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kVAZH39SZhCxrhwCc8PnM7SkUU8EBOIIzRaK6VkcfrglOkyFyMOXY/U4pm6PaeeLJN4PQjqFDmejf5IKwduXVsV21QZUIqo5ZCLvFA9eGpEEIsL8PaWhf5+BvKebWkMdQsrzTlqkdQxPxksiy70ziPDCbEiZd13sErLICUpyXjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkdU6SL5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkdU6SL5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0DD1F000E9;
	Tue, 18 Aug 2026 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787068412;
	bh=nopx9UMoxhVIwr8rj+CcbZo90QHmoCLfA5eB7628Qu4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nkdU6SL5tWhI+9YUQo72iJ03G8ES29q1R8lgft4yZ+a6Qc96c54Ha2TEBIqAGRneW
	 2a2SeT/kz2lQKiKdlj0oDgRBPxc93Agp21FZH/pl5spfUbteXCaf+MwJmxBbCdCqKT
	 Em+F2eIAAkubJGTgaMeVc2++Iwg6D4CXj5vP8jGVqNGSwRikbp2mm+QsYtiFX5GQmi
	 aZSvxf2BPwJs6LUxY/m6MZsjAyM2PjQ6XXfE3Uu/71pXUti+69OJK20xvjfrqxIR6L
	 iLIDCGGBZCKJm+iy+qlG8vlWbNpRk0QejpWBL0a3vP+M4kOiR+ya+bqpxMS38CgUKV
	 qMwQ1IBwc18BQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aiden Isik" <aidenisik@member.fsf.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260818-for-next-lucky7-watchdog-v2-2-6743f479a47f@member.fsf.org>
References: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org>
 <20260818-for-next-lucky7-watchdog-v2-2-6743f479a47f@member.fsf.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 15:53:32 +0000
Message-Id: <20260818155332.9E0DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `drv_data_exynos5515` variant includes `QUIRK_HAS_PMU_AUTO_DIS=
ABLE` but fails to define `.disable_reg`, resulting in PMU register corrupt=
ion at offset 0x0.
- [High] The `drv_data_exynos5515` variant uses an INT_EN register for mask=
ing but fails to set `.mask_reset_inv =3D true`, inverting the watchdog mas=
king logic.
--

--- Patch [2]: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt com=
patible data ---
commit fd223d0c16451bec63089d85a77c3b012b8f28ed
Author: Aiden Isik <aidenisik@member.fsf.org>

watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
   =20
Add driver data for the Exynos5515 SoC's watchdog timer.

> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wd=
t.c
> index e31f93db05096..7299dfdb0c099 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_exy=
nos5420 =3D {
>  		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
>  };
> =20
> +static const struct s3c2410_wdt_variant drv_data_exynos5515 =3D {
> +	.mask_reset_reg =3D EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,

[Severity: High]
This variant uses an INT_EN register for masking but omits .mask_reset_inv.
Could this cause the watchdog masking logic to be inverted?

Looking at s3c2410wdt_mask_wdt_reset(), the logic evaluates to false when
unmasking if .mask_reset_inv is not set to true:

s3c2410wdt_mask_wdt_reset() {
	...
	const bool val_inv =3D wdt->drv_data->mask_reset_inv;
	const u32 val =3D (mask ^ val_inv) ? mask_val : 0;
	...
	ret =3D regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
				 mask_val, val);

Does this mean it will write a 0 when unmasking, disabling the reset output
instead of enabling it?

> +	.mask_bit =3D 2,
> +	.rst_stat_reg =3D EXYNOS5_RST_STAT_REG_OFFSET,
> +	.rst_stat_bit =3D 24,
> +	.quirks =3D QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE | \

[Severity: High]
Since QUIRK_HAS_PMU_AUTO_DISABLE is set but .disable_reg is omitted, will
.disable_reg default to 0x0?

During initialization and suspend, s3c2410wdt_disable_wdt_reset() applies
updates to wdt->drv_data->disable_reg:

s3c2410wdt_disable_wdt_reset() {
	...
	ret =3D regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg,
				 mask_val, val);

Could this unintentionally corrupt bit 2 at PMU offset 0x0?

> +		  QUIRK_HAS_DBGACK_BIT,
> +};
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-for-next-l=
ucky7-watchdog-v2-0-6743f479a47f@member.fsf.org?part=3D2
