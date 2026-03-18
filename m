Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7695233121E
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Mar 2026 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855733; cv=none; b=JVYDO9qW/oFnikHqD/oplBYA4TEiU6Sy2OqHEQx6NlX0QUoWDjWvJaxkn+jEUaBfApa9rp39MpT5j4g87D2F69CthvtjDpRFFdDuOC/invi7ioJzOoAbB7J5a559OsFQlDn7yCQ7FEhvq0Q519Ik1eiHPzfAkLYVslmL8KMb9vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855733; c=relaxed/simple;
	bh=qv+baRZR0Omqd5j1n6O3ERGa5Zh1w8scDVoM/YfP3bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huNhgjHdxmZw/Lixy/ClPK66CcZVjy9xYu4HnuwOI21wQS31ktTaZ7uSwxzZT8nW/rlF7eOlHZgiwPPFcM6ihiBHSnbm+Fxgv0jcSwaH6Zl0M6daDG3rGjrqZDnFRVfE7S0HhftbriK/CNXs7IsphBBbbIrZ5Bw4hz9htxkmfVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9PWXmUi; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9PWXmUi"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so146537a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 18 Mar 2026 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773855732; x=1774460532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh1Qn7cKorGxUfkHdc+69X0eAoAMyDqvHflkwvi0a9k=;
        b=i9PWXmUi2aBxTTvdXD0NtWkyNfeVK8u1fkSJmYddznIQoVLdXlMKoenASTazO/bRZy
         x8pDJLJL9/iouoJKYkna0pRIVYIhuH2k0zO2YX2Mpu+xX3iVflvCl2wnCvjQMyRHqY4Y
         GzgDqiWQ2GkJPbvyB75lbLzm2SDrA6JVjCsCzKT0PHY9FbOnGXd5ESgpPgYybfn6cYxB
         NCLI8Z3rL1HhcSGnLUC5Ban0s1btngvby5sHxurrPz7ACMgXhRNkuE1NYIMaNchd3ct4
         fpjWJTG1KhUe8bi284qEgeQH4j1MR2q2mbfVPDtNW6WH+UzqWZq+6DmP3qCWpb3SXYez
         NktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855732; x=1774460532;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zh1Qn7cKorGxUfkHdc+69X0eAoAMyDqvHflkwvi0a9k=;
        b=aFjXyhuW0YJ81WNjMktoq68yqlFQyUhS6X4f9/l8tzMB1xmEJbaqY3dngUZ7sGxzL5
         XOSksselq8EJgJgt3OWzRaK+OBA5Bmnbzhz1yvsBihpyZKm0HlXWt6wfoD74fLhTzBys
         dj58EMxjw2kpzqXCC2aH7ZP0DoxTDc9y42zezTeiGOcMqzlx6L2RRLv9Byb+N8DFJPKC
         6MXUCz/Z/wC2ti7+4/u3b1ywwTsJJxIfyXi4JIPEhvrZBCMVd8F4oLh3vPS5xuaodHoE
         yg+2grwEpx8wgqFttD2tvA3Potk7CSSqiwYGNHBivDI8AoLtQLQnlv1NZos+L5TWUSzP
         ljUg==
X-Forwarded-Encrypted: i=1; AJvYcCWx4ZuhqG3igWUrTq2igOEkBu2lQI0neQqoSXptkNsZndtyaDmtEJIIb0co47i8asA/lGLe27JvQtFu5MkG3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Xk7gLlAFPtjuhs/wmSHq+V7nTEgPs2u7twlss2gUTLuo4Llu
	sTfy+G0oen5mWkyyKa6RrzqfBZjy+oEvUfkHDhZZxNK28R8e6fWg4xr0
X-Gm-Gg: ATEYQzxf7WAuFbuXMlXp/0bu1gvueMZ3wCZpDrJXPnXba2KfOvUXcGDuMlSOuRBm1mh
	yxb17k/0igY7sqONtTF/JMWm/tafzyYMrvWmJwwRDfgsYQf/EDByp9m/otZDfY21UXup5WA5cOi
	jIoTZH7IPcSEXeUJWq+qjLm1KRzGxqAa6JzjLRLz0MFknX9ck4PcPbn01AFWFmlunG0ugl9MNZc
	tvj2W7FJGBPtSdHhgqK/sTlGq67ouh114n1i02FmysXMd8EGwua0hQV9AoCRukWXM3S35waRLZk
	93v93nNBcNPc+2dKstIg/m5oXCRgOUMeaDN5eeK2xBo3KCcB6/U/nja8YJIrDiYNb/hNYFF5yjL
	BIejKudVMImItBGr0H1ArKBN4WexWp7/gkKsnwGWSF6+DwBeOdEERoTw3KPW6LHyuOhlSYc/yUR
	Y+1u8ZTsZ/XVWEKiOjoBdqTzmFa00Xq3M0ltAqvvgFQ4b3yeS1iIkmrUGLPPpOfrnGEP/NEfsA
