Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B683563FB;
	Fri, 11 Sep 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139514; cv=none; b=GqrVl0TMWN17kIx9N2ev4ZIxnXFW/niIZCB2ann63VoEfhYt02FVtnPWTuHXa86PhlM+L/gIgKKc9z6KC8K/CBmObweXW0QR062G1jGo9MiY7BQGeGis3liGl43v96Tu5g3NYwOtQtzYFeIe9iBBOZ/Rc4hZLTZ9Czw/AWwebyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139514; c=relaxed/simple;
	bh=A375MHPJrMugdsUGf9CwY7o9hxH09BqaCY5MfJ8kt1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPbNBd9pEp6COb5wEu+m4JDjvvXa4G3tfZHCLQ/Iz7d7vO/XHiZEKWBPfutjvFgGsbclz2QhSpMPjVzExKJXg3sIU3MzXjYGp/go+wtcJKS5zFiA3vpGENPwp92gcgw7KyLKoUjxJpFZfxSNPKKSAEj6jR4jLMWknHkS0RnYfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XYfMYLWm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XYfMYLWm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id AE396C63A0C;
	Fri, 11 Sep 2026 15:12:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DBF3E601DE;
	Fri, 11 Sep 2026 15:11:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2144411C7AFB5;
	Fri, 11 Sep 2026 17:11:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789139506; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=dRlMEpGpqBW17zcTUVrK9fhqRNyge76HasNlMTZp7g4=;
	b=XYfMYLWm4m06vyRkb9z7uZEZHLS0IiPyI1Ub42PzIVHxtMxz1y2RoEAQzshtnnVwGxRwnB
	jU2a0l0JEjRqDQEo839v6uXce+A1No+UIKA8eTLjJ4QL+gXSAX/MBC1GUxSGonPp9kFDzC
	O7UGc9A/NWwheYQ3/qnJKpIlxtqJrVqzyIWiBCQDxF82z8DNFfk1LoEyC6Cu+6LopATU5V
	pDpcIyitgXSIcME+MAzoqiT/82U6KC+P4rGWBMjSH9kM77YRMnhxSjugG66XCAPHgCq/ag
	i1T1UikI6ucTtgdqBErmBW13DN/IyntuAHqffCL+8qTkZzvew6wZUPVtX6ujPw==
Message-ID: <394c64f5-aa0e-4af6-ba69-2c2c60722d44@bootlin.com>
Date: Fri, 11 Sep 2026 17:11:44 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] watchdog: omap: Add support for reading boot status
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 linux-watchdog@vger.kernel.org
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <20260911-omap4-wdt_boot-v1-2-637d778a4a1e@bootlin.com>
 <20260911093051.D2B671F000FF@smtp.kernel.org>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <20260911093051.D2B671F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/11/26 11:30 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Medium] omap_wdt_is_running() fails to detect a running watchdog if the bootloader configured a hardware prescaler, causing a false negative.
> 
> Pre-existing issues:
> - [High] Missing return value check for pm_runtime_get_sync() leads to potential system crash on unclocked MMIO access.
> --
> 
> commit a118768ddc7f3bc1aec5e3a2e71d0f63ab1a2766
> Author: Diogo Ivo <diogo.ivo@bootlin.com>
> Subject: watchdog: omap: Add support for reading boot status
> 
> This commit adds support for determining the boot status of the watchdog
> during driver probe. By checking if the counter is actively incrementing,
> the driver can maintain a running watchdog previously enabled by the
> bootloader.
> 
>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
>> index f8a76df3c7882..d9ab46c70f8c8 100644
>> --- a/drivers/watchdog/omap_wdt.c
>> +++ b/drivers/watchdog/omap_wdt.c
> 
> [ ... ]
> 
>> @@ -225,6 +228,20 @@ static const struct watchdog_ops omap_wdt_ops = {
>>   	.get_timeleft	= omap_wdt_get_timeleft,
>>   };
>>   
>> +static bool omap_wdt_is_running(struct omap_wdt_dev *wdev)
>> +{
>> +	unsigned long period_us = USEC_PER_SEC / RATE_32K;
>> +	void __iomem *base = wdev->base;
>> +	u32 value;
>> +
>> +	value = readl_relaxed(base + OMAP_WATCHDOG_CRR);
>> +
>> +	/* Give the watchdog some time to count if it's on */
>> +	usleep_range(period_us * 10, period_us * 11);
> 
> [Severity: Medium]
> Could this wait duration fail to detect a running watchdog if the bootloader
> configured a hardware prescaler?
> 
> The duration statically assumes an unscaled 32kHz clock. If the bootloader
> enabled the watchdog and configured a non-zero prescaler via the PTV bits in
> OMAP_WATCHDOG_CNTRL, a single clock tick will take much longer.
> 
> For example, with a large prescaler like PTV=7, the 32kHz clock is divided
> by 128, meaning a single clock tick takes around 3.9ms. The hardcoded wait
> of ~330us would complete before the counter increments.
> 
> Would this cause omap_wdt_is_running() to return a false negative, leading
> the probe function to incorrectly conclude the watchdog is stopped and
> subsequently disable it?

This is a valid point that I will address in v2.

>> +
>> +	return readl_relaxed(base + OMAP_WATCHDOG_CRR) != value;
>> +}
>> +
>>   static int omap_wdt_probe(struct platform_device *pdev)
> 
> [ ... ]
> 
>> @@ -267,7 +284,7 @@ static int omap_wdt_probe(struct platform_device *pdev)
>>   			wdev->wdog.bootstatus = WDIOF_CARDRESET;
>>   	}
>>   
>> -	if (early_enable) {
>> +	if (omap_wdt_is_running(wdev) || early_enable) {
> 
> [Severity: High]
> This is a pre-existing issue, but does pm_runtime_get_sync() need a return
> value check before we attempt hardware register accesses in this path?
> 
> If the clock domain cannot be enabled and pm_runtime_get_sync() fails earlier
> in omap_wdt_probe(), proceeding to call the newly added omap_wdt_is_running()
> will result in reading from unclocked OMAP registers.
> 
> Can this unclocked MMIO access trigger an asynchronous external abort and
> crash the system? The same concern applies to omap_wdt_start() and
> omap_wdt_disable() where pm_runtime_get_sync() is also left unchecked.

Again, pre-existing issue that I can take a look at in a separate patch
series.

Diogo

>>   		omap_wdt_start(&wdev->wdog);
>>   		set_bit(WDOG_HW_RUNNING, &wdev->wdog.status);
>>   	} else {
> 
