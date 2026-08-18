Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3721347D920
	for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2026 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787071409; cv=none; b=jxxumUVfN1XxjvX4g++SLIQs/orGNcEiLIfgnuhsAHc3NGXN6P57eJ5/49e3+c2eFGUfYy7cmEY7Tx717IVSm0TgVo2F112sMRhEbBv58iSIFzWXovi020DyijyfcxKZ/KgJa2HbdhQZEqIdb0hjDHtngYQjzbzZUtvR/5rLJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787071409; c=relaxed/simple;
	bh=K+QUy4zLmlv4+MaVDHnBLu+gH/Gcy3fxKtNBfHWbBA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aYZw71BZHpaDaXioG68H78CkvzT4Cyxdmf5Uz3K0Gm3sbznFJpjHHOZLiJdh/cZvEFYBkvRGOezoY6fda//1ViTb83MTlPK9hKY5hLDX/jtcn/JFlMeCQdEt2AF9q0D7h8Xhj/kceySizlyBbNyoviVz0GnQPzKDHUDxGzeZ8ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9EbPXO1; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9EbPXO1"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-848743155bcso71386b3a.0
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2026 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787071407; x=1787676207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6RTooZUiv9NtYPBqi5Uj7Uh2pUea9ucaOoXpNtgOCTw=;
        b=A9EbPXO1ApjFrzE60rfXTYWX/lt4OA+9biDGASkShdcYuPToMmry5pfswW7DOl8B8k
         azeyR2+lQOggWTdQA1DgCooyTQg8ejZEpwO3sH16ZmDMMJVBm33mKiZttqjazvIKUXON
         vVueLZWIl0TOiKWSTDUhMkApfok2dzVkO0S3OXOdPy02B4zj9/Z0jk3SPudN1uual3LI
         RprQ9cO+XV7AhZ96Vu20GtS3O3LFNwCtJs8UutsvXVxHHkgtFZdB5miv/6QcW+gkGPUd
         zzvyNydfhXNOdxG0aFelXrgDo2IKguUy3hfyqyR17GrA9RYZP/ALH0ELDHEsvZVsVkNY
         0n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787071407; x=1787676207;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6RTooZUiv9NtYPBqi5Uj7Uh2pUea9ucaOoXpNtgOCTw=;
        b=FLqErpwaCOtoGMU1b7bpYBaOut4zVgMHNi4laXoicT4NN7p1W3BBPEW87nrEboq7S9
         VCH0HIBjJonmBxKmwSs/sYfJ2K5wvCqxxZrgjFEXYkxrLV85JcYDbhsYP/HheNAEB0D7
         tSMpNWgQ5LAym+J7UnvJu9hVsU5VELa3ArOBCifB+shfL5FnUOK3NQY53wBOCC9Rtl9L
         Hoi0q6ngJTgiSBJDrKjmLr1ytbSEQJCUqfeiCGtlr1LcFEiGKI2lZTrNTLZcKNPe8jns
         zxXS6HmHVcVTXvH8KkMn+9qBX6mu16RE8PTMWlIcSgrE7jSgY+6hbIKK7YzEPQtrB5WQ
         9EZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYGBdCirLh4slgpYDc4lyJDsYSStYn2EqATQZ5VpfFzTfolQKIFNNqf5mEdNWzuu3Dxe0recca5nUPXfnKYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzMvoSLUeSCo6yJXfgdHyfdyvS8efv4CY/gvmRQZLzc94n4fp5
	/O3COd2Zxzdks/5gnbCSktbDXTubR/5f5feFvKKsq98Ujyp+A7yMukQB
X-Gm-Gg: AR+sD13Yj5BUFs+m/WKXPPfPleDB1Hvsse5KZoN1U2PCl8YnXiDJcwSuXMPGcgbATxj
	fMRQK991bfpAFfri7nEmQo7lJBLSgYLCADMrlnFA4YuLY3jA/69wlBg3WP2Pa7U64QBkGTPbC19
	zaqRmk/kjG2U7vzwpnZJDmvHgrRnt7r7RBmSisSFX8dNa8gSgxgZsvUmEdrteiBWDoRxnWpRmpR
	iV5DcS2KvvyrrJDDVKRI8GoOYHnOMXm95gQFuNpS8WOnfTMxthUkQ+jPPrySIJU6yGeIEmOJqPK
	xjbdf2OXBisPOD1a/bB2wYBCeneTDjCJFsde/IDEKy17re2HFErzr2DOEqKqnfwRgPQW8aDU9Hg
	cT+oIMi5FNXZWeJHG71vDMcW861l8VQxjZuHd3gdIL0A2ozpbTDynJqdYuifKjzXLo66jjLnm1s
	QcyzG7QPCPMPeqnY7YXK8UfBcIupjvZ9yjMd9LT0pe7O7t+3vnovMfo49Qjfi0TDmesDxnubLvs
	RhUzMrYbHtDt5Wq+X0xCFQKcLrBNvcrHkDZLQ==
