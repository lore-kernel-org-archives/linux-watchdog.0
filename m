Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1142A7B7
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507182; cv=none; b=tO7VmvPlEz+7KmTieLE/bzFfh40bcrKewT/mqLjPqtfzNv9agtTa9QizGoT0jYfqBNJwK/NVxcyVuplJSVJ5w8+EVPBjjez7gcJ9ydfLv7V/LcBtfxYmkR02LGVTCIMDyPW9Zg0BHKF50ZSqvHf5NgR/YufxejUtEW03ySd78yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507182; c=relaxed/simple;
	bh=0aDIb0fU/IpGonH1K4ihI7im17zW2pGOollQDCIp11k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=byiD8KVvuNTwrJqpoCqnRHmI9Twq7+Nz5erjFnM7Mid1issRpHrqSWb+C0q8LO/ZPzuYNTN1jTM6ceLyUCgwfTqKHv8hbUIQ9SohdAeWLrtP9Rv9Qt8ya3ECvnpvPF6lVLxsXDQ4S6fpz4G82FJi+HONsoFRJqOGRlyrgUzAetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOFn3Fnd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOFn3Fnd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e347638adso1304586a91.0
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 07:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507175; x=1786111975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qls6m4+nvnABe9mzo/b58dSKb8hrptf8rR5t44pPd/I=;
        b=oOFn3FndSk4G3HLjh5mk9NGqmN9B4eW6Gl+m4Ti6JpF2XMAkZBGwUFFwnTcIRV4qtm
         tIXReAui9olvCHHShsFpGwWbLOFifngl1qKqNHBzrBqlluPipRWcky2tnRHBherIP5lM
         nxsk38LeNFSRK17XfA/mcwr1vjwWpMird33nCSluRp5zp50VDRJLUeumkf/N7uczVUD4
         n8zbrzO48ppfajJlhHLboJePwlMZpuzjoivsYxXMy9+WKsh2og8MEuNvjxRVxRkzS0Ca
         poxvXzxTlbb5p3+v7jOz2BzWRlroTi7J7uKn1Mr8PZlDX5VxJkxkGD+CI4LYWxthg+0s
         gdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507175; x=1786111975;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qls6m4+nvnABe9mzo/b58dSKb8hrptf8rR5t44pPd/I=;
        b=UIgV0hwjuSAEWWqK+YxSZ0eankzkoqZ3AxNaxO+DQnrS8jtNY0jncGqoVTBDwJlZq5
         ERBwlj8uGaG54mQI1NjWtAP7UXl82vSPcg2/5nZGUgFXS22xOxw1RBavJCALAs1R7UO3
         j/T9uFbTAmhaUDM+Ds/IXYZGqGsfqu4mcT075Z/qjeCjFfpnmSiflU3JlEQl2L5DX0KF
         CMBpRXQSQWe+tt1n/q1ITa374jUxJC/fBzLQ5by3B+cG5Mxpw2hEjfy2p4J7QsmCChoN
         A7gsh8+brssm3nH0F7cpq1U01E2d1iSE/uTfVy3wpztY0GPuxZuiYMxxwV28o7RXcncV
         Z9sA==
X-Gm-Message-State: AOJu0YwZ1nZsj5ze+VM5JoMPsRrt4gE8FF+JQ6ooNiQ16XBsij/1C6Nv
	fcoshJi5uI5C9Vr2WgNvolKDnQXMPbN6sOSsYbWd1LjJCg2Llu/2Ed0c
X-Gm-Gg: AR+sD13CLPsmhI65bfJKcq0u6ecuFAmcfNoaxjgLmgiRNQXotLy0OGCLsoKG+XCSv6+
	b46FKg581i2ohUngd6jXtdVTtc11vVUO1W5dF+4ssTw1ZzuJOaP4KSLmIfATINRWTeTxSjRe4Yp
	/Lm8yCtbmy/bL9aOoZmvgeX9P1KlSNIwRJsXdIMv6L7/SWAeRAHhXs5W3OVSREpzrWq0V5/R7f5
	cfby89QPBhXove2W6y6iX4R7sJwVkC8MYvH5qCRBoUYGnMo0yt2SEc7p7T2DKTO2D6e3sMQRwUF
	BCz28221YP8o7XMHEqzX4x0qLmXBRywVMmnMKX8sQPEUI3ARuLgGMgvxvrOFZ+Zn3B9TgNSMpVm
	rOOqLAutXbvxe7Lte2l2Rj0pBqaZu/yK8n6fegwcB2kiukqoVH/A/ILXoKiQjwnxwZ/mrknZU/g
	dvbKPRndSMINfTJZRR01AyOfe8fREng57HCXyIxJbKS0/PoMNfHEiez8ugYohK7Ce/VTKDxljhY
	TnHmMQHwozfXSTxP5g5yZxqtJ1gQyoRXj/PUmuaCPZMAz4J
X-Received: by 2002:a17:90b:2d4c:b0:387:df8f:1401 with SMTP id 98e67ed59e1d1-38fbc598becmr53602a91.34.1785507174623;
        Fri, 31 Jul 2026 07:12:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2964c10sm763044a91.4.2026.07.31.07.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 07:12:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f98f6f9c-9cfc-4fb6-8a1a-776b480bbad3@roeck-us.net>
Date: Fri, 31 Jul 2026 07:12:52 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] watchdog: qcom: Register pretimeout interrupt as NMI
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, mrungta@google.com,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Thomas Gleixner <tglx@kernel.org>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, "Kirill A. Shutemov" <kas@kernel.org>,
 Douglas Anderson <dianders@chromium.org>
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com>
 <20260730-qcom-wdt-nmi-series-v1-3-3aa86d162914@google.com>
 <36a7bd8e-7e00-4df0-abd4-e22b86e91ca4@oss.qualcomm.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <36a7bd8e-7e00-4df0-abd4-e22b86e91ca4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/31/26 04:56, Konrad Dybcio wrote:
> On 7/30/26 11:32 PM, Mayank Rungta via B4 Relay wrote:
>> From: Mayank Rungta <mrungta@google.com>
>>
>> When a system is completely unresponsive due to an interrupt storm or
>> deadlocked CPU cores with standard interrupts disabled, a standard watchdog
>> pretimeout bark interrupt will fail to execute, preventing the pretimeout
>> governor from capturing CPU backtraces before the hardware reset bite.
> 
> [...]
> 
>>   drivers/watchdog/qcom-wdt.c | 55 +++++++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 51 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
>> index 49bd04841f0c..19d8e91cff40 100644
>> --- a/drivers/watchdog/qcom-wdt.c
>> +++ b/drivers/watchdog/qcom-wdt.c
>> @@ -51,6 +51,9 @@ struct qcom_wdt {
>>   	unsigned long		rate;
>>   	void __iomem		*base;
>>   	const u32		*layout;
>> +	int			irq;
>> +	bool			is_nmi;
>> +	bool			irq_enabled;
> 
> Do we need to track this? I think we can rely on the framework
> NOPing out multiple ops->start requests
> 
Good point. Agreed.

Guenter

