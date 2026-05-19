Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82E814BF97
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232261; cv=none; b=DIO0FxEkTKJaiydM+f3HCXuffRKrhQxvfA2cW3BVICRYJRWpPsY7zabxkAZOw2Rk4xCguetQ1RiWDbngGMZb6ZX3unZgV31neBcHJbMnMqw5yZYXZu1WojO5I4uMBprL+B8Rv5Ig9s0qcocmvcJHIah+4zJrYePK6kbJvpj0LN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232261; c=relaxed/simple;
	bh=6FT9vQ8iOo+U0XQMMcRQrYI/37rpFRgkKvcbY93hGn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfFaDwE0DMdMX2LC6ATkKXIo5XJPyGENe98v1Gp9P5YDAkkxEakOQOBxHH/AMFUj62CbwfSsSc4skN23UxucB/c2atGBJT8vOJqBYKlzQdPfn0YRkarm8qr/LcIQnfLx/j9Edy6pMgfqkhYmwqhFuMT47FHJONA4zaNluXevcxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYVc9JkP; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYVc9JkP"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f00a567cfaso2674327eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 16:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779232259; x=1779837059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AqtVlzT98AWArYTxFsWIwCHdwPtWXmF7BOKYCzC0+3g=;
        b=cYVc9JkPCokToKMHO3/rl/U2d31+6r2D+32mO3eT1aWH7JqmRPtao+uzzs449ZEZpJ
         dr8yuEVSNn5G9SxEaM+INjpGfHDjNZTVVbZULtJ9N1RngANTcUAy6H3XP0JH5qUPRHXb
         VSh7mhBqbrCo1zi7ynXNgYHkbolOZ+wcW6JeapJwdfehA5eF26zodv5P442rkLqDR6Fc
         p9lWxhSlq4mfsTY4K+G4s9aYB33Ro8J0nx1xVSbftYLsT6HKt2B6/kReeQFW5bVwwHx4
         3+PqL1+5oOJgqjkpRG4/2HAm8+WUG7NJ0pnBxE7tktt3A5kRDdBizVPczSsTNvAz/OtT
         HmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779232259; x=1779837059;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqtVlzT98AWArYTxFsWIwCHdwPtWXmF7BOKYCzC0+3g=;
        b=Sq9G3hj7ShDT0HkvlYo5gq2iDFoKDonQJQTqFsYmbmQfBDfknvAUz7vZLA+eFBOMux
         6Nfvxb54wtZD2oblXh9IQW2pHsBTCM+JJ4w8eY3lZgNqw5fpM/JB81qxujr7tQ7/X+jW
         ozg+SptJCnKnDQ7Ap9+8TOqza24Oac6bQXtlfUu+XW8/sbkVLj+aLfkUNcgtfwTzCLeK
         DQ1en4ZfyBdqr9RuRkAtAbZXOBkuBHVhajxRN64y9so5YrPPSMWqWXoTTkBL/sX6O/c/
         x14EOi8kY4eDKJ6liv3lErBMMMO5r1g9keILUllAo0FU+4G4DakuDNCqNNnPP/lUsBHo
         b4XQ==
X-Gm-Message-State: AOJu0Yy786kpmlFnnCrBN2l/LMsabsKrM5/EvrC2f1wOmv6ZBt+wmEv1
	rEmuLQEuapdZY0TiG0wrime7HpQc33IxGV+q4FWzTmgTK0pPA8LeHh0r
