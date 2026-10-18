Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AC3DD866
	for <linux-watchdog@vger.kernel.org>; Sun, 18 Oct 2026 16:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342127; cv=none; b=QZf/7iQ1EhcrM9ijAJ9efuyjUCAQH9ml/Olxr67etnK84KueoNQqllYQUYSFNktTvAa6MU4W0k5rKFBJzze1AxCh27ucpqc7keTuPs78CxnZYj7yqUrO7jjU34WaiATslryPztwwN82CrgOCm4MU4bDIJVvjwjN2Sx6hrMbIYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342127; c=relaxed/simple;
	bh=BQwom/JpLTa5hVv/QW0sgO7TAm5bZ2zgWUdehMZk33I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PN1kBxn7Nhf31/nxc2sO62kPPY0bCf3c2R9ZWJKzbvxrHN31VJpa9H6/pH+bDCCspZ+epDYkveBDzic++/51AlqQF63aTqM4ijwdFYhw1VlqDucAYyre6p5AvWtMISUH0W5KvYebGm+F1wJyEcM06HGt8VqFphGO7FPX/36axJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N99ZUS+U; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N99ZUS+U"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso790253a91.0
        for <linux-watchdog@vger.kernel.org>; Sun, 18 Oct 2026 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792342126; x=1792946926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fjh022Vk0Y78tFOJ30N8yOVXBDcISHKO2EIs3a224Vc=;
        b=N99ZUS+U3YN4fBaa1JLi+eCGkecFGJUnpQLfmxOn0Pdl3Q1pbqPRyCYO6mIK1s2dj0
         I3RQPYExDCnb6CYwXMyp+XLcyiawuCaTyG7nYyrJZxhOQQ/pTT7CRnvhMLxlkKtg1KZh
         lnIlYezT/aakZHIQIoAbQtO3A6dHN3L67QWnLYcBWa4nGqTY19lCOyQFS2nBrq5soWZD
         GwkkAA5XidlEbkr12T0HHQ2PpLJTUQZZPuYqoIq7wWDaR/e3FTwpJZCL46QnWLyUc82z
         mJdul3M7Kce93eHGQORwOCqFpG0gKxLyB/2QUc8jIukNl8wkAQdMEdjwx+W3FrN6+C0b
         2jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792342126; x=1792946926;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fjh022Vk0Y78tFOJ30N8yOVXBDcISHKO2EIs3a224Vc=;
        b=S9O6BWjW04fdIyo+w36tGFjNa+44+pXG1Nde5UNnbJeATsuJ2I275tviDBOQIw8Lt2
         HpuNf4bFSTd2ZYydTmVRMGtzx9IjVLzdaQsZVNxyxHTvTcvdXE4jdfBRCT+nff9uiR0R
         Pt8avUsXkxPmna4ZRfPu3SyWi0mq/39WAzUpQaY3RkS8ZUxs7BU9MXTvLAzRxEXGMwYA
         8Wknl1DVjUu29JGqu0Vs9cm/dclaCUVtxFATrKP8GstgHbqX1Ty6SMSc9DJFwbpBRzI/
         aoP+fck+J31k/6DZo+FIpQUK/NxzLRVzry5ObQ5R5JFYRKBNLpRVZZaclznN7l6S71Pg
         vz+A==
X-Gm-Message-State: AFq9FYKdkqh1z6GV+/2jQujZm50QNy3wKc+CGF2F87Zh+p2A0ANz5QyK
	FtwJ0elRwgVyMgaMY7eWQ077wstdPOu+A4+83bsD/4ka5UMWSxQGbpE8
X-Gm-Gg: AYBFou1OBoU6LHPbt1TRmI+4emtoaINCBUf3lJGc9n1uq62YvdWcntdGXtD9g+WMr1i
	0h0qwT+i+PiNBm5uXlGN8arOuuZ6ZasHwQIdB4i6CQllrSh1QIiF80hp3d7cAyMLLBsZB3w0CDF
	TEXnIbkzHCq4Mw1KclN6+ralea0Mf/8MLci/a8nPuoo24VoZv42P3/22dnqK8mVxK8ZGlaRrF89
	oXMvS9/SKSq9mI1BWTHB9QSidXeuK9gBTTGL/6wslKGZHHETgH4PhtApfCf1N4Mn6sukpdalvyv
	KhO4qqI23jo1mIetGyZNkoqLvdtf3h3OI48sNVx0YjEvyMD2l2RIGKNON98cRnCAyDDjkrMP4gR
	pImR1T4rhA3VZDTAOHx9GnegpD8NZGzHnCGHdKOKURb10WE3IZpVA3onwk+KTtWg2+MceXjFYhn
	btY/5B3PR/1L5YOIzpyW553LkQiq7OyI7CfE9DoEjkRqwtnqhlgMQCJnXWbouCFE/uVmZDKGDja
	aJcYI2xfkAad357BqKrA5KDqkvh/UG6hDk8E88qZ79oEmJDKOMMqyqQBT8=