X-Received: by 2002:a17:902:ea05:b0:2ae:56bd:5318 with SMTP id d9443c01a7336-2b06e357259mr39334515ad.22.1773855731660;
        Wed, 18 Mar 2026 10:42:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e627132sm34298235ad.74.2026.03.18.10.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 10:42:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f7cc1132-390f-4f2a-8884-5e3d90b8be8c@roeck-us.net>
Date: Wed, 18 Mar 2026 10:42:09 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] watchdog/hpwdt: Refine hpwdt message for UV platform
To: Steve Wahl <steve.wahl@hpe.com>, Craig Lamparter
 <craig.lamparter@hpe.com>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
 Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
 Steve Collins <s.collins@hpe.com>
References: <20260318155005.90271-1-steve.wahl@hpe.com>
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
In-Reply-To: <20260318155005.90271-1-steve.wahl@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 08:50, Steve Wahl wrote:
> The watchdog hardware the hpwdt driver uses was added to the UV
> platform for UV_5, but the logging mentioned by this driver was not
> added to the BIOS.  When the watchdog fires, the printed message had
> the administrators and developers looking for non-existent log files,
> and confused about whether a watchdog actually tripped.
> 
> Change the message that prints on UV platforms so it doesn't send the
> user looking for non-existent logs.
> 
> To aid in any future debugging, include all 8 bits of the NMISTAT
> register in the output, not just the two bits being used to determine
> this was "mynmi".  And provide names to the bits in NMISTAT so the
> code is easier to understand.
> 
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v1 disucsion: https://lore.kernel.org/all/20260316214530.104344-1-steve.wahl@hpe.com
> 
> v2: Fix subject line; remove hpwdt_my_nmi function, and inline what it
> formerly did, reducing complexity. This addresses comments from
> Guenter Roeck.
> 
>   drivers/watchdog/hpwdt.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index ae30e394d176..ba08189937ec 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -22,6 +22,7 @@
>   #include <linux/watchdog.h>
>   #ifdef CONFIG_HPWDT_NMI_DECODING
>   #include <asm/nmi.h>
> +#include <asm/uv/uv.h>
>   #endif
>   #include <linux/crash_dump.h>
>   
> @@ -158,24 +159,31 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
>   	return 0;
>   }
>   
> -static int hpwdt_my_nmi(void)
> -{
> -	return ioread8(hpwdt_nmistat) & 0x6;
> -}
> +#define NMISTAT_EASR	BIT(0)
> +#define NMISTAT_EWDOG	BIT(1)
> +#define NMISTAT_RTRAP	BIT(2)
> +#define NMISTAT_DBELL	BIT(3)
> +#define NMISTAT_EMSWDG	BIT(4)
> +#define NMISTAT_GPI	BIT(5)
> +#define NMISTAT_NMIOUT	BIT(7)
>   
>   /*
>    *	NMI Handler
>    */
>   static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   {
> -	unsigned int mynmi = hpwdt_my_nmi();
> -	static char panic_msg[] =
> +	u8 nmistat = ioread8(hpwdt_nmistat);
> +	bool mynmi = (nmistat & (NMISTAT_EWDOG | NMISTAT_RTRAP)) != 0;
> +	static char panic_msg_default[] =
>   		"00: An NMI occurred. Depending on your system the reason "
>   		"for the NMI is logged in any one of the following resources:\n"
>   		"1. Integrated Management Log (IML)\n"
>   		"2. OA Syslog\n"
>   		"3. OA Forward Progress Log\n"
>   		"4. iLO Event Log";
> +	static char panic_msg_uv[] =
> +		"00: A watchdog NMI occurred.";
> +	char *panic_msg = is_uv_system() ? panic_msg_uv : panic_msg_default;
>   
>   	if (ulReason == NMI_UNKNOWN && !mynmi)
>   		return NMI_DONE;
> @@ -189,7 +197,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
>   		hpwdt_ping_ticks(SECS_TO_TICKS(val));
>   	}
>   
> -	hex_byte_pack(panic_msg, mynmi);
> +	hex_byte_pack(panic_msg, nmistat);
>   	nmi_panic(regs, panic_msg);
>   
>   	return NMI_HANDLED;

