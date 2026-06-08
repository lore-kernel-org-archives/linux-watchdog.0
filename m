Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4038AC65
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951401; cv=none; b=lEnbA/6UtnO1ByjXg2r43SJqAYp/hV/quetKFqMtHcz9HA5PTIgUB0KTPl3cIwxwCzAXcW3kBkSlnJXUQdHvezPydefiw3y7fxYhwqP9TC7Ca0PCUdL8618FTm6SlTL+TfJ59wKdNnMUPTE5cj/9ompHGJB6LbubnKiqgGfsyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951401; c=relaxed/simple;
	bh=MmypxDkV9WidFdoiNyUarK5RO4529BdDXNB7K8CTTjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgcLOORBkfK6G5gtmLUYX0xJNTB2hZRj4MIv/c6nZSgnpTsURNkMJ4KPFF399fdYTWUZvXZNY5jsu7ptytgC/xyhg7xoXE9IiF/J2QKZ8+0vdRnMKeGJGgABwW+a442PkR3jsvP4dM/TywXqpFhBaftRd0NgDVI/BEuyLXnKk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAcPHX3j; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAcPHX3j"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so4346818a91.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951400; x=1781556200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=v397rAc4nLW0basLyJyPzlrgoP80PAn+u/BhLVjss90=;
        b=KAcPHX3jnEYVgKm07HAXM+sBcvu6IcxkHd7tsA0VfexM1coM8N0iLH72s52NCRCrk4
         W1/iDhvJMQRnr2P3qEHfucD1Vh00wKRHzW0ZEstc8eGCDxkfFBuaFc68wRgDI54kxeQK
         O1eoVVRq3Fy8A+Xx+pAF55Af7e9c4Iv3Rcaf9jUWKw8ULX0KyEFUwxtgS0PhhEuP/eFH
         KEPXBV8IaE0Yb8ycRpxiY9GAbgFuIxOVf++X8dlgpggCM8/qjto6tqPZsxbQaKAulQPH
         uO3P4Grimzsdv4QvE5TLvJShZWshPvJOzuVBNz8YltqCCK/kZZusTXWiPEHsdZmdo5K4
         Bt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951400; x=1781556200;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v397rAc4nLW0basLyJyPzlrgoP80PAn+u/BhLVjss90=;
        b=BMbvjCwQZwwWQ4vnHxmrPS2hylsYDgsndXSlj5T6j1DvsQrMidrdLpFhmtZag9pZWV
         QhhvdcU+MK+cp7M6zCiauCfdYQ5FUrDzud+WMqzSySmAYOa+CP5Vsm0XoEohqem3drAB
         3fsE54Rw3iE5Z5bO5PoNZ7wMupWH2MBonIB88XrQ0sOaQdEM+MxDXa/HbAnRnyT0o3ee
         bGQ4LPqDk0NJ6xYn+nsai1JFFdw7f45ru7TVDbmkpBkbVnoOFx3/Z1XDuSvlvGYNqegI
         IH+qMztUbZ3RZh/ULhs3llGA6MpH1fsC8yUNdzgkCU8UfsK3Cx/97VHmwlHRNX2TrReU
         5VZQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cEqruAPKJofo8DK/WkBcstsCf0ewjwKLAdDhwLJSo1pcHTUMQbpA2mgCAyUYWBiddBHSkQIPjrRAiSpUCnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+MNTWcvAoOzfm6w6XDs+I5sOIe7KgWl+/3gkOjIg2Kk3QUXo1
	z8TAfrgE9yb0JxHYWyQJhRGMGDMqMk3TqAKVwFTIOZZkbsrQEaoSqVzd
X-Gm-Gg: Acq92OGJPkA4uPW+LAuNO/E7MNvj7iVlkjWlK36maULX6nbimQJiIqlB9zqFfM3Tr0Y
	u4kw1SoQU1Z3whtYZ3ilJr/GpmVxW6HERjji95EcECrCDUsUnvOQUuHaD5PUzS8z6Af/DVm1zh5
	T/L10+k4e+xUrFMsQCddRDS2JI1aekKsqW8Wm/hgAMqPNOctFNCQTIcJU1buXiZxg79nUxT/XE9
	Pjn1bg1LTmW7j16RhBC0nPgVaL82F1Z1JLJz+KgiyYbLIU3hb+6GeqVUyllSSZbaI2/DlcAWWXQ
	ywnRH3RCkOKOj8ODv9RVZii7rpmfYAU1twi9Dz9TPdvU1EqlkQS8sBqXhIIOMw+alHSOiIm9nBQ
	DVHF760340SaaLH3Wb5dfC+iKCHQ2m+wr8356llDSl39YgEJzbLD/+88s1ivd1rIenpoxmkblDD
	dtdviFAxlKm8GLHYYKyc8gIVlpNFF6OEuJBPc6Ox0+qywkwr7wTQ6N+L2uDC76VVNr7IfPF9hsK
	bYc/in/AD4=
