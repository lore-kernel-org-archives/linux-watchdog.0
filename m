Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E4A345EB2
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740847; cv=none; b=GV6eJ4K9gGi2hIG8wjfFyTXlz0EKHlo/999RMxk2wQ3seZkQcARi8YZp48EbPO+tA8XYMUrwRJnAfArBwm/lT1HpkDe7Pl7GZLPBgx16sxup5HTK0rfsXZriI5ybYis+4ahXMruSzXer4c+piKMyddlKbbBLMWu5/Ze+dNjR5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740847; c=relaxed/simple;
	bh=DJqZhyX0gGwMTqlxjMu4Bgd8Kix1ZKsIveGhMD3+yqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c3CHJLwRclzz+LXNEsZgQkpJkP1pymbmeYzEol/z7A6UDAKPfwhG9+k+e5h3Ms0SkAZUvXM+emHi5vi/U7fOmsgvH1l78zzDte3VZ0x/pgYXymM+e/a3w5bD5ukru9H2lKybgnVnjM6XP/NBks+rMZSCKDv131ue/oqoK/ocnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KT5pHU9j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KT5pHU9j"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84864086bfeso352028b3a.1
        for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 10:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784740846; x=1785345646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9YDxesPfcPwfShu8nVsbz40Ds5tkovd3DYnjzOR/0fc=;
        b=KT5pHU9j5lLBe0JsheOGKa/gA77w2ksgmrRsRCCkK1/VP8G/ZeXra5xuF0MQ8rwe6H
         7W6WEl89+LtyILkPZZuphYyDx3fc/IIQFwj/J0d988RyqHGwYrKfnnb48yB5UXFIc0+k
         R1ElHq0nj4BAwKzrTdZ9AGSJKfKsBB8NbH6q3j3j1SlC7ghz56eFOdoLYFKpBR0tO2Uq
         K2Ji5kUOPJ6oRBj+X9nbxxQoVXpFgBlTzdra+eMAkTPMiZ5VgwGseEvy+BeNmhFMSbxU
         strznBBbpbK7+rK7h+AKDk+X34xUYOxroCOb2ZFBBDrimsQ3Z4S1PRd3hFRkPzMwOXNh
         FLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784740846; x=1785345646;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9YDxesPfcPwfShu8nVsbz40Ds5tkovd3DYnjzOR/0fc=;
        b=HaQdndsmwk+L2v+JfeNLD6ujVOWyxpYaNgxgWB1Wr6oU6YR10VUEUSK9Eu//D/mySI
         sWv5pwG1XVjIp0SdgqIVVDFTAiNfhPpyfZxN67Ch1sRtF+4GxkFwE+4fL04qA/oDusdo
         EWipEfq1P1bPM2tC6p+J0iuo9cEhPmxosYX5u4IICdrzLjnpxr6xSPZHxKTJMMBouk7a
         g/PmRc8WKLZnmqExfzpvrXBgJkAdHJKLBwdVznAQizQb2AgvgT7LIteEz2eaZwexnNTe
         VNl5R4Qmk3ia+9liopfpT3uBWr+l/El/i178L2spLAIusGHoJtvv3f653LcxelMVKbQl
         9EZw==
X-Gm-Message-State: AOJu0YyQeRh0szENMx4xjwnn/oxXdNEYHr6ghs0N6Gle08mYcU7QFk1q
	KBPj9ew1nTJmTBW6/V68CDrUmyqQDEXsQTZgQol5Oo+VEuvjc+Pn38Rvu2rsog==
X-Gm-Gg: AR+sD13ud3Jdla6YfRsRVPtab5mnoRmECYURelgOx1jcPuHRD5+r2/AUWuwp6CIxc70
	8+EeFuiH9QsBCjeXuMS+WS6/rAG0z9AR493lIqs0nb7VLlNGqBWCyigSr0WercpsdVQmalq1ENO
	RH9PTVROh3/m2tRyWxNU9pTDvBA2KdHdjGq94CCYK16+RzObVwIy/ncpw9+r8UZs1PwtNVo92mK
	mVWpDB2FvslOHgXNqF4KHFy17lhJzq46LOvlVdZ9tFOIZSdfBY9Cmj0iTfoL4NIh6AlJERq2Ry/
	1V1KaGu5zr/GVZQ9wRkn36i8MQWNLD0KuMr4A70fDniK+khxaLFMnhL7BWRQBNkWD3J5S4p955R
	xMGse7OrrbF9/O2W8VPDjHm9BVzAorGv/Z55RpTpoprAo883QNplNXiEJf/TN3c5ofFpuTJTRPr
	vy4W7mqgzsj7LYPN6DUfkJyg4B5Ft1f+R/aeuhHnI3/pP95rcVqoqoN9XvBOnXAA==
