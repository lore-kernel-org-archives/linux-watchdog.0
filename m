Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF24137C92B
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839727; cv=none; b=kzPECueqo2EqxJ0MjX/CkVkSqx28Xod/2iWwF5LVw356U9/nkCEUIl3oE5st4OQdz7BC92DjLc6fgzLjzqgtAmfO+qsJtu1jCGlyCb+r+YR6II756RtEtvuBwopCEJiKrJj6d0TNOo2vzrGeXrsR1KnAfK2HGSAPVfKLaMjYDPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839727; c=relaxed/simple;
	bh=fesvM0+k/ikzSZuAkZMavI6AP3yd+unG7hRJox32vao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZcKYVa80hm9qe2Fz+pBZ/sb7ykGrD3EGySVZ44F2gQasmisMHV/WqN0Z3PE6Ny2e/MUtdzsuCFsJNmDcoURS8AGudURviZPWuAHlTteKaCStjtmWIkqD6DoTqx0c4DRB+KGct0BDgPrrS9hMRQyJMUrAPYE82iGccoWzTUaJNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8a0wd4r; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8a0wd4r"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-852c481415fso2661683b3a.3
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 07:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787839718; x=1788444518; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5YG3sxWzk0CX73QWBF5zna1uNlS+BRXCJ02l1uWMRDQ=;
        b=H8a0wd4rWHr0zPUKFFGG2LqSUls5N6tqKJIHYh+D6tHRXiS7Kz0hPyjDq6tRbqe46Q
         U8zZCPQ/m0Tk+PS8JEPIVcBgW47QqrPEO+TgtZAf55+8J1BOfiwKWBaiYu8wctAKiB9G
         Ig9qPoe3IKxWYI79uNAdvpg9sZ6IxBVmMGiOuQaFttBJvvePYxvokmHyM7bjISEd60QY
         zWfZZImjR0HCZjmFJkQOTvbXIEGCFuP9eQZZwiBJO1GU4DaSCieJgHpMH4GXauHN80N8
         j229uG4MXsPaZN3l/oddySGDMhltqcxyFX5WcHNtdfqnss+r8ZPskL63RJTQ+5QkMMFT
         dlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787839718; x=1788444518;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5YG3sxWzk0CX73QWBF5zna1uNlS+BRXCJ02l1uWMRDQ=;
        b=Si1EpwoyApQuSdJ96OKUHlnCspLtCVlz7Ux0KMmyIJKZQC9KQHr/t/icCjqvI2N55p
         kqIX3ObYQTijidouQIR0Zyqyg0XpAFSssqcHU+LDyEposJegyviPOaHa8VS/DwjiItBB
         Q2AVmgT3NZzDR6DIeo1HeKHFjwjqxAcmNzAkVq99sRQtm4mUvsadKMYmAz7Ci6ZEY2Zw
         wVWPEV1TwJVz4gFhhLU/6LEq1v03zqbMrkebQRhGFLruhJOJQZ4J1yRbgBLwBn+pqNYQ
         YIjgb+lfoWsay5fL0xLH0VQiaSXQLs0fzfo3hfXsxLrzHMFQ/ET4axAdU/qc0IyGmOHI
         CA1A==
X-Gm-Message-State: AFuF++nI5/sKYbIUAejeAkpy1oC/FBXt1ifaVmBVwG693B7cauuTpB+G
	93pIANTIgnoMwnw5t666To6rXQ2LYbjfGJeUdumsl4E4gHCSxmTbUzWgTrfHVA==
X-Gm-Gg: AR+sD107/R2KgjE81KKXbRnGe43JUv/HEhw+desDRviCaULRqV44XDZzWdmFkTbSmcE
	HnPpL4QMjliE2nR+82pv5l8rNlz482NnwOm+bOPQmO2eOHGngoNFzlN6Bbu3kGKTAZxznWTMNJO
	TKj160Kc2w1r6JRoHy1tjEyE+Kg/ITmGhZ2UASfkXqp2lbhpWsxvivE8Aa1JZyHkgp/yDtGDKBY
	TUurX5Ul3PV7Wl4Gcl2KLqy+IVv3foktaoIszgdHfu14dUUlLXRZ+sOr+BOv+0zzlG1CWQphfcf
	Xq8usH03g6CAaWNDutJiNapdN1yefAfuzSbau+4i7HR3/ZfrEGBdNYlUXwDq/F6ApA69X7+lYIy
	Jbc1Ld6Gvc6XsFX5DHFT50JnW0si24k72oYpeYbX9lsN4iZCjUTKkzkfDwolVsy9rdWFoIOo4uN
	bU6obyA2bHfz/r+Xi9QjrJ4w+S3YjLYqzmmjpI+tWb4r2JYQOxw5WUHCs/y2A87mq4kA40C17GV
	ccaG/dTJrMsCX+6klTdbhYM/68SIXpXY/jYGw==
X-Received: by 2002:a05:6a21:2212:b0:3d0:ba81:79b1 with SMTP id adf61e73a8af0-3d0ba817b48mr20704346637.0.1787839717755;
        Thu, 27 Aug 2026 07:08:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1beae53e5sm2254786a12.7.2026.08.27.07.08.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 07:08:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <31820269-d0b2-4ca9-9902-0e20466a2fba@roeck-us.net>
Date: Thu, 27 Aug 2026 07:08:35 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] watchdog: rzv2h: Convert WDTDCR handling to regmap
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20260814191415.2110732-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 12:14, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi All,
> 
> This patch series converts the WDTDCR register access from raw
> readl/writel variants over to the regmap framework using
> devm_regmap_init_mmio(). This conversion serves as a preparatory
> refactoring step. It allows the driver to subsequently support
> syscon-based system controllers natively by passing along alternative
> regmap handles without forcing messy architectural branching at runtime.
> 

I do not see the issues reported by Sashiko addressed, nor feedback
explaining to me why the reported issues do not apply and/or are false
positives.

Guenter

> Note,
>   - This change was suggested [0]
>     [0] https://lore.kernel.org/all/c3ef312a-4c26-498c-90c8-118c6dc035a0@roeck-us.net/
> - Patches are rebased on top of next-20260813
> 
> v2->v3:
> - Patch#1, is split from v2 patch #1 to make thing easier to review.
> - Moved unwinding changes to patch#1.
> - Set use_raw_spinlock to true in regmap config as certain watchdog operations
>    runs in an atomic panic context.
> - Updated commit message to reflect the change for patch#3.
> 
> v1->v2:
>   - Dropped patch #1 from v1 series.
>   - Switched to use regmap_set/clear_bits()
> 
> v2: https://lore.kernel.org/all/20260715133922.2129340-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> v1: https://lore.kernel.org/all/20260702160457.1884345-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> 
> Cheers,
> Prabhakar
> 
> Lad Prabhakar (3):
>    watchdog: rzv2h_wdt: Propagate WDTDCR access errors
>    watchdog: rzv2h: Convert WDTDCR handling to regmap
>    watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
> 
>   drivers/watchdog/rzv2h_wdt.c | 80 +++++++++++++++++++++++++-----------
>   1 file changed, 57 insertions(+), 23 deletions(-)
> 

