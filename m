Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE0F3DE43E
	for <linux-watchdog@vger.kernel.org>; Mon,  4 May 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903626; cv=none; b=Ax2WDqkVZfXftgcXK8NtoIjvf8byvqJzH1527FOcYM2RlhkITMBpu8w1Uui2E+3VtKbhPV4ZfiQh6GGefjtyqUoJYh23WlnV7cpXkxN7cpZLhx76D4zI1VfeQYEHhCxFMuZ9zRes56Sxalb78V4OdMUYidoDg6z/KUf5+ZkxRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903626; c=relaxed/simple;
	bh=p4TNWXFzxSZPs+w/zTaBL/06Fie+A/+SzSybmOLSStU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVxeesxEtEwpOt9/rsBEM6HTmbktwOovyXewYvilOej0IKw0ryMcdg/vETFc7/IYxg38AAWE2TDKJOLmsiEp1HPnvKja5/6fnmLM0/HLYOjyPjVxuig6vvSPtmw8E/q/nzD5G3wtIsFE05hQWegW3CGCwOih14oiU2oglOxFs+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPTtcrGr; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPTtcrGr"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12c88e5f4aeso2365332c88.0
        for <linux-watchdog@vger.kernel.org>; Mon, 04 May 2026 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777903625; x=1778508425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=5SodUFa5OKjCfXMMyR31CKP2Q/lfXpF4gL//OT3nY2c=;
        b=SPTtcrGroGEU73ZsQ6kyPeV35+zMj72/O+FJTPzsx62zSoGqyat5zhR/9RPWgSLi6A
         EuVKwCNncJhbrQ57p+Eolv2loT8Gs+S7a41UfXnsxdHl/Mxclp1ncrQQ8DCbA4B+2Gn0
         5TpFePo0dGgJR9bGrBnNQgjdQV8C2vbq0mIC0W+N8pUuVTX3YWacOar3Ka0kx/2jIbCY
         eSkJ+wVjBLv6AQQ0Bt427Jvro3mG+I5kYeRwHTEEA58THEErAgQrj0SPRCcqzJkrv7iE
         CgmtYi4GCmbdoHO3lDTXmSHuLgD/AjB5USutrek9nb2mb6bpil3fNCcuF3SSHYJNPKY/
         TK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903625; x=1778508425;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SodUFa5OKjCfXMMyR31CKP2Q/lfXpF4gL//OT3nY2c=;
        b=pmH4k+sYzbTqOfDgBa4Aow7iMh586Vf0Hoq15QnZYYyWC7pH/incHB56ofQixkfgsT
         IULMxUXhuPMZa/tQ45wxDWcVItRNXUDExpmgtBWBz2fPd8cqSRStwSiVaZGBKz7AU7R7
         dDTx2h7KXSsA0x+ZnTQWzut4nizGXUew/EW9GR1Qua8mCA+vjIdxaFiCkPy6SFyWo9xS
         5SnBJaFF/6AWjR2Qp5jm7gCwtVxUrl/4FMJ03d+IGjnKPC2dqX+BxckiQq6GK85QcJr1
         uh7b1UqcixO8ch0zaBfrexD7Uj95+K15ZeXiuFInwZk/wnzVKIj8SR0CSaGD6Ld2z5I8
         YVww==
X-Gm-Message-State: AOJu0YyJvxA3bFHbMkJnE1d1E/LjZqsLTS2LDfCba47MHeRaR91io9v6
	C/sppn/Dh9Q+sJyJjrHe+BPt4m1eZ/xT3+5ICa11ddgqKenELF3rgArZOGmlOA==
X-Gm-Gg: AeBDievQhUlWud24dd0kWEE50UqNpKERVIGnsYnAMwpfqVNd9M7TB+2Q91+/TP2vGTl
	db5gK/o8o5u+KaUSH+YFY0WGLmavvSsyW5xJm9t3jcwuBVHxYWeX67vdT4CgTctlPyLD5/2rhZS
	CxjXCvCrQfmmCaFaHZRha/6dmGp71P9fe3r9hQ4/d4r+eekB5y4WlYKwARLfmgCCOKgndU8OUZC
	q2uAqyukN4Ze/sxseouHyKjYf/fKbuZF0yeOzIS8le1EaX6nl4isgCx02og092aYs6APYl0e52f
	8vm8MzfoMY6HiAE1kAcK5nfWNnqjNkn7fTz8SruH5T6zfnOCDq+7eAvlPHfJSgCXT8dZJ5i1Rhy
	+vDUaKPK8hk8u43OFF6L4LKownUxAtoSOnhFeDz9QtB0yDzBFlnOMS3fi+shotSo417jjtDa7oT
	LflwTZIHYAjGiSd64fci4922SDLTRNexlvOlZDPVOhrp36zYfi13y1D7u3AoxfCkMm9NwbhMr2u
	fJ9dbL8La8=
X-Received: by 2002:a05:7022:60b:b0:12c:9037:5115 with SMTP id a92af1059eb24-12dfd596e21mr3853981c88.13.1777903624413;
        Mon, 04 May 2026 07:07:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8424ef1sm20329083c88.9.2026.05.04.07.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 07:07:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fa76f946-f943-418b-a06a-b36b001c14a0@roeck-us.net>
Date: Mon, 4 May 2026 07:07:02 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH 1/6] watchdog: Fix wrong SPDX license identifier
To: Philipp Hahn <p.hahn@fritz.com>,
 "sashiko@lists.linux.dev" <sashiko@lists.linux.dev>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
References: <5557c8ab4a62750c95631f6f78be7d2b11e091fc.1777892508.git.phahn-oss@avm.de>
 <20260504111735.3D387C2BCB8@smtp.kernel.org>
 <232833f9-5542-4f4c-9bdd-92f72b0597d3@roeck-us.net>
 <FR3P281MB22523AF9022B4059696D33BF97312@FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM>
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
In-Reply-To: <FR3P281MB22523AF9022B4059696D33BF97312@FR3P281MB2252.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/4/26 06:52, Philipp Hahn wrote:
> Hello Guenher,
> 
>> linux-next$ scripts/checkpatch.pl --strict -f Documentation/watchdog/index.rst
>> total: 0 errors, 0 warnings, 0 checks, 18 lines checked
>>
>> Documentation/watchdog/index.rst has no obvious style problems and is ready for submission.
> 
> Sorry for the wrong file, but it was …/wdt.rst which `checkpatch` complained about.
> 
>> Please refrain from unnecessary churn, and from making false statements
>> ("to silence checkpatch").
> 
> Sorry for that, v2 is on its way.
> 
> Thank you for your mail and sorry for the extra work.
> 

By sending v2 without giving me a chance to finish reviewing v1 you did create
even more extra work :-(

Guenter

