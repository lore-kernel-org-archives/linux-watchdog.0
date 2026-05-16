Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C895233723
	for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778956392; cv=none; b=YGWgk2P1bgYKDOWkW73A4Dswlkhj+UaB09La/i3HR6hZt8TUJIrAv4z5pbbX3y7mDXDgUfHiQfbIPP8hNZf/KqClEbA+r6OTnoPe35OrjB2qXsUZPA80N1qd8zjWxvn/7zLf9nQJszG99dpgiFSEeOWxXEcldK/ncQGXCGWIJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778956392; c=relaxed/simple;
	bh=hXHIWKI6wgxzSeQ2rxIsqxw4r79nivnOIlr62ncCho4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hK01Mg2Guq32l4SUyLn/SwcBTw9HUe2oyB/GUUnms6ZVEGtdBAL0F7Qaq48PZglSLrYf58ABFNe39Kk4jA3atICU4OI4o/0YrjVO4vLh7nxFEpFD+t2L2xmpnjZa7zsrAtkwMLlDx1pYHRA+yjOgplAGPQNK3wZQv980gbzsgLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ED8fhov4; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ED8fhov4"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12db2e415a7so353964c88.1
        for <linux-watchdog@vger.kernel.org>; Sat, 16 May 2026 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778956387; x=1779561187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=XUoL8IfXmhr3FEtdbxmowuhFwjumOfiDBF5o0m3Q710=;
        b=ED8fhov4gm+uqw4LiMcqJxiPqrnDxx9JsCF0UWf2x58SAHxtZJ+J6JcZPVQcLQvS8d
         6VgTSAh9KY/1gsko/2+VSfChbFdHeKPHSnYQz2ggy29H+F0bloJlA6xr52TEaN20VaXn
         jpFLvb2LbBF3AnMCcoW9jm/3TvmQlfEP4rdXx7KiTlpGZ0QWebtCsKxuEJnzSHx4ps8x
         JFhMGverxpzfy1sVHBxISQyyKjaiIA5dUUSkF0B9VYC6IX4lWEehJ+KpxyqRLvKRXn4g
         evMXyC3i/EgNkwLujvT8ly0ByVb42Wewg6qZTUqTSFx9FSMxSVgI/yGRsI4NYXyJ0m1D
         4GWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778956387; x=1779561187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUoL8IfXmhr3FEtdbxmowuhFwjumOfiDBF5o0m3Q710=;
        b=JsvGCZRvtgYAP77FEYK2qKA0pxCYsOLPfgjMqJqzJrsc0Cj8CkHJKA40ZC+jqWNFgl
         oVGHRQet7ejHDwHtDwqLW3xqP7IrayDfVyhrz+herPRC3z3ChH2fYkVdhzaHAwb1by33
         WVlnfYg1ly9P27jkHK7uz8tB6qU9cBJuH1wGCU45pfuUmTZqn2Yf6JAj7EGfu0aSAJVf
         2PKYePqP8s9tLUosoSpifZHZ6ZGfFELAtUTHICT672KWeyX0ENxshAKq34cgmMsvYRAy
         C0fpQv8K+jaGtQgV0UOYCJMCwpW/8+DWr0NPINLPGLUKbsdCtn4dtjASKjAZjjogGdGP
         TyyQ==
X-Gm-Message-State: AOJu0YwQoTv/UEc2EPlowMJ8g3idvLsGfvV/dpoQmLWqSJ/zCAdR90vQ
	ZdMWmWzjZgEqSAgftWxdFQjMyO2jCgkIkVtByIWfuvOButOfr+F8zkpDLYgJftLh
X-Gm-Gg: Acq92OHnIG87s2NNpZwfpdXoZc+hsEmRgBLxYuoEUcXoH+eJ+0m8AUapoB4w+oh6oRq
	S1npanYNQ2IHHYA3/oXpsllQIJoB7fUGwjUp4abome5df2uOE/ZqhyTo5l9y7sTrdUcUPBMykai
	WhX24pgT8IjuxxuPKPKiM3ZwqNx/eqShrgOLAHmh47vFKR7JLp4ahGrQmP1R2QsYiaIXNeDKRVG
	BvkYlBfpm+IallcPeq2MPpQ3n/wBoSJlOzPQYqaUkO08lyuRIKTY1Ga1ZGxaSM2XLUvuHF8evpq
	8RPrsLjyU4SwVLdlnlqOiJq4MKC0vJk7ofrl9Hu3oZJVuxVpQBvm9Tc5paClQFJkVpyynCr5n2g
	EqE7hNX5xVbkh0e2meCvLAZ1J95HeaRReNB+pSo5lTvmeQsj27oMWKoaeGEMWhQnp4tMy3h775e
	uO6wSjwv7qSSkwlzF8BagucD7t+QeAYmh8Tm5xksq/42shvMIr72/TVW1L0DiOJvn5klgR6ZAME
	d4nuYJjyx1om4AUQ6WyZQ==
