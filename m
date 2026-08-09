Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653125B0B9
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 14:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786287246; cv=none; b=c+baPiGGgA4rkC+Y+zrcfLCzde8B9WnyJQ9duS5D7cBKN1fMQAdivenDfl+JbXDRRwW+yXgxPsvDTyfKV/QE6BtsO+mZMn53B04fKey01Jx+hh85UOYOxS0RI901Xw0aDH48w9I7ahca8Bx7JZLufLHgEQu+b5irX8+x/+e5vq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786287246; c=relaxed/simple;
	bh=OO72YdKbYqHE9KvojX92nCxwDmER1p79MGU+ioKD91c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMa3LYNmiVgKT9zDWteB4Y3Pn7ttl9UBHBGxnc9hLDRoRXq7H+r9KN4qLsgBX4scDjhdapK4MZKZsA23W1nY+GxNNbkkdqsgG8FNI0ShFg+Z9pHmVapJ+uyAUysJSwUpD1cDHd/MCy9+AMr85EoFJyYgJp9xRlIqp142kycRDQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hzfr6XUZ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hzfr6XUZ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9aea40d799so480268a12.0
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 07:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786287244; x=1786892044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H/cw6oMGvUHB+hNpkuOSeNVySjC3l8LxiE9FdEJYQLw=;
        b=Hzfr6XUZ2ji45l6jDZCcNVh8S107BVGcL83VuQXm6tqd/4MFNiPLoux5Ag+8oSmHN+
         sksmj1uRHyviEXloSuDY8Z0HKTgXLivUSAIwP5oF66j2xgWwiTYf20D/WiCGl2IXnncQ
         GbNYo+oMfJ18n/iVSJJVop5F2RQ/4imzx9VDG0xY+jktQCRMhgzCfWeVGakvxDb6HAK+
         H64xamY46CRsvJnKbM0kFMtQ7FAD3bfGn6kVW6n0n/kUnngq4CC5cjTMfVBQDlSH7b67
         Jq6b6ozhhdb+PIhPqVkn6R2erfQAYau8w91phrRv8+oJ2efs9cTOgP6g3jP1wJyDApQc
         X65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786287244; x=1786892044;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H/cw6oMGvUHB+hNpkuOSeNVySjC3l8LxiE9FdEJYQLw=;
        b=KamJyQzPM/q/G4wasjfuLqCimExey9gB7fUBQG38UVgt4Yj1iJWqvgoz79XeG0Mmmb
         DSaaji/ttFi3nP4bUpry9/cGpGF64e3fJ8oReNYYl4Z0X6W7xa5Tqfd++uDU9+dHHRL5
         46dvm7Avq/OUTLIYWWZiXqhcRHzYKbAkGVw+NTEKuqyQTGheqMxhnNLTlnMPoeqblzrO
         VASDhDr4b1UdXbUCzgRSjxSER55gV/z3EAgTmOPjTDGqD+yxOx6yq3KzxiFqY6YOv0rZ
         2YbGQMM1QxRg2QXTd0zHvGaRfjlwEmOwa4mCpK+B7yhHHwa0R0OREx7JOy7h6eI5IkZp
         3/ZA==
X-Forwarded-Encrypted: i=1; AHgh+RpWbOEmMO7unfRXRoJMMaXj7dh3Sjw1bo4OEFMOnMUU4+Km8p1qwkKSrOKYyjfbIhOe2goD+TUu28JmmFZNAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1ICxi700gbIEkul7BhCD06iuvoBEAQLg74rRCdsbQygUYW4V
	cXyQDhLS/Rth1bM7Apcp9LqUz+8Qu6Le8rHEVDXhhwuzmApCW2voGlee
X-Gm-Gg: AR+sD13YK2KTgO7VDGPf8wAc1+yCyamFoXCJqawHyHpJpJtRx1csDS56FOJLzSuixhi
	SF0+8tffuOGQ/UD8ZE+GzpLbZ0gK7aEWebv/lHsgxqP8PAtOjownLhwySt3Zl05WhZNbfeIdEAx
	bTXlnDssY8f2jMdjcTu5CXfHtEXDIVNw5ApAynurHVPFWiOgoaBTjyHLQ+vBb4rbNm2dTjdLACe
	HvdPT/otSCZuSfBIYQU0xrAwvOUY6jZqTk3kVQDt5hOyaJ6F7G8bXe0rUv7jjKQOPFqKmeZe++0
	8KnUFniOktJlgWOMY7ST7TseGWNd9Zs5J38Dt9KvXoqlOw+SAZv0FStqlGj/7JMHIPjzi63wOzo
	ArajVtgT0DNYy/Q1YqiXWFbDQ8BDD6cSv+3kJZGp5Z0J3ill8ju3+FsgY4uaixn9dzvMyAJDACT
	qwryCzKwbtSonOYCxX/OrGzHUD33mB6azwOHpS55wm2F7mwJb0mHEqv2ZXsHsAxAwwOcuKoDM0G
	Fo+pXRuoMS4KP3Z3aAUvS2fXsQcSkUQldBRWQ==
