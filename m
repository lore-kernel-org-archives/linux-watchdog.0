Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81556275B03
	for <linux-watchdog@vger.kernel.org>; Wed, 24 Jun 2026 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267690; cv=none; b=nfbCNCMeIe72o6PnVfRP+EXXtFXfCQ67iNmkW9yQwzxEFWixL3uzDRrJJ33KUGRu7gzkSq43srpqPRWDNRjJNhxP1eF3tjQ6zesoszkUqWy3rgRPWqvGfNhCcWgRhfb7h+UWBKzcKxTPSq/bZUnD+HRPLxKStq75LcghsvTBMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267690; c=relaxed/simple;
	bh=42cm9ckJfIQl4FKdiDBo3WjjTd9hs88gHxDvyyotou4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGdMJTnegFUjsheOwLxtg5BT7NScYLsM83qwReT0XQlJqjyyt1aPaWhjJazn83RDWkgqn/FnW6mVT2EeCblRAYuLgbPT9ZDdvEok58KdLf/CoiHMDpYufPNcEiOnyof+hGMWiA085JM+Kf0eFjfukEuZJbeuvieF/PuupUIb2B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2IfnAtO; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2IfnAtO"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30c09f29b64so439014eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 23 Jun 2026 19:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782267689; x=1782872489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gsPxiom7+of0XRbfxEb1B6mhW4FGcrdPonMB7NSZSig=;
        b=d2IfnAtOAY/8I6ndsocAgxcLIL0gkhLqGQIMPiqhYy/qWt55otASjGmZTuBo7NCbwm
         kIaDdguV50KIa/AFztgoSTz7f3dWVJxJ/3pOd36CuoaYaFViXUjV3OnNtWHm0uSAOtVW
         n2nXWm7SZZS037G1JXUGbrl0y8HLlrrGN1j3nVIMB817XbGFqoe4s4dmQbGW5d36/KRE
         qcwACudHcTo9miHkrT0ggVqNimRrKn9N0Z1mhnRkxaT21asyFLjmxAG0oaDASI26c06S
         Yjvim3+6K7h1hw7my+7+/+ZACA7H4QmVoiOVmL5XfffHqb730cFIgEEVXPNVrDRmbc8m
         PQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782267689; x=1782872489;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gsPxiom7+of0XRbfxEb1B6mhW4FGcrdPonMB7NSZSig=;
        b=EqiMCY5ytIjnlbbU7Q2INBToaMaYeVcBQZznb4+DdqQmq7cs6jYOVu2eBZkAo38jpt
         MKhgJim5VJvC++TBw4Z7yZ5pBj4gTAO8jtllNzjXg+4qMQ0Qg2y4XfWlD5+pE2XkN1pP
         ffZX9dutmCX1Mit/pCszJBvT7khSOf/fo7aqiAKkZtzHXOvryfXIiqCRmofOFBAcZ07K
         jKFcrtoGlZu5Dv3TE9YierKgG/UUMjUn1KoLXpsjifd/wlg9q68Ag8LMzy21FLbHreZj
         kk0nuEHvgt0HoqvAEyqJ8IOabt6LuUwLUOJnOwpyKYzUN+JQM31TRyzmMQQRbKnvWb8i
         QmMQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkOvu/vsg9T7fkDXnzl8K6ODyftk5fjmGouekeNXMQyTz0n3qSAVC79iGmrZ0r86sjox+Y4vliuBjo5lro+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDt+dsk+L4FIgqpnUx1JTplvygAPUjQj1RUMqNIGvccT5LUoVy
	i5pr6wGo5FKPYwruWnJb3tlLvgGRXUzK2ry5NZdB5sAJFbSCnh0mx7ri
X-Gm-Gg: AfdE7cnTGtncStokNcShT8OPhG0UFWv+phQfO6+NBy3fRrocNuY2/XjZcamgoVnjgNx
	T41mXsxbCV24V3CvelsRY8v/UKmLFQyC+ecSDlmAO/Nj8Ga9GAUONthZr3KBXfRCzk0cMz711JQ
	ncqYJKvEf+U+kAjugqAo2ubVrvSQ2ES9qb4Uz42vu+kiJMH9m0+6OgyelWHGaHOET2T+P7CUM5C
	bRcs/K+Hh5wwN+7KcSfnRlDlEvV2/BAmYC9pSWfgE05dpxA5PP64QV332IR3xI5N5dsDU6vca0P
	NoPZq9UF6REyRfDjIEuurkJopUxArwWrQHy46OVs7rNkU9Ux3UgCz1/eDtRnPSZdP4Ordl1NBKQ
	naoLLOmOYW0ofWCr1GF3c96r2pxe05kifrkXKSc1MqduCchiewcPKb1dNxHpVLyc9BM4vstev10
	B/5W+aY1fkt5r9S70zbLNdwrxa8OT4ud83uc/L8JNZgTJO2f2SGYin0XcBi/wt7xOcsfqGaOyx
X-Received: by 2002:a05:7300:1801:b0:2ed:a58c:942 with SMTP id 5a478bee46e88-30c5556303cmr6011221eec.8.1782267688564;
        Tue, 23 Jun 2026 19:21:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1c376sm21893073eec.3.2026.06.23.19.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2026 19:21:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6c516e9a-1dad-4c02-aedb-52168806bd21@roeck-us.net>
Date: Tue, 23 Jun 2026 19:21:27 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo
 SE30G2 and SE60
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <mpearson-lenovo@squebb.ca>
 <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
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
In-Reply-To: <20260622144531.2413447-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/26 07:45, Mark Pearson wrote:
> Watchdog driver implementation for Lenovo SE30G2 and SE60 platforms.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---
...
> +static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
> +{
> +	if (timeout < MIN_TIMEOUT || timeout > MAX_TIMEOUT)
> +		return -EINVAL;
> +
Unnecessary range check. Unnecessary call, actually.
See watchdog_dev.c:watchdog_set_timeout().

Guenter

