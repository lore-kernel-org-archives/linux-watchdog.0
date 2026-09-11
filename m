Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E54345736
	for <linux-watchdog@vger.kernel.org>; Fri, 11 Sep 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139638; cv=none; b=OY9GefbXAg2etUOJbf7guPrJwSprVitvtvBylUVW1FA+3j7UreM4rr4UxGPQYlojbFH1jywWOCUjuzUhU0Vzj03r+SLc8LSaev4rDiDZq1wRIl3wKgdGR9hlGd6fmqL5piW8AhoOTtfNUWPbEp6/weKAJDmeR2apxEKeVoDzMao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139638; c=relaxed/simple;
	bh=uq/WUuirl9LkveBlBap7y19BGfLqBJsaeerSYP8tut0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OojpFbojjp5+L/rBp9/BmdzGsDBjPS7PZ4MXNThfawoOtFsP8tHw7A8AbgkL62lGdAIy6gFxzWIc0NPWUATCwIZjgAvnAAoqD9wYaFpWdT1dgp8ao5QSea+ZplEcjwJdw791WMLEz2P7iSsNaYvLM46IIqhsRWPUjVO7zYZ6jco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ayrsyn0a; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ayrsyn0a"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8EFD64E401EF;
	Fri, 11 Sep 2026 15:13:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 545B8601DE;
	Fri, 11 Sep 2026 15:13:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 37B6811C7AFA9;
	Fri, 11 Sep 2026 17:13:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789139634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zZngMg1fCLBrGuEL0fyeHrYu9D1J2Ahq2Mn+xR7GSjE=;
	b=Ayrsyn0aAX9LhMS80a/W973tT1Vk8KiITQQBr9uCDIoV5VBVHdZYbu9oL777bxrCpP6I9g
	BYew6UhOpO4syz+J5pwa4Jai29lSmO75EBUsl6AnOxABFy8p3pJfoQDaOTvjU7/weRozsC
	xeBoANNnWws1ojF4HsVr64ZY3gH/3uhGJa0QDvVzSWyyvwFq4ExQmGCgDueY92OZkMR0uW
	B4kBcwd88sPVJ42gIr/Qa02CouY5AqTQbIBDh3F6EfXdihbtZ/vzid2Kn0DF/GHGGI1CMS
	cFaqR2lzq9YlnXmvJnaLkiZjiGGYttI7RMuT5N3u9XSVrknNpdKx3yzn5fUDog==
Message-ID: <627a2d9f-3618-4615-9315-36c3766ca9a7@bootlin.com>
Date: Fri, 11 Sep 2026 17:13:52 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm: dts: ti: omap: Prevent watchdog from being reset
 on kernel boot
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <20260911-omap4-wdt_boot-v1-3-637d778a4a1e@bootlin.com>
 <20260911093025.DBDD01F000FF@smtp.kernel.org>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@bootlin.com>
In-Reply-To: <20260911093025.DBDD01F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 9/11/26 11:30 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] The patch exposes the system to unexpected reboots due to a 30-second window before the watchdog is idled, contrary to the '3 second window' claimed in the commit message.
> --
> 
> commit 1abe23cd5472149baeeab9af481deaf65caccd1f
> Author: Diogo Ivo <diogo.ivo@bootlin.com>
> Subject: arm: dts: ti: omap: Prevent watchdog from being reset on kernel boot
> 
> This commit prevents the watchdog from being reset and idled during kernel
> boot by adding the ti,no-reset-on-init property to the target-module node.
> This is intended to provide a 3-second window for the watchdog driver to
> probe without resetting the watchdog.
> 
>> diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
>> index 4c78a0b28fab3..e061ea3fc8e70 100644
>> --- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
>> +++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
>> @@ -1126,6 +1126,7 @@ target-module@4000 {			/* 0x4a314000, ap 7 18.0 */
>>   					<SYSC_IDLE_SMART>,
>>   					<SYSC_IDLE_SMART_WKUP>;
>>   			ti,syss-mask = <1>;
>> +			ti,no-reset-on-init;
> 
> [Severity: High]
> Does adding this property unintentionally cause a regression where the system
> experiences unexpected reboots due to a 30-second delay instead of the
> intended 3-second window?
> 
> Adding ti,no-reset-on-init skips the immediate hardware reset and triggers the
> delayed work fallback in sysc_probe():
> 
> drivers/bus/ti-sysc.c:sysc_probe() {
>      ...
>      schedule_delayed_work(&ddata->idle_work, 3000);
>      ...
> }
> 
> Because schedule_delayed_work() takes its delay in jiffies rather than
> milliseconds, passing 3000 evaluates to 3000 jiffies. On typical ARM
> configurations where HZ=100 (the default), this results in a 30-second delay
> instead of the expected 3 seconds.
> 
> This could lead to a boot loop if the bootloader configures a watchdog timeout
> of less than 30 seconds and the system relies on the driver to stop it.

This is a valid point that I am not sure how to solve. I could change
the hardcoded 3000 but I don't know if that is the way to go. Any help
would be greatly appreciated.

Diogo
