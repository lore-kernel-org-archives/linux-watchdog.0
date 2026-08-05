Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3600346E7A
	for <linux-watchdog@vger.kernel.org>; Wed,  5 Aug 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785945211; cv=none; b=WDbVE/+2wqeGZHI8HeeW5/a8UB1WgeThAewrqaWw0lfm3BCV1dDDP6MvHdZukbAbo5CaTkYojPZGiOcn0+23+3rb/MJy17M4IEsA98BeKzC43EdC5Wbev/1DBAPTN0NCT8kkH3P+dw8SAKptqjP1fd338QYKNpHqkVcyPkcLfIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785945211; c=relaxed/simple;
	bh=5X+1t+4+xmhnMVYBjo3t3Iwo5rcHQLymZy6lHAa0QUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNKiTF7TsHSgbBeYFkd7x+QTTvIvXmDLPt59kWbcYxfpC9ja52Yz+zTTH0uz0SobE4Z1WG8dmQ1eSVTaqWhOoZumsqqv5iLdYqmmB1ZSqJH75CwBKbMBIyGcwreY+QfFdBX1/N1mQO724Z9OfHK+r+8nZO7CbQovxD7D9lCySNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnuDVT29; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnuDVT29"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3811f512167so1364683a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 05 Aug 2026 08:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785945209; x=1786550009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LI+iqn9ICVSIQ/135Axv8IaVBypuz9z9dggrSDoE2hE=;
        b=XnuDVT29M3hxgQqo8jcsr/zood4Cj6bzto37YGzU8Vvg3wlMOhmhIfOZYjk4mgd8N1
         +pvj42VOleSP4RifNAg/M+M1BkWvOlPg8VWl2dfjg8S3gaWyYtWoL9UEMAWXdFhAMn+8
         WTGx0Giqj7TF99vVDEILAH7ZFlqP2BbgclLSitNyp57zXZ5sDRdXuXB/ixtD4F4aFC9c
         ZTx0VYLMZmPhqWo9Kk7vnfe3SyIQIFX+hxgJXn1RaGmylCWIi0IGA8cj/K1HeBZszIHO
         oJpj1bFsaIolHcwLtCDWhPueu83wkE6See4z+1XAH2Ombkt5zFRLwGvJkr+GFL4ohNog
         fMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785945209; x=1786550009;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LI+iqn9ICVSIQ/135Axv8IaVBypuz9z9dggrSDoE2hE=;
        b=EKafoO55yhmbTN6l/hOjvxNpmr5F/lCzBIeNsMmKCEyyBakbLEjg3mSxUnBOnf4uHo
         2QSOoSjHbET8n5tcsajlLMYcBPmJowHHAr5brUQbhovnJNdfjlw17BI+yHNU68x8EKg8
         y7EjtwnssgXFNgI5gWSy3K9ADC1DFJRR1u0xnE1X9HQnAaocPCJpiJir144/r1Lsp8lB
         msJz+9B2Dpm8S3A773UN97wJqVXjsJjtexgKUAkAxyBn1WCGMkPcM1CdNmwdBOU8gBUj
         raDI8yulCRFpY1/2sqDnKxZoazaefV6ta3EmU9tJkN8zB+RSc+G2S8UzyaTfWbWdON+f
         yyYQ==
X-Gm-Message-State: AOJu0YyyDkSqLN33YTqGAd+NYzlDOHTtflOqZD/xGG0XUqiX7HmdSocg
	h9679heGeU9NwkDH25C5hySf/xujNGmSwasLMQ2YqmEd5l+PafHkKpkX
X-Gm-Gg: AR+sD117spHTbIqSsd3LSlQQkuNkGaI8mbhSzW2OM6gvpJe9e8TEyfm0pHuwTpSy8Vu
	OPRFDqgBCTqwseZugafqscA/x7DgocDpe/x/ebUAZ/xZLkW8fz23onmY0yIWl3hgQKI4QoNRZy+
	xbTahNoPKqUY6DYdqDgCqqsbOeetya+lEquJE7C1qq9y3t+uo3R1Ui8anoHJC0PrfkqS2sRc1Tw
	1vBMUptmyRP2Bq9qpC7fLIxaDw90abAQ5lYvVW8nu5t9uEaEOAm52f/HxOEgRhoYVclKn8jE6eW
	DIh4HuxNQa+AUcxjY54Wj2jmfVInJALW2hTqYhPwpG8rbpwZmBBvnfvZrQ+t/nnT3mDvtwP+1I5
	pbQV3WkpBuROKaseHA80RLyc19u4WFWQQ89IBX0UepDmOhvJICT6aQjKEoATOg1IQgam8wKUS3c
	1WXEob0gCtJNtj9Owz/xU8Rfb3YfRgMrnBtlU/dkEkfY00MFA3j3XyKTzdcvBd8WDYMD47PxK2Q
	FmEK+0DawkLyK2uwGDpbbQYrbAldztOlkgnAw==
X-Received: by 2002:a17:90b:4b84:b0:38e:8021:2ea9 with SMTP id 98e67ed59e1d1-3903c5f6482mr7298055a91.19.1785945209015;
        Wed, 05 Aug 2026 08:53:29 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38febffb349sm5040077a91.6.2026.08.05.08.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 08:53:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ab8431ab-2bdf-4de7-9885-62ec10948e1d@roeck-us.net>
Date: Wed, 5 Aug 2026 08:53:27 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: pcwd_usb: keep device alive for open files
To: Qing Ming <a0yami@mailbox.org>, Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260805102907.5354-1-a0yami@mailbox.org>
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
In-Reply-To: <20260805102907.5354-1-a0yami@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 03:29, Qing Ming wrote:
> misc_deregister() prevents new opens but does not close existing watchdog
> or temperature files. Both file-operation tables continue to use the global
> usb_pcwd_device after usb_pcwd_disconnect() frees the private object.
> 
> Keeping a temperature file open across USB disconnect and then reading it
> therefore accesses freed memory. KASAN reports:
> 
>    BUG: KASAN: slab-use-after-free in usb_pcwd_send_command+0x4f/0x480
>    usb_pcwd_get_temperature+0x71/0xd0
>    usb_pcwd_temperature_read+0x5e/0x90
> 
> The object was allocated by usb_pcwd_probe() and freed by
> usb_pcwd_disconnect().
> 
> Store the device object in file->private_data and hold a reference for
> every successful watchdog or temperature open. Use disconnect_mutex only
> while stabilizing the global pointer and taking that reference, avoiding a
> lock inversion with miscdevice teardown. Serialize command submission with
> disconnect and quiesce the device if probe fails after the temperature
> miscdevice becomes visible. Reject commands after the device is gone and
> release the object after the final file is closed. Hold the usb_device
> reference until the private object and its USB allocations are released.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

This driver was introduced when the watchdog subsystem did not exist.
I am not going to touch it. Many of its problems (and there are many,
as Sashiko points out) can and should be fixed by converting it to use
the watchdog subsystem. On top of that, I consider disconnecting a USB
watchdog from a running system is out of scope for an urgent fix.
This leads to the question: how does one even do that ? It also requires
disconnecting the reset wire. Is this even real hardware ?

If you do have hardware, I would suggest to convert the driver to use
the watchdog subsystem.

Thanks,
Guenter

