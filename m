Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4D2E764D
	for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787780305; cv=none; b=T+n0LhKMOoLKDc1cKtH3Gyvyc9hX9vioDEY/LjxSSGg8//qsNPQIKRax+8fqp245I0whYMFHh9nzcWjo79zVFJvLlzJUipqe2/6gHdj9zxe2xYykiQdOchdjjY8evcBifeWrS0vIBuSSXtHmbepPOI1YZPG3yrAWGPEN0+kR+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787780305; c=relaxed/simple;
	bh=KJxiocFFulx1gyvaIva7hCGCdkW8RxYUKtNlSyCVR0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bg8Sjx3MK77FAR4OwLYc60zWxDgjIAvZ730diY4LBTFocfS3wP6mhKF3LKY2uTY0ECUga2SbuTUxhAsB7uRf3YnkkQcmgIzbKF5MLONcoN06mMq2ogfjhCNFA+fcipaUSf/tXH0qB8YFlOiKyhKq65Y1zz5w9IwOSKCtewvY64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koybN7Lu; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koybN7Lu"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-39266382df6so252a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 26 Aug 2026 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787780304; x=1788385104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8v0eLC3lqB1O4ht8TaGs8/rxS1/v9Xyd+T9SvWAlPQ=;
        b=koybN7LuCr1n3WDJ9E2hM9hYNYhUxkq0iYBKkKne+dd7l2ukBS5q09lUEzfL5x3DZh
         znyJhVsrRWSV+Zf9LA9XTDNlwG+U36vNxhVpTOFEkPlNa7NCRq2DyxnJT5eLJvBM+960
         yEZ5lL8yU+EKUTQpWN+zZaEcHYXgdT+hIGE3DPRrpazNmIeIp2HVICaVNF+Zq2tJauqF
         63200MngAlUndqee6aWGfOSbHQvUr2APm2EPDVv6iq1lAgXNyvzPOUkKqVbH0eQoOx4+
         f5ZJ6GCumS1nEJKyPgIAtCw192Ci5wVR/EBQcRk2rc9IOXbXBoklNvDAmRuDsieSPdHr
         fKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787780304; x=1788385104;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D8v0eLC3lqB1O4ht8TaGs8/rxS1/v9Xyd+T9SvWAlPQ=;
        b=rjrNNwhO1DFSw+6bDWfdwp2vDS/QmDulhA/pl9vb8XWU3/RH1DxUUfdgTrMq/XIPkv
         AvzJMfQtzYoFNSsJR5LlW0X8oFFY1kW0QpNc/ufUhNFfP3jnwNadDsrHVmi2SC5YB3PG
         7+KGhozdbOhefDijN6EB8yX689uYmZ4+hkdgPhVCmoZi5pcUZKDMeW+Dc8DvlC5Se8Jy
         DgxpURR8r3gS86vW4L85POMmNd5dMrvKrrWPfyf7g2R/ZqHxAbFPtRQqHjYOD0VNIBmf
         C5kUEhxiuAbdUTKO0umxQ6aDzWON4BPi+gD9EHdbCUc3j0GSw4wqDCEGaFZFSP49wxLN
         5/SA==
X-Gm-Message-State: AFuF++k2JGT7qxaHzhnaZCqlwmOHVvG7gBll/BSNrXTsm04c9GSGSrT/
	dmRLHKdaLra6p3fpuZsx/1YdReINunjphJ7EHXH/AFcWjoNUp678Ig0B
X-Gm-Gg: AR+sD1011WS19FdGWJldXCgGay4VAA6qPP3RcY+mFh525jRgm2rVUNVxLiTFvXmKgbf
	dOw/Cwc+UUwFcs5iai/V/grUYNxn3pj+ckiqXNRyIOOYzxD/4zb/M/sRzp6SbiUPlfP3SrDss30
	qBuQXxqJxOrgVE/Hv+pcM2XyLwNqcIikvMiP6I/9qTvwm8nEYhdf1n+EeQe1qSohRBdER8fUdgU
	zSMJ2+1emv4OhyryByMXLxbVkMz+82pkAItfvKPGcIwF1dK5U40olaOoGTuqLp1MHeV5T3BpMfF
	+MzuFYZN7uqHVJsJifVVhPv56pVA9FQyUcszQmKgIjp0kh9htz1qGwijjY5ArSHJBONuOnMsmVT
	CSN3SDDgD83gP9PiFftnauB5xcYLoJf14CQ0+0yPC/O0zlN615eoW4GVsHs0b8/bUQcXB7+vt4M
	KytzF358tKGjCYKRYhfpDzSmITjcdQXBhLi6vdG736OzPOkCmVLlBpUc6LzpqeMqGyoTfu3/wLj
	nBnvQ54BfeIjr+Br/LHnI4FUtpmDCLipQy2nQ==
X-Received: by 2002:a17:90b:380b:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-3966d002fffmr19304395a91.0.1787780303532;
        Wed, 26 Aug 2026 14:38:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396686e8e74sm5737255a91.1.2026.08.26.14.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 14:38:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e942dc40-891f-4612-bbbb-2ff41fd88a24@roeck-us.net>
Date: Wed, 26 Aug 2026 14:38:20 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] watchdog: keembay_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
To: sashiko-reviews@lists.linux.dev, Triet Hoang <triet.hoang.dev@gmail.com>
Cc: linux-watchdog@vger.kernel.org
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-4-triet.hoang.dev@gmail.com>
 <20260826061737.EF6B91F000E9@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260826061737.EF6B91F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/26 23:17, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The driver uses `pm_sleep_ptr()` for the `dev_pm_ops` structure pointer in the platform driver definition, which violates the strict subsystem guidelines mandating `pm_ptr()`.
> --
> 
> commit a755ace210f3814431fd01a8ffbd96e121f18dda
> Author: Triet Hoang <triet.hoang.dev@gmail.com>
> 
> watchdog: keembay_wdt: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
> 
> This commit converts the deprecated SIMPLE_DEV_PM_OPS() to
> DEFINE_SIMPLE_DEV_PM_OPS() and wraps the PM operations pointer with
> pm_sleep_ptr(). This enables dropping the __maybe_unused annotations from
> the suspend and resume callbacks.
> 
>> diff --git a/drivers/watchdog/keembay_wdt.c b/drivers/watchdog/keembay_wdt.c
>> index 2a39114dbc641..9424ea4155f07 100644
>> --- a/drivers/watchdog/keembay_wdt.c
>> +++ b/drivers/watchdog/keembay_wdt.c
> [ ... ]
>> @@ -285,7 +285,7 @@ static struct platform_driver keembay_wdt_driver = {
>>   	.driver	= {
>>   		.name		= "keembay_wdt",
>>   		.of_match_table	= keembay_wdt_match,
>> -		.pm		= &keembay_wdt_pm_ops,
>> +		.pm		= pm_sleep_ptr(&keembay_wdt_pm_ops),
> 
> [Severity: Low]
> Is it correct to use pm_sleep_ptr() here for the dev_pm_ops structure pointer?
> The PM subsystem guidelines require using pm_ptr() for dev_pm_ops structure
> pointers, reserving pm_sleep_ptr() for the sleep callbacks themselves.
> 

The use of pm_sleep_ptr() for .pm is widely used in the kernel, but at
least Sashiko's guidance suggests that pm_ptr() should be used instead.
Please do that for .pm pointers.

Thanks,
Guenter

