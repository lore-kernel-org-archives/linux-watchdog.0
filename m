Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D0536B07C
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218725; cv=none; b=ZSsCvsr4XjdGlthS6chDrRAlcKueCoisihc8fQ8z2avijUlBBFYOpOm0jmorVR2jX3U9EDmqZr8jiyVzPpv74IU+kEzx2fkWlcCmy9FuxKtaCmTBVUe1ASHCZVU990mzftZVrjbKv+Nw0wVPugPr3N9SmPUbxFP9tbVe2S5MCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218725; c=relaxed/simple;
	bh=iM0TRDOcy4l8reAEAOUMbxTxW74flWhUvDhCdwEmvjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ssEgM01nhMWuO5ZclDe5Lu7fqb5B1UNjHJEs7VUlH5O9Z2X79Ew4CmV2VGQzyqYewarfrjnW0ywMX+2RGGcgC+MREKaW2AO7QK1QMCJe3rWRxh11Rf3MfN5ZOYXqU12vlh5aRG+pCCUfHlBv4SRrLrAzR6SHcM4Icly//CzHI3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYVqi+S4; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYVqi+S4"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f30a4601bbso3763727eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 12:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779218723; x=1779823523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmis+mS3qmz0gLYPzWgL/CSwMvzFgkyxhS291aPc6DQ=;
        b=GYVqi+S4enuAiqWSZ7+Z8c+BvpQIcD7yjDz0r23pCvxCsl9mqFmy1BnQF4ZnpKXJcQ
         2gYVsEW5+K/FeXMag5iT1F7qZY8kNgUW3cFD1kDVbjDAWAj7Q1rsIBtIwhCiIJWZmhOQ
         JDIBGmKw/ikb2MAbgmnSW1s1p4lt7rSVXQ4ov5qH406AZVx+dQmdQ3YJlM8pzf+R1F0B
         WjwvCMPUX0HpK2IG91pTT2vCzVrEHK/PrTOVJCzWDq5XvZKMk0Ib47EC2ofvbVzp43Ho
         lSk5Av+0/NP6BCH98FIFRFlJHa/TpQhJ5IoGeJ2uAjYKVMCjbirWXMYJBJSYoV3fDWHJ
         M+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218723; x=1779823523;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wmis+mS3qmz0gLYPzWgL/CSwMvzFgkyxhS291aPc6DQ=;
        b=sne4sNLqeS25pWKPsBA8I+lWoW0c4F19R5e6dMzJ9Wbz7nDEPn1kn8zCsRLubNgkMy
         XBKIBqcuhlGl1r6XFcGLQ4NnX6bgTnN+exjZaKn38bWzZIUKLpe5ESknpj+nsDEZAkVL
         Pgg3HLRfJV2RUJZ4TQ6DcgCQLyrs35Khfg6FAeqQobIwEA95IUhrPRXbLKxgwq9WI1F6
         vOrbL+Fm7Ns6eh1Stcp7jQZmqGACy6yjASoYS8vskku/Ff/0zow/pfQD4LzV+2QPfgbf
         Yhx9NVdRjo/4ulvy16Ljjxkiet2M8sURuHYME4j7K4usPfbGDjuynlGxBhkoktKHvLu0
         DUVA==
X-Forwarded-Encrypted: i=1; AFNElJ/gBJYyT2l33Y4f9MqFpf60GPoPJ0V/pBH5xYpolCpBHQw5xQK8K0GRzvd26J1fRhcIcZoXgnJ9PqxOgdOvSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVwm/uBSDyUdCpmxYrnJp81LYcmsyHiQ497OBeujmVIKZH1UZF
	mdW7a5hDhNeBaGgwOaxVXTau+gLzWjs5HkaIFiV8O9gEBsGt/exGq8nL
X-Gm-Gg: Acq92OEtUXqsl4uIi0sBQvp+xUafZ96JW9k/9oungplsTYwQUQYnMCsGe0tEHQsuVo3
	az33B7w+FP/kVkcwUZeoQ5H7xLRWjGj9OFT04cTfqoOHr5semqdz+qRYkSwO4tbkX9qs6rEqva6
	CZD46pYOX4B00RE6o+ua2jFiGc3/5CMFn1zYx0S6SqTrvwKsbsLnke7vvYAt1Vpo3KhjgnffmE6
	he8eUdDTfJw0nRoaBX+FrU0zJVMcrb7IZmuRUUBrYt7iMNCvG5g03bFSvokjrNr8eKvmogUdbyV
	G1ofkhMEi//L2eQC51rwXPDcVJGjgcN3FUu+KKQ6pgzKMqxqcHUOhLTtlSy4j1ovwFPtAJFXhkV
	adU0nrLFsnp/exeC0aYojmD56kUjaoq3jxKsDuUqz6gb4PwAzjDTaBynad8s0Kpk3ti67vTIXV/
	lruAiG1REYujDDP5MYJi/5cVfAa0jWRAd93sKCXDp4D6GCm7e8+Wh/WgquRK1CgFb5kQsHvU5Qf
	NTEIqvGoac=
