Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016536;
	b=5APcw16CABOlYdPoowlReEFOpjILkrYcLF4iaG2JgZRmvTL0Vl/bRvnwPE4dh9EjBB5n
	 NN4aEdG6LhkrZJXUVe8+BJ5SMwAxvMLGjJ7gU8kLGQKVDH/YyT/u2yODxsADvad9Sv90j
	 9HbqFxezAjHQ7JWW2piUnBnuNPl//RUqGm6GXyVmQTDXMtmE83YRuM9+QCNBeP7zmnCAV
	 nDVzU9WQSuLeBVEWsgtcAFrUZzKoyn9JCsLiPB+y3WIE3eoYv0fcKKKXR1/KJ/zyCX/u6
	 nZsYsqCk/eqWeZC0enxxEXy1jga3/u81l73MCKU+0gNJIB5DaOOsFxfG9n9qQfW4mhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016536;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=jQWvaTPqCek4DCh8Db7RNU5imBTdMArsT9KivA1cjR4=;
	b=2LSlibvpHAMWHDGSBO5mB/DeJq4HmztPGGqcI90zjrzEYc5tQBKWCpXx16qB44llqXgR
	 KG1MZBxgFm0Tgnjj8P5E89HeiyjWxv74XqfSI9ZQKNAtoluBpRp8QO9kG0Pjbc+d8rj4q
	 2COigPyHiFojbIZjXazBJ5nBuqhVBtOcvIunNQLZQyBwae6oCL8T7djK22ZODaZJWwTMT
	 eJxj7coMcZ1wm1ax3yoVp9V7GrxcooIS9zLM1QUbX1uL6B58yfrgW8r+09Yo8UrwfGvPp
	 HFGDbv5rE7zfrtFFsFZ6OomU0rzxL/B7TLvDc8fzRCSstRiLAeyZ+4X0FpSVOamQMFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=aAqMMf5l;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F21606A32C
	for <linux-watchdog@vger.kernel.org>; Wed, 18 Nov 2026 15:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51F21606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=aAqMMf5l
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id TQHbxU2a6V16IThnbxC2MX; Wed, 18 Nov 2026 15:42:15 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id ThnZxIp7mFhzrThnaxrySg; Wed, 18 Nov 2026 15:42:14 +0000
X-Authority-Analysis: v=2.4 cv=JY+8rVKV c=1 sm=1 tr=0 ts=6afdc756
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1B2Gx-C2IWWF3AkqscsA:9 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=jQWvaTPqCek4DCh8Db7RNU5imBTdMArsT9KivA1cjR4=; b=aAqMMf5lZoX0
	7MQAPncxF7QLT+JSwX39o40MvuNCDkZoAobzTlk255tUiqg9rrRK5gzwkHHsRj2dzAMo694nu+aQ7
	3yFYVvk1vLvu3MEDqjmOp3SexoyKmvJ4vvpCOp41mOwPDXCx+WwefOuq8jceh9bTDcN4sZbdZJxue
	DThcbydr66g1HDStZQA0BYzzqR4KKD1j3pvMJCtUr5jiLNDZGTE9KEo00hq7u1wWfL7O3vdcn+mBD
	ZOyGg6eBg28aIX3ZGZsoKtz8nvcjwatUwLvH87k5oHoQQG91wB81IJRGxy8uW1KQwQd2yRwsFS8pT
	3uh2xR/P8XI8W3kP+Lu+Dg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53778)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xThnZ-00000000mIQ-2zzs;
	Wed, 18 Nov 2026 21:12:13 +0530
Message-ID: <23c02c91-0f92-46aa-86e7-5d9692d9ba8a@roeck-us.net>
Date: Wed, 18 Nov 2026 07:42:12 -0800
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/2] drivers/watchdog: Add RISC-V SBI watchdog
 driver
To: sashiko-reviews@lists.linux.dev, Prajwal N <prajwal.n@oss.qualcomm.com>
Cc: linux-watchdog@vger.kernel.org
References: <20261118092147.2017658-1-prajwal.n@oss.qualcomm.com>
 <20261118092147.2017658-3-prajwal.n@oss.qualcomm.com>
 <sashiko-outbox-220630@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <sashiko-outbox-220630@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xThnZ-00000000mIQ-2zzs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:53778
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHFiA2U2oaf1VwcgGjFiPcsFmsCOJhrh6WPNvmfnTrXc6vxoo/w8QMCJAWMATdorSrMZ9N8IdXkeTSHRE/Kc3Byg0jmCKq/MHPBIwf5BmBqHwd4TBp7W
 5EVA+42oke3myZ1bd6+GdgtZ2kTprkc9h6bR18folZ+PKb7cT3R966hIHbYhEX74jRoqT9g82MGqlT9XGezHUY9+TlTDXYo6UJ2N1bz8rb+DqQFyhpPVUaXR