X-Received: by 2002:a05:6a00:1c9e:b0:845:c694:5c3d with SMTP id d2e1a72fcca58-84fddfbf1c0mr37409469b3a.1.1787071407292;
        Tue, 18 Aug 2026 09:43:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b401ddd9sm2069801b3a.3.2026.08.18.09.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 09:43:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8919c7f3-2dcb-4666-91e0-a91edc378c28@roeck-us.net>
Date: Tue, 18 Aug 2026 09:43:25 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
To: sashiko-reviews@lists.linux.dev, Aiden Isik <aidenisik@member.fsf.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 linux-watchdog@vger.kernel.org
References: <20260818-for-next-lucky7-watchdog-v2-0-6743f479a47f@member.fsf.org>
 <20260818-for-next-lucky7-watchdog-v2-2-6743f479a47f@member.fsf.org>
 <20260818155332.9E0DD1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260818155332.9E0DD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Aiden,

On 8/18/26 08:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The `drv_data_exynos5515` variant includes `QUIRK_HAS_PMU_AUTO_DISABLE` but fails to define `.disable_reg`, resulting in PMU register corruption at offset 0x0.
> - [High] The `drv_data_exynos5515` variant uses an INT_EN register for masking but fails to set `.mask_reset_inv = true`, inverting the watchdog masking logic.
> --
> 
Please either address or explain why those are non-issues.

Guenter

> --- Patch [2]: [PATCH v2 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data ---
> commit fd223d0c16451bec63089d85a77c3b012b8f28ed
> Author: Aiden Isik <aidenisik@member.fsf.org>
> 
> watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
>      
> Add driver data for the Exynos5515 SoC's watchdog timer.
> 
>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>> index e31f93db05096..7299dfdb0c099 100644
>> --- a/drivers/watchdog/s3c2410_wdt.c
>> +++ b/drivers/watchdog/s3c2410_wdt.c
>> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>>   		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
>>   };
>>   
>> +static const struct s3c2410_wdt_variant drv_data_exynos5515 = {
>> +	.mask_reset_reg = EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
> 
> [Severity: High]
> This variant uses an INT_EN register for masking but omits .mask_reset_inv.
> Could this cause the watchdog masking logic to be inverted?
> 
> Looking at s3c2410wdt_mask_wdt_reset(), the logic evaluates to false when
> unmasking if .mask_reset_inv is not set to true:
> 
> s3c2410wdt_mask_wdt_reset() {
> 	...
> 	const bool val_inv = wdt->drv_data->mask_reset_inv;
> 	const u32 val = (mask ^ val_inv) ? mask_val : 0;
> 	...
> 	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->mask_reset_reg,
> 				 mask_val, val);
> 
> Does this mean it will write a 0 when unmasking, disabling the reset output
> instead of enabling it?
> 
>> +	.mask_bit = 2,
>> +	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>> +	.rst_stat_bit = 24,
>> +	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
>> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE | \
> 
> [Severity: High]
> Since QUIRK_HAS_PMU_AUTO_DISABLE is set but .disable_reg is omitted, will
> .disable_reg default to 0x0?
> 
> During initialization and suspend, s3c2410wdt_disable_wdt_reset() applies
> updates to wdt->drv_data->disable_reg:
> 
> s3c2410wdt_disable_wdt_reset() {
> 	...
> 	ret = regmap_update_bits(wdt->pmureg, wdt->drv_data->disable_reg,
> 				 mask_val, val);
> 
> Could this unintentionally corrupt bit 2 at PMU offset 0x0?
> 
>> +		  QUIRK_HAS_DBGACK_BIT,
>> +};
>> +
> 
> [ ... ]
> 

