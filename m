Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC29038655C
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780946779; cv=none; b=Yj19rsRSVozeUqHH0lKbdjaIT0NZ8uqHe322gYo2dL6oIYgaMUTaNPzc5tFWJA8wl2fzZwsQ86K6QGAXjbZd1AELAeSa987o/qsOO5fVHCT+hRMXr7LeSgOQYZDgIcGS4p4pDAsS4XojrLOCp5X8B3kGqIHhU4rVM5vN9tPkUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780946779; c=relaxed/simple;
	bh=blS6R/iqXN8Elh/yFOETBp49d4SpeMBUoXNM3tJ+L4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0trGpVpq3d6Y9pAHCnpMb6O81TQShkMXMFZt8sa1XX1AkNzxTdPJLJaZ4Kl46dSHjIax7NN8+dpA/MMGzdjhJBHp1zF9A+s3fmIPuEVYvwFCQbY20bRLIG3rGSeVCpDHd6/pSpq54zn0pmhkV1RMfGKW0JlDtQM8xDLoqjhLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4SsdQ39; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4SsdQ39"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf36a6905cso32699075ad.3
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780946778; x=1781551578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=K6EtStCAzZXkOFxJ4vFBzgNIF3Za4FB4llRwrKTUx2A=;
        b=o4SsdQ39dfXSOm2JzdMu2A8PbnM1t93PIYwZP9VHbuHDnhjPDDc7+cfqmVfQra4KuP
         kQK5/scxZcLNMXvw6lPzTch82hDT2XBT54xanbLOP7NcJNARL68rhdeXAHeTEcg44I13
         97DZXtEUu+WYyTPyW3KywAnb2yakctcyA6Q3hvVgIXw9glPsjnE6izYmolDqeYWlFe0V
         GNMOZs/DBCPgNiDsUhEceRo4V69CxH98PNcKAG0komYF4Mp9owZjocSYT8/kA5or1y3w
         9s8PiRPt3Joe6B16QSM8Ne627v3ROgtbgjlXJbs2ryQZJ0Jh5FjRR7IJBaSJ38+OSIuT
         7O0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780946778; x=1781551578;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6EtStCAzZXkOFxJ4vFBzgNIF3Za4FB4llRwrKTUx2A=;
        b=qVnmbK1gqgx/LPA0CpJM89B1nMuz1uv96oKUjKAuT297xKysJDkuGeEGnAqEXXyCRL
         e+wTrbKn0rdKB4fKErtvv64nHP1OiPb8GuRoaIZdcSsxqOB8p7HkUDMHYll+xCijhIVd
         Zh9pCBuC31l2UtLfLyoKC8pKvsrKPDFQmIbmFmc1w7Z62+57wmuZcG+fYbUrwnweVhDP
         /yUHzhTNCJXvjDs4oyDSE5KKrL7ACq1QNgrPWAcGobu7n9DmB4zrs9Toy7s1+4g94iBK
         BXDlKUMCgSZl2YH8IaTLgMfyPjVV5ezAdn8vwv07P1DZ5Z1d5Rik4PcHb0ybiazgKNT7
         t3Dw==
X-Gm-Message-State: AOJu0YylUEcp8Op6dOhCGSivEz4ozQIHRooZ2jB0wmISO+1zburo0vs9
	7AN/lic6LhD8fmNqR6uVgoQ+mKm2hBN8S+QrmoW4llAg/4JZlFR6xYR3fGlB5pYg
X-Gm-Gg: Acq92OGXsKVIjIYqPw3HWnQU/rPNenXk8mGRR5L3onJVFuDzsgZTbLeSn91TM3OjHj6
	f+3OpKEsQbtBwoDHN4er0/L34YGNqioorv7A2ZfkwuFy+6oyhmnHhcTnZijnPUD0hPHRKqMtdNz
	/BFSHz+pRlY1+WXt1saq1shIsQQm3ZH1tVSdFmkhjWIE2TXGT/8e877Gp+HEG5P77dUnTK7Shza
	yI44X6dJRcedwbywvshXISZSocgRfrFV9w9eNwCxAEnm/T4U5OPB4lOfBDj423N7tN0f4j7PqOp
	wCCk/PTRJFur8JAWs9jISVxPzOLgMQoDszqgA74iqFHxOV2cXlCw0X7N5ddGkW1e4tzzVVae2nV
	3SzkCEFalm6GXs3gANn1cSQ/OgYqg62OrP7FDCVQsU7foTmte6yftAxYMnFt2nft4ZPTh8btt2G
	BY2nEEeH/r2FNDrsn1g1TPD1DS9qqrfq5DhLY7ODIz3d1OLptP7CI/ZryBPl4C8ATxjtHTDiCiR
	SceOwy/5Fk=