X-Received: by 2002:a05:6a20:e593:b0:3c3:fb32:a004 with SMTP id adf61e73a8af0-3cbcea16454mr15497371637.34.1786287244292;
        Sun, 09 Aug 2026 07:54:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e90asm31456515eec.3.2026.08.09.07.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 07:54:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ccd8fd7d-4555-4ac5-ae73-c16e98b8edc8@roeck-us.net>
Date: Sun, 9 Aug 2026 07:54:02 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ
 lookup
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <2eb8b31e-a3c6-4310-b9cc-7acd135b6c99@roeck-us.net>
 <CAABR9nHqKKbxkzBNkENadhFJgC_HuetV+ab7SVsGH+cwbF+OFw@mail.gmail.com>
 <9971b3aa-cb1f-44a9-9d58-4f75f0c6ccea@roeck-us.net>
 <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAABR9nHu4pt-Rg8Aq0B6KfKFHX+C1xQmMk6=j8jq1Zn-MQ0p6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 03:01, Bui Duc Phuc wrote:
> Hi Guenter
> 
> Thank you for your review .
> 
>>>    irq = platform_get_irq_optional(pdev, 0);
>>> +if (irq < 0 && irq != -ENXIO)
>>> +        return irq;
>>
>> This is still wrong. If there is no pretimeout, it does not matter if there is an error.
>>
> 
> If checking data->pretimeout is required here, I'd propose one of the
> following approaches
> let me know which one you'd prefer:
> 
> Option A (minimal diff, keep existing structure):
> ---------------
> irq = platform_get_irq_optional(pdev, 0);
> if (data->pretimeout && irq > 0) {
>          ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                                 "wdt_bark", &wdt->wdd);
>          if (ret)
>                  return ret;
> 
>          wdt->wdd.info = &qcom_wdt_pt_info;
>          wdt->wdd.pretimeout = 1;
> } else {
>          if (data->pretimeout && irq < 0 && irq != -ENXIO)
>                  return irq;
> 
>          wdt->wdd.info = &qcom_wdt_info;
> }
> ------------------
> 
> Option B (check moved out, before the if/else):
> 
> ------------------
> irq = platform_get_irq_optional(pdev, 0);
> if (data->pretimeout && irq < 0 && irq != -ENXIO)
>          return irq;
> 
> if (data->pretimeout && irq > 0) {
>          ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                                 "wdt_bark", &wdt->wdd);
>          if (ret)
>                  return ret;
> 
>          wdt->wdd.info = &qcom_wdt_pt_info;
>          wdt->wdd.pretimeout = 1;
> } else {
>          wdt->wdd.info = &qcom_wdt_info;
> }
> ----------------------
> 
> Option C (default-then-override, only look up the IRQ when pretimeout
> is supported):
> 
> ----------------------
> wdt->wdd.info = &qcom_wdt_info;
> 
> if (data->pretimeout) {
>          irq = platform_get_irq_optional(pdev, 0);
>          if(irq < 0 && irq != -ENXIO)
>                  return irq;
> 
>          if (irq > 0){
>                  ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
>                                                         "wdt_bark", &wdt->wdd);
>                  if(ret)
>                          return ret;
> 
>                  wdt->wdd.info= &qcom_wdt_pt_info;
>                  wdt->wdd.pretimeout = 1;
>          }
> }
> -----------------------
> 
> Let me know which one you think fits best, or if you'd prefer something else.
> 

I wpuld probably implement something like

	if (data->pretimeout) {
		irq = platform_get_irq_optional(pdev, 0);
		if (irq < 0 && irq != -ENXIO)
			return irq;
	        ret = devm_request_irq(dev, irq, qcom_wdt_isr, 0,
				       "wdt_bark", &wdt->wdd);
	        if (ret)
         	        return ret;

	        wdt->wdd.info = &qcom_wdt_pt_info;
         	wdt->wdd.pretimeout = 1;
	} else {
         	wdt->wdd.info = &qcom_wdt_info;
	}

(which I think would be a combination of B and C) but ultimately it is
POV and doesn't really matter.

Thanks,
Guenter

