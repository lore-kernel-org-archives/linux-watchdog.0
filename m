Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6D13A3F7
	for <linux-watchdog@vger.kernel.org>; Wed, 20 May 2026 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779237544; cv=none; b=ltIQFViOnRPGJoT5f5oNpRlNKcuddrz6rWv2N0ve8lXJxUqOFHvWmzTmjO7v0p/s9EF540HNnGU2RFvy40JnP/kaGz0nT+YyZVhSem6BRtTwj62MiiBvOraExxNqvwCfK8osthn2rLiCCSrqUp1r/VNyiqG1tFbUj0paSjQ825k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779237544; c=relaxed/simple;
	bh=mYyNVOWtbjD/sSCBJJ2pB/k0OYShG9aJ75JZn/GrWSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8Yq+oEpRA4sk0SsVPDjuz7g2lsUN8n4pF7tJcd+/pEVb1lOOplaFAmi6jFNID2M+uU0a1nYytpi8R+eKUKbEnvUI38hVdsFdY32RotVuzxLfSwir1BMp/sarhRxL8gHuxdgWnI9afpoZ0zmGlYMtVCOjkdf6YWD9q74Ry40uoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSO2T2st; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSO2T2st"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f8893bff3so1942614b3a.2
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 17:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779237542; x=1779842342; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mevsGGnqPIhP4Y/7CpaBdXAIE1/wiBFR9v9vGz9YGiQ=;
        b=nSO2T2stLu5EXlaE0BwP/4SzMs0t615pcNDiKQwriaMURyipnHYBh8aTfhrRk11IOm
         aE7I7D+vfxCAXo7PVp0D8QfhtDHLvNn+NK8ZirlN8FIBFPh6ovaH1+BoyNyLJB6adz2D
         n2MvnWii37Z55hrTdN10NiKgUVJEngIz76xT8bTaMWM/+jn4+qi5cfR+XakZ+iOEAB+H
         ze2QntFlQMHUHMl6WHrvALFD9Dd6RyXnzh+LzW8VXQ8XJF1ZtFAQpLvgfPMvjJPpjMXs
         Zm2ju2mqViNiELjWIBB/nGoGZ7/UoabfQ+zlfMnYnaZOLOrmNItXkNWdhSMV9/NJVr/e
         3RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779237542; x=1779842342;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mevsGGnqPIhP4Y/7CpaBdXAIE1/wiBFR9v9vGz9YGiQ=;
        b=VtLfwEGWNAsA9D2/hmFg6/hv/AmA1Z1GlIE8xn0RAqFpcELYJpdoI1Ts5soSONN8bt
         nF90nzPpU+C1FNxTxDVHlickL5YyuOoqWP+BlhkMhH/Tx0uoX4MM4InMS81O4bSJQEfv
         7xmSHE4TKr077BgVX0ABj+rRYaLoj3IOgeutZheJoEij37G02Yi/YllcLVq0uIoal7IP
         A5plEg5c+yRXG0leylqnHhKu9L5vIkuA5IPfy65+WRxBHgIs+3bcLV/0IQ1REPpekfcV
         RvZR5wn5XRxEH8DmnaezGp8otrOynVFzsco4lCnbsIpcEabaXappIsBLGAdn+og7ThMN
         UlgQ==
X-Gm-Message-State: AOJu0YyV3PVznf2BzKY+7DJz/Gzl91rKbZ4q1UtO+pPqlw7IzQLMLxZB
	1397R74RtpZslc08COc54zxq8DmLO4dRqd8dX1EUhzbW1xP2ICkMQQaZ
