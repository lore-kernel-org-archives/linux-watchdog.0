Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C39C3CAE8C
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Apr 2026 11:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776857502; cv=none; b=UT9BL/GRh/ewfICma5x1rV7Z89uM7OPbl0Icwe4U/fE5j6Au4yh1e+/7JbwnnKrGiihvrwk87W7L8eIcSAFUJ1PjsWtqr29kp59iX4rAxj6paVabpcayW3IejtC/ba8y7ClB69hAdQ0pz8twTAQIm7YBjl13ychRf6pwt9ISsZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776857502; c=relaxed/simple;
	bh=dxWL0oIs2O0hHphSdyrBQaIDlz0zLBnPvixdL6cnuzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hAy95HBgSsCiilQMAdtPr+fRKij01EBLEtqCF7Y9u00r8ZrArURdYQWxl/iPtkqArAq729KVUkTYREiLsKEXq9LUcR+lkxXRYpStCqi9OhnKpS6CUYw4sjM96NfDfvb9fgOjl68NcdYWTyveJP1iBdgTwsRdrGCJHMH1sIRuP/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIudcK6R; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIudcK6R"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2d3a9e149so29582245ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Apr 2026 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776857500; x=1777462300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hkcKKzHXhDt0QojfD9JNtY27MSNR66ERsxzTA9kHdc4=;
        b=FIudcK6RP22Muizhjizeoor4rQtfoPiK5WjaCxZa5aO4VWD6TkWSPRbgMbziByP8Qs
         m59jgqvqJJ8rOsd6huHGRxATXiorGCSNTVwFvVmKr29OrcmwbeIvcCkWMrZLzp6KkLx2
         8gNB4qu0rwfyLlWVfRnr+DkKnPhZRVWrZcQ1Zhn5UjRQyegViujY3Wrdw+h+yCqTmByq
         q78EUdwl6HArnrq+2lj30ysZhCBUJd/aw53JHdKSeyRqUINiLFHMbpGToiUUitEgiJyl
         NVlnT2aK7jTVcFCeKC6+L+LEKfLxsctbit0iJyMJxqAs5gY3tNtj6hp6EXNp2/OR8dGE
         zM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776857500; x=1777462300;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hkcKKzHXhDt0QojfD9JNtY27MSNR66ERsxzTA9kHdc4=;
        b=p0qWW1Z8I7BvC4NcaKOIvoi0fLcGnN2zuuydWJ4eZcMR7nyAkbS8NCIXkIBPjx9C2n
         UvpI/F2Vql1R1nbE/dhG5vhVCl73r+bbw/jqr22ipt7ganFxcxyqfJRy4oXeBo0Uqs2v
         FORUaFGciZ8ZaY1j/jBnIE0SzP/2zDHSNTobYQ5RAci4F6flvRns0DyvP3lv643oX71V
         n4WAHMUYX7eF/bcwmf4Op3sZCoiMgyCkMIkRrDBYu8GjwpA02MxWOF/Ny/afWyrig0vE
         xsGaXq/j+c9FKT53Mwt+sorNYaJJq/IEOgxaBQm4r8YddrMQUicrB3+c+I0Sj411HNIM
         01cA==
X-Forwarded-Encrypted: i=1; AFNElJ9d9ah33cUZDPA7Rzj1vayUGxwbJLkeNnyPIxuf6QM4c+2aLoaL3pQ5BqO3Vfgt8fMrnbpKzjQES9TGU8Lp+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnzIasq2acjkDzza+voJKHz8h84JQvwU+Nx1g99g34nUb74D7
	q40gsZOwcPTgSaxNFUCaeA+5ta6nrQxqZ2/yUODX4Y4WcoNoBn5ayUJB
X-Gm-Gg: AeBDietD6VSjP8N6otYxRAvtSBwt3FwMMRq3zvLkIANmixuTQdrGqo99kEegzlquAy9
	TG/gEoW0APUBhXkQKoUhBcd2BG19QDZSwYTBLgZ6roCEgCYvUCcIuOK4lf8H4r5AILEOwxYY3Ct
	8cibNhSmHPuu9hqOKbRdi9cgQUElpPt4cOAa2dECg2YOqpHPpw0rzT9RTifEpZBpiB0ImCAb2uz
	hAGh7GQ+8urFYZTripetWdLjdRx8CqH418MfH3gePQMJ5QHkNwgVPvAQVqJKLzKLjPYnW0BtNlk
	TZC37HP4bZARSd+t2f+wHZ7ZsGO6Zfo+np3e83Y19LvwOD7pWq6WuyIYP8EsdGD/o3+uQuROkj0
	5cge1GYjYfOV6T+2yez5oyRWSrgFGaCIrSuNJIVa4k2awnTGwbElgOagPxAXwQJnkRqO/3G7h5K
	gRX8/Ha3meneekKAck1WfEV6KPOLFP9CrtC57fcUs90Z/3saqhTKI/ZT1MCQes/HSaxtjjVMy1J
	gTIrzvLNGgO1CZtW1uGhw==
X-Received: by 2002:a17:902:c94d:b0:2b4:6597:44d9 with SMTP id d9443c01a7336-2b5f9df28fcmr197558055ad.8.1776857499746;
        Wed, 22 Apr 2026 04:31:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa494e1sm158588085ad.35.2026.04.22.04.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 04:31:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1ec664e3-ecc4-4773-90f6-36b0c07ee7dd@roeck-us.net>
Date: Wed, 22 Apr 2026 04:31:38 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: qcom: Unify user-visible "Qualcomm" name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422082736.81981-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260422082736.81981-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/26 01:27, Krzysztof Kozlowski wrote:
> Various names for Qualcomm as a company are used in user-visible config
> options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
> "Qualcomm" so it will be easier for users to identify the options when
> for example running menuconfig.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> 
> And "Qualcomm Technologies" has even variations over the tree:
> Qualcomm Technologies
> Qualcomm Technologies Inc.
> Qualcomm Technologies, Inc.
> 
> I am doing this tree wide:
> https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
> ---
>   drivers/watchdog/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index dc78729ba2a5..2d3b404aee7f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -882,7 +882,7 @@ config TEGRA_WATCHDOG
>   	  module will be called tegra_wdt.
>   
>   config QCOM_WDT
> -	tristate "QCOM watchdog"
> +	tristate "Qualcomm watchdog"
>   	depends on HAS_IOMEM
>   	depends on ARCH_QCOM || COMPILE_TEST
>   	select WATCHDOG_CORE
> @@ -1093,7 +1093,7 @@ config SPRD_WATCHDOG
>   	  by Spreadtrum system.
>   
>   config PM8916_WATCHDOG
> -	tristate "QCOM PM8916 pmic watchdog"
> +	tristate "Qualcomm PM8916 pmic watchdog"
>   	depends on OF && MFD_SPMI_PMIC
>   	select WATCHDOG_CORE
>   	help

