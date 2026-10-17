Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D413CCA19
	for <linux-watchdog@vger.kernel.org>; Sat, 17 Oct 2026 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792273370; cv=none; b=XOTkg4tqkclEQqFgqJEp3uYZi1TdmHgI+jJW+GVOGlsn9ti0PJmmpl9J/i8UOK35usvAYheSuEOBnzlDBYMcGy8z4BTKZJ8WqNghGgKVUu/dBKYyeur4P0Cbjgicrg0/jWVt1ye4zbslaHw9vxvVx+BDKQIhrpjDI6Z9/G5M+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792273370; c=relaxed/simple;
	bh=vwce9QZh0YjGdk0hHH3KPAT02bmznkKX2olAZ3xxR0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGsmUJoROS2G6UiFl/beJDC8BkDKMhNxQDwSTzjd3a183mGCQM3N2OR4/c85u89Pf+BAxIxF65unt6nyiVuBYo+mV8HIMQeKsEchLRGmb7xMsaNOuWyNiGcyGUd8Jc2AwkPRiTGYwFT0KIB2Lvlm+k0vAhktzI7XuQ3dbDUzC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTuj0bY1; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTuj0bY1"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so667222a91.2
        for <linux-watchdog@vger.kernel.org>; Sat, 17 Oct 2026 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792273369; x=1792878169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NtMtMcjvDiG/mkJrZNZLBZRrz/fsXp09ZdXXjXeDy2k=;
        b=HTuj0bY1ozCot516edn2bkUZKEzjnil3GVwOWT+argL9IjufuoolVPvpTsvrwR8U3N
         OhjvZXLCV/HBvnz1KF75tPQeyuMKhQOJmiuLxhIDtTqbySBVfExEqlt4na//pwxeSRyM
         KYikQGzRxhK/6HZ/Zo9W3RLYngt74T1oE0/x+Q2Ydg9EF2V/RA8FnXkkVGhSRkRajF/1
         pHWzP9HqbL99s6JAN44IRMO8uh6RThQHg49XROyA7w47gfQM0J/q9nA50ZZuxk0Z9vCl
         h+AuHrJbYLp4TxOn8CfIm9vpBDb56MTVIT8wgr7ew7Q3bHdkdsn79OMWT9Ea4jpIWAiV
         8dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792273369; x=1792878169;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NtMtMcjvDiG/mkJrZNZLBZRrz/fsXp09ZdXXjXeDy2k=;
        b=fEmZJaO0nzNs+XjkTYQ4NXOvVrwCqT+ZDMQRj0l/7lJh5uEAjDE2rBSrROceclwemM
         y94euWhKfxyAytHx47MTwUCmvOlPIanGXNm/qPgFrWOfe0GcCV/lJgJesNfwpWL61ZVt
         3nkraDrHv0g/x0wIPMJj72hz3Yk85E+zKWuq6JMn8YLd/tiVP2hZ5+Wg76wMBbAg2Ncw
         /sEp4fbb8n6LZaC0UZxDwVNfVHYL76xKVnt+lbQJXkzFB/Z3dPT0brFKpCrYtlg0RbXG
         m8YcUNeWHii5lsn2yn2mRSuldGQu6hzrpIhIzlaUYGkQwxBOlV3qunzu5SZ1iXGxZJwt
         LdHw==
X-Gm-Message-State: AFq9FYKUQQ+Is5YXVFSOFOw8HBFwQyye/QfE72hfZ3vQ7EwEvoHWXNRy
	+txVRf/VWUnXMhaDmANC+998wMJeeiPFVnZr7nrseBw18XYGgaySrVipuJZVYA==
X-Gm-Gg: AYBFou11fMYHa0QqMkIYlGS+7ZZwhVyKt840e6Uq/kYEQCMoCO1vPYef0wNw9s0HIwk
	+W84vgz1lriKTLBOC9C4z1NQFHXuYppUPosHfIcoAlHNjtWz/Nwbt8rYtMe8xPo65DhBcinYq/M
	McBj3ZU7xEi53pO8Te8hrTPbKgdfMkO3Pd3gpyY9bCQQmJzyFZvUPGpPlhJ/1p8Axv+yAvJ4o8G
	VxP58XixPBg8tOm9yfDqPnG6oD7fX8zDtxD5PXZfcOQiN8jk9I3Qki+GX0dnK1W88XVs2eSl33b
	V3Ih68JzO193yGtbZA8e9DTo9lkIk/6V5N9yn2EBSTkGpYwG2YhJwCavcmIEPyO67+Y25rsGqPs
	Z1WvBPuvPihJW/qUTlLbBxn+FwVqpJyhpqXAIES1YuKI1EJcvP8fRTPglRFlcINKAU4NENa1d69
	zIjtr1LviKQLLPbMPNQ/BYmr/uTU/ibzvwhk9JBwwsMy6WWhBrfG7FamodAQDWxM6Eh0lg4YFNl
	5CWx3wE749P2BWAgF29/zktl30T8cwaZ57Fj68QbSGMV4rL