X-Received: by 2002:a05:7022:438a:b0:128:cf5c:5356 with SMTP id a92af1059eb24-1350440ab6dmr3721112c88.5.1778956386620;
        Sat, 16 May 2026 11:33:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33aac9sm11334943c88.14.2026.05.16.11.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 11:33:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3dfcec0e-3ce9-440b-9377-deba8fa9f2eb@roeck-us.net>
Date: Sat, 16 May 2026 11:33:05 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] watchdog: realtek-otto: Change to use regmap API
To: Sander Vanheule <sander@svanheule.net>, Rustam Adilov
 <adilov@disroot.org>, sashiko@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 Wim Van Sebroeck <wim@linux-watchdog.org>
References: <20260509163101.722793-2-adilov@disroot.org>
 <20260509171602.6B74FC2BCB2@smtp.kernel.org>
 <1d8a4fa99fa1af9e41f255ec147a7571@disroot.org>
 <173f0f7d804d3b0f33b6584b8a592d2079c593e9.camel@svanheule.net>
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
In-Reply-To: <173f0f7d804d3b0f33b6584b8a592d2079c593e9.camel@svanheule.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/26 14:10, Sander Vanheule wrote:
> Adding back Guenter (and Wim) in Cc
> 
> On Fri, 2026-05-15 at 20:48 +0000, Rustam Adilov wrote:
>> On 2026-05-09 17:16, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential
>>> issue(s) to consider:
>>> - [High] Deadlock risk in the atomic restart handler due to regmap's
>>> internal spinlock.
>>> --
>>>
>>> commit a520c8e2203154ba331a6ae28f00daec074e62ee
>>> Author: Rustam Adilov <adilov@disroot.org>
>>>
>>> watchdog: realtek-otto: Change to use regmap API
>>>
>>> This commit converts the realtek-otto watchdog driver to use the regmap API
>>> instead of direct mmio accesses. It replaces direct read/modify/write
>>> sequences with regmap functions and selects REGMAP_MMIO.
>>>
>>>> diff --git a/drivers/watchdog/realtek_otto_wdt.c
>>>> b/drivers/watchdog/realtek_otto_wdt.c
>>>> index 2c30ddd574c59..e5e9cb480f4f9 100644
>>>> --- a/drivers/watchdog/realtek_otto_wdt.c
>>>> +++ b/drivers/watchdog/realtek_otto_wdt.c
>>> [ ... ]
>>>> @@ -199,7 +189,7 @@ static int otto_wdt_restart(struct watchdog_device
>>>> *wdev, unsigned long reboot_m
>>>>   
>>>>   	/* Configure for shortest timeout and wait for reset to occur */
>>>>   	v = FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, reset_mode) |
>>>> OTTO_WDT_CTRL_ENABLE;
>>>> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>>>> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, v);
>>>
>>> Could this regmap_write() cause a deadlock during system restart?
>>>
>>> The restart handler is often called during system shutdown or kernel panic
>>> in an atomic context with local interrupts disabled. Since
>>> devm_regmap_init_mmio() configures the regmap to use a spinlock by default,
>>> if a panic occurs while another cpu holds the regmap lock (e.g., during
>>> a ping or timeout update) and that cpu is halted by smp_send_stop(), this
>>> regmap_write() could spin endlessly and prevent the system from rebooting.
>>>
>>> Additionally, on preempt-rt kernels, the regmap spinlock becomes a sleepable
>>> rt_mutex, which could cause a sleeping in atomic context bug when acquired
>>> with interrupts disabled.
>>>
>>>>   	mdelay(3 * otto_wdt_tick_ms(ctrl, 0));
>>>>
>>
>> Hi Sander,
>>
>> I hope it is alright if i CCd you for this as i am not an expert on watchdog
>> stuff.
>> Wonna make sure this issue applies here before i proceed with the suggested
>> solution
>> to add .disable_locking to regmap_config without understanding the
>> consequences of it.
> 
> I'm no expert either, but AFAICT using .disable_locking would essentially mean
> all accesses are only protected by the watchdog subsystem. Which is also the
> case now, so that would mean feature parity.
> 
> I'll leave it up to Guenter to decide if this refactor is worthwhile or not.
> 

I don't mind the refactor, but it must not introduce a regression.
As Sashiko points out, either regmap needs to be configured with
.disable_locking set, or regmap can not be used in the restart handler.

Guenter

