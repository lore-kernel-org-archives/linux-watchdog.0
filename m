Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC93F825B
	for <linux-watchdog@vger.kernel.org>; Mon,  6 Jul 2026 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347258; cv=none; b=W55rnA/6DAN3n2fZlZVoNCU09I9+Wp8Qo6oNfOqiH8HiQlaqEC9dWU6wuRTDLavyVvorTfKkyHAGCKrTmU6NoyXAM77ZXl9DdjipueyUC4urVNCHF3gzRYSWw4juSjCRIx+aQ5ocXdSDgwykKvbnouJ6g89xT9uW7LzwZOVXr0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347258; c=relaxed/simple;
	bh=9z89FMGjVmFK24VDWzElAxMtI8ZB8CNBDIlQMYVNatY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AJYuwjhWFbg1V8QHsFZFJgZtkaXmxC00KuGLNT1JtM04lnKS0ccsXRX1jLxHC+jE5IvHRT+/wB1/pPmx3wWjIUcgq45VwoZvToVgz7Qg4cGkVEa/p0pA5TtOPG/Gyu8Ca5qfFQoiRfq7IBjExjiMspbWl918jpwv3zgRTxAJ5Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRss2YHN; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRss2YHN"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383adaa461fso1419009a91.3
        for <linux-watchdog@vger.kernel.org>; Mon, 06 Jul 2026 07:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783347256; x=1783952056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ecbU4NfavdIpgG1AgTSd/pVLxZtxLRNI50aGbnUwuSM=;
        b=fRss2YHN+qBe2uljV3IIylh0ogKvwIaqJXpYlkSRcHBDRAMyfQiEPeX/phgHAWihjV
         EZD3+fdcPsAAZz0TKwb4LU+lzB/o07yE18wzYZM1eVhCHlThUI6GvZtR3EFB8mgK1N6t
         N8kVGOcMVGZuwP++mF4OUOkLnryi2UnvLV01We04X8DiR2wG1ejNHjDsUD9NQAy88aKZ
         8Cp8O7n1BwGtDZ/zl+67mvIXsx2Ulg9Vr7l7PsURySEnO/yjRNBhXM9c8UuCjdzuEteJ
         /o2RWGzN4YHJJdtEX94Nomt6cMK/SMNHBMa8GSTd6nPHnzftv86tfDEEXBawoyDlLMqV
         JzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783347256; x=1783952056;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ecbU4NfavdIpgG1AgTSd/pVLxZtxLRNI50aGbnUwuSM=;
        b=BdzdjSCAnYc/V115L5NBSQoDZNRAHQTG3LDUf9BBfbR3ssqDYXhL/QWvSZKfWRV2cB
         u7N1flqV8fC4DvZxTUCSiVBeB1kJLlQTrdPqqvcTSgeGfKThLVdnQEi5DdZ6K6QKczcF
         thGQfx4vid4oCXjjgklcUQStyKZkASEj6Mst5rbkKEBNrXa1VGhCDN7GwwYsJv/gLEQx
         ui9EJta0fAZl0MLiIzwa3uzK4lgsYwOhbGrk5zpI7vy9v3+e9+anu5RchqSfA87ztQ/6
         9/1hWTuWPd9o3pwbk4cgJxcZwbSKQh8gKXU8mnVhCCshK8AwShWa7XsaTnyYkr+66313
         Bb0Q==
X-Gm-Message-State: AOJu0YzVWfocQwlUZuItaCjUuaWZiJa6AV9avFv0KPOkLq8GCEopuB49
	+FJ/MCAUp5IWpGtaC4vzqxLM/l5JmjN7Uf5JfeEjCFW90cV4/YaOfznH
X-Gm-Gg: AfdE7ckDToUbFcsHD0SL+l3YlmqWMdHpoC0K5yTQkr88g5Gg9vl5C5vrJgSOA63Pzzu
	KgeKrEQnyocWaAXBY9KXCzGtocDDCzieuZMDCdYVGwVDZrWc4udL5RMi/qGKllCX/vaBBNswRKl
	+3wC2JZ/m04QZDETz8lG/jP0O5yYMqMpvgKROfx7iluBEIySUMl+LxvGOx/UnxIGzQdwS7h7A27
	VAII5QKavuXjhCMzNukE5MHlVqB42KT/gFtOqefy2JHyPI/J5GYwFg3nwBmFvBnmWerCyrhigCu
	7S2DYCF0iojII5VcyQCTC5U6nZf2V5e46MdXX1OIpTWZNWfqA+53cU1bG054+hG5sAH6QSe3/Og
	My+DddBUahHNh8plVLgw2KpXw0f2wOMsNmzOm7riC7cumjVknJ+2sRwsGkRcsIKgFuCPkz6fhLN
	sd5DvpasPVomnjS0i0xfpH6fPO8HMkJrCo7NrOUNqWlS5dOvWiuHSnTmArNbCVsQ==
