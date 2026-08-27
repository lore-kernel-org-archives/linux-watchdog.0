Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0C229B8E1
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 13:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787838664; cv=none; b=cfShgu8OAHGLOPbzLYXsH5VwUXDgb3lMkgVzDnjzxh1az1M1UXGaKmix9ovK1T1Gsz3cp9xu8SfXV2kOjj3n+H7x6LD1guWHw1FKcpfXjlOLouE0OROwh76T5d47UIZ6To9DQuTVU3fnoAWciZ/Fhcb3p4UaArsMfhhdaxRPeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787838664; c=relaxed/simple;
	bh=GSXCNAWdi1MMmnqf1XW/FPRyeflfu8kqpYT/0BkJlPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ+c+UCl8K9vt0ruI3rDuUDok338UvQbqBCgzd5jMnomgiyaYuDVuifnD0kOG+51TlzB4uXT6maCyoQlxkWPQceBYNnRMUk9ZLNRP06qEZaEAPIgYstkGXc/G+dMRO39dMSBSGtfunNcd7CohH8/dGjgtJBvPZElt94TZdpqbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=is4VpxRZ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="is4VpxRZ"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-382ef647e20so2674396a91.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787838662; x=1788443462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QGwb2ysQ4spjThnrjYtrwlyO99o7U1vRUqimeHR94+E=;
        b=is4VpxRZDqIyNePXkzt18xRXkXLrR9pzzxdJXlzsGjZ6tu6NcNjhfXVHmJn6x9QBqS
         iQtlmeeyxwr+xEvHxcT198QYRnQ9ZLv0v40J7Axseee/GATGDuw6HrT9jgMDJKbD35ny
         IzNvYSwdlRU408TtZAsSntz3SRebPAoViE9/hopqRaTakw2dZwA5OTpNrBVMUxG/tRgV
         hMum4wiyROnDkRbMcNu44heUbyDp2SJP1siRwtb1j5deRTpsnQ7cIaworwlRyLWeOsyv
         Mr+Q3nQWd8mOYMiIqGns9tyu+cDBjfsA3wyj+G0HlrA0yajjI4UGVG9IkbMOPN93+zsH
         UKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787838662; x=1788443462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QGwb2ysQ4spjThnrjYtrwlyO99o7U1vRUqimeHR94+E=;
        b=qvQ2pkZ2mPb4/GOD+OpHHelq+5GWKM4qk11y1P0D6nHNfMhwLkHOMG5a2x1kOctLV5
         RhCSGvvCQO4z4xwM/GL9XaNsqHSuOOg0X4A4FdQl/GzwQS3YAmF3lk6aKqahQG8UfW4i
         lw/WXNNwcTh/i6IDOkyxr9hLazVkV+UryoJ7rFVZPmXPnBCI37VO2Xshm/F6k/v+6bOf
         yQ5w69Pxk0aspajDgpGnbWVqbhOrcbEFuvsIYFEfjHkbxe4FL2FYhn+cpPrLS+ht1mon
         lZXk7oUdRFI/614qJ5Omss6DrAWiIxLdhWKZlV8SHx/ZhRF2M+ulsz1hkkMmvqA3STEI
         EJHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoSHpbLbCSgY6YpPRelS8fPgV//ovZjGcCdbMCzlzfVtFUW/8kA6O5NW8rFUNpQbAiyLmr4yaVWfhqKQUSKsA==@vger.kernel.org
X-Gm-Message-State: AFuF++nnW5oaTk/h6a2qkmk06in8oU8wrSHcAGez5wWwtcWEcb4kxqT1
	Zy2DhvKyXCsfP8VWU9AFp/2DAtYKcI4ZDuQvbuI0crSW4s/pSIGbH1Cu
X-Gm-Gg: AR+sD13WZG2g/U7eiB/kAZ7GpsfmXENr/ytq57qCz9gG3vD17aUOt/mieCpP+Qn73PB
	erx5vhlDEbhmkj/yxjLBhlSKQXAqRY9i0ffargdkeY5ldLyZ7+fMV1I+QMimYx1dxIkRsRvfmEl
	kZvAxOdnclX0M3QjrG82ZToGN5z9Qip7T94ElTYO3d3fM5tX5WTF4tJHoRekY4TNfUiWNyQr9S6
	A0wxNE488lgtySE4zwDqMZexThmTS+PR2uH7UIdFAD/nYbfmuefNgjAG1mbsfeA2Lah5XzvK/Hm
	a40fp2TQ53kTG+JrwY3/Dzd8q0A38Rd7bhFpEHI+JLcLVROPlPg3PwdykYjXqwYN42uq+wBncpO
	qenNJxffvw+IiHAuyceDRuasDUU3iDtIDHIuIQoWCZmh3sashQhRsY8Wz6OXa1XX4IYfuKL4yvF
	u5BZhw/1WvRjigdGFpLx8/qNUXZrQGfJd4xqu4clsLUxbkYekWXCoAkrFnzDZCrlhXypzssrdY5
	g==
X-Received: by 2002:a17:90b:4d88:b0:395:4de0:b78f with SMTP id 98e67ed59e1d1-3966d36e327mr30704782a91.1.1787838662493;
        Thu, 27 Aug 2026 06:51:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0ea80edsm2894675a91.1.2026.08.27.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 06:51:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 27 Aug 2026 06:51:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Aiden Isik <aidenisik@member.fsf.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
Message-ID: <168be4ed-d670-4d61-a061-e01abb33efa4@roeck-us.net>
References: <20260821-for-next-lucky7-watchdog-v4-0-d070cee5009f@member.fsf.org>
 <20260821-for-next-lucky7-watchdog-v4-2-d070cee5009f@member.fsf.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-for-next-lucky7-watchdog-v4-2-d070cee5009f@member.fsf.org>

On Fri, Aug 21, 2026 at 04:14:50PM +0100, Aiden Isik wrote:
> From: Aiden Isik <aidenisik@member.fsf.org>
> 
> Add driver data for the Exynos5515 SoC's watchdog timer.
> 
> Unlike similar SoCs such as GS101 or Exynos990, Exynos5515's PMU does
> not require explicit counter enablement for the watchdog to tick.
> 
> Signed-off-by: Aiden Isik <aidenisik@member.fsf.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/watchdog/s3c2410_wdt.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index e31f93db0509..e61439a3f4b2 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -232,6 +232,20 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>  		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
>  };
>  
> +/*
> + * Unlike similar SoCs like GS101, Exynos5515's PMU does not require
> + * explicit counter enablement. Hence, QUIRK_HAS_PMU_CNT_EN is not set.
> + */
> +static const struct s3c2410_wdt_variant drv_data_exynos5515 = {
> +	.mask_reset_reg = EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> +	.mask_bit = 2,
> +	.mask_reset_inv = true,
> +	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
> +	.rst_stat_bit = 24,
> +	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
> +};
> +
>  static const struct s3c2410_wdt_variant drv_data_exynos7 = {
>  	.disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
>  	.mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
> @@ -379,6 +393,8 @@ static const struct of_device_id s3c2410_wdt_match[] = {
>  	  .data = &drv_data_exynos5250 },
>  	{ .compatible = "samsung,exynos5420-wdt",
>  	  .data = &drv_data_exynos5420 },
> +	{ .compatible = "samsung,exynos5515-wdt",
> +	  .data = &drv_data_exynos5515 },
>  	{ .compatible = "samsung,exynos7-wdt",
>  	  .data = &drv_data_exynos7 },
>  	{ .compatible = "samsung,exynos850-wdt",