X-Received: by 2002:a17:90b:38c8:b0:36d:b12f:613c with SMTP id 98e67ed59e1d1-370ef2f0208mr18085500a91.10.1780951399887;
        Mon, 08 Jun 2026 13:43:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6c668e98sm17382723a91.5.2026.06.08.13.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 13:43:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d2e5196f-415f-4948-9c7f-6c567a4b2000@roeck-us.net>
Date: Mon, 8 Jun 2026 13:43:18 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: sama5d4_wdt: use platform_get_irq()
To: Rosen Penev <rosenp@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, linux-watchdog@vger.kernel.org
References: <20260603005409.226774-1-rosenp@gmail.com>
 <20260603010104.56C0C1F00893@smtp.kernel.org>
 <19f5c865-0ec6-4079-bb77-cf6f203723fa@roeck-us.net>
 <CAKxU2N8SwOzGqjoVrOGQm3fwrhp8M_Q7JGwPFQjOv8y2ubJeTw@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAKxU2N8SwOzGqjoVrOGQm3fwrhp8M_Q7JGwPFQjOv8y2ubJeTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/8/26 13:11, Rosen Penev wrote:
> On Mon, Jun 8, 2026 at 12:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 6/2/26 18:01, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>>>
>>> New issues:
>>> - [High] Assigning the signed result of `platform_get_irq()` to an unsigned `u32` variable causes the `irq < 0` error check to always evaluate to false, breaking the driver's fallback mechanism.
>>> - [Medium] Using `platform_get_irq()` instead of `platform_get_irq_optional()` for an optional IRQ causes spurious error messages to be logged.
>>>
>>> Pre-existing issues:
>>> - [High] The driver registers a shared interrupt handler (`IRQF_SHARED`) before setting the platform driver data, creating a race condition that can lead to a NULL pointer dereference.
>>> --
>>>
>>> commit 7ff7f2de154616b7a42f6e5710f322b20ff6152e
>>> Author: Rosen Penev <rosenp@gmail.com>
>>>
>>> watchdog: sama5d4_wdt: use platform_get_irq()
>>>
>>> irq_of_parse_and_map() requires irq_dispose_mapping() on failure. Don't
>>> bother with it as platform_get_irq doesn't need it.
>>>
>>>> diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
>>>> index 13e72918338a2..d9b212557ce36 100644
>>>> --- a/drivers/watchdog/sama5d4_wdt.c
>>>> +++ b/drivers/watchdog/sama5d4_wdt.c
>>>> @@ -286,8 +286,8 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
>>>>               return ret;
>>>>
>>>>       if (wdt->need_irq) {
>>>> -            irq = irq_of_parse_and_map(dev->of_node, 0);
>>>> -            if (!irq) {
>>>> +            irq = platform_get_irq(pdev, 0);
>>>> +            if (irq < 0) {
>>>
>>> [Severity: High]
>>> Since irq is declared as an unsigned u32 earlier in sama5d4_wdt_probe(), won't
>>> this irq < 0 check always evaluate to false?
>>>
>>> platform_get_irq() returns a negative error code (like -ENXIO) on failure,
>>> which will be implicitly cast to a large positive integer. Instead of
>>> gracefully falling back by setting wdt->need_irq = false, won't the driver
>>> proceed to call devm_request_irq() with an invalid IRQ number and fail the
>>> probe?
>>>
>>
>> Please fix the problems reported by Sashiko. That applies to all your patches.
> Done for the reported ones. Sent as a series.
>>
>> Since it appears that you are fixing bugs based on issues reported by AI agents,
> Difficult to do given how late in the merge window this is. The other
> issue is every time I fix bugs reported by sashiko, it complains about
> new pre-existing ones. Cat and Mouse game at best.

That can not be helped. Also, bug fixes do not depend on commit windows.

Guenter

