Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ED9F9E8
	for <linux-watchdog@vger.kernel.org>; Mon,  8 Jun 2026 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959163; cv=none; b=BPFxlWRWJXALRM3lfsYV+NIBQKswjz5hOGIJtMMZsj9iN1x5F55+d8pSZkabZ79HRdncrgOYn9DBRRt+JYyxgterccV9GG/YEx9EJND4qWltUrJxYad+gU6Fb1ynsdymBwYCObZ0AD6cR8e/RafGXo6uofcLT7rVvZtevuLUvqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959163; c=relaxed/simple;
	bh=UR94XfZGe4SN0tK+q/lzFr5zoyRdgF+h9/R2DPk8MdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8opHbO2veCoS3DAR6o7zIvrJURy3mpInaBBUMsejRPjW0Dfxhalzo4lxW3sEiMlp/jc3tuTBBrFMRM0sx8t2lYzxmY4VPdL795JkEOpgzDFgaaVgt+tH/TJCwObjP3ZHyYOXSZ03KXnUOJ9+aIxUcoh7NinI1Mh9kx2UB9GKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qqQpIQy9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqQpIQy9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8422524cb38so1590633b3a.0
        for <linux-watchdog@vger.kernel.org>; Mon, 08 Jun 2026 15:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780959161; x=1781563961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt2Eo3v53IUPQ4iRdHxED2L6IQZeVQo07iv+ksWhxxo=;
        b=qqQpIQy9IHiHwCLD0IEKXXpIfjRD2hpx4FNZIHJTpdrAYeithULkfHjbw5FiasAijh
         uaIff21eMZ9db/EBERVEdvdx42oi1FdcD5+maZsmugXe0f9GL2ByfiHNCd8TAk2Nu8YH
         YBXDxFmyrGnNrO9ZKBayLtbbdiO7LZAjKVMvTKaw64vm3a5ytaUObNcgCO9EOiTKtfk5
         5ihXhGOM8kCST6VetheKPLi5FsjZHpvfcdjTEBZHurpbQoq0UNAgJCoVpH6IrSuqTw89
         1B54jPxLaLGkSPeOC6AFamFRz57S5FfSyF/I0KSBn+Woyq+C5Ao3fKdBs9dOlBOzMm2B
         bkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780959161; x=1781563961;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jt2Eo3v53IUPQ4iRdHxED2L6IQZeVQo07iv+ksWhxxo=;
        b=KWdkBVEppP6TQBCbc1ej2ukmYy5PoilVg25Drr0o5eJ/00eSt9vF6l0IC/fsEFMz7w
         +6axH07QdGNSqfr+kBESsQa1grx3pmwwONzFNhWiXDHyUv4T3TQAzJYfZmaJ5lE+Difj
         IPZf26Hasq5b0lu/AyCxFaP4XKsyl0EcT0h/6dYhJFEeiNDM0IRID3e9vgu2nszulTdx
         ItEp86OOGsVl9aO5otKFM1imxlYlme6kyKQ/J2uXMh2/sQ5rU+JM7ZU6ynMrLKHx4rO4
         XsN6DYtkjNePKdxwVXmrhb9QSs8d2MYkyv3V4GeQG1N3kdEEJ9R+xnZotSyxaXZnqzqx
         ctBg==
X-Forwarded-Encrypted: i=1; AFNElJ/nmtpVHmMLDJsQaEBg0sFuRppfPy3W7Kkcyu0trfK3yAdqVkxJIq1w5H3pSB7+MIzZVmQQGoBiTIZyBILfNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzzB55PuJJWcFmLKNBDDREetiH1tQkMBfMy1x26xfwFJofR3yol
	nAw8mZ8ieEAk+MY+uuiSl3iwk1OXaf1xxPZ9+sogTH2Er5ov/HiQ/dTU
