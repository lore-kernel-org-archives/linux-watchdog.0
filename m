Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC2B3DEFFE
	for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2026 19:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080278; cv=none; b=OCb0DOBcNynMsUHC6hngDFFq/2dRtOFZ65nHxUNfltTM2VNPwRtnhlPprJVRp4b9bVpc4nMhwcYkGNNsLNcaDxBh9OLnCJ1rI5N14xBJMjD5/AZSF4nM3fQIKvWpzZ/J//nh3OV8lFplFw6O23dCvd1UVdHMdwbMCcClozA/9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080278; c=relaxed/simple;
	bh=c1up1Sr7bYMUcgw1kwDK1BEdHmzPuMH+BV+CjC+r9i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bSHFEh16UON66D4ZkJaODrb+TlhMEhO67BQvFXHFKO3JHqgOA5Hxkk/bArdgZ5XQHOGT74EyaKxSYisYgNe1J1/VdiEsUAIiZPZAhTV8jPAxXWvJTbLnL0RV0qoylmAIjkSIv4gPMShcZE0cubqnF2X7iqE+q69P4lqSH4p/1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQ/KcU3k; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQ/KcU3k"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96c92c0980so68240a12.3
        for <linux-watchdog@vger.kernel.org>; Tue, 18 Aug 2026 12:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787080276; x=1787685076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oqejPSPmpWq4aveojXJ9NhylWdssz7eILklSEDd4p4=;
        b=rQ/KcU3k3OZiCyo7QXn1vtJc4Xq+0EudeziGBWO744WX/SMAOyz8dip/yhtsY8jv8w
         UJTDpZleDLIZY4uZKGlfsp0B4NNPIt11cZCwaaU+Z2zc76QTARgFJlndgmNcxZB+nDwJ
         mms7MwRtW1xAA3cf8wmMQXVVEVDxHGm3o6gXS5oi4SGlctGP8d8pn5M2JsJxfAKxEWBB
         jnhieDigxeiroFNp53545cqeVlDx4tpPJ6+dRmVk0YqBSlJ7EE0kawtmDHw44s4s9cJT
         UYbjHvqL9LHiyyIbvyTc78/9ztM3AdDu4NEO7lJLoYOAwG3GvIDHtnL1mnEh4fPTI43l
         fQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787080276; x=1787685076;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/oqejPSPmpWq4aveojXJ9NhylWdssz7eILklSEDd4p4=;
        b=pcx12SDSakjZbIB5ZSLtOD/evDYc2kMqXDE8XJzOgXoKu14C/MuEV3H5/4FmxdPaY3
         Sp2U2Ux9NBr9LfSn7n2M4hTuOTAoQMK/R5L1+WnPdoeVvXEdEqAZCWJYSG7Ef1F/67mv
         fS1XSLeToDiPOGhVF7xpurrpnHa4Gzc2Mejxm2gq8I1XFYKKLQ9zO0a5I+iMJ/YjoN25
         039iIPk3jbeCNrjQvQOeGw6zLkt2soGHNV5NmxzALaGEGfNuM+g7fb1fHXC4NeUNT5dR
         mekvEjU0E2bBTeFF6Y9u4j2pntf/iUJYKmsq4hS08Bmr8P6ufG9EbOEZtBtM018rz6cZ
         HvfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr87jp0g2cRf5bO9bThcR5Al/N6mIBrWm7Mh8aHNKbaXMVUmRwgb1zAsgO3uM1y5rw24rZlsFB+ESayrLvqYg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/5CjMuaAAs9tNnmNxF0EtleZcrhcuxyjCwgKBsaMz7vRP69d
	VeSoVlX/9+nTpi+Oj9P6xBRUN/teBLVxGgeFSxC2fT9THBNGzx4vxkJi51MPTg==
X-Gm-Gg: AR+sD11jMNJlby2JnwTR9e/c3VQovybh/PnI7Be725VdqLyDfuHbnBK/3IHySRZxYW6
	d78qSboNEv0NEWI957gV6H7FKh9W/fw1dR2HjzxdNQNvf2zYqjlHLwQ3cXzNjFAmwo43Rc0hqHN
	C5gL+OI8Rnw0pld2LaQeY8bpoggWBKRGsnHdxW5dpGr0Qjs+zvsYLcb7vw6etRkK/tGpUqZnpXs
	/QnFxnbPrd9C/rP4SzJtqK9W6nRT7ckrEoB4gt11VSPUFMQ0T0PVqIaZnJ3p0q36aTyx2DTBQrE
	jfFWXy09zO/fIMwMkY98a8hk/WN1Pg5SwjhrPqgGTEt2ma2j+v9SPKfa0mme+8vnwevBrtuNeNa
	K9krGSmk5RCCunM8VDzd+TbEVuCgcPeVZ4ndcZMbTv0oMTeydFLaN88XpZpcZtjajJzYG1hiyGm
	T0wkLe5+BsWPs10mJZU/ywPABu4OnzERajaJwCfaaWmaNsqs1K9YZ+x2Jf5PMC8wZ3XhSiLxr+4
	/pEUa4EIMTyf5/l6sCcDvkqkNnAO+vK9rJgNA==
