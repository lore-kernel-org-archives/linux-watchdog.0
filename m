Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FAD484222
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787846514; cv=none; b=G6Qg/0xS5IpZlhjlEut0VhWdNWrG375PSEq/MizoGdyRjotFpKZqYIhF6gI/w1cmyjOg1ZM4nRw0XNGkbuBk/ffOCRS2YVpIFLLSNV3hRq5FPRS0K0HyBjRA+NckUk11Qk/L/+qOPSvJsO3RNyFnAdDpCE74FGFAMPPlT4V/Qg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787846514; c=relaxed/simple;
	bh=ic5/TCOazI+vzPge6bvWZ7zGCvPN02z9h0DP1o5xW6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YosbPGeIN+Yad4Tp60mtO5kMp9X8KggtfeYzx0vVWdbKkwvIp9WgNws1B0Gv7i8hrNm3oz5o1woZUWZUtLASiYhHMP+kYCg6U4Sd0uP5VVdI0Yi3JvbBnZgRnx1NYsccoTJE11WB06JmVi8mc7Lvzyd/pP020pCtpva97Xz3mKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQqXS1FQ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQqXS1FQ"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso112490a91.3
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 09:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787846512; x=1788451312; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rwE6YgjixsCX9aq2oQ1p8iALzcQlAqogkPLdpwFVN3Y=;
        b=SQqXS1FQ5ieH2j98ZToKV5SQ+4Q4PwijBXbR+zF6+sa0Izwq9Le6UrKFDoV6hyA9NA
         +FJBYk0vu9dY3QFE4pB9EYAYSQGWnlqcTBURi9HpZcYM0rO+C2aGhdi8qKUP4icmpMrg
         HZsw3AgP9wmTLoQObDCF2mnR/fz5S6VgDc9LD3gXzTgE3b1SVELW42zejqxIaI4fLuRb
         YnD1F+ujPvXRwGhkfsB5kQyVetht9uYnbGtTKUMbS1O6zEYvk85h02OGjNlonlteghnh
         mX3UsfnHy0Xs/crT/R0EYXe9CfMIt5sYiCMVjX85XYMkbJpX+i6mmuTLI4b7eTsVS6zS
         mAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787846512; x=1788451312;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rwE6YgjixsCX9aq2oQ1p8iALzcQlAqogkPLdpwFVN3Y=;
        b=hXuECv8LLkg744LDqPJZPIfSHeTZnlWmo+34Xzx9AIqU2OmTiFomgzL3TCVXaL/Gi2
         rmuhGiHmTNmaawJa+p9RQsCtK/BgwFk3vqK13aNi1YI/R+/kbKhAviKWWk5TYRZ0m15E
         VcYpZbWEFuylJ46LOJ6u8ifC81J65qeGuOUa0WCdSToPwSOSjcWpFH8XKOagk1s021yv
         j+I5nWxTb37rpM7nrakmrqHjsdB28ljnDS4lwkr9l81nqxydFRfHifj2WPKtDTXoIOqp
         1SQG31hnxSW49scfp0dGCfpSfNDxHqBcK9ajpKrSsbVHovX1cXjzED6hg7hPMRNsrjY+
         AbyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpcDTCH6jm+4dbdwEJrA22DSUNGzJPuOPFrykZataRRAJAIoIoVzFVSLglY1NECtZhqVSbDtAorU96WvfGnjA==@vger.kernel.org
X-Gm-Message-State: AFuF++nhuKVbX1BB17yivimtpDOcT78e3dhuponzB5gbOLkTxouNqtqL
	bIUtTAvsLBPn2rSxDzFEN6Imkcg9sFBVCm3XEY6lKAS8cv0U2iNmompj