On 11/18/26 01:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] watchdog: riscv_sbi_wdt: stale firmware pretimeout in
>    sbiwdt_init_attributes()
> - [Medium] watchdog: riscv_sbi_wdt: unclamped default timeout in
>    sbiwdt_init_attributes()
> --
> 
> commit b565a37dea556ad8d64b1011abd4a164f5ec1f54
> Author: Prajwal N <prajwal.n@oss.qualcomm.com>
> 
> drivers/watchdog: Add RISC-V SBI watchdog driver
> 
> This commit adds a watchdog driver for the RISC-V SBI watchdog extension
> with support for MSI pretimeout notifications.
> 
>> diff --git a/drivers/watchdog/riscv_sbi_wdt.c b/drivers/watchdog/riscv_sbi_wdt.c
>> new file mode 100644
>> index 0000000000000..026579a3c5cfd
>> --- /dev/null
>> +++ b/drivers/watchdog/riscv_sbi_wdt.c
> [ ... ]
>> +/* Initialize the watchdog attributes */
>> +static int sbiwdt_init_attributes(struct sbiwdt *wdt)
>> +{
>> +	int ret;
>> +	u32 attr_val;
>> +	u32 timeout_usec;
>> +
>> +	/* Read watchdog capability from firmware */
>> +	ret = sbiwdt_read_attribute(SBI_WATCHDOG_CAPABILITY, &attr_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	wdt->attrs.wdt_capability = attr_val;
>> +
>> +	/* Read watchdog min period supported in firmware */
>> +	ret = sbiwdt_read_attribute(SBI_WATCHDOG_MIN_PERIOD, &attr_val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (!attr_val)
>> +		attr_val = 1;
>> +
>> +	wdt->attrs.wdt_min_period = attr_val;
>> +	wdt->wdd.min_timeout = usec_to_sec_ceil(wdt->attrs.wdt_min_period);
>> +
>> +	/* Initialize the watchdog timeout to default value */
>> +	timeout_usec = sec_to_usec(SBI_WATCHDOG_DEFAULT_TIMEOUT);
>> +	ret = sbiwdt_write_attribute(SBI_WATCHDOG_PERIOD, timeout_usec);
>> +	if (ret)
>> +		return ret;
>> +
>> +	wdt->attrs.wdt_period = timeout_usec;
>> +	wdt->wdd.timeout = SBI_WATCHDOG_DEFAULT_TIMEOUT;
>> +	wdt->wdd.max_timeout = U32_MAX / USEC_PER_SEC;
> 
> [Severity: Medium]
> What happens if firmware reports SBI_WATCHDOG_MIN_PERIOD greater than
> SBI_WATCHDOG_DEFAULT_TIMEOUT (60 seconds)?  Writing the unclamped 60-second
> default to SBI_WATCHDOG_PERIOD will fail in firmware and abort probe, or
> leave wdt->wdd.timeout smaller than wdt->wdd.min_timeout.
> 
> In addition, if wdt_min_period is in (4294000000, U32_MAX],
> usec_to_sec_ceil() rounds wdt->wdd.min_timeout up to 4295 seconds while
> wdt->wdd.max_timeout is 4294 seconds, which causes
> watchdog_check_min_max_timeout() during watchdog_register_device() to reset
> both min_timeout and max_timeout to 0 and allows sbiwdt_set_timeout() to
> receive timeouts that overflow u32 in sec_to_usec().
> 

Maybe just use clamp() for the minimum period and bound it with something
useful, just in case the firmware is buggy and reports a minimum period
of 0xffffffff microseconds.

>> +
>> +	/* Initialize the pretimeout to default value */
>> +	wdt->attrs.wdt_notif_time = 0;
>> +	wdt->wdd.pretimeout = 0;
> 
> [Severity: Medium]
> Should sbiwdt_init_attributes() also write 0 to SBI_WATCHDOG_NOTIF_TIME in
> firmware before setting SBI_WATCHDOG_PERIOD?
> 
> If a non-zero pretimeout was configured in firmware before a module reload,
> driver rebind, or kexec, leaving SBI_WATCHDOG_NOTIF_TIME untouched in
> firmware causes the 60-second SBI_WATCHDOG_PERIOD write above to fail with
> -EINVAL when the prior pretimeout is >= 60 seconds.  When the prior
> pretimeout is < 60 seconds, firmware keeps the stale pretimeout active while
> wdt->wdd.pretimeout is reset to 0 in software, triggering unexpected
> pretimeout interrupts and allowing sbiwdt_set_timeout() to pass timeouts at
> or below the active firmware pretimeout that firmware then rejects.
> 

Unless I am missing it, the driver doesn't check if the watchdog is running.
Given that, it might make sense to explicitly stop it to avoid surprises.

Thanks,
Guenter