X-Received: by 2002:a17:903:248:b0:2b7:975c:dacc with SMTP id d9443c01a7336-2c1e7b4158dmr193585585ad.1.1780946778023;
        Mon, 08 Jun 2026 12:26:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e096sm193156945ad.44.2026.06.08.12.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 12:26:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <19f5c865-0ec6-4079-bb77-cf6f203723fa@roeck-us.net>
Date: Mon, 8 Jun 2026 12:26:16 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sama5d4_wdt: use platform_get_irq()
To: sashiko-reviews@lists.linux.dev, Rosen Penev <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org
References: <20260603005409.226774-1-rosenp@gmail.com>
 <20260603010104.56C0C1F00893@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260603010104.56C0C1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/26 18:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Assigning the signed result of `platform_get_irq()` to an unsigned `u32` variable causes the `irq < 0` error check to always evaluate to false, breaking the driver's fallback mechanism.
> - [Medium] Using `platform_get_irq()` instead of `platform_get_irq_optional()` for an optional IRQ causes spurious error messages to be logged.
> 
> Pre-existing issues:
> - [High] The driver registers a shared interrupt handler (`IRQF_SHARED`) before setting the platform driver data, creating a race condition that can lead to a NULL pointer dereference.
> --
> 
> commit 7ff7f2de154616b7a42f6e5710f322b20ff6152e
> Author: Rosen Penev <rosenp@gmail.com>
> 
> watchdog: sama5d4_wdt: use platform_get_irq()
> 
> irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
> bother with it as platform_get_irq doesn't need it.
> 
>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>> index 13e72918338a2..d9b212557ce36 100644
>> --- a/drivers/watchdog/sama5d4_wdt.c
>> +++ b/drivers/watchdog/sama5d4_wdt.c
>> @@ -286,8 +286,8 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>   		return ret;
>>   
>>   	if (wdt->need_irq) {
>> -		irq = irq_of_parse_and_map(dev->of_node, 0);
>> -		if (!irq) {
>> +		irq = platform_get_irq(pdev, 0);
>> +		if (irq < 0) {
> 
> [Severity: High]
> Since irq is declared as an unsigned u32 earlier in sama5d4_wdt_probe(), won't
> this irq < 0 check always evaluate to false?
> 
> platform_get_irq() returns a negative error code (like -ENXIO) on failure,
> which will be implicitly cast to a large positive integer. Instead of
> gracefully falling back by setting wdt->need_irq = false, won't the driver
> proceed to call devm_request_irq() with an invalid IRQ number and fail the
> probe?
> 

Please fix the problems reported by Sashiko. That applies to all your patches.

Since it appears that you are fixing bugs based on issues reported by AI agents,
I would kindly ask you to fix _all_ problems in the drivers you are modifying,
not just a selected subset. In this specific case, the problem below is much more
serious than the problem you are trying to fix. On top of that, the fix introduces
two new problems while trying to fix one. That is not really helpful.

Thanks,
Guenter

> [Severity: Medium]
> Will this log spurious error messages when the IRQ is genuinely absent?
> 
> The driver treats the IRQ as optional and handles its absence gracefully.
> However, platform_get_irq() internally calls dev_err_probe(), printing a
> core-level error message to the kernel log when an IRQ is not found. Should
> this use platform_get_irq_optional() instead to avoid confusing user-visible
> error logs during boot?
> 
>>   			dev_warn(dev, "failed to get IRQ from DT\n");
>>   			wdt->need_irq = false;
>>   		}
> 
> [Severity: High]
> This is a pre-existing issue, but does requesting a shared IRQ before setting
> the platform driver data create a race condition?
> 
> A few lines later in sama5d4_wdt_probe(), the driver requests the IRQ:
> 
> 	if (wdt->need_irq) {
> 		ret = devm_request_irq(dev, irq, sama5d4_wdt_irq_handler,
> 				       IRQF_SHARED | IRQF_IRQPOLL |
> 				       IRQF_NO_SUSPEND, pdev->name, pdev);
> 
> Because the IRQ is requested with IRQF_SHARED, another device sharing the line
> or a spurious interrupt could cause sama5d4_wdt_irq_handler() to execute
> immediately.
> 
> The interrupt handler calls platform_get_drvdata() and dereferences it:
> 
> drivers/watchdog/sama5d4_wdt.c:sama5d4_wdt_irq_handler() {
> 	struct sama5d4_wdt *wdt = platform_get_drvdata(dev_id);
> 	...
> 	if (wdt->sam9x60_support)
> 	...
> }
> 
> However, platform_set_drvdata(pdev, wdt) is only called at the very end of
> sama5d4_wdt_probe(). If the interrupt fires within this window, won't
> platform_get_drvdata() return NULL and cause a NULL pointer dereference?
> 

