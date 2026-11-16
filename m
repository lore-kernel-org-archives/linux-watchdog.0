Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794839838;
	b=2L3jNOLEvuQ+AcIxp+t5RCB/eZVab7Lg2pXy9yBm82M1eScuTloPOBEBlwYv78+k6jbA
	 64ApGsOcz9LmfIIKXQWwzz8l8kp7XW4xewU36Lmm5QBrPce3crBAz5W76TsbzjOstIq5o
	 j4yPbEN6zKfz5Xj7DCLi4q9tOi0E57kA2/k/dnt4VGEHc02qfF6P5E8RFGP5XzNd+TNUi
	 yKatRkF7FtV9kIhHFngILvbAfUbq+kNoyOwH3jSsbuTkXP58keooyRKFla+yiX4Js75t6
	 TdXSQn5Q1JNGL3ejTbNbtB6FO47kWq8lQJV7KskyUWU1YpYBXx89GNAY+qoX/2SRpzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794839838;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=7hSHlaQM1lE+i4LuhiemUki7VOefUOHjVjA72bigLyU=;
	b=uJ7x/3LFUGPsYNv0r3LJlAZAaNxD9xG+BJ3xDrymbVyBNlaa+FqLXXm22nEUbTvD8r+i
	 mI310tEh4iB+g2O0MtqNS77Y7zJMC8NOZ/YFJkn1peChqov2Ze8ZdEnTvFZW6cD/AuPth
	 Pbf20ckDA90ziBTNszz3fql9noC9ZGgSnwnRIyZLGqFFZoQiwZ3M3UfACAdx6XRLTGZUG
	 3UBnOvXSc/vfTfNbfD1OnnmcqkMx83cv3sN97btwe5m1Bnn5iOQ5iw1+Oa86+XeoNvL1H
	 XyoI6k7wG/y/senTAfGKLzr+Yx0by4rpkAJ+hZq3n0dAmT5yQvTw3Cyx1NUX0hbbWwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=VCMEJvEX;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DF606A323
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 14:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B1DF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=VCMEJvEX
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id SsZIxlDxKyb4YSxpexrfMF; Mon, 16 Nov 2026 14:37:18 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Sxpdx4zWvb2qJSxpdxt0Nd; Mon, 16 Nov 2026 14:37:17 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6afb151d
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=K-vJ0q7JDzK1tjjCEHQA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=7hSHlaQM1lE+i4LuhiemUki7VOefUOHjVjA72bigLyU=; b=VCMEJvEXEmxO
	4lb+xiR/cupcXfpnF7Kng96OOxsR1PaDSsOJWf12RN+rM0PwJ3paXLe4172J6u8yUJNt+35kyqWhM
	VN6k8AHVQcaSAXGhCbplwkLFIqLZMMwdXk3tp6H8E7Z+/JLEQaOh5kz6/H0YhqqW6xI6/ApztBZ7j
	a3ljMJ5j+LDSMADSX+03RfHuijSUJOo2+jLoJcHuaePi1695VPrMJ9QkcBMZoqQxjGJF3FxJSwW8A
	YT7UFQDsUCwnoAL0+NzEslFJOA4GHWBrQccKBxG6qVy46KAGwB6J6pFbGvVmMmKYTEtcD04IvLobQ
	l5JKWXhQJET2YPh11JpPlg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36996)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSxpZ-00000003vvt-2Nii;
	Mon, 16 Nov 2026 20:07:13 +0530
Message-ID: <65280967-46b2-4c72-b9b4-0308ad8887eb@roeck-us.net>
Date: Mon, 16 Nov 2026 06:37:11 -0800
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
Subject: Re: [PATCH v4 00/15] Update watchdogs support on STM32MP platforms
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
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
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
X-Exim-ID: 1xSxpZ-00000003vvt-2Nii
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:36996
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 99
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNOb1cBcZKUo83RompEApiGGDxxoSzybqQftEINWILSlk0HcxFXZLIMkmv9yuULrjU97h7tw5KmRy3NyjoVgUextOaCVPw+OBeD3uFiIq0oe+FLJ1jJ3
 sVmtNdAIL+1JQXhv0bwFbfPKopJOKAPQXWsZEzmot1uNPvyMR4SFX6S1BLxqf6fzQVg1ZIk8K0YhpdI1GZhg1Qe2Y+Hqmw3nBrEQRxuC2IAev6bDdLz8G8nm

On 11/16/26 05:24, Antonio Borneo wrote:
> This series allows the stm32_iwdg watchdog driver to determine
> whether the watchdog is already running and adds support for
> STM32MP2xx devices.
> 
> It also completes and rationalizes the configuration of secure and
> non-secure watchdogs across STM32MP devices and ST boards.
> 
> For STM32MP1xx devices, it enables the ARM SMC watchdog driver in
> the machine Kconfig.
> 

Applied: watchdog: stm32_iwdg: set driver data before requesting interrupt
Applied: watchdog: stm32_iwdg: serialize accesses to EWCR register
Applied: watchdog: stm32_iwdg: get hardware version during probe
Applied: watchdog: stm32_iwdg: detect whether the watchdog is running
Applied: watchdog: stm32_iwdg: add pretimeout support for iwdg v4.0

Thanks,
Guenter

