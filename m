Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3C33F59B
	for <linux-watchdog@vger.kernel.org>; Sat,  9 May 2026 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334743; cv=none; b=Zwam91iI5asddPf67HPg9E0PUXuDorJQGewUn+P85mWQsXiZ5of77c3xOxoQJu/SkkzfNzIrGBHxyWU+Ayp8xdwIdT6sNGF1/dTaEv481StsEHMupVj9PVg91o9S9DIWNTazd64vR96m6Ag09ksa9LQpkmg59dO5nDHStab5FtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334743; c=relaxed/simple;
	bh=dDVT89lUaK5AaceSrmWXBJaw98wR7XGRF3ip/O6S5uU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3FOyJ+RqzjpFV6T5faM24h81V+7EsrlYltOXUS5OsEj5D+7N96G/hym0krtmHq1S3n+Ha72GSPhP5cRI5B88x82RLdE3Vhu+IMVYT+QahWHi01Nmsg4VoEx+l4bx+Gncaun1Gem8lvJGiHtnvX9yzpil5pBpjGhpQBymJnsBWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+g/Ettw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+g/Ettw"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2baca4df358so17374305ad.2
        for <linux-watchdog@vger.kernel.org>; Sat, 09 May 2026 06:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778334741; x=1778939541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eLjz5BrlqtDyibjCzTnvwykNaKQN50uSHfg6BnMXy6U=;
        b=p+g/Ettw02FpxXVZ7SK9VqxHm5rUGAiyKb9VRF3vREQtNeou7Jywhi6NoYli6w9KqJ
         DSQlcLLZLMGKIESbhHkjpbgQLXmL20QeoUui3g+fuAM1VfQfFT5rEcp+wWu5YiW35VIf
         sIqi1PaBHqJfqINwmfGpTqIOe6Q5OBotZ1K+42aKtDrpMvO06QjFynZGGGQOGJjH0igu
         n2rx3leebwsfT+UZa31aT4zbF2bfB8+HX7uIcqNPbi0/do4Rq1w4bXt3NH6hqJuQEQSQ
         hvaelPCsU/1VefObXW63kTwvIGYT3qycwONw3BUw50ZaYfro1dZ3hnBEx0VZ8Xvztr3z
         Rfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778334741; x=1778939541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLjz5BrlqtDyibjCzTnvwykNaKQN50uSHfg6BnMXy6U=;
        b=dgMCXFz7uFh2RC18F0n47NsdFMtPCffn6s+CD1oaXnSQms3ErNAed9uyywlf1yzGXL
         38sWlxEx4R6535yi2qF7/HXtloxJPTM/Iko7lo7EMomDm7Z/wd13IkzAr3hBd+Kcisyt
         CwDocdicUbzO/jUcsTXY3NSq9wYNF0MVoAspS95yiaYpbCkv8TKrCXCGzh64h54PUFF5
         jhPvB4R7cK05hHaAQsRWtT39MzznhU8ImqduLZlZ9nK/3aF1ASWYLYqgbAQQqVv7qK3d
         Z8U3JlGu6ob1Ben9pZgMuZZNAqDy332mWdXqYMXdgqtdo0EBIZYFYg8q0vBZvqln5ECU
         EN0A==
X-Gm-Message-State: AOJu0Yx4O2kb3ZBsPhCzavvzHqoI4ueS5F184bTLvAFdRVv/v6V6t7RC
	QkoeMZxrgdl1SarzRR+5oH++59MFpT9S8X7IIw5mQNlCIMIk5JNPoTTA4CfDHw==
