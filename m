Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0B36B901
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139408; cv=none; b=O1l5PgBhbtUmDp7eHp7TLf3LUDksNH2vYLaGL+RRzEJJ/4F3LDoDpuj9Xzg5+lYps632pDz4OE4Yh15A4DGZRRagV2Kn4ZDOn1oUFNEHhyVUjrFFIyPI9ip2KbcN93E23t7H/y0rj/4Rcu70uMnb2GQdyfS2QHuSaxyKZBXtS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139408; c=relaxed/simple;
	bh=Js9puJ50w+HI0MGuV6feMwOvX1HULotCJJa88JmArx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V3zSiKD1zdVQxZFP8j7Qc0M4v1preucQqkQQTYx3j2YmAy/MLcNNOiCM+vw3VN+6Jdtmg/TPsHu0fVTtqavvsY8/rslZPM11z/mSVvgkRZt7flFWK9FyonmSqmNY2aIQ5pC5SRijyFJzlBmGisPxWYGJxUwZAK1u2Tq70htuuQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CzV8wFrC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CzV8wFrC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 53BA51A01ED;
	Fri, 11 Sep 2026 15:10:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 269F4601DE;
	Fri, 11 Sep 2026 15:10:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0E0C11C7AFA5;
	Fri, 11 Sep 2026 17:09:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789139400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fWPlFRGwqG90pX/o9uM2pzX/j2BCy12aD2u87wsKGSM=;
	b=CzV8wFrC2z+QxrqmY6vwcnSfhlo9mtA35GZi/WqNr81GIPHASRTvZ5KgaVsyMQHhmaSfvQ
	RaqHG0c3w+Gm+icrd9evb2Rd3BYLTpC2LBz9W7Q3dF1hzrUArZkNjCFZhA3MqlpWSKxVVk
	+W2aSoCgXyfSFCIvP1UtZnyXEs6SKdvqvxYI26Tenj7hpRusP9Ydq2KMMMYENr9/V/pmbY
	mNUH5MbDwXVtu5G22DPvGLR/wjOkhSzMBUtxXZv5IJHSMAojr97TDojxzRuGcSWcS7W/FX
	8yuaQ+w8L+YVNMSi6praYL8ZVpxSDEyhRBDvsmrbolxC6SAcuuGQCqnSKMtxig==
Message-ID: <0db135f8-5c60-4368-9257-7a4dfc7ee73f@bootlin.com>
Date: Fri, 11 Sep 2026 17:09:58 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] watchdog: omap: Remove duplicate start() with
 early_init
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <20260911-omap4-wdt_boot-v1-1-637d778a4a1e@bootlin.com>
 <20260911092903.97BA41F000FF@smtp.kernel.org>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <20260911092903.97BA41F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/11/26 11:29 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Asynchronous pm_runtime_put() is used immediately before pm_runtime_disable() in the probe error path.
> - [High] PM runtime usage count and active hardware leaked on watchdog registration failure.
> - [High] Incorrect teardown order in omap_wdt_remove() exposes the device to userspace accesses after runtime PM is disabled.
> --

For this patch all of Sashiko's comments are for pre-existing issues. I
can take a look at them in a separate series but IMO this lies outside
of the scope of this patch and does not influence its review.

Diogo

> commit 569cfe0fa3feafe4258fc44d697167c767425987
> Author: Diogo Ivo <diogo.ivo@bootlin.com>
> 
> watchdog: omap: Remove duplicate start() with early_init
>      
> Commit cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
> reworked the handling of the early_enable parameter and added an
> explicit call to omap_wdt_start() in case that parameter is true,
> but left the call that was previously there, which became duplicate.
>      
> Fix this by removing the unnecessary duplicate call.
> 
>> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
>> index 95c7e44b7baac..f8a76df3c7882 100644
>> --- a/drivers/watchdog/omap_wdt.c
>> +++ b/drivers/watchdog/omap_wdt.c
>> @@ -285,9 +285,6 @@ static int omap_wdt_probe(struct platform_device *pdev)
>>   		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
>>   		wdev->wdog.timeout);
>>   
>> -	if (early_enable)
>> -		omap_wdt_start(&wdev->wdog);
>> -
>>   	pm_runtime_put(wdev->dev);
>>   
>>   	return 0;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does the error path for
> watchdog_register_device() in omap_wdt_probe() initiate an asynchronous PM put
> just before disabling PM runtime entirely?
> 
> drivers/watchdog/omap_wdt.c:omap_wdt_probe() {
> 	...
> 	ret = watchdog_register_device(&wdev->wdog);
> 	if (ret) {
> 		pm_runtime_put(wdev->dev);
> 		pm_runtime_disable(wdev->dev);
> 		return ret;
> 	}
> 	...
> }
> 
> The asynchronous idle/suspend work is cancelled by pm_runtime_disable(), which
> leaves the hardware in an incorrect power state.
> 
> Should this use pm_runtime_put_sync() instead to avoid this suspend
> cancellation race condition?
> 
> [Severity: High]
> This is a pre-existing issue, but does this same error path leak a PM runtime
> usage count and leave active hardware running on watchdog registration failure?
> 
> The probe function starts the watchdog via omap_wdt_start() (which takes a PM
> reference), but the error path only calls pm_runtime_put() once.
> 
> Does this fail to balance the second PM reference and leave the hardware timer
> running without a registered device, which will inevitably lead to a system
> reboot?
> 
> [Severity: High]
> This is also a pre-existing issue, but does the teardown order in
> omap_wdt_remove() expose the device to userspace accesses after runtime PM is
> disabled?
> 
> drivers/watchdog/omap_wdt.c:omap_wdt_remove() {
> 	pm_runtime_disable(wdev->dev);
> 	watchdog_unregister_device(&wdev->wdog);
> }
> 
> Concurrently, a userspace process with the watchdog open could trigger
> omap_wdt_ping() or omap_wdt_start(). Because runtime PM is disabled,
> pm_runtime_get_sync() fails to power on the hardware, but omap_wdt_start()
> ignores the failure and proceeds to write to unclocked hardware registers
> (OMAP_WATCHDOG_SPR).
> 
> Could this cause a kernel panic due to an imprecise external abort or bus fault?
> 
	
