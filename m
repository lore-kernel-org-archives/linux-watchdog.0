Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794852065;
	b=gIHgDD7qi38+9Xy/yAxLXiyOy05Ys1ULrgliIKmkWPdTYSLJasTCMWXYHesMyXz1GaKn
	 L3jz5kElZT1qm/OKYX2/ZUclUiP4xdUMvh4UiKU/ZM+x1f2L9W9R23Cv5Ufp0U/uhTUUh
	 QcLjNcTOfYU01yCkL9XmFlch7wgehhVYTYKje59TLDpfNXeFQW7DwltKsMJKGpQMvpi4F
	 A5pKSyWDiCKR269CkIDLoix9plIXAnC7Kz6sDGQS7D0uY0/0XjbfnIMrIWamBVrfdz4f8
	 R1BWRNR1n9OiCF3vBUJpQHLzVLi9FZKXSHoklACf0qie1l7aM6WxTm4qWQMjSJ56PqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794852065;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=Ltq0pQI/ZMNBgnaD/q0Y2ypyV3mBPASt3xgWnkZCEc8=;
	b=LW/nH9mdsAO2/d+mZfOtbGERp1B9QgoQUkrJNLt57zgsF7SXi3f3V24MRbZzN6LVhWzL
	 tZJQmyQN3tukXg65E8wiWlJqASR0OaGfZhf0rMTl7+p26wk9WRjQmF0R1tjOHTBEdC1B/
	 a+/1wtHLxqNA0ZMnzLbalttYL662thRt8u5zpfRLwpYxXH3qjfHyNn28LaCInl2R+HDV1
	 AOTL/ebNGEqVoQ8T/PqU9V7Xc/LJHsP2CbUEBM6OOtr5mcw/NbRW3ERGvNig8dsJuBqxf
	 BaOZW6JTJbZj84MJwcU1G72rrM+WaZfQzpipE91RuyIr3u9/4Rkz71EXfqR0CVVU0Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ckt3u3FU;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC309606A893
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 18:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC309606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=ckt3u3FU
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id T0zsxPCKY4vCDT10pxDpgd; Mon, 16 Nov 2026 18:01:03 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id T10oxsRNilaNKT10ox0B5A; Mon, 16 Nov 2026 18:01:02 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6afb44df
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=FXjISBkA9uUpg2xqjyUA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Ltq0pQI/ZMNBgnaD/q0Y2ypyV3mBPASt3xgWnkZCEc8=; b=ckt3u3FU8wfb
	UNReXeL/yWpvxp7Gv6a4+GlHAJ9RgpyZIpwyNK9ihajCUsUQLoO2m0quk7/C13G8VFQQ6XGVwP+9v
	GIjU7fKqx9AUxKMmKJ1cCO+oX0RQVh2qRWXMie0yJmWYsMxTGfB5mYGgvLj9UI0Xilufq0CHPZoXW
	YHusOg/Ax/r2ast6ujL+5I7DoMQwHX0Ssx8VaD6mWqSx7uENfgBlb/mJlptUN7j3r0s581rRLxgNx
	8TZuFBuqVPjzOGL1BXsDLeBJp5JIP89BLlBj5rTYki+S6sqKp5hCv4zK+JwHK5XvltARfThKmpvnn
	syQmznHJBO+/yNwkdDUEoA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58046)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xT10i-00000001Aes-1XM0;
	Mon, 16 Nov 2026 23:30:56 +0530
Message-ID: <53492f71-9a31-4093-8c61-fb410cf44d5a@roeck-us.net>
Date: Mon, 16 Nov 2026 10:00:54 -0800
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
Subject: Re: [PATCH v4 06/15] ARM: stm32: enable arm smc watchdog on
 stm32mp1xx
To: Antonio Borneo <antonio.borneo@foss.st.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Yannick Fertre <yannick.fertre@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org,
 =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>,
 Amelie Delaunay <amelie.delaunay@foss.st.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
 <20261116132416.1184447-7-antonio.borneo@foss.st.com>
 <32157be8-28c1-403d-8485-96c1fe4543ef@roeck-us.net>
 <2628f6e623996cda73a8cad46d451a629e749462.camel@foss.st.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <2628f6e623996cda73a8cad46d451a629e749462.camel@foss.st.com>
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
X-Exim-ID: 1xT10i-00000001Aes-1XM0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:58046
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKLOnPNOrEAMXV7hSOT3HDxI5rzeMqjK3UB2SFWh+Iqh7XGSmvTPYcYTnnmIr7O9ssaZ8PdPuNeHnFbdsM80Dc2JvMHERWp5WTBwBtMFOn80z2hME4C6
 2wolH36I5TnhPz1s+ivk5XIi/EoGZssDNyx+0TXMVPsMjFtQ2W4GUb0BqUxcFGHNNJ5vPGAOrCqOxk/7p7PyFPTAUEd1RW28BbgytVVeOMe5O5Qa+mkC+HOw

On 11/16/26 08:45, Antonio Borneo wrote:
> On Mon, 2026-11-16 at 06:33 -0800, Guenter Roeck wrote:
>> On 11/16/26 05:24, Antonio Borneo wrote:
>>> The watchdog IWDG1 is secure by default on STM32MP1xx SoCs.
>>> On boards that keep it secure, Linux must use the arm,smc-wdt
>>> driver to ping it.
>>>
>>> Enable the driver for mach-stm32 when ARCH_MULTI_V7 is enabled.
>>>
>>
>> As mentioned before, that doesn't just enable it for STM32MP1xx SoCs,
>> it force-enables it for all boards running ARCH_MULTI_V7. It also
>> goes well beyond the current scope of "if ARCH_MULTI_V7" configurations.
>> I would suggest NACK for that reason, but that isn't my call to make.
>>
>> Guenter
> 
> Hi Guenter,
> 
> sorry if I take more of your time on this, but I haven't got your comments on
> my reply to this patch as v3 04/13.
> 
> On platforms STM32MP1xx the trusted firmware starts the watchdog.
> Since on such platforms the defconfig is multi_v7_defconfig, the upstream kernel
> configured with multi_v7_defconfig would need ARM_SMC_WATCHDOG to prevent a reset
> during kernel boot.
> 
> Clearly, my wish is to have an upstream kernel booting properly with defconfig.
> 
> arch/arm/mach-stm32/Kconfig handles two series of ARCH_STM32:
> - the deprecated ARMv7M platforms that use stm32_defconfig;
> - the ARMv7A platforms that use multi_v7_defconfig.
> 
> In this patch the condition 'if ARCH_MULTI_V7' is to enable the watchdog only
> on ARMv7A, not on ARMv7M.
> 
> Clearly any driver enabled for ARCH_STM32 will automatically be enabled for
> the other SoC that rely on the same defconfig.
> 
> Also reworking this patch by moving the change in drivers/watchdog/Kconfig as
> 
>   config ARM_SMC_WATCHDOG
> +	default y if (ARCH_STM32 && ARCH_MULTI_V7)
> 
> would still result in the arm SMC watchdog enabled for all the SoC that use
> multi_v7_defconfig.
> 
> What would be your suggestion to progress on this topic?
> 

No. As you say yourself above, "the upstream kernel configured with
multi_v7_defconfig would need ARM_SMC_WATCHDOG to prevent a reset during
kernel boot". I fail to understand why you don't just add
"CONFIG_ARM_SMC_WATCHDOG=m" to multi_v7_defconfig and instead want to
force every single platform using multi_v7_defconfig to build this driver
into the kernel even though almost all of them won't need (or want) it.

Guenter