X-Gm-Gg: Acq92OGtuaIHW0gdrc79axNFmHf56lV4ZO/Dz576LWIylMtVBIEWqw9YY5bUDy466XX
	SiVE5E8B4godnAUrm1hGWbAleLCWsdEk+Try383tqB69eoFJmMswRr6/LULlNBX9Ohpw98OyqtD
	CCCfm3miBoGYAnqbhUdSYY4gV4jSUBWZjQfXtb+an89pE7rEmVGBQoPDaHAWnoTSoHEmgLJ04Nv
	XnnktKTWW+kfyyrSPAnjWTjamHPhkFdI2lRbTj4xnG8kVBYGVRWJzSGfAHGXkedd6Kd1E9otPsf
	nFlRXoXqgH2fb+m1HGeESZS9wyGdyaYC8VNj6BTyWU4OIBZf/B+2BNdsNg5sDfbpctjaYbrVaVj
	I4tpc7YESPVyBIEfpOTO0n/lKS4GIzSdCJVHtJRU9knPG1dxSs1LW+iH+y5Q5sYpilIoiG77r5N
	c/hTUYWyiKOe29BYOwiBL3n9ayW7ymxD9F16+mOaD8UYYznDPC8wqoXrDsTqoqUn1XueyiL6MKF
	s9fMIXVqrk=
X-Received: by 2002:a17:903:1aa6:b0:2ba:5f24:cae2 with SMTP id d9443c01a7336-2ba7a33a5c6mr181654045ad.35.1778334740929;
        Sat, 09 May 2026 06:52:20 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e35494sm51447215ad.49.2026.05.09.06.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 06:52:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f182256d-0623-4c9b-a18a-acca8457bb08@roeck-us.net>
Date: Sat, 9 May 2026 06:52:17 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: wdt_pci: Fix shared IRQ storm and complete
 system lockup
To: w15303746062@163.com, wim@linux-watchdog.org
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mingyu Wang <25181214217@stu.xidian.edu.cn>
References: <20260509121655.275311-1-w15303746062@163.com>
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
In-Reply-To: <20260509121655.275311-1-w15303746062@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/9/26 05:16, w15303746062@163.com wrote:
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> 
> The wdt_pci driver registers its interrupt handler with the IRQF_SHARED
> flag. However, the interrupt handler wdtpci_interrupt() fails to check
> whether the interrupt actually originated from the watchdog device.
> 
> If another device on the same shared IRQ line (e.g., an I2C controller)
> triggers an interrupt, wdtpci_interrupt() will erroneously process it,
> blindly log hardware status (e.g., "Reset in 5ms") to the console, and
> unconditionally return IRQ_HANDLED.
> 
> This behavior defeats the kernel's spurious interrupt detector. Under
> heavy load from other devices sharing the IRQ, it causes a severe printk
> storm and keeps the CPU trapped in hard IRQ context. This eventually
> leads to a complete system lockup and RCU/Hung Task panics.
> 
> Fix this by checking the WDC_SR_IRQ bit (which is active low) in the
> status register. If the bit is high, the interrupt is not ours, and we
> must release the lock and return IRQ_NONE immediately.
> 
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>

Is this an actual observed problem ? Are you using this driver ?
Did you confirm that the change solves the problem, and that the
newly checked register bit is indeed active low as claimed ?

If so, please provide evidence that the problem is observed.
If not, please refrain from making such changes. This driver,
specifically, is completely outdated, the hardware it supports
is very unlikely to still be used, and making such changes without
actual need serves no practical purpose but to keep maintainers busy.

Thanks,
Guenter

> ---
>   drivers/watchdog/wdt_pci.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
> index 3918a600f2a0..a35ac064b690 100644
> --- a/drivers/watchdog/wdt_pci.c
> +++ b/drivers/watchdog/wdt_pci.c
> @@ -304,6 +304,17 @@ static irqreturn_t wdtpci_interrupt(int irq, void *dev_id)
>   	spin_lock(&wdtpci_lock);
>   
>   	status = inb(WDT_SR);
> +	/*
> +	 * The WDT500/501 supports shared interrupts (IRQF_SHARED).
> +	 * We must check if the interrupt was generated by this device.
> +	 * WDC_SR_IRQ is active low, so if it is set (1), the interrupt
> +	 * belongs to another device on the shared line.
> +	 */
> +	if (status & WDC_SR_IRQ) {
> +		spin_unlock(&wdtpci_lock);
> +		return IRQ_NONE;
> +	}
> +
>   	udelay(8);
>   
>   	pr_crit("status %d\n", status);

