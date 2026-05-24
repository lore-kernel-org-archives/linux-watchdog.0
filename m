Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A713932C0
	for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779636178; cv=none; b=S1TtdGNVNoGaQszfCenSt9VVh193fLO0U+HKYGMCWBGtsUvVbkrozqTaA+JExEGJ9ld2FZsYcYgq3m6yzmNmlTN4UHvNpTwVugQ9vk+QBjxMe/gMh+kZj642a/DdVu0rmyeDVtDkqEVMK2EaNX6mt6cEQt73plC06sKaZFpVP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779636178; c=relaxed/simple;
	bh=OsuzESaKSmF6HzeTYOKV9fehkmNs5L4ihAe/ZJszXfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7f2XE1njeV0WxmRfA5POCdcSziAQ72pZZYFu/gdmwzBfBqL/f7AgU9+lxNG63PE7qxa3EuVs3e7wfRA2d2LNURBDIVJFwYNq0N+FN58B2xir7OyvWGvfBr5pMq7NVP7Mbu//l33p/gTd0g/MNvAKAXm/+d/5paNbpLzygJDiaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqjfGRWK; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqjfGRWK"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2f7020a928eso12830947eec.1
        for <linux-watchdog@vger.kernel.org>; Sun, 24 May 2026 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779636175; x=1780240975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0Wc9xFCjODhf1o834spKeK2iKybTUN+RVgChSd7CmZo=;
        b=WqjfGRWK2JX3oXv45O67cxLrhMxQmVRBBDJwwvZZunGfFfMS8qsp2ZAecpDmK4AzsO
         lv1xV7M2XqOlhFxxyVcOrhYN4bIWq2ySInRdmjNrBfQiJgw5GxM+OZm4+xJYDlmcjk4X
         PDLmqkG9qpPjl57zCw/iQpkPkxwWBRROT0EIwsSK5axugtSK+MHW4br0uim1a2vXmSa9
         PdVw1OqnDCUs9xxP7NHKaHo/iCM8EjRUI9SlJn1zr0urOYcX6y3ff91oUqbIve2PXacc
         oLRD3SKJkW/tc0LXBVaX2dNWrCvWNwom7n2F8qTdQfpGHyTMfKNnoHCNKX9FO5GgHjhj
         IKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779636175; x=1780240975;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Wc9xFCjODhf1o834spKeK2iKybTUN+RVgChSd7CmZo=;
        b=FKn7wuHdTPoo7eH8i+B3aQTSNETbn8eTGRMNU0SBxoMtGrYwobXWKpuwLjaRgD1k1V
         rD9L99wqzGVq406eG4uVWINcFWFj4jPazMZrBOwmzeHNR+2NAp+aabjH53dSgLwXbrYe
         GK/3u9AlzYpKWjNoqWPCdXl7VBOzglut95bA9ADIkM/pj4mq/j3Du3xl0UnyN6d1e/74
         /rGd8rJLPeSy3f5sqHStM+ewJp2WpW7WjYmk2kjuyQDijRu6si7Dq8xUy7NrjXEbFCDd
         l2fgySw2F/pavOamXYfvJEvTUYcAsNZSUrd7ns8NKLmd3LXHNa59bAPpnqfLaeiuoXVN
         3rxQ==
X-Forwarded-Encrypted: i=1; AFNElJ+itxmEVTXQPHQPnzTJuvaO6t2cLB7OEg4Rrn+UrOecWhvJKpAa98Y25mDt/lGPc18kzeBPY+VSxdNqofgKEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwME/fI9o8zXkJ5YTqoa/gHwFlYTPRAKxEKG9DBrbOZEvAuOWqK
	rTgPpcm9QFmAiAVoKeAO7+pbMq0DktZbd41N+ylK7ctr2ciB2FuS4ADY
X-Gm-Gg: Acq92OEzUqN7bKtAxuitOKzc/2Wm0K0Bwwm8eI8pHck5jX1KLS/239PcwwqV7KBc+p9
	4ylJrIRZdlNDrJHnnNeA9RC1CtaQnnnzjJ5UwvPig4WVeYsZzuxkDcEcA9jnRMd1TGdufLcXV8K
	PVWVc+InRNzaTVV1Kp0RvKxEeTsyHhy/ej3NYd0wei/5/WU1VKzVaSvgyyF5AA/p5jYmJjjyTBU
	+Kjyc8abgG438K0DH6hRV6tp9k7JxT9kGoO/5e1JMNh+qa+jTKRfMKK5FEHcCoBML2XLJfPejP2
	gG5AirziRlF4APijNObrwI3anfStQ36lAWEQ49YEWrBZKXNnFS3JNYdVg5BARSfuvPRFhVxUbJ9
	OPJ2kNCi70ZjqpwEkUKCPMWvJJNFu+P8KryLENfDtfzCwjPcCe3JobKMlO38VKDsUEm4R+OHYD4
	/POT/bUndQWEjqZ5yezTksruDKwN29bxZb+bekzcRUFTNUToNzrMUREHi9Xktr9IZWl3EtFCwV
X-Received: by 2002:a05:7300:ef82:b0:2ed:e14:7f5c with SMTP id 5a478bee46e88-3044922ee86mr4756548eec.32.1779636174650;
        Sun, 24 May 2026 08:22:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ca2d80sm7372684eec.0.2026.05.24.08.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 08:22:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c6375856-be1b-4c87-9673-e59bd3278718@roeck-us.net>
Date: Sun, 24 May 2026 08:22:52 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: core: assign parent with devm registration
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linusw@kernel.org,
 open list <linux-kernel@vger.kernel.org>
References: <20260524022332.179202-1-rosenp@gmail.com>
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
In-Reply-To: <20260524022332.179202-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/26 19:23, Rosen Penev wrote:
> If the user did not pass a parent in the struct watchdog_device
> then use the device used for devres as parent.
> 
> This is quite intuitive and can help avoiding having to
> assign parent explicitly in every driver using devres
> to add the watchdog_device.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   Linus: hope you don't mind me flat out copying the description from
>   https://lore.kernel.org/all/20260427-gpio-mmio-more-v3-1-fe1882351424@kernel.org/
>   drivers/watchdog/watchdog_core.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 8300520688d0..726c85debabc 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -440,6 +440,13 @@ int devm_watchdog_register_device(struct device *dev,
>   	if (!rcwdd)
>   		return -ENOMEM;
>   
> +	/*
> +	 * We are passing the devres device here so if the user did not pass
> +	 * another parent, it's this one.
> +	 */
> +	if (!wdd->parent)
> +		wdd->parent = dev;
> +

I understand that you consider it to be garbage, but in my opinion Sashiko has a
point. If the watchdog device data structure is static, wdd->parent will be retained
over multiple remove/reinsert instantiations of the driver, which in turn would result
in subsequent UAF. That means I can not accept your patch.

Guenter