X-Gm-Gg: Acq92OFAd6pW9UViK3JCeWp5YygGUdQxNMwl8XwGnU5lFvvQSQCd3JAli1V/PUxKa8T
	Wyc1FLqjz0iItQun/pbXJW4FlobH/8HVwBHnFyNrNKdDtdP3SYCFW60g/a3EeF/edAOsvgTrwVV
	Vo3sDEI4BOW8JDGElGgWNlMQv504gvqiUtm5dPlgr0QHQB/ofjd/+nFEzt7/WXYCH50hMF8wy5J
	vNB3BADssxiqHjpITanIwxZneFYrOX2avcKByd0Ouv7n+XsfGXvBTbyMbBjpCSzW7MNzOSTu8Oi
	6ePZIwlptwe5YfqARCrKtlqb0LMJBq1POXlPyWX9K2QNPr5mXnFUTvhtcvFxin+SMX3okAVH8TQ
	LYzv6YwswI0BI/TcyqC/MBJP9lXYcf8TLatCbBG0K/nflw40U/OE4w7+4ILrttPGZH8Do07TVPu
	03SCP5DUfd/ftSYvgONyRshhw/bjE4CO+K10fp6kXvFjfZwMTI8CDjiCiFKq9fjxt2VfRUKZln7
	7G/XAfqPkLYE/xBRrtdyA==
X-Received: by 2002:a05:6a00:1ca4:b0:82c:6b1b:7ad4 with SMTP id d2e1a72fcca58-83f33bc808emr19652315b3a.3.1779237542172;
        Tue, 19 May 2026 17:39:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7ed3fsm18977149b3a.45.2026.05.19.17.39.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 17:39:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ad3215f7-e4d5-413e-982f-efd859be1580@roeck-us.net>
