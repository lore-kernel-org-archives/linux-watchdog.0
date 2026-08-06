Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8163DDDB3
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008662; cv=none; b=WrvilXN4IqH6HmQtTedyDkapkgs/uDLFsZq4y5ZVmNfQlzhYPSRB9G92GDkTWKWH915Wp03RY+xJej39hwJbFpBsJIC3vmRFNf7e6Ubf14KDTnWx32SKkmEOxSTcHe/cu3Ll641ogyyuUz2zpsTk7C6n2he4D4s4fk9dUQtTIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008662; c=relaxed/simple;
	bh=3ecCmNLJ8Yi+N6zUxh62mZZdokLubRXFZjgWA8YZZPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ags01dTwwDwt2gQGbSvR3f+7L/P4U1U8K3RVHfgJNjcYmtjy3bzac+b9EHnnYJz1/NjIa2ZY8k1lzbB88hvJFvHfUwPrmsBTjuuUVf8cORwF2lO97lk0cIcsP8s7P5BeXON7rjTrbK0Nz2+TAneKxDA5ZrFsCYwaOYEMRiE3vgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lgqkwdzj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lgqkwdzj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccf2360620so19394695ad.3
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008660; x=1786613460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8hTyEaOgmS03aOgKculGs8mBdlQjNfVXusZZmOidICU=;
        b=LgqkwdzjEBUXJXK1AxCdnrX/WRZ8kzbMSHJGZSS5bDnpOdmaApezv6SlRvztwRHKnL
         c077eEgTtTaqC+UDMyNJeryV/ov/tDmTeAG7E/gi/4ZxUbm5WZKoE1S5i1MIPqchQuTc
         TKKg+2uqmIBf7UHp9/tReNlTrAEhXyYaDvrhMvoablVvjR1/UeGdTRSktkf+AUxSI9hg
         fhuXCy8bsCIwP68QrTD7adtRtHvEUX9YpW7FOG0e6TfG1s5Jvh3W6f53iwA352mYCBjj
         ifLSYgimRbhcra1iu8Mmkb9gukuZnD3nCaVXuqym9cmVc6n5dWqwgPjMkOlQWHoDuwHb
         2dJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008660; x=1786613460;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8hTyEaOgmS03aOgKculGs8mBdlQjNfVXusZZmOidICU=;
        b=evgp9JHwFZ1Zam49DLbXc2UgI5uV7IBr7JOamwInQRVjtW08guFc/qTDCScPAHUTuZ
         RBmAibcvEM1opvi/MnKRcS3cxeeDAvq4kFUpjtFQVu2fIdaH2PQDNaMr06u10j/i/JIC
         WIv/2Tw5VKv3VFax5nzA0xqvwsdJdPyHaBHRIGFd5tbeAPyoNoxK4gc3cIrmrwf2uaZ9
         EIrdZQOE6+2X2SWelJjHnDgnbRSIosGCNNwlu8tdoPkrA2Bd070Y+KOll18RPGjGIYTo
         Zcse6PZ8g+ejthMfgoGY45d2gMLxXn78KzufR75jlaMfurwSj+bXFgDOGNsrTBOXaLp0
         /uIQ==
X-Forwarded-Encrypted: i=1; AHgh+RomgNzDgTVKcZVkMlmEV6Yvp1eWRVv1RnMMzJQ8hQWkvCPJoYY0PX7VsPUVlRdMpLrIwKuoZOJSi8IMBLVxDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OyEis57LNZpHhSz9c2YitvJkSCw4OvbN5g4Chb+q3HGAWADO
	1lpy2qJN68m6M2EqyiEsRhKmYY5cUKlH1lvN2VRWH36IvfvA1wJpuCk07fBwjA==
X-Gm-Gg: AR+sD1280nYl/Lll4zf10yJkHEECw/Grl9ejdKSDHHYUXThQqPUJoY2fNzMxGvsan5I
	6ZspN2VPzPQY/ljPU/aQmkJVmha5SGNPdNM1cCY1+ZykH3Sw1RglqmLZgv1wyyeU0Nz8cBwopV1
	0Us45w2rBA46RFDu+usDm4l5pKLuo0+uTP5VNr48akIu/K7DdMBPdVLesVw4ghhboFLh1jv11aP
	GdYm2dy1rw5g1597HI1u4ieX8BHaT+bw915Z89wjbYfath7IVQMo7LIgORBVHAh07gViCbFQclk
	8e1WF3/eutMoAF0UaiNdrzcTcArvvUezXYJvb7al0DE9u6IU85O+61JsdyBRLNKnXwX0XJXDU1q
	nFimfbS5JT1YmjkZM2ZQ+07FWvjsPWzR3wJqmREp5J+PIIQYuOFCnr33W9vaKbj4/FiqPvv7eIh
	RDugtvMMnM3DJR38qgJRSD9HSjw0xwr0FiKu2GlYThpVayCIgD0N5MR9ANZqStKB3NEL4TXXG49
	NenO4eJNwJ7w0rjFuPccgpTGAjbDGm3p33za9tNlmmqg5hs
X-Received: by 2002:a17:903:1847:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d0ca711befmr157043905ad.1.1786008660019;
        Thu, 06 Aug 2026 02:31:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9ff4d61sm29662205ad.24.2026.08.06.02.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:30:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <81cf90a0-a966-4cab-b5ea-ceb1d241fb3f@roeck-us.net>
Date: Thu, 6 Aug 2026 02:30:58 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] watchdog: orion_wdt: Propagate -EPROBE_DEFER from IRQ
 lookup
To: phucduc.bui@gmail.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260806062812.26523-1-phucduc.bui@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260806062812.26523-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 23:28, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Return -EPROBE_DEFER from platform_get_irq_optional() so the driver is
> re-probed when the interrupt resource becomes available instead of
> continuing probe without an IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   drivers/watchdog/orion_wdt.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 0e145f762f6f..8595073a8179 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -606,6 +606,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
>   
>   	/* Request the IRQ only after the watchdog is disabled */
>   	irq = platform_get_irq_optional(pdev, 0);
> +	if (irq == -EPROBE_DEFER)
> +		return irq;

I think this should be

	if (irq < 0 && irq != -ENXIO)
		return irq;

Guenter

>   	if (irq > 0) {
>   		/*
>   		 * Not all supported platforms specify an interrupt for the