X-Received: by 2002:a05:7301:608c:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-303984edb2dmr11587065eec.15.1779218723211;
        Tue, 19 May 2026 12:25:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm21770601eec.17.2026.05.19.12.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 12:25:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1d5091ff-e497-4b5a-a906-7cc02c31c4c0@roeck-us.net>
Date: Tue, 19 May 2026 12:25:21 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] watchdog: realtek-otto: Change to use regmap API
To: Sander Vanheule <sander@svanheule.net>, Rustam Adilov
 <adilov@disroot.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260519182329.24472-1-adilov@disroot.org>
 <20260519182329.24472-2-adilov@disroot.org>
 <6ff773c9cf93167fbfcf5d9a40106121f9ac8238.camel@svanheule.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <6ff773c9cf93167fbfcf5d9a40106121f9ac8238.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/19/26 12:00, Sander Vanheule wrote:
> Hi Rustam,
> 
> On Tue, 2026-05-19 at 23:23 +0500, Rustam Adilov wrote:
> [...]
>> @@ -74,24 +75,17 @@ struct otto_wdt_ctrl {
>>   static int otto_wdt_start(struct watchdog_device *wdev)
>>   {
>>   	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
>> -	u32 v;
>> -
>> -	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>> -	v |= OTTO_WDT_CTRL_ENABLE;
>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>>   
>> +	regmap_set_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
>> OTTO_WDT_CTRL_ENABLE);
>>   	return 0;
> 
> iowrite32() doesn't return anything, but regmap_set_bits() does.
> 
> You can turn this into
>      return regmap_set_bits(...);
> 
>>   }
>>   
>>   static int otto_wdt_stop(struct watchdog_device *wdev)
>>   {
>>   	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
>> -	u32 v;
>> -
>> -	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>> -	v &= ~OTTO_WDT_CTRL_ENABLE;
>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>>   
>> +	regmap_clear_bits(ctrl->regmap, OTTO_WDT_REG_CTRL,
>> +			  OTTO_WDT_CTRL_ENABLE);
>>   	return 0;
> 
> Same as above.
> This is probably short enough to keep is on one line? (< 100 characters)
> 
>>   }
>>   
>> @@ -99,8 +93,7 @@ static int otto_wdt_ping(struct watchdog_device *wdev)
>>   {
>>   	struct otto_wdt_ctrl *ctrl = watchdog_get_drvdata(wdev);
>>   
>> -	iowrite32(OTTO_WDT_CNTR_PING, ctrl->base + OTTO_WDT_REG_CNTR);
>> -
>> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CNTR, OTTO_WDT_CNTR_PING);
>>   	return 0;
> 
> Same as above.
> 
>>   }
>>   
>> @@ -126,7 +119,7 @@ static int otto_wdt_determine_timeouts(struct
>> watchdog_device *wdev, unsigned in
>>   	unsigned int total_ticks;
>>   	unsigned int prescale;
>>   	unsigned int tick_ms;
>> -	u32 v;
>> +	u32 mask, val;
>>   
>>   	do {
>>   		prescale = prescale_next;
>> @@ -142,14 +135,11 @@ static int otto_wdt_determine_timeouts(struct
>> watchdog_device *wdev, unsigned in
>>   	} while (phase1_ticks > OTTO_WDT_PHASE_TICKS_MAX
>>   		|| phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
>>   
>> -	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
>> -
>> -	v &= ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 |
>> OTTO_WDT_CTRL_PHASE2);
>> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
>> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
>> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
>> -
>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>> +	mask = OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 |
>> OTTO_WDT_CTRL_PHASE2;
>> +	val = FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
>> +	val |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
>> +	val |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
>> +	regmap_update_bits(ctrl->regmap, OTTO_WDT_REG_CTRL, mask, val);
> 
> To be consistent, you would also need to propagate the result of
> regmap_update_bits() if it's an error. Same for the other regmap_*() calls.
> 

I am now inclined to reject this patch. regmap mmio never returns errors
unless it is associated with clocks, and now useless error handling is
requested. That defeats the idea of simplifying the code. Instead, its
complexity is increased by adding unnecessary error handling.

So this is now a NACK if unnecessary error handling is indeed added,
unless someone convinces me that this would add some benefits that I
am unable to see.

Guenter