X-Gm-Gg: AR+sD12iNOA/UmApyybUv7KREM910FZVF+GSAjAKrg+ZfRo4LXjiB+8xHJNWzQPz6TU
	Lzycs5tIBHYopXM8PRpU24lNdUK9thPwaPEgs+pAWSe5Uhc/e3jJ0z1zYi6wt9eV7NA27GTJjj/
	kx0FqgE0mcb/Y7pPSLuxh3hbx681ZE9RQudUyO/7KALTPE/DQVSlmJK5Hn5/73JxPC1bB9/tyWX
	M6iiZYyKWutkzySKQrBKN9fY5dRBiP66xGyABlQjjgaHJME9vWVSVPpuoiGB1YzCWzdbEpEwhOj
	rdMlnobQOqDyj1PoA8FiwPQdYfICjquW0yznnw+XdZwVE4DJKlzGKzoF2Cc2QmSAEChk1NqH/6L
	Rew+BlOuXsK3ubx69PvrFMhr4q/wbixxHPf4A45QEcvTifa+3z3UPvWr8mK0Mt1Nqxex0aVZW7y
	TUvO926cLuhNAg9YTvYvf8GHqYp2DsuTckDGSlqydgcTTWPyjjPvMIvIn+xg4kJfHxgmFG8h3vp
	c5NBLRIFcYUBBqCeH+KhjN/9mKeVEgw1xmiPA==
X-Received: by 2002:a17:90b:1dce:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-396d0ea8b47mr544141a91.3.1787846511975;
        Thu, 27 Aug 2026 09:01:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39675922253sm2543868a91.4.2026.08.27.09.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 09:01:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2bd566ca-2696-46d3-aeec-57db66fa1902@roeck-us.net>
Date: Thu, 27 Aug 2026 09:01:47 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Differentiate scenarios when watchdog is closed
To: Charles Haithcock <chaithco@redhat.com>, wim@linux-watchdog.org,
 linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20260824205051.4117285-2-chaithco@redhat.com>
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
In-Reply-To: <20260824205051.4117285-2-chaithco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/24/26 13:50, Charles Haithcock wrote:
> Presenty, when a watchdog device is closed, we print "watchdog did not

Presently

Also, the subject should start with the subsystem name ("watchdog:")

> stop" in a few different scenarios;
> 
> 1. When nowayout is set
> 2. When the watchdog is able to close, has received the magic character
>     to stop, but fails to close in device-specific code paths
> 3. When userspace delierately closes it without stopping it

deliberately

> 
> For 1, we explicitly print we can not close because of nowayout. Nothing
> differentiates the other two however.
> 
> This change adds a print to indicate the watchdog was closed while still
> running.
> 
> Signed-off-by: Charles Haithcock <chaithco@redhat.com>
> ---
> 
>   drivers/watchdog/watchdog_dev.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index d7895009a2..a571dea353 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -955,14 +955,17 @@ static int watchdog_release(struct inode *inode, struct file *file)
>   	if (!watchdog_active(wdd))
>   		err = 0;
>   	else if (test_and_clear_bit(_WDOG_ALLOW_RELEASE, &wd_data->status) ||
> -		 !(wdd->info->options & WDIOF_MAGICCLOSE))
> +		 !(wdd->info->options & WDIOF_MAGICCLOSE)) {
>   		err = watchdog_stop(wdd);
>   
> -	/* If the watchdog was not stopped, send a keepalive ping */
> -	if (err < 0) {
> -		pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
> -		watchdog_ping(wdd);
> +		/* If the watchdog was not stopped, send a keepalive ping */
> +		if (err < 0) {
> +			pr_crit("watchdog%d: watchdog did not stop!\n", wdd->id);
> +			watchdog_ping(wdd);
> +		}
>   	}
> +	else
> +		pr_info("watchdog%d: closing while running!\n", wdd->id);

As Sashiko points out, this changes behavior if the watchdog is active
and was not stopped. Also, I personally find "closing while running"
not very informative. Also, while technically userspace may close the
watchdog deliberately while it is running, that is not what happens
on a regular basis. I find the previous unconditional "watchdog did
not stop" message more informative and relevant.

If you want to make a change, I would suggest to add an error message
into watchdog_stop() to report an error if the stop callback returns
an error. That would distinguish 2/3 without making functional changes.

Thanks,
Guenter