X-Gm-Gg: Acq92OEfiCSwevqWE1AaaNmP4fyZgvwfIupn40jzE5YB1A2OaGbHfTNxwh6VvkTh/MV
	Ph006m8ekEYQQ9PaktiuMN26gGTWNw83GmObZev3eT+wLZqlYy1PZbH5DnioWBUwDgJ5l5BSdkF
	7R4oPcTXpQsdly7tXp/MDJEuNpYKE7qheM8aKKP7z45L3F520J6A/gGtH1hHxnb7RG4enju92No
	Y+cCIeShzeJMF8+xe/R8ptfipztQ1F1PpMSpwEQJ27LwjH6PiQEPZX0DlmmaTbsi5poERN6m1YH
	QXBCAJbTdmNWByV1EX/ipnqJIymCXdNqMi3ayUNWKcASAs/Qq1aWKnP7j/NDggdzTgJM61XWmew
	lQFeLyspkaSe71KOmwFBW+DvEAyfKiv0qDNP2eqwycset0shgwFvLVCd7/KwOIIgq0rQCzbetny
	K+t66NnylxGJKcP4PBTcMlCFY5l682jGqeDR4ie3nX9256YkzWG2qugvYgHrhQcbT/dGVR4hLap
	zykg3sxWwhzIV+O5wLoAQ==
X-Received: by 2002:a05:7300:1351:b0:302:c4c7:a18e with SMTP id 5a478bee46e88-303979e8e90mr9074098eec.16.1779232258949;
        Tue, 19 May 2026 16:10:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302944ffdf0sm18394515eec.8.2026.05.19.16.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 16:10:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a74ce1b6-06ce-4a30-a53d-79070a272a2a@roeck-us.net>
Date: Tue, 19 May 2026 16:10:57 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and watchdog
 management
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck
 <wim@linux-watchdog.org>, open list <linux-kernel@vger.kernel.org>
References: <20260519214229.16656-1-rosenp@gmail.com>
 <61a24e1e-2490-4791-811a-3c1c85fda05b@roeck-us.net>
 <CAKxU2N8pzaWow-pQ=gTkyvD=4JpZF77SN7F9pF9Ty78vkj65xQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAKxU2N8pzaWow-pQ=gTkyvD=4JpZF77SN7F9pF9Ty78vkj65xQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/19/26 15:44, Rosen Penev wrote:
> On Tue, May 19, 2026 at 3:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On Tue, May 19, 2026 at 02:42:29PM -0700, Rosen Penev wrote:
>>> Replace clk_get/clk_prepare_enable/clk_put with devm_clk_get_enabled
>>> and devm_clk_get_optional_enabled so the clock lifecycle is managed
>>> automatically. Switch to devm_watchdog_register_device to eliminate
>>> the manual remove callback and the disable_clk error path.
>>>
>>> Switching to devm in these functions is fine as the proper
>>> platform_device is passed in.
>>>
>>> Assisted-by: Claude:Sonnet-4.6
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> drivers/watchdog/orion_wdt.c: In function 'orion_wdt_clock_init':
>> drivers/watchdog/orion_wdt.c:82:13: error: unused variable 'ret' [-Werror=unused-variable]
>>     82 |         int ret;
>>        |             ^~~
>> drivers/watchdog/orion_wdt.c: In function 'armada370_wdt_clock_init':
>> drivers/watchdog/orion_wdt.c:95:13: error: unused variable 'ret' [-Werror=unused-variable]
>>     95 |         int ret;
>>        |             ^~~
>> drivers/watchdog/orion_wdt.c: In function 'armada375_wdt_clock_init':
>> drivers/watchdog/orion_wdt.c:113:13: error: unused variable 'ret' [-Werror=unused-variable]
>>    113 |         int ret;
>>        |             ^~~
>> drivers/watchdog/orion_wdt.c: In function 'armadaxp_wdt_clock_init':
>> drivers/watchdog/orion_wdt.c:144:13: error: unused variable 'ret' [-Werror=unused-variable]
>>    144 |         int ret;
>>
>> On top of that, the APIs are not 1:1 replaceable.
>>
>> I am so tired of this. Please stop. I am no longer going to accept any "cleanup"
>> patches.
> If I don't, the bot yells at me. If I do, you yell at me. It seems I
> am at an impasse.

The above is the compiler yelling at you.

Guenter

