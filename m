Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCA37F00A
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334318; cv=none; b=C++xJSqiVPwigHChTE7muPXJpa/FpszcFHH+Kwk6BNX6X21uu9jxss94M+aCNETAMgoqychxziyA5tcusXuiLbPquRd0PFmTMMHk7YSPwsxh2Weyv8utRTWtR98mVsoGGv6PGjHRNEsZQcpTvUsos8YNIh2fvK5ctlr1PaSetEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334318; c=relaxed/simple;
	bh=B3CoMJndgo3NRxCZvw4SLcraJ/a41eFbyD39O4s7wYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+cPPlMi/oEgNB8dzE3bTDqpUK2LGiwbXCRTl0wJRAc8uoEHxJRpIbO2Too1CcDS5FDQmokHlQSXeirYOsDbm8T6VwnFrCXNgXy5l1+soZ1dgSFxWZ+cet98iqmYNXal0mtR3Sg1gDlrlOPBLc1CVVXSOzAP6bwn+GdQ+TIm+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWabPFVA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWabPFVA"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38f620399a0so1196512a91.2
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 20:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786334316; x=1786939116; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEU+pp4CCJstwvmXVbRVK0utyTpf3g/1fbsNABHVlac=;
        b=nWabPFVA9Hbqhsa9uPstQfLXQ7vyaaUhuOglyGYoEPrv1EYnOdNDASMDVADIrgZwg4
         ayKcILn2wgNlYAzW8AQRoU0WJZe5fKNGaNKo/PE099FHpGnNDRP4mrrVUAnI13aPJnsV
         PgmwJF8VkqV3YuQ1UtVgk5lScavn7Vw/SUd5UnUE/yALHvl/0e0BvuK+a7E1W4uenHRQ
         UNCsXVmAEfhEUHnZsySf2+MNB7It+R+8B2YHFYmqBD8Pn+CqdvXPQdhnjgdYcj3F0G7v
         Vk/chal6h02EBTlvIsDTYlAq6DT7eybKKtSGgnVueK4wkmCnYFS1anz2x9XDbXj0or/H
         MRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786334316; x=1786939116;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QEU+pp4CCJstwvmXVbRVK0utyTpf3g/1fbsNABHVlac=;
        b=fIPKF+Cxi1GvF8gd93nbptZ37tDWMuJf2sieUmJWz4Zce3HLXe3/MyLm8k4HlAYlYE
         mgAomStGfOKmRE+gMx8C014Eaee+WDICUijETOtJ40kI0LVJ6898juEuRrItjmPhOPVO
         06cOxBcwgaBs5OnHwibJ4B0cZfyineEUwlN5UX8cccm+T7w3Wt8LxOm9Y9PDQ4srYJ+4
         UBXllILMxlcxBPut3SLvYWLipri9GjhQpNkzLp17Np+rKI/Zcc/jXev9j3ouLO0ems4p
         Ju3sQ3u8MWehv68e4v7O+qfg2Ym2q3rb7RM65w0E7CRcaM9qcmy1tEXM8pRXGyd+Okt2
         zeQA==
X-Forwarded-Encrypted: i=1; AHgh+RqVaXa1vYiIDA8lcqDIiEMWS2uncwj08wQTgKp/SPVvwILkaEH8wxh1j3O1Hl6SNrYsCYN95m2+Q676nUTDDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDZfyobrf3/zPDkHiIHQM0lq54NFOntlOZFJ4jnrJ6mUZR27B
	ZQZIVxfo4IpuX11nJ5zbgbNqR04/cZbRYYQI72n1FQ47mtzHRsTrMFFN
X-Gm-Gg: AR+sD11nbVp0Sldpw+C2Bb1mn/Pm0BZogWqwPeLfZ0lm/UW1h0uKusy6RjeEjIr3NdF
	w3V9m6Gd2q2g0iJoTeTtm9hVfOGqJb/TLCT93VkGLxG5dCl54iPcLDcyWTJDNBsgdNeH9AbwbuQ
	8Zri5ZPlna5q9WbVAqVrY1RpGyCwDeZGDG6BOuspVZ21/cth+d8loR86ngILOHCiuiVLRiGmpeE
	RTz+hV+3pMu0xr9pF8uhA285s8ZuoRh+SwwnIU2rvLyv66RnobhafOPMS/ITB+LTn3IUTA1zUl0
	AwW9ynEwXmPSACxRyywOwHxosYQCY09XeeppmUBJKFlwXL3pgo0QL34NANWzf3z71fdC65Iw4Lp
	IgRK8bzwKHb7JSzO9qV8xJ9pnA7noi4g+pac1GNZnGXoNvG2F1zAGXmr1wUFx2J2ZxadFOqlVM1
	9LtHCVIZEjuySFwopUsGWnCw5COViF0mX+CRL1WwPo2hbp/NZf7Gu+PklNbHlfIFfnfjLshE92T
	nLU9LvR0AUG+hlssGsQY4kYe2dzRCBnJO2MrfZDFuFZ5F8L/g==
X-Received: by 2002:a17:90b:5244:b0:38e:9eb2:9d43 with SMTP id 98e67ed59e1d1-3903c5b685bmr38481045a91.16.1786334316290;
        Sun, 09 Aug 2026 20:58:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebde353sm41638500eec.23.2026.08.09.20.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2026 20:58:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3a9b7b85-e6f8-429a-91df-f674479dee58@roeck-us.net>
Date: Sun, 9 Aug 2026 20:58:33 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ
 lookup
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
 <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
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
In-Reply-To: <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/26 19:38, Bui Duc Phuc wrote:
> Hi Guenter,
> 
> Thank you for your review.
> 
>>> +             if (irq < 0 && irq != -ENXIO)
>>> +                     return irq;
>>>                if (irq > 0) {
>>
>> This if () is no longer needed.
>>
> 
> If we remove the if (irq > 0) check, irq can be -ENXIO and would be
> passed to devm_request_irq().
> I see that the irq argument of devm_request_irq() is an unsigned int.
> Would it be safe to pass -ENXIO to it in this case?
> 
No, sorry, I was wrong.

Guenter