X-Received: by 2002:a17:90b:4d0a:b0:39e:21a7:5df5 with SMTP id 98e67ed59e1d1-3acef293029mr4763179a91.24.1792342125232;
        Sun, 18 Oct 2026 09:48:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acddc37958sm10551724a91.14.2026.10.18.09.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 09:48:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <170e005b-c6e5-4b48-bc01-9b07ff918252@roeck-us.net>
Date: Sun, 18 Oct 2026 09:48:43 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: allow WATCHDOG_PRETIMEOUT_GOV_SEL=y
To: Dmitry Voytik <voytikd@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>
References: <20261004213755.554191-1-voytikd@gmail.com>
 <e7c99dc5-dfa4-4ce7-b7da-a3a70a2710a8@roeck-us.net>
 <CAAX90H0qGF-H8BYcmT_vbUGoqN9RbfeGxMdTTRyQPK_h8MzFhA@mail.gmail.com>
 <053269a6-41ab-41eb-8756-b6a04eea2e5a@roeck-us.net>
 <CAAX90H1-tzrH6hwHHrvfQi2e-TXQKmgNy0Lj2TXG7yDbKYy3Og@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAAX90H1-tzrH6hwHHrvfQi2e-TXQKmgNy0Lj2TXG7yDbKYy3Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/26 15:27, Dmitry Voytik wrote:
> On Sat, Oct 17, 2026 at 11:42 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/17/26 08:59, Dmitry Voytik wrote:
>>> Hi Guenter,
>>>
>>> Thanks for reviewing the patch!
>>>
>>> On Fri, Oct 16, 2026 at 8:21 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 10/4/26 14:37, Dmitry Voytik wrote:
>>>>> Fix the issue when WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =y,
>>>>> and always is =m.
>>>>>
>>>>> The issues can be reproduced with the following steps:
>>>>>         make mrproper
>>>>>         make defconfig
>>>>>         ./scripts/config \
>>>>>           -e WATCHDOG_CORE \
>>>>>           -e WATCHDOG_PRETIMEOUT_GOV \
>>>>>           -e WATCHDOG_PRETIMEOUT_GOV_SEL \
>>>>>           --refresh
>>>>>         make olddefconfig
>>>>>         make mod2yesconfig
>>>>>
>>>>>         grep '=m$' .config
>>>>> returns only CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL as module:
>>>>>         CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
>>>>>
>>>>> "make menuconfig" doesn't let it to be switched from =m to =y either.
>>>>>
>>>>
>>>> This does not explain what the problem actually is that is supposed
>>>> to be solved with this patch. Since this is just a selector used to
>>>> enable other configurations, and the configuration option does not
>>>> result in any packages built, "WATCHDOG_PRETIMEOUT_GOV_SEL can't be
>>>> set to =y" on its own is not a problem.
>>>
>>> The issue is that
>>>     make mod2yesconfig
>>> doesn't work as expected. Help says "Change answers from mod to yes if
>>> possible".
>>
>> This does say "If possible".
>>
>>> I might have misunderstood it, but I thought all configs should be =y
>>> for this make target.
>>>
>>
>> $ make allmodconfig
>> $ make mod2yesconfig
>> $ grep =m .config | wc -l
>> 51
>>
>> Not really.
>>
>>> Maybe a dumb question, but why does only this config have " default m"
>>> and others use
>>> "default WATCHDOG_CORE"? Does it have some special meaning with "default m"?
>>>
>>
>> Again, this configuration option is only used to set the (default) value
>> for the watchdog pretimeout governor, and the "=m" states that the default
>> should be WATCHDOG_PRETIMEOUT_GOV_PANIC=m, not =WATCHDOG_CORE.
> 
> This doesn't explain why it's =m by default.
> 
>>> I want to have no modules and still not disable the module load
>>> ability, and it annoys me
>>> that some configs don't allow "=y" :-) otherwise when I do
>>>    grep '=m$' .config
>>> I need to remember that CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL is a special case.
>>>
>>> FYI, for Arch Linux based config, only
>>> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL pops up with =m.
>>> A fix for the same issue with CONFIG_TDX_HOST_SERVICES seems to be accepted:
>>> https://lore.kernel.org/lkml/as04AoNxjzlvh-K8@thinkstation/
>> You are comparing apples with oranges. That commit states:
>>
>>     Fix the issue when the driver always gets compiled as a module.
>>
>> There is no module that can or will be compiled based on
>> WATCHDOG_PRETIMEOUT_GOV_SEL.
> 
> Sure, I understand that. What is the semantic meaning of making it by
> default =m? And why can't I make it =y?
> I understand the build artifacts are the same, but I'm curious why =m?
> Why WATCHDOG_PRETIMEOUT_GOV_PANIC is not =m by default?
> Thanks for the explanation in advance!
> 

The idea is to build WATCHDOG_PRETIMEOUT_GOV_PANIC as module
by default. There is no "why" to answer. Why build anything as module
by default ? Are you going to question all those 478 default=m
configurations in the kernel ?

You still do not explain what actual problem you are trying to fix,
except that WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =y, which is
not a problem. The only problem I can see is that you don't like it,
which is not a reason for making any changes.

Guenter

