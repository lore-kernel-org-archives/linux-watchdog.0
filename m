Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393753FD37
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963172; cv=none; b=IZ2FMxSe6G24SO7332bMwBdj5nWt6q0N78/mJcAi/zDUtz+RCVBZ08ThjjesM928w7R6gbm8dULwPXFcQrrCGr0iuZVSrB6BJXU2Dn8Iuh2qaAzGFxFVwCgzaedizBRUS6zBFHrJ2n4QfhvwVv0JU43cVcUWLr61hxSp7XJVtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963172; c=relaxed/simple;
	bh=VAUG9ocA9CuuA3ZZK3/Ji3B3eMK2e7/A4q+kEwaraLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxXHmj6TB+OIBPkJd2rymLEc9yU881mkKwA+a1fdpv3dF5MLXhFWRH7ZoVHmA9CshMgxaGV9aP3RKsqBPmoXHXfR7QXqcKuig2cHYdCFKnTaEcz6bkFnVC+uuXK4k4tNIEaE4SV1qNm5etlGqhRnoxy8P2rchbKEA2WZTCiD6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsLp6Npb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsLp6Npb"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceab75934dso56973085ad.2
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788963170; x=1789567970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2bgojeFeUpvXitpM/OgDxaX8mLFSNcZ2WBsJ3E6rjeI=;
        b=WsLp6NpbmgzdJch+5EILXUgOxbzUM2BSNIp7BshFaCb9mMCv2PqBnXgEvMRn22YPgc
         2++YHMyZCkDK5zdciAMlg1z9QmDe5Heep0+oWf4QSMNWvCDej1gz5Ddjc9W5ithpw23M
         jGqKvlqhSOOi6pi2RQM116/P+UvIRgs3OLgc/9/mB6rAADvpjI210lfeGbLcxADrx2oT
         Z8M5Ukh+GopxegIS1uK3usVbNssrTl8Hq8x/UIcrCNsEYObMnvS5HMG6u+pJIYJKcjsc
         aCUaftx7XauiMYygVg1KDbCJSvFf8hAT/nAEccI3UxWxsqfy0/g+PGJZo73bQSeNmd8c
         lnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788963170; x=1789567970;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2bgojeFeUpvXitpM/OgDxaX8mLFSNcZ2WBsJ3E6rjeI=;
        b=BmpCxnIXpfEYSOB9Oi5HIzY1/X0zfLRnl84LrW/1Rlm54hceUUf85Ry1xwaNnYoSke
         yT06Y0V0IFpD/4G5Ar07rcP/noNaTr/YSQ3E+4kdgEJWlg7lhofDfuO2+LquyW8kt36H
         BYm+9hsOvTBvztik5aOyD4DPtuAWKfFJUSAUQzCQ/qdA3eNOYzXc3kFgMN/2/w1TjuzR
         RxOvj7EdOc1AWMYZgJfWvBlQQK/jiiGpBYgk5cGuCLhkbgDLOonkm+6jHZn3xy03FzP+
         l1rGEFli18GYs12BYZMej9+PRER4iu2EkAP7BAoUDDG588cwrAL8cI6VcdwUB/x6P1ZV
         Mf3A==
X-Forwarded-Encrypted: i=1; AKwUvBzeB7qTNU/rh2w6TMmC2ZAX7Bj5abpNjZXUu3DhZmIkJ51yZ0hfShIpvNRYZwYsSOBZP+wraeAiqwKP19Jo9Q==@vger.kernel.org
X-Gm-Message-State: AFuF++luSs/IMV0ncBFIu4KN14gWcjMlEAK0rfhYlBdMytHztjKbZ60E
	bCFiPTMy3mUqcX4aIkjodT/PBvUBbkhRmI1aoKmKqFHU7YkNrKD8TZc2
X-Gm-Gg: AYBFou3pLDbC7rcJ0clz0RX9W8us0taKWJJC4EOrIjhs8OF5O+Pf+immUu8dVnuPAIn
	fqETEkezywyP+oyEsWolw+mwp4QNcC/RP9WSsK+FMedcw96Sn+iGfla+pj9Rkok6kq/pVtDNp7n
	Vh55Zd3l7+eP3xcv5/e2KCDi6/hrM0QLs/u/f4j3ZpZ0BjT25GrnwwxIE0GdGabxc65oJlN/S+2
	+z1hmKJSvXQI05rrGo0Yd5EF35SeVTjxC/lyjiCQmWpaH7WCkRuocTDOAbIfpOyWPf+jb69BonF
	InbvAB4Hfq9e3FLOpav9OUGQF413z7ez+Cmm4TQbFjtalf5pWtaoSIDI4G/t7n5j8Eq2EHEJjDX
	maDDzA1IE9AHbSK3DE4iISodbkjGfiU4h9UEdd22p0ciDK/vIpbvKRvw38STgx38AJwvW7xKYIw
	RXX3FCKxvC7dYcKg6lv236H1djR9IVslMOpwpXmFZH1/cVsuwtB+jTIFFOxvZRROl0vs5iIYmoE
	gkDEPvxReGcTHj4JUH2abVmogjp0IjA1zDDsXYtvQyIo6iJ
X-Received: by 2002:a17:902:8203:b0:2d8:d4d0:792c with SMTP id d9443c01a7336-2db1287779cmr388670795ad.16.1788963170238;
        Wed, 09 Sep 2026 07:12:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae7637sm74597655ad.79.2026.09.09.07.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 07:12:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <43a1bbe0-0012-44b1-ab0d-0dea1136869a@roeck-us.net>
Date: Wed, 9 Sep 2026 07:12:48 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
To: Arnd Bergmann <arnd@kernel.org>, Lee Jones <lee@kernel.org>,
 mfd@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-12-arnd@kernel.org>
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
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 06:21, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
> 
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

