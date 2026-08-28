Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922D455162
	for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 14:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928502; cv=none; b=BTngXwq6FU9cV8dVCvAA04TW980wO4w3vjRGEhV+eONIGsbTWoFt04FVaOfwqe5VMEU3wcSfMyGOFyQGtmSUGIbnrnslSa6HeAtSJq+NkqLFX0dF6iuWBlJCjODJmumW5rl/D4BQ5JZXUCEzwDdZWceODhwlYz3fG2ZfAosINtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928502; c=relaxed/simple;
	bh=OsfdMNdNWdQnd9txu/d8hUp9MYPSVyBj4z1mKIgc9Ao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuHecQOPIJzR27yPgf1lgx0qSpxs4bjMmNtMVLljGDpRX1oyH2LDqSk9YGp5n9GTq6biF3k2/evP4THQQ06AQTHgELlFDcB9VtT2EFIyFG3pmzVBZ1rquby17qbN+JIim/l6NI5JR3ki7c9K1Wg9Fu+tmYf9/6pM4vqmhm9c1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1vzRKyz; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1vzRKyz"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso978736a12.0
        for <linux-watchdog@vger.kernel.org>; Fri, 28 Aug 2026 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787928500; x=1788533300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ARUeGPBiDr1+0OzMc5FY1N5iqqWogq3yghf2ipP7bMw=;
        b=S1vzRKyztGcCsKQEz42PdwtLoil+PHD17pQPjJe937lWNbO20q3h4/kYFmZBK4JlPo
         SguNMdvsPi+vUCmoUG5b8bzFqzlxtfUyLjQSsa2SsCoVzC7rOhXnwMIlEjb0s/RhE+tD
         dlG7Y5nIcbbs9+Ymz4J/Oqq+T7ycU9EX+/shBfVSsomEHWHQU5dUv2ihdra/i2L7k9uX
         tsbpgGEbGKCXXT/WKfJvYsDpd4gVS22a1LGduafUdDygBzFGNDeGLAgFJLjZdS7XonRM
         8HmgYYg0ncufFoSqPB1hroDbrA4OZgeTZiMqfk/V/83vHeS/q+JS23o3T+85YfGtwaAE
         rjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787928500; x=1788533300;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ARUeGPBiDr1+0OzMc5FY1N5iqqWogq3yghf2ipP7bMw=;
        b=dOd9NdIS+F0krRc2tJawP9ENowedhiZf3h4fsEjMvNx4lyOcC1rZOj79/XPapsSCuS
         CntnRjxuAP+5lyLwNo/I9A5/v906yswh8EctKvgmnUauDKRTaYImdoETYpbXMbiwjTWv
         mD5VA1x0A0qvrc1EuDsvzYUwAHQifB5SXxs8sI3ZB8/aJ0RxsqBAzWdzyWVR/xT4B1QC
         4pbm5pwAyhvgcnW3w7cxrNtHC/Q7uX3buuXv5roYA3SJDVocykeWeqU7AcH4G62DNHfn
         k5+E1RZRhfAj2CAdsYJ2psxX1WOEoELna/Fw7g/pl8W+ygKgppV+p7gHVaCJCPFeLCt7
         2eJw==
X-Gm-Message-State: AFuF++mclaNOW4nbfnVWf8BOBera6MU9rK6AEaMQ1LjhYAI8Vs2qmEdD
	gaDNMwBrCddKkm45i/ba44aPYa5h8VVZZPdz+LgXzIgqAsYDIy59MdjmXpPSPA==
X-Gm-Gg: AR+sD11UVOKkaxmW5XAfEX71ScHGJvGZ7E8TAolXRjFT6+ZsBsZfu6NDCWlBuLDbZW0
	GReyrCaipA+4QqjNN3YXaI2vsi2R898rIRtSUFHIvo1PKZsBkkV1W88Z7Mfq24C5Gmo0HH/L++6
	B94Lm8Djbi2Lj17qNpQBSejXJ+RpkflclMT4wFPR2vzmjh2D+tSDqdS2EqbQ33NbiaTS9CLNvz9
	7WoJ2yTbJ2CXzdUL7bVU4duytdkxDJdi2a+6JGJqvu+ftT4TINhdAWQeLCIGp3N0VLhOgg8Jvcp
	/KJ3Zn3XjUd3Jf6vtrVsGqi3RgF+xiRC7mYUkY0PcxIGOCnEijVGradkqkW0FJDGXQR9P9EfA0W
	kWlIvecZ8j+7maUHKMUc57jyuXUSybCy3O1X4Fza5D2C2R1KXMeehWzmxY4oVa6iNkRVRyup6Ku
	6oImnem+0tQwwnRDZOCuCXuyN5u9vFnT+a+Bi1Rykl1QS1fjLTOzaqOEacl4QnaK+TkJsWaIi6z
	PxVycHYECzWFutUCuIzFhEBb7aaBATXN5E0Vw==
