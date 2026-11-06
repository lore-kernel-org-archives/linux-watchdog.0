Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794003533;
	b=ZkD8D9XI3vJzaxq9qnCNOn1RVD1uvMulXj6Shx/GTNCZEpL+jy82wF4X/M5NdzyAda5A
	 npBLEF7ThKTu06YLT7J+f+sAqriOTvFs5q4BRvkM+IftJqz1OUmdrdWR0ju83CGAnjcsc
	 2ICePqxbYNyz3uCe6SOCXUdjArFJzDRhqIDMUACbmThZO0Y9aC7Sqw2fJksY47vCWlc6L
	 v/+AtTefqaEJIIypt423Sw36f4U+B4aoIDCVR9H1iC4PTLZP8q3Edc01591A1AdTyxTSz
	 WfBreBhD9VgCwB2Wb5vvoTkmDUHProQu1zZ2PaVcqeWF/Fg0cwSd1eZaZzi+FulsMsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003533;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=tURUu78Mfm5tXaSKC+0omXpop8yxpZNIgR2c4OXKv84=;
	b=PJnkHZ5JxbcyjX8/FNdIMfMdLs8TV2iutPiQOm7jnzxPbc3y5TXA1T5CjhE+3Fy9lIY+
	 xLZqH4I6BEtuMsmYbFyIDukngZed/w+HqJewwGViA+0tMuXAOi80Ld9wBxUR+FvxyXclj
	 MPxFMcO02zHlg6e364A5d67aS0U6qhZrPZEVEIm5BJrAk8O1RyrjURD2OJIoKKLNkEEXh
	 KeegpGG43nHW4/F/y0yn+6HE1agR2dhNwUltTwOowJSqCUGCv0CV1wVuN1qZlT5DRX8lg
	 esE5HXXQ6wLCH52axpW/Ck/9EJ1YSwsgouJh3+WRwO4MIVyqJ7KTdlTvKKpJdOP+2Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=aIVgxCDT;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D34606A32C
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 22:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66D34606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=aIVgxCDT
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id PNauxftHB4vCDPSGkxt6cG; Fri, 06 Nov 2026 22:18:46 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id PSGixNtXcdRrRPSGjxX3b8; Fri, 06 Nov 2026 22:18:45 +0000
X-Authority-Analysis: v=2.4 cv=LOhmQIW9 c=1 sm=1 tr=0 ts=6aee5245
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=8b9GpE9nAAAA:8 a=GMUnNgnwFuJ-T506CLsA:9 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=tURUu78Mfm5tXaSKC+0omXpop8yxpZNIgR2c4OXKv84=; b=aIVgxCDTOgBT
	ZuRVJechWxxhECFc8mlmWQ5lJuxx4iodvszw03hVJvSZ4iTh626FT8rT6lvCBq66eO1Gbcginx5W/
	HpPRxQy3y+xQVKJNZKQgcEnmpHXUhSdVMZNw8ZD8hJ7qFS64jkdg4gX4szdYARF9+mIKbcGIW42QD
	dWkYfYA1mvL001BxzckioODzLxdCffshUsTMWQAkQFEjV5xrVP2Si2AlLGxgJL5dsVbskevd/7/vA
	4GZr3rmYDXKs8rlIdPm+IjLchIt1MCm1bd1YfKPCQnAy1/cDO/VJ5mDGXbK48cqqrKgBZdvGWXPjP
	xRRc2jv3wByqweiNXHYKrw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50820)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xPSGi-00000003WZp-311T;
	Sat, 07 Nov 2026 03:48:44 +0530
Message-ID: <bf99b912-7a98-4d97-852b-45cb3c3c58be@roeck-us.net>
Date: Fri, 6 Nov 2026 14:18:43 -0800
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
Subject: Re: [PATCH v3 04/13] ARM: stm32: enable arm smc watchdog on
 stm32mp1xx
To: sashiko-reviews@lists.linux.dev,
 Antonio Borneo <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-5-antonio.borneo@foss.st.com>
 <sashiko-outbox-201910@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <sashiko-outbox-201910@kernel.org>
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
X-Exim-ID: 1xPSGi-00000003WZp-311T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:50820
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEq5SE7mmTbGpdF2XgnYF2YgQ9+7lhFTvVcQ3ovnIu43cg3au+7JdApbWYUlk4ESJcz4iMLa1eMVxj9cL4LYxJ9h0rfn6ftsN8fuEO8HYX5SUUkVQvup
 LuuW/wdbxeuaN+XU7LBebqFxk1zkNnF3077XzIafOYYlsMJX8Ozq2C4OwHH995rlF7iun7K3Pqq/c53ZCh+zOoR+JGLkU/3tNTYdPJDufHCtm8KVAkIS/UqV

On 11/6/26 09:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] ARM: stm32: selecting WATCHDOG and ARM_SMC_WATCHDOG forces
>    built-in config
> --
> 
> commit 4450302b23f46b760d6b23f33c853eaddb3d821b
> Author: Antonio Borneo <antonio.borneo@foss.st.com>
> 
> ARM: stm32: enable arm smc watchdog on stm32mp1xx
> 
> This commit selects WATCHDOG and ARM_SMC_WATCHDOG from ARCH_STM32 when
> ARCH_MULTI_V7 is enabled.
> 
>> diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
>> index 4ac3384e397aa..de09b2afa0f2e 100644
>> --- a/arch/arm/mach-stm32/Kconfig
>> +++ b/arch/arm/mach-stm32/Kconfig
>> @@ -13,6 +13,8 @@ menuconfig ARCH_STM32
>>   	select RESET_CONTROLLER
>>   	select STM32_EXTI if ARM_SINGLE_ARMV7M
>>   	select STM32_FIREWALL
>> +	select WATCHDOG if ARCH_MULTI_V7
>> +	select ARM_SMC_WATCHDOG if ARCH_MULTI_V7
>>   	help
>>   	  Support for STMicroelectronics STM32MP1 processors using Cortex-A7
>>   	  cores. Note that support for the earlier Cortex-M based variants
> 
> [Severity: Low]
> Does selecting WATCHDOG and the tristate ARM_SMC_WATCHDOG from the boolean
> ARCH_STM32 force both symbols to y whenever ARCH_MULTI_V7 is enabled?  That
> prevents building arm_smc_wdt as a loadable module or disabling the driver
> and watchdog subsystem on multi-platform ARMv7 kernels with ARCH_STM32
> enabled.
> 
> Could ARM_SMC_WATCHDOG instead use a default in drivers/watchdog/Kconfig
> (the way STM32_WATCHDOG uses default ARCH_STM32) or be enabled in the
> relevant defconfig?
> 

ARCH_ASPEED and ARCH_S3C64XX also use select, but those architectures depend
on the watchdog driver's board reset capabilities. The smc watchdog does not
support board resets, and select should not be used here. As far as I can
see this patch is simply unnecessary: Both WATCHDOG and ARM_SMC_WATCHDOG
can be enabled in the configuration file if needed/desired.

Guenter