X-Gm-Gg: Acq92OEK4TQCnpiK0BLjesFA4ewsxxUrLzPHtQQc+daXrC5zRYMI/cpDMnxARPdCsE+
	F0RPimV/3AV1d3LdtNyAmEreWxn7uX+ZEAWMv9FbMDZOT4qhNKwLYY2ykFfJedAGnha9wuEeF9c
	ClCmLVVUTKEyuUuKbhc3aYkIsy0LfDkfu14VdwugD6vUg1W+Jy6Rc6ZkVL9i1xsT87VWqnnlb8r
	lihAxn9sieN1USuTBR8FIaePSd09v4w+swukltg1T4Gyk2j4mK2vVe0oFgfkmUR01lz3gYnA3QS
	kO9yWJshF8oBnmXWpMMVEyrpJI5rJmKwFMjYiW0SMVco1nCC5QYhOT94WIShhis/BFka6hUiyGL
	rPzDjqUJW8ddOwCSS/Kd5CLdY2CXGkGBq83rREfVE3mdXr1Ha8dXyvRJ7lI0X429Weu/8nE26yD
	YoMVDR7mrR7v6+RtNnH8tm2XinzhAQUIj6G47bUxKwvnrekzMixzojHDoCsyOsM+PLI48pwd7kz
	2eDvipbwEhJhsz9kN+hdg==
X-Received: by 2002:a05:6a00:1d9e:b0:837:f79d:909 with SMTP id d2e1a72fcca58-842b0fbc2efmr16431184b3a.39.1780959161319;
        Mon, 08 Jun 2026 15:52:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428221d1absm22868140b3a.9.2026.06.08.15.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 15:52:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d51a340-281f-40bd-9574-1f0ab0849ebe@roeck-us.net>
Date: Mon, 8 Jun 2026 15:52:40 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] watchdog: pika_wdt: fix timer lifecycle bugs
To: Rosen Penev <rosenp@gmail.com>, linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260608210402.31545-1-rosenp@gmail.com>
 <20260608210402.31545-2-rosenp@gmail.com>
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
In-Reply-To: <20260608210402.31545-2-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/8/26 14:04, Rosen Penev wrote:
> Two timer lifecycle bugs in the PIKA watchdog driver:
> 
> 1. pikawdt_release() clears the open bit before stopping the timer,
>     allowing a concurrent pikawdt_open() to start a new timer that
>     is then immediately deleted.  Move clear_bit after the timer
>     stop.  Use timer_shutdown_sync() so the handler cannot re-arm
>     after the call returns.  Add timer_setup() in pikawdt_open()
>     to re-initialize the timer for the next open.

The clear bit is not moved, and the approach is wrong. More on that below.

> 
> 2. pikawdt_exit() unmaps FPGA IO memory without first stopping the
>     ping timer.  If the timer handler fires after iounmap(), it
>     executes pikawdt_ping() on freed memory.  Use timer_shutdown_sync()
>     which permanently prevents re-arming.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/watchdog/pika_wdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
> index 87b8988d2520..d567103ec5e4 100644
> --- a/drivers/watchdog/pika_wdt.c
> +++ b/drivers/watchdog/pika_wdt.c
> @@ -117,6 +117,7 @@ static int pikawdt_open(struct inode *inode, struct file *file)
>   	if (test_and_set_bit(0, &pikawdt_private.open))
>   		return -EBUSY;
> 
> +	timer_setup(&pikawdt_private.timer, pikawdt_ping, 0);

Calling timer_setup() in the open function is wrong because the
timer may already be running.

>   	pikawdt_start();
> 
>   	return stream_open(inode, file);
> @@ -129,7 +130,7 @@ static int pikawdt_release(struct inode *inode, struct file *file)
>   {
>   	/* stop internal ping */
>   	if (!pikawdt_private.expect_close)
> -		timer_delete(&pikawdt_private.timer);
> +		timer_shutdown_sync(&pikawdt_private.timer);

This is wrong here. timer_shutdown_sync() is only supposed to be
called if the timer will not be re-enabled. Anything else would be
an API violation.

> 
>   	clear_bit(0, &pikawdt_private.open);
>   	pikawdt_private.expect_close = 0;
> @@ -291,6 +292,7 @@ static void __exit pikawdt_exit(void)
>   {
>   	misc_deregister(&pikawdt_miscdev);
> 
> +	timer_shutdown_sync(&pikawdt_private.timer);
>   	iounmap(pikawdt_private.fpga);
>   }
> 
> --
> 2.54.0
> 
> 

