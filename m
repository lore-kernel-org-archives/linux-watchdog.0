Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818764;
	b=ptg1a/HMUUZsoFotsCTYfbsFlqlTfUxBBO3cNVuhJWz6fczyzPM/GRC6yL/kAKbyE5Bl
	 Zwl5DI20GU9H8bIiyAIH0+nIYXXalb134TW/nlzw+tWho2VKjvevzV0J2okiqitHm7NPe
	 0MZ6qw87nAjbu/jjTq+8TVt/Mbjqdsom0CXo+OTKAOBveS+x9bkGmZvbjzJ0G0jyVVn98
	 /UygyB8Pz5j2HfDk6dZ0aw8ntg7YDSweguBJTLYtJbICOSyRJO4hiAACBR+WrY9cv8hcr
	 RNUDtW8BwkmSJvAweXdS4H5b1gIQqLZiZxXrgDixXM2y+TA6berZTXme4H2m9akAgCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818764;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=3LWSzGS2M4d4ZV9UBRwC/myQQ0a6KadX0vuHW/VG2Go=;
	b=OwcypFHcXrMgSWbv3FOzHt46hl4xSTiiuHyMDbIn8ECBPRjmyVY4FaACjWa13nOI3UG7
	 ECnv/Y+7BOV02mWK9O6T7g/TwkMR1FHMpCoXVSsKqSOSkDTmOArAiyFfgSb6Kd9r8Eaqo
	 u+LfE1CCAYCxNNN1aWzSEc0lkA3ChmARJlM9AJ7zeYjLfCX8Po6TNfpOVLuXKT88jZoec
	 USHbcehawqscwPxVZhVrPJV4XCGv2dNXYjkHYZIzQaG+LEd7yEHaIQxfHA3BwSsT3kj8A
	 cLxlVqEctcpTRZk14VH4QVxuiAEpTiIei7m2aXd/CvY8H7wVLCKpcO8e5dQMDypsyIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=O7CvlFch;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94347606EE85
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 18:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94347606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=O7CvlFch
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id OIFcx0q5kAR1iOgChxvfnm; Wed, 04 Nov 2026 18:59:23 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id OgCgxbqN3KD1BOgCgxbWdU; Wed, 04 Nov 2026 18:59:22 +0000
X-Authority-Analysis: v=2.4 cv=N6MpF39B c=1 sm=1 tr=0 ts=6aeb808a
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=uChsZFC9AAAA:8
 a=ZYZN6JFVlrb8GS7rZWoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ULtXvzFHYWHLyBAuiDia:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=3LWSzGS2M4d4ZV9UBRwC/myQQ0a6KadX0vuHW/VG2Go=; b=O7CvlFchzVm2
	LU9Vh4hwKtXjicNibNvf3z13BbgzCY+AO3XQmrUM/u8oDbmlu61BLS/+3l+AVN+CZ7+htDmZjz4cp
	aKKR6eoxL3s/zsruvjHM8tLvFn0QjZcFmK967lcguf2GGKr2Lj/3TFxzOve+6KI9HVwvQIQaqjz3i
	tw9tM2IL1nfTYwbGYUa7bmb8NSnM1ZQC67GSu25OH4zZH1Qk7Ri0EZV+Irn1SBmFdiVnJoSv/PAvu
	X3e6diYrCCYYw8nBMHva8FpsXLcA+TjA4tu8oicvvHBBM4NxE2TNiHcY1uxvQN+4S3TPYNSXnaUNT
	E02szdHQJKrHu0qjOY8JQA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49340)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOgCf-00000003kFG-3QtC;
	Thu, 05 Nov 2026 00:29:21 +0530
Message-ID: <fe63bd63-bc70-4acb-84c5-225fb11021b2@roeck-us.net>
Date: Wed, 4 Nov 2026 10:59:19 -0800
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
Subject: Re: [RFC PATCH 0/3] watchdog: arm_smc_wdt: allow a list of SMC
 function ids