X-Received: by 2002:a05:6a00:cd2:b0:848:51b3:f3c2 with SMTP id d2e1a72fcca58-84c292c7125mr24156114b3a.33.1784740845668;
        Wed, 22 Jul 2026 10:20:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e20622dedsm918324b3a.11.2026.07.22.10.20.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 10:20:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <98a82f60-fa06-412d-832f-74b1985e291f@roeck-us.net>
Date: Wed, 22 Jul 2026 10:20:43 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: atcwdt200: fix return value when watchdog is
 enabled
To: sashiko-reviews@lists.linux.dev, kr494167@gmail.com
Cc: linux-watchdog@vger.kernel.org
References: <20260722163706.14238-1-kr494167@gmail.com>
 <20260722164637.8EACF1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260722164637.8EACF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/22/26 09:46, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [Low] Setting `drv_data->int_timer_type` is useless dead code because the function immediately returns a fatal error.
> - [Low] Kernel-doc comment for `atcwdt_get_int_timer_type()` contradicts the new code.
> 
> Pre-existing issues:
> - [High] Failing driver probe when the hardware watchdog is already running orphans the timer and guarantees an unhandled system reset.
> - [High] The watchdog restart handler acquires a standard spinlock in atomic context, causing a lockdep splat and sleep-in-atomic bug on PREEMPT_RT.
> --
> 
> --- Patch [1]: [PATCH] watchdog: atcwdt200: fix return value when watchdog is enabled ---
> commit 8139a405984f14ed6f8cead4736a58db3d02c322
> Author: Surendra Singh Chouhan <kr494167@gmail.com>
> 
> watchdog: atcwdt200: fix return value when watchdog is enabled
> 
> This commit modifies atcwdt_get_int_timer_type() to return -EBUSY via
> dev_err_probe() when the watchdog is already enabled, fixing an issue
> where probe() incorrectly returned a positive value on failure.
> 
>> diff --git a/drivers/watchdog/atcwdt200_wdt.c b/drivers/watchdog/atcwdt200_wdt.c
>> --- a/drivers/watchdog/atcwdt200_wdt.c
>> +++ b/drivers/watchdog/atcwdt200_wdt.c
>> @@ -274,7 +274,9 @@ static int atcwdt_get_int_timer_type(struct atcwdt_drv *drv_data)
>>   	regmap_read(drv_data->regmap, REG_CTRL, &val);
>>   	if (val & CTRL_WDT_EN) {
>>   		spin_unlock(&drv_data->lock);
>> -		return TMR_UNKNOWN;
>> +		drv_data->int_timer_type = TMR_UNKNOWN;
> 
> [Severity: Low]
> Is there a need to set drv_data->int_timer_type here? Since the function
> immediately returns a fatal error, the driver probe will fail and free the
> structure. This appears to be dead code.
> 

It is. Code further down does the same, but that is not excuse for doing the same.
Actually, TMR_UNKNOWN itself is pointless since the driver does not really
use it, but that is yet another pre-existing issue.

>> +		return dev_err_probe(dev, -EBUSY,
>> +				     "Watchdog is enabled, cannot detect timer type\n");
> 
> [Severity: High]
> This is a pre-existing issue, but does failing the driver probe when the
> hardware watchdog is running orphan the timer?
> 
> If a bootloader leaves the watchdog enabled, refusing to bind the driver here
> guarantees an unhandled system reset. Should the driver adopt the running
> watchdog instead and set WDOG_HW_RUNNING?
> 

Yes, that is correct, but it appears that there is no (known) means to
determine the timer type if the watchdog is running, meaning such a system
is actually not currently supported.

Maybe the driver could stop the watchdog if it is running, retrieve the
timer type, and restart the watchdog. However, that would have to be a
separate patch, and it is questionable if such a system actually exists.
So it is ok to ignore that problem until someone actually observes it.

>>   	}
>>   
>>   	/*
> 
> [Severity: Low]
> The kernel-doc comment for atcwdt_get_int_timer_type() currently states:
> 
>   * Note: This function must only be called when the ATCWDT200 watchdog is
>   * disabled. If the watchdog is enabled, this function returns TMR_UNKNOWN.
> 
> Since this patch changes the return value to -EBUSY, should the documentation
> be updated to match the new behavior?
> 
Yes, definitely.

> [Severity: High]
> This is a pre-existing issue, but can the lock used in atcwdt_restart() cause
> a sleep-in-atomic bug on PREEMPT_RT kernels?
> 
> The watchdog restart handler acquires a standard spinlock:
> 
> drivers/watchdog/atcwdt200_wdt.c:atcwdt_restart() {
>      ...
>      spin_lock(&drv_data->lock);
>      ...
> }
> 
> Since restart handlers are invoked in atomic context with local interrupts
> and preemption disabled, acquiring a standard spinlock_t blocks and can sleep
> on PREEMPT_RT. Should this lock be converted to a raw_spinlock_t?
> 
That would have to be another separate patch.

Thanks,
Guenter