Date: Tue, 19 May 2026 17:39:00 -0700
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
 <a74ce1b6-06ce-4a30-a53d-79070a272a2a@roeck-us.net>
 <CAKxU2N-2rA7GQZGoBQdkJLvWeSZNbfUqzNvEOoBskzc1FjcH=A@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAmgrMyQFCSbODQkACgkQyx8mb86fmYGcWRAA
 oRwrk7V8fULqnGGpBIjp7pvR187Yzx+lhMGUHuM5H56TFEqeVwCMLWB2x1YRolYbY4MEFlQg
 VUFcfeW0OknSr1s6wtrtQm0gdkolM8OcCL9ptTHOg1mmXa4YpW8QJiL0AVtbpE9BroeWGl9v
 2TGILPm9mVp+GmMQgkNeCS7Jonq5f5pDUGumAMguWzMFEg+Imt9wr2YA7aGen7KPSqJeQPpj
 onPKhu7O/KJKkuC50ylxizHzmGx+IUSmOZxN950pZUFvVZH9CwhAAl+NYUtcF5ry/uSYG2U7
 DCvpzqOryJRemKN63qt1bjF6cltsXwxjKOw6CvdjJYA3n6xCWLuJ6yk6CAy1Ukh545NhgBAs
 rGGVkl6TUBi0ixL3EF3RWLa9IMDcHN32r7OBhw6vbul8HqyTFZWY2ksTvlTl+qG3zV6AJuzT
 WdXmbcKN+TdhO5XlxVlbZoCm7ViBj1+PvIFQZCnLAhqSd/DJlhaq8fFXx1dCUPgQDcD+wo65
 qulV/NijfU8bzFfEPgYP/3LP+BSAyFs33y/mdP8kbMxSCjnLEhimQMrSSo/To1Gxp5C97fw5
 3m1CaMILGKCmfI1B8iA8zd8ib7t1Rg0qCwcAnvsM36SkrID32GfFbv873bNskJCHAISK3Xkz
 qo7IYZmjk/IJGbsiGzxUhvicwkgKE9r7a1rOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAmgrMyQFCSbODQkACgkQyx8mb86fmYHlgg/9
 H5JeDmB4jsreE9Bn621wZk7NMzxy9STxiVKSh8Mq4pb+IDu1RU2iLyetCY1TiJlcxnE362kj
 njrfAdqyPteHM+LU59NtEbGwrfcXdQoh4XdMuPA5ADetPLma3YiRa3VsVkLwpnR7ilgwQw6u
 dycEaOxQ7LUXCs0JaGVVP25Z2hMkHBwx6BlW6EZLNgzGI2rswSZ7SKcsBd1IRHVf0miwIFYy
 j/UEfAFNW+tbtKPNn3xZTLs3quQN7GdYLh+J0XxITpBZaFOpwEKV+VS36pSLnNl0T5wm0E/y
 scPJ0OVY7ly5Vm1nnoH4licaU5Y1nSkFR/j2douI5P7Cj687WuNMC6CcFd6j72kRfxklOqXw
 zvy+2NEcXyziiLXp84130yxAKXfluax9sZhhrhKT6VrD45S6N3HxJpXQ/RY/EX35neH2/F7B
 RgSloce2+zWfpELyS1qRkCUTt1tlGV2p+y2BPfXzrHn2vxvbhEn1QpQ6t+85FKN8YEhJEygJ
 F0WaMvQMNrk9UAUziVcUkLU52NS9SXqpVg8vgrO0JKx97IXFPcNh0DWsSj/0Y8HO/RDkGXYn
 FDMj7fZSPKyPQPmEHg+W/KzxSSfdgWIHF2QaQ0b2q1wOSec4Rti52ohmNSY+KNIW/zODhugJ
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAKxU2N-2rA7GQZGoBQdkJLvWeSZNbfUqzNvEOoBskzc1FjcH=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/19/26 16:19, Rosen Penev wrote:
> On Tue, May 19, 2026 at 4:10 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 5/19/26 15:44, Rosen Penev wrote:
>>> On Tue, May 19, 2026 at 3:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On Tue, May 19, 2026 at 02:42:29PM -0700, Rosen Penev wrote:
>>>>> Replace clk_get/clk_prepare_enable/clk_put with devm_clk_get_enabled
>>>>> and devm_clk_get_optional_enabled so the clock lifecycle is managed
>>>>> automatically. Switch to devm_watchdog_register_device to eliminate
>>>>> the manual remove callback and the disable_clk error path.
>>>>>
>>>>> Switching to devm in these functions is fine as the proper
>>>>> platform_device is passed in.
>>>>>
>>>>> Assisted-by: Claude:Sonnet-4.6
>>>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>>>
>>>> drivers/watchdog/orion_wdt.c: In function 'orion_wdt_clock_init':
>>>> drivers/watchdog/orion_wdt.c:82:13: error: unused variable 'ret' [-Werror=unused-variable]
>>>>      82 |         int ret;
>>>>         |             ^~~
>>>> drivers/watchdog/orion_wdt.c: In function 'armada370_wdt_clock_init':
>>>> drivers/watchdog/orion_wdt.c:95:13: error: unused variable 'ret' [-Werror=unused-variable]
>>>>      95 |         int ret;
>>>>         |             ^~~
>>>> drivers/watchdog/orion_wdt.c: In function 'armada375_wdt_clock_init':
>>>> drivers/watchdog/orion_wdt.c:113:13: error: unused variable 'ret' [-Werror=unused-variable]
>>>>     113 |         int ret;
>>>>         |             ^~~
>>>> drivers/watchdog/orion_wdt.c: In function 'armadaxp_wdt_clock_init':
>>>> drivers/watchdog/orion_wdt.c:144:13: error: unused variable 'ret' [-Werror=unused-variable]
>>>>     144 |         int ret;
>>>>
>>>> On top of that, the APIs are not 1:1 replaceable.
>>>>
>>>> I am so tired of this. Please stop. I am no longer going to accept any "cleanup"
>>>> patches.
>>> If I don't, the bot yells at me. If I do, you yell at me. It seems I
>>> am at an impasse.
>>
>> The above is the compiler yelling at you.
> No I mean my watchdog: orion: Use of_device_get_match_data() patch
> resulted in the AI complaining about clock code that I didn't touch.
> 

Problems with your patch:
- It was not identified as bug fix
- It explains what was changed, but not the underlying reason.
   "so the clock lifecycle is managed automatically" is not an
   explanation and does not explain _why_ the change is necessary.
- It has no Reported-by: tag
- It does not compile
- The APIs are not 1:1 replaceable. At the very least, replacing
   of_clk_get_by_name with devm_clk_get_optional_enabled() in one
   function and with devm_clk_get_enabled() in another is very suspicious
   and asks for a detailed explanation.
- Given that you tried to compile it on ppc very much suggests that it
   wasn't tested, and the limited test status was not mentioned in the
   patch (not that testing would be easy, given the different means
   used to get the clock).

In such a situation it is much better to respond to the agent e-mail
and tell it (and me) that you understand that there is an unrelated
problem, but that you don't have the knowledge/understanding of the
driver and its requirements to submit a fix.

Guenter

