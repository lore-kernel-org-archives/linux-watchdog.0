Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33D44D6A9
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Apr 2026 15:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564401; cv=none; b=htlMQ28Sc0ctteCiVq+6tt95koCNWYNfs+aRJwTDzRM1vaQh0x7O0KHtscobf7a7d3EHZCM93qKZuMKJVkE9d0+SyBJO/9S6CKiNtPv2byvn/UNn3HjQNTkNKn/XDEv+qOu3kREGUN83hXoNMy/u6Sbly7nQ7XTliJKsG1Tcj9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564401; c=relaxed/simple;
	bh=75jLL6My7D0xQI5ivVk6A3DdJzwv/c53xWeQJx5lDSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9Jl7tBVNkIvU5EGN75hb4uL0AyLPRpEfwluWjt7Y1V4DWaa6hILMJdJ5MqoPYVp08OdaHI0KspZMhslCGmnTkwH6myN9USwQK04Ww8NVUhEU6OCZRWRScOLtmS3wq+7RIT24s9Qih+SaWP6qO9hJctb9JznAtGS6LYa3CcFz+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDQhfxvS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDQhfxvS"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76c60c7502so914623a12.0
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Apr 2026 08:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777564397; x=1778169197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QGIicf8Eto6vwZdPjAak0AulcuZCkFdv2f/+Z13adSE=;
        b=MDQhfxvS/SYc5wd7/7eo9PUD/sAr7ztlQlQZsnBb+yQAEJBro7O0fySnMx52grdBWq
         X2rkN1Xz9iAnZsO/QfyoyOErmvBBO1MEwcfbx+n8TccbWaMHNnCqLf90QEYsMeG5CdXn
         PYz1CItipw4owaTqwF6DEsY1tXkRJcOxLaycCgUboKwEmlvHrBjuBrn3wQg9hlWLffRD
         cx1sG8NhsBLOSzIYq6e5X/C1F4lAmIKM/xhLYB45cA4IY9XTfspOVJknQzin57c3lM4v
         hx4/t03sJYZ1CyXKnABsMdB7dkbJZuTEvzBJbOXXwnCUlMF1neetvmYFF3r/ZIBSZ7zq
         XluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564397; x=1778169197;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QGIicf8Eto6vwZdPjAak0AulcuZCkFdv2f/+Z13adSE=;
        b=Qn8BG2X3o2og1ZlkSPn1RNmitg9IPPmd84AZ5qfFnTyncfE/ubNpEAlV7mvu/UjWzR
         TaKtbim3t3htFmwxYswQ2ivythB5F6YmTHOpy7eVPYcYre4/TWLDoCLIKfCBTMAtWdly
         /VkLV2VSFZCzEKpd/nH+q7u/RbzBl47ONx7JwRT0mEDik3HtVlSfvM1mQrnW5WANI0dl
         +rpOor0a0A5wcw55CsaWWP9ivJzF5/40DTKG50+Z6W7SHu+rRNFhOvGU2mQY0xQJKqni
         5yNWetkn0JQAQBEqEBAgJwv6YjDrf5D7ZtIYhHcvjRx+PZkZAw1X2EoDA3PjbyxC4/yM
         ztDg==
X-Gm-Message-State: AOJu0Yy95Gr/aHPD8l/QDOfq0Lt14+8FpBf2ZvpHeJLrh5ONR4EZ7J6/
	3O3JCRQ3SVooYfPqUfTUi9qJmgAD/IuESeKT0Jsrxr9UnfHlTVr+wMDq8GVfAg==
X-Gm-Gg: AeBDiev4KH1xvGXilg3gytIOiMfktpE1tB9fxsNzgfnAiO2kd/ADhqv86h0CIwyITUm
	kawmvEudpgROsb8oY38+hTftSzx8tPOQ62kDh9YMNG2Rzy9ib4xwY9XK9cNvcubWBt+xYL9Myyc
	ToL5F7W+DURCW7G1E4HP2TywlvLj6x+LZE7j+oO9aUFuNRcTpt4nECJYE6g40jfU3X3yawVWo3i
	7/Wrvno73UCqS65XYVEQgAjRSoyag41QgzHmIL0F8+EIpLXgNb2EjQjGinafjey4vvj4HqmtWtW
	bzazRe70cqnPr+5gqqyMt+nO4YpxLkLl7LcMrol7ljpyRiyTwBE1o2JC8G4q/rzuTO1wV70Jze+
	jiZeFFYzXl6eeVVdxxPHAKJdOoZ9zPVpCNgq9u/uSlpRvsvVMXMLN1ywfswIZvMNn5WoCWazFjQ
	QCuOtp3dDgYRolvYSOpODAP9oV8ZpIOXMSbnvnIYomhcs23swECZ4nihxnkiPPWccZAmsg+MxWl
	+ijVpLC7A4=
X-Received: by 2002:a17:902:ef11:b0:2b2:5070:8b with SMTP id d9443c01a7336-2b9a428297cmr27914095ad.1.1777564396613;
        Thu, 30 Apr 2026 08:53:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaaec82sm497825ad.24.2026.04.30.08.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 08:53:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2ca08749-f1b6-49c5-9281-c4f5b37e890e@roeck-us.net>
Date: Thu, 30 Apr 2026 08:53:14 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: realtek_otto: Use FIELD_MODIFY()
To: Hans Zhang <18255117159@163.com>, sander@svanheule.net,
 wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260430154230.34218-1-18255117159@163.com>
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
In-Reply-To: <20260430154230.34218-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/26 08:42, Hans Zhang wrote:
> Use FIELD_MODIFY() to remove open-coded bit manipulation.
> No functional change intended.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Please refrain from making non-functional changes such as this one.

Guenter

> ---
>   drivers/watchdog/realtek_otto_wdt.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realtek_otto_wdt.c
> index 2c30ddd574c5..cf4841583721 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
> @@ -149,11 +149,9 @@ static int otto_wdt_determine_timeouts(struct watchdog_device *wdev, unsigned in
>   		|| phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
>   
>   	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
> -
> -	v &= ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 | OTTO_WDT_CTRL_PHASE2);
> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
> -	v |= FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
> +	FIELD_MODIFY(OTTO_WDT_CTRL_PHASE1, &v, phase1_ticks - 1);
> +	FIELD_MODIFY(OTTO_WDT_CTRL_PHASE2, &v, phase2_ticks - 1);
> +	FIELD_MODIFY(OTTO_WDT_CTRL_PRESCALE, &v, prescale);
>   
>   	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>   
> @@ -279,8 +277,7 @@ static int otto_wdt_probe_reset_mode(struct otto_wdt_ctrl *ctrl)
>   		return -EINVAL;
>   
>   	v = ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
> -	v &= ~OTTO_WDT_CTRL_RST_MODE;
> -	v |= FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, mode);
> +	FIELD_MODIFY(OTTO_WDT_CTRL_RST_MODE, &v, mode);
>   	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
>   
>   	return 0;
> 
> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b