X-Received: by 2002:a17:90b:4f45:b0:37f:9cdf:f039 with SMTP id 98e67ed59e1d1-387572b4606mr577007a91.28.1783347255988;
        Mon, 06 Jul 2026 07:14:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c3bfbcsm5271321a91.8.2026.07.06.07.14.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 07:14:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <22a92049-0ff2-4ebf-b286-1e1e7ae9b3cb@roeck-us.net>
Date: Mon, 6 Jul 2026 07:14:13 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] watchdog: w83627hf_wdt: Add support for Nuvoton
 NCT6126
To: Paul Louvel <paul.louvel@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20260706-w83627hf_wdt-nct6126d-v3-0-fa5ad8d486bc@bootlin.com>
 <20260706-w83627hf_wdt-nct6126d-v3-1-fa5ad8d486bc@bootlin.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260706-w83627hf_wdt-nct6126d-v3-1-fa5ad8d486bc@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/6/26 03:29, Paul Louvel wrote:
> Add support for the hardware watchdog integrated in the Nuvoton NCT6126
> Super I/O chip. This device is used on a number of x86 single-board
> computers and is compatible with the w83627hf_wdt driver.
> 
> Unlike most supported chips, the NCT6126 shares the same high-byte chip
> ID as the NCT6116. Read the low byte of the chip ID as well to
> distinguish between the two devices and identify the NCT6126 correctly.
> 

Doesn't that (and the code below) mean that the driver already supports
the chip, only it identifies it as NCT6116 instead of NCT6126 ?

This means that the commit message is misleading: It should say that
the chip is already supported but misidentified, and that the added
code helps to correctly identify the chip.

Guenter

> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
>   drivers/watchdog/w83627hf_wdt.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index bc33b63c5a5d..a6dfa9d01702 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -49,7 +49,7 @@ static int wdt_cfg_leave = 0xAA;/* key to lock configuration space */
>   enum chips { w83627hf, w83627s, w83697hf, w83697ug, w83637hf, w83627thf,
>   	     w83687thf, w83627ehf, w83627dhg, w83627uhg, w83667hg, w83627dhg_p,
>   	     w83667hg_b, nct6775, nct6776, nct6779, nct6791, nct6792, nct6793,
> -	     nct6795, nct6796, nct6102, nct6116 };
> +	     nct6795, nct6796, nct6102, nct6116, nct6126 };
>   
>   static int timeout;			/* in seconds */
>   module_param(timeout, int, 0);
> @@ -94,7 +94,9 @@ MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time (default=0)");
>   #define NCT6775_ID		0xb4
>   #define NCT6776_ID		0xc3
>   #define NCT6102_ID		0xc4
> -#define NCT6116_ID		0xd2
> +#define NCT6116_ID		0xd2	/* also NCT6126D */
> +#define NCT6126_VER_A_LOW_ID	0x83	/* ... version A */
> +#define NCT6126_VER_B_LOW_ID	0x84	/* ... version B */
>   #define NCT6779_ID		0xc5
>   #define NCT6791_ID		0xc8
>   #define NCT6792_ID		0xc9
> @@ -217,6 +219,7 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>   	case nct6796:
>   	case nct6102:
>   	case nct6116:
> +	case nct6126:
>   		/*
>   		 * These chips have a fixed WDTO# output pin (W83627UHG),
>   		 * or support more than one WDTO# output pin.
> @@ -428,7 +431,12 @@ static int wdt_find(int addr)
>   		cr_wdt_csr = NCT6102D_WDT_CSR;
>   		break;
>   	case NCT6116_ID:
> -		ret = nct6116;
> +		val = superio_inb(0x21);
> +		if (val == NCT6126_VER_A_LOW_ID || val == NCT6126_VER_B_LOW_ID)
> +			ret = nct6126;
> +		else
> +			ret = nct6116;
> +
>   		cr_wdt_timeout = NCT6102D_WDT_TIMEOUT;
>   		cr_wdt_control = NCT6102D_WDT_CONTROL;
>   		cr_wdt_csr = NCT6102D_WDT_CSR;
> @@ -499,6 +507,7 @@ static int __init wdt_init(void)
>   		"NCT6796",
>   		"NCT6102",
>   		"NCT6116",
> +		"NCT6126"
>   	};
>   
>   	/* Apply system-specific quirks */
> 