To: mateusz.nowicki@posteo.net
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 linux-watchdog@vger.kernel.org, Julius Werner <jwerner@chromium.org>,
 Evan Benn <evanbenn@chromium.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Marek Vasut
 <marex@nabladev.com>, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261104161553.30115-1-mateusz.nowicki@posteo.net>
 <c742c878-d4b2-48d8-972e-a09aa4d215c7@roeck-us.net>
 <37f9e5e73070972f224583bc1581e400@posteo.net>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <37f9e5e73070972f224583bc1581e400@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xOgCf-00000003kFG-3QtC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:49340
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 16
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBt+8fr4cUW7O9pcAWN06y89yxWROdAWapKOjA/5qjtnQ8cHjVCOkAnkkI6MNe9y1n8FnY2ppGtCQ8fBgK1Gou9lRcyjBdotNiOeKf/mwDZKCf9iHneq
 J44Zc+SuZTrDScICPMCcyxc6HD01xsJl83LAR9bMRw/ZFzxCHCwg/+qdkj/IwvYRPVcmVyA9CKY39IMmWVbHozJ8eZnckU130HQcw5a02Ad41IPKev40QtY1

On 11/4/26 10:10, mateusz.nowicki@posteo.net wrote:
> On 11/4/26 Guenter Roeck wrote:
>> On 11/4/26 08:16, Mateusz Nowicki wrote:
>>> My earlier patch, commit ae4d08bbe3f4 ("arm64: dts: st: fix arm,smc-id
>>> of the SMC watchdog on stm32mp2"), switched the dtsi to 0xbc000000. That
>>> made the watchdog work with current OP-TEE, but it broke boards that run
>>> the older firmware. So today 6.18.y uses one id and 7.4 the other. When
>>> the kernel and the firmware disagree, nobody pets the watchdog that the
>>> bootloader started, and the board resets after 32 seconds. Marek hit
>>> this even with a recovery kernel, which is about the worst place for it.
>>>
>>
>> So the DT on the board is updated to use the new ID but the firmware itself
>> isn't ? That seems a bit odd; I would have assumed that the DT on a board
>> is kept in sync with its firmware. Is that not the case here ?
> 
> Not necessarily. On these boards the DTB is built from the kernel tree
> and installed with the kernel, U-Boot just loads it from the boot
> partition. TF-A and OP-TEE sit in the FIP and are updated separately, so
> updating the kernel alone changes the ID. That's how Marek got hit: he
> updated OP-TEE, but his recovery kernel still had the old DTB.
> 

If the DT does not really reflect the HW, is installed as part of the kernel
image, and the ID can change across FW versions, it seems to me that it does
not even make sense to store the ID in devicetree.

>>> The idea from that thread: let arm,smc-id be a list. The driver tries
>>> the ids one by one and keeps the first one the firmware accepts. Older
>>> kernels only read the first cell, so they behave exactly as they do
>>> now. For stm32mp2 the list is <0xbc000000 0xb200005a>. Calling an id
>>> that belongs to some other firmware service would be bad, so the
>>> binding says the list may only hold ids known to be this watchdog.
>>>
>>
>> Would it possibly make sense to check keep a list of known IDs in the
>> driver ? It already checks 0x82003D06, so it might as well check a sequence.
> 
> Fine with me, and it avoids the binding issue. I'd just rather not try
> the ST IDs on every platform, so how about making the list per
> compatible:
> 
>    compatible = "st,stm32mp25-smc-wdt", "arm,smc-wdt";
> 
> with { 0xbc000000, 0xb200005a } as match data for it. arm,smc-id stays a
> single u32 and, if present, is tried first. Older kernels just match
> "arm,smc-wdt" and behave as today.
> 
> If that works for you and the DT folks, I'll send v2.
> 
Works for me.

Thanks,
Guenter

