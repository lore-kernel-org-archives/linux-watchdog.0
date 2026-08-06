Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3540433E8B
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 09:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786008962; cv=none; b=FNCJWUgEbZiMgqVCl70/PQnn4oK3PP1/b7/onWrsAdruif0MYTZ3A0v1r4INXZz9VqSVGpBCSHyPPADH7rqrh6bS8lDo+wwdn/AqnN/XEXMbPemJZvoGWDsUj8UB0zyHCMRxxSvV2kpnhC6/sCvaOxvJ7Ohqnr3LWYjFLSioNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786008962; c=relaxed/simple;
	bh=6MD3/emgMQpVS8+ClfDHsOWmrPdh0fJOMUVPqDJAs+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiINoJJlGKs6ZKak+5SS1Ees3mpWcSXKI4tCJ221t+PqK7i24jJmbdVzYAoDOKT4blYwJ6uYff4EwWnB/okhhIDq+j31wTrK4oPk1XUOsvFNTFB+jNRw61xK+SNqr0p1rr8C9mWo6XUrNGv8wV63dxDyuCZkU/0zjKvUJD9/qXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qzm2g2RW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qzm2g2RW"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so25113895ad.1
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 02:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786008959; x=1786613759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ULE6uDTLXdtM6z8B9L/Qb6Jzh4xJsdCzsVAxM/7Q73Y=;
        b=Qzm2g2RW0dHw5hFtist3+BYHSJsIEl5xUb0g+moYkgtk1O7fFWYJs9aQl1xXzcRrPD
         tIskA6bWsNWj7JbphPJfqZRGvrlaDGutSX2zjtsH0RD3Jve5bZOJm7d8B4hdkMB2qxoM
         0WCUgEzFgNqYpkN/bOK4NWRYM9KM1hy+yFxSM5JhijxKx0qaJ34eHO3PDrTe0X853lX0
         fyyKHRB0iGYPPF19ntZqXpR7HR+akYCza26rWKVQp1USxDAWhnn1e/jLeKHobi4Kl+O1
         SKJufoZwQN5qlwGbww03yLR3J5rkdC87t+WOa9Hg/qDakqZCeyn4scTFWaEWeRg+DuO0
         ecYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786008959; x=1786613759;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ULE6uDTLXdtM6z8B9L/Qb6Jzh4xJsdCzsVAxM/7Q73Y=;
        b=VXQDYNfX2Ymb/QkeoV7vj5H8apIUWFKpXnUv7V6g41vmuJS6CMY7J2M5BNT4fmo+TR
         i5+gFMc+DT4WwsnAVad60O/eXUOrVCSke/Wt4qeyOAmthIeXut7wpjg7JqYg/vTa+ADq
         05qI2hVSUX5/OTaqJHNkeKRq7czBOU5IvJ+++EDC8sTSwbCOOo59wyaMTTtKLAR0v0G9
         JAYckdfg87uMdba2K6ccAGWyL+I8CRrgu9vvwoX13hcbtmVvJOywBY2qP5VklmlHFxvT
         EIrDwJ9NqC/X6C4Vt+OuuhCLfZxa92OBHxuCiaUv8cF/ZkOfpU/+T8Mk5iP/eH2CdZjX
         eQpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrxl95LveYfv9LX3fkyPgHVXiOY8HmDiWJXN4TpyXOY4WwJ9jEyqgNxa2FnBWrVMQ0adkO0PXrFgS+wof/noQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOWOcAHSgM6oXVH2vn+9v5v2jIiABmRCux793LyyRCz1iQCIx
	TUpMi2zO4DVqHfFnuhnIn+rdx18n+BzwgvDNVyjzthHVBuWqrBswI6+Y
X-Gm-Gg: AR+sD10Iy/E33ox3kfipwG4XaIW5rw4czgCplZimNU3VLONhvvS/U6OiYmtte/59shT
	M4y78LSfXYYB99fcxUt9Lll2WB01Gwv7oaaEGevzc/Fyj9LPuROOSO4+Pcf4/6jOTqEDdiwp3Jo
	WRpy/xQv6EECXiudqQV8CBwKr/1RyPVe0+nKNGc5aHCwg1B9erQDYI/pJuUBpeTtWYGmenhqdun
	xbeu/CiX9py+6ygi1rVN/YPohFIWZ/3KWOLbxH5UFZXHDVVq+cx9VhvNZP1wDkgj9YeNaSLx93v
	iHAMxYnpMY9/7A8qyFLEvXZTClwxSvgBuF7PQQvB7j+ETrGOsCQftr0lu/74gjp/2OMbVwr4FTY
	NgI6ocQHucSvv2uZSpuwHc+WQ2qkR48AqMaxIutPrup2lx18MxIhrNSHoZ5jI5XrQxUk4vb7SUM
	AJS7iZK01M9h5qXcYP+N0iIqa0tOf9dVCh5uXmVBW31dfL5W/oGc7IDTHLb+3CWDJsIPIvD7IP2
	iv4CoHvyHGBvYjKAT643Akv+rMWRwsaBDFifg==
X-Received: by 2002:a17:903:2301:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2d0ca7afc9fmr135970995ad.6.1786008958858;
        Thu, 06 Aug 2026 02:35:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa013dafsm28332885ad.35.2026.08.06.02.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 02:35:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <697f8c44-1eef-47c2-8e59-9daa65e6989e@roeck-us.net>
Date: Thu, 6 Aug 2026 02:35:57 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] watchdog: stm32_iwdg: Propagate -EPROBE_DEFER from
 IRQ lookup
To: phucduc.bui@gmail.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20260806062812.26523-1-phucduc.bui@gmail.com>
 <20260806062812.26523-2-phucduc.bui@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260806062812.26523-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 23:28, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() does not returns 0. It returns a positive
> IRQ number on success or a negative error code on failure.
> 
> Return -EPROBE_DEFER from platform_get_irq_optional() so the driver is
> re-probed when the interrupt resource becomes available instead of
> continuing probe without an IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
> ---
>   drivers/watchdog/stm32_iwdg.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index b356a272ff9a..102f51084957 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -287,7 +287,9 @@ static int stm32_iwdg_irq_init(struct platform_device *pdev,
>   		return 0;
>   
>   	irq = platform_get_irq_optional(pdev, 0);
> -	if (irq <= 0)
> +	if (irq == -EPROBE_DEFER)
> +		return irq;
> +	if (irq < 0)
>   		return 0;

	if (irq < 0) {
		if (irq != -ENXIO)
			return irq;
		return 0;
	}

platform_get_irq_optional() does not return 0. and -ENXIO is returned
if there is no interrupt.

Guenter