X-Received: by 2002:a17:90a:dfcc:b0:380:f389:447b with SMTP id 98e67ed59e1d1-396d0fd3a24mr16120708a91.11.1787928499949;
        Fri, 28 Aug 2026 07:48:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396d77f7643sm1174890a91.3.2026.08.28.07.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 07:48:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e860d0c8-99c2-4978-b15d-290759ae4f7e@roeck-us.net>
Date: Fri, 28 Aug 2026 07:48:18 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] watchdog: msc313e: Enable clock before accessing
 hardware registers
To: sashiko-reviews@lists.linux.dev, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org
References: <20260827044700.554333-1-tzungbi@kernel.org>
 <20260827044700.554333-3-tzungbi@kernel.org>
 <20260827050107.9AD441F000E9@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260827050107.9AD441F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/26 22:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Medium] Clock reference count is leaked on the probe error path if watchdog registration fails.
> 

That seems real.

> Pre-existing issues:
> - [High] Repeatedly setting the watchdog timeout leaks clock prepare and enable references, potentially leading to refcount overflow.
> - [High] System will unexpectedly reset during suspend if the hardware watchdog is running but was never opened by userspace.
> - [High] Potential division by zero if clk_get_rate() returns 0.
> --
> 
> commit 363d0038f19004fef94c7716c644171a89070cb1
> Author: Tzung-Bi Shih <tzungbi@kernel.org>
> Subject: watchdog: msc313e: Enable clock before accessing hardware registers
> 
> msc313e_wdt_probe() reads from hardware registers without ensuring the
> required clock is enabled. This patch calls clk_prepare_enable() before
> reading WDT registers and leaves the clock enabled if the WDT is running.
> 
>> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
>> index 3b62650375628..b89b1cddaa5e8 100644
>> --- a/drivers/watchdog/msc313e_wdt.c
>> +++ b/drivers/watchdog/msc313e_wdt.c
>> @@ -98,6 +98,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>>   	struct msc313e_wdt_priv *priv;
>> +	int ret;
>>   
>>   	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>>   	if (!priv)
> 
> [ ... ]
> 
>> @@ -120,9 +121,21 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
>>   	priv->wdev.max_timeout = U32_MAX / clk_get_rate(priv->clk);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this code cause a division
> by zero panic during device probe if clk_get_rate() returns 0?
> 
>>   	priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
>>   
>> +	ret = clk_prepare_enable(priv->clk);
>> +	if (ret)
>> +		return ret;
>> +
>>   	/* If the period is non-zero the WDT is running */
>> -	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16))
>> +	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16)) {
>>   		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
>> +		/*
>> +		 * Keep the clock enabled. The watchdog core will skip the next
>> +		 * start() and a future stop() will balance the CCF reference
>> +		 * count.
>> +		 */
>> +	} else {
>> +		clk_disable_unprepare(priv->clk);
>> +	}
>>   
>>   	watchdog_set_drvdata(&priv->wdev, priv);
>>   	platform_set_drvdata(pdev, priv);
> 
> [Severity: Medium]
> If the hardware watchdog is already running at boot, the driver intentionally
> leaves the clock enabled here. However, if devm_watchdog_register_device()
> subsequently fails:
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe() {
>      ...
> 	return devm_watchdog_register_device(dev, &priv->wdev);
> }
> 
> Does this regression leak the clock reference count on the error path if
> device registration fails, since the prepared clock is never disabled?
> 
Yes, that will need to be fixed.

> 
> [Severity: High]
> This is a pre-existing issue, but repeatedly setting the watchdog timeout
> leaks clock prepare and enable references, potentially leading to refcount
> overflow.
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_settimeout() {
>      ...
> 	return msc313e_wdt_start(wdev);
> }
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_start() {
>      ...
> 	err = clk_prepare_enable(priv->clk);
>      ...
> }
> 
> Since the set_timeout callback directly wraps msc313e_wdt_start(), does this
> sequence unconditionally increment the clock refcount every time the timeout
> is updated, without a corresponding decrement?
> 

Worse, it starts the watchdog even if it isn't running. Separate problem, though.

> 
> [Severity: High]
> This isn't a bug introduced by this patch, but will the system unexpectedly
> reset during suspend if the hardware watchdog is running but was never opened
> by userspace?
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_suspend() {
>      ...
> 	if (watchdog_active(&priv->wdev))
> 		msc313e_wdt_stop(&priv->wdev);
>      ...
> }
> 
> If the watchdog was left running by the bootloader (WDOG_HW_RUNNING is set)
> but never opened by userspace, watchdog_active() is false and the driver
> skips stopping it. Meanwhile, the watchdog core suspends its background ping
> worker.
> 
> Since the hardware timer continues counting down without being pinged, will
> it expire and reset the suspended system?
> 