X-Received: by 2002:a17:90b:3889:b0:3ac:b6eb:e0dd with SMTP id 98e67ed59e1d1-3acef5961c5mr2822459a91.50.1792273368623;
        Sat, 17 Oct 2026 14:42:48 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd654a15c57sm2544966a12.25.2026.10.17.14.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2026 14:42:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <053269a6-41ab-41eb-8756-b6a04eea2e5a@roeck-us.net>
Date: Sat, 17 Oct 2026 14:42:45 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: allow WATCHDOG_PRETIMEOUT_GOV_SEL=y
To: Dmitry Voytik <voytikd@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261004213755.554191-1-voytikd@gmail.com>
 <e7c99dc5-dfa4-4ce7-b7da-a3a70a2710a8@roeck-us.net>
 <CAAX90H0qGF-H8BYcmT_vbUGoqN9RbfeGxMdTTRyQPK_h8MzFhA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAAX90H0qGF-H8BYcmT_vbUGoqN9RbfeGxMdTTRyQPK_h8MzFhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/17/26 08:59, Dmitry Voytik wrote:
> Hi Guenter,
> 
> Thanks for reviewing the patch!
> 
> On Fri, Oct 16, 2026 at 8:21 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/4/26 14:37, Dmitry Voytik wrote:
>>> Fix the issue when WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =y,
>>> and always is =m.
>>>
>>> The issues can be reproduced with the following steps:
>>>        make mrproper
>>>        make defconfig
>>>        ./scripts/config \
>>>          -e WATCHDOG_CORE \
>>>          -e WATCHDOG_PRETIMEOUT_GOV \
>>>          -e WATCHDOG_PRETIMEOUT_GOV_SEL \
>>>          --refresh
>>>        make olddefconfig
>>>        make mod2yesconfig
>>>
>>>        grep '=m$' .config
>>> returns only CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL as module:
>>>        CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
>>>
>>> "make menuconfig" doesn't let it to be switched from =m to =y either.
>>>
>>
>> This does not explain what the problem actually is that is supposed
>> to be solved with this patch. Since this is just a selector used to
>> enable other configurations, and the configuration option does not
>> result in any packages built, "WATCHDOG_PRETIMEOUT_GOV_SEL can't be
>> set to =y" on its own is not a problem.
> 
> The issue is that
>    make mod2yesconfig
> doesn't work as expected. Help says "Change answers from mod to yes if
> possible".

This does say "If possible".

> I might have misunderstood it, but I thought all configs should be =y
> for this make target.
> 

$ make allmodconfig
$ make mod2yesconfig
$ grep =m .config | wc -l
51

Not really.

> Maybe a dumb question, but why does only this config have " default m"
> and others use
> "default WATCHDOG_CORE"? Does it have some special meaning with "default m"?
> 

Again, this configuration option is only used to set the (default) value
for the watchdog pretimeout governor, and the "=m" states that the default
should be WATCHDOG_PRETIMEOUT_GOV_PANIC=m, not =WATCHDOG_CORE.

> I want to have no modules and still not disable the module load
> ability, and it annoys me
> that some configs don't allow "=y" :-) otherwise when I do
>   grep '=m$' .config
> I need to remember that CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL is a special case.
> 
> FYI, for Arch Linux based config, only
> CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL pops up with =m.
> A fix for the same issue with CONFIG_TDX_HOST_SERVICES seems to be accepted:
> https://lore.kernel.org/lkml/as04AoNxjzlvh-K8@thinkstation/
You are comparing apples with oranges. That commit states:

   Fix the issue when the driver always gets compiled as a module.

There is no module that can or will be compiled based on
WATCHDOG_PRETIMEOUT_GOV_SEL.

Guenter