X-Received: by 2002:a05:6a21:6f09:b0:3c3:b57b:645e with SMTP id adf61e73a8af0-3ccfec91351mr202234637.5.1787080276373;
        Tue, 18 Aug 2026 12:11:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267c389363sm19530758eec.23.2026.08.18.12.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 12:11:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <83b5d8e7-9504-41c9-9f24-8fce60641de4@roeck-us.net>
Date: Tue, 18 Aug 2026 12:11:14 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt
 compatible data
To: Aiden Isik <aidenisik@protonmail.com>, sashiko-reviews@lists.linux.dev
Cc: Aiden Isik <aidenisik@member.fsf.org>, devicetree@vger.kernel.org,
 robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org
References: <20260818-for-next-lucky7-watchdog-v3-0-2912bd122c57@member.fsf.org>
 <20260818-for-next-lucky7-watchdog-v3-2-2912bd122c57@member.fsf.org>
 <20260818181349.894171F000E9@smtp.kernel.org>
 <k_6CWq_7vPkV72MkyL0wCdcr9ptTffpGOGc6dBLbXjcHBV4DGRzP-35mxO0tdOBaIEhy4BxByYLCh8T5nidgwaMwGcNYD9KCIpxkeF4RRiE=@protonmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <k_6CWq_7vPkV72MkyL0wCdcr9ptTffpGOGc6dBLbXjcHBV4DGRzP-35mxO0tdOBaIEhy4BxByYLCh8T5nidgwaMwGcNYD9KCIpxkeF4RRiE=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 11:33, Aiden Isik wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] Missing PMU counter enable configuration for Exynos5515 watchdog.
>> --
>>
>> --- Patch [2]: [PATCH v3 2/2] watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data ---
>> commit 9ce360e3c933b7447ba5da9ba1b7ae3fee989703
>> Author: Aiden Isik <aidenisik@member.fsf.org>
>>
>> watchdog: s3c2410_wdt: Add exynos5515-wdt compatible data
>>
>> This commit adds driver data for the Exynos5515 SoC's watchdog timer.
>>
>>> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
>>> index e31f93db05096..5592f25fe6c83 100644
>>> --- a/drivers/watchdog/s3c2410_wdt.c
>>> +++ b/drivers/watchdog/s3c2410_wdt.c
>>> @@ -232,6 +232,16 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
>>>   		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_PMU_AUTO_DISABLE,
>>>   };
>>>
>>> +static const struct s3c2410_wdt_variant drv_data_exynos5515 = {
>>> +	.mask_reset_reg = EXYNOSAUTOV920_CLUSTER0_NONCPU_INT_EN,
>>> +	.mask_bit = 2,
>>> +	.mask_reset_inv = true,
>>> +	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
>>> +	.rst_stat_bit = 24,
>>> +	.quirks = QUIRK_HAS_WTCLRINT_REG | QUIRK_HAS_PMU_MASK_RESET | \
>>> +		  QUIRK_HAS_PMU_RST_STAT | QUIRK_HAS_DBGACK_BIT,
>>> +};
>>
>> [Severity: Medium]
>> Does the Exynos5515 PMU require explicit counter enablement like other recent
>> Exynos SoCs?
>>
>> Other variants in this driver (like Exynos850, AutoV920, and GS101) that use
>> the NONCPU_INT_EN PMU registers also pair it with a NONCPU_OUT register and
>> the QUIRK_HAS_PMU_CNT_EN flag to ensure the watchdog counter ticks.
>>
>> If the Exynos5515 hardware works similarly, omitting cnt_en_reg, cnt_en_bit,
>> and QUIRK_HAS_PMU_CNT_EN here might leave the counter disabled and the
>> watchdog silently non-functional. Could you confirm if this variant needs the
>> counter enable logic?
> 
> Exynos5515 does not require this.
> 
> Downstream on GS101, as an example, has this struct member set:
> 
>> pmu_count_en_func
> 
> This is not set downstream for Exynos5515, so it is not used for
> Exynos5515.
> 

You keep talking about "downstream". What is that ?

Guenter

