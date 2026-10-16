Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A5F487CC8
	for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174896; cv=none; b=XuZ3bXtB4SX4VRNRT6/lqflwwGfQY7AErbgB54bxpTErKSHJdbtUg60nt7RR2bB2a76kGXjK2VqCrlP/64cOc7VOSwXNEbTaDxXnNZIznqPg2dDWJD9xeNUGJhGVpnmv5uR6FSKkZ09z4SNGSzSDl87jtNX3TUpevPiqEUis5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174896; c=relaxed/simple;
	bh=P7O79ZLj5F0GGvTc/f2daAdUTh2Yqj6MHo++HqedS2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UIxrL9Tn/OMVavGa7nFQrqrsN2+WEz1750DSkpNInWfj7I0R8KmpIMWykHrVkjbJqVXjYRMAxHW2aofNGqcB2X8zvJeKsGIX0gBmogU4OMX0/8xkvgv6zWm/G25hvem6SWDEAOpRu4N3RiyyCT0MuClfKHGknAYK2634Mx6SaWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzKDmLGo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzKDmLGo"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ab98332238so246740a91.3
        for <linux-watchdog@vger.kernel.org>; Fri, 16 Oct 2026 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792174895; x=1792779695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cREHVSgVpsX1N2sYltHm34md8NvEm7EO4it+8u2tj/M=;
        b=UzKDmLGotnT2Rl3S0/CS3JqjQnQjkp+T8J+zN8QBdXuavTNlj4gP6yQNruDiigja4t
         kqGuwUNwQyXCymTyPZOtF/T3Cp5PW/5SBzS3zFydCkzCW6a0K01/0OfOfCWhAGHdCWnr
         MWC7fzxpuv/Mh3kQOlrfsKwhqINwqG7/yfZ6jFYXB5XTfKYTyxIQT9SlhCoJ1eh2Nv6F
         amRKr2QJL1Wcl9Q1Brcg6hm4NwtRB5UYxqoo/THlhNba2RtxXQzKxvRoW/ERO8ocHmQ9
         iHddyfQxh6GiWky48K+h6zcBXkiUSUsgnotttv+AOa9Ljrt4q4qTpCMOTaI7UDJ9kpU+
         VCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792174895; x=1792779695;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cREHVSgVpsX1N2sYltHm34md8NvEm7EO4it+8u2tj/M=;
        b=LiKbYFeFMCbtFce6XRameHAoJA07nvBzQIZzDWZsJQxVu8o8eWjRgtBNfsKojcdfKf
         1zVm3InEVMAkY22NXkCfsA3lRk7Wo8N1ELATTdBh3NCW39Xjqp/W6/ER4bCGDY71UkxK
         5V6Z5C0Pn5ZB0w0mtLZ+uinI7U6uGIhu6hrnB9Y2FiWfuaVmTN/xdNHma9e9LNMCcNcu
         DQCMnN/P6238INezVrgou8iJQje5DqVzbexLoU+GqKNFKrkmpJZuGYTdcdRh+dHM0o0T
         g2Phqqmo5i1f5/VAhWXPjtI2K4nJzrd/F1aphOkzO9CDDZdyIfJ9Wx+h/XTi/wdbcZWf
         wolw==
X-Gm-Message-State: AFq9FYK8GOyqMilZcxoRxkfWWxfQOhPKtXLc3fWJavkJI3c/naq9EHzi
	InnvzK06yhzg30eVhgjGC9LO6oWzAfmV+cjXuMJSjvfDAO+JlCm8sHPa
X-Gm-Gg: AYBFou2Taux1ah7ux2s9cMjWK5MYiG4fMn86Jg5EF3luWqwSGDyCQafbqDGfz6A6nwc
	p/OSPE6glXmhqv6mYzc05rm/7Rt2nPRJTkLFpZKn0DKWHW3jPq8E1NTFcKG4eZnWPkzpxqe+iFw
	L61ravX7y3ygoXdhoSqkU3oznp27p5mKinWTLz2zpWWBUN6Xam+vl8LoN8x40HPYskmW2hNz0VA
	s3CRuy3EahCq1Ac+h5jn0iphtTuq8vv3o9FUkpk3QQBquKevGtFE80caSVKpLjTjuwR0MEJ2su8
	I1ZEDxlaHr5evFcmXXfbbrkdPeLTCyFIh6wNfYHuP4bSeMiKYc7jYc2Jo58HGnKvOaRQNmXAnxl
	0wAnWZRB4VnteuIbrMuf/Cyb4b1NUS8KGb7+ZSShts7QH4f6ibioq2BZ8KqTniWUATmtYm6ADz4
	wWNdtM6n5ANZL7xzbT3BbPdZugJFWzQd6efyUfj1ucwN5348uOWXghjfamYiKzg1kujRfMM9nD+
	HS8Z3cETYMFUgDjqSbcCHWrBaVlU2suswAsyBsHMs18V630
X-Received: by 2002:a17:90b:1805:b0:3ab:c6d:2bf9 with SMTP id 98e67ed59e1d1-3acef5b0dd5mr547132a91.57.1792174894838;
        Fri, 16 Oct 2026 11:21:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4872861sm5616457a91.7.2026.10.16.11.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 11:21:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e7c99dc5-dfa4-4ce7-b7da-a3a70a2710a8@roeck-us.net>
Date: Fri, 16 Oct 2026 11:21:32 -0700
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
In-Reply-To: <20261004213755.554191-1-voytikd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/26 14:37, Dmitry Voytik wrote:
> Fix the issue when WATCHDOG_PRETIMEOUT_GOV_SEL can't be set to =y,
> and always is =m.
> 
> The issues can be reproduced with the following steps:
> 	make mrproper
> 	make defconfig
> 	./scripts/config \
> 	  -e WATCHDOG_CORE \
> 	  -e WATCHDOG_PRETIMEOUT_GOV \
> 	  -e WATCHDOG_PRETIMEOUT_GOV_SEL \
> 	  --refresh
> 	make olddefconfig
> 	make mod2yesconfig
> 
> 	grep '=m$' .config
> returns only CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL as module:
> 	CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=m
> 
> "make menuconfig" doesn't let it to be switched from =m to =y either.
> 

This does not explain what the problem actually is that is supposed
to be solved with this patch. Since this is just a selector used to
enable other configurations, and the configuration option does not
result in any packages built, "WATCHDOG_PRETIMEOUT_GOV_SEL can't be
set to =y" on its own is not a problem.

Guenter

> Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f7d0a0c2c0ef..712ebfa1c99c 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -92,7 +92,7 @@ config WATCHDOG_PRETIMEOUT_GOV
>   config WATCHDOG_PRETIMEOUT_GOV_SEL
>   	tristate
>   	depends on WATCHDOG_PRETIMEOUT_GOV
> -	default m
> +	default WATCHDOG_CORE
>   	select WATCHDOG_PRETIMEOUT_GOV_PANIC if \
>   		WATCHDOG_PRETIMEOUT_GOV_NOOP=n && WATCHDOG_PRETIMEOUT_GOV_DUMP=n
>   

