Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978021;
	b=lT6QlUEiihr94sROKpzw8MgEn53UdyjAUgR6kaO02YpgH1sA9mUvWiaqxijIg1I96a9m
	 U/5g/Q1RomBDqnWSXwCx9fBoi1aL+AX203xl549yH5aV9YA4crSR2lM+G0n8XAC/qHPXL
	 wKO85Rg3Xs5aouUrcCd3k2thMYm3AtBECpQzplfjelv4wnQxkv1bh6Rwosk17RzIn5UVC
	 2myG/McQUdI8IY/EBVAiLzLkwgvFeSRmjCNfvEXeqzUeWDFCAMR0L+GyWpXeLlHv340mG
	 9/NCKLGWy/FLcMZsUDRvOaNzqiH31Jer0J+0o+8T/Pdy59lGDvPQyF1dMpBVictrTBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978021;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=Ug1oH65mHtM4sBvSgSyWiP9pC3vWlFca2Iy9VURj7Cs=;
	b=n+SkxcmZcDP0t0be0IOGDaMS5iQ+/pyZZWzoMJASr0dUJSh1B5o6PLALkfgtziaZa8gf
	 7LpFHTuVeng6KDpKcGci+sMIXhuLF1N6MUAoM83lXMl9qw7SqX56jSGj9oUP1wEdKEGKn
	 BhQVqV6DUKNbz75gN2ZtPUmrD46qQaxGBBaO/tPn9k1uw2Jwd9iZT/XaRum0MGx1SSzJM
	 eMuDeY3UVuvLXIZXqWCf9ewyU9AfwXU0VkXoUTjINZ5TJ+Y3YdGffaMwxqzVvxzfgC+2U
	 gJiGYKg+iIoTXGKzFJAwQEkHGVnH3QyP/X2NiBwibbIAoP8ABNlrqlnC3YnlnWthd5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=CVsXojlM;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B065606A32C
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 15:13:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B065606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=CVsXojlM
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id P3DmxAvSSAR1iPLdNxCz5p; Fri, 06 Nov 2026 15:13:41 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id PLdMx5xyRxqjjPLdMxcRcq; Fri, 06 Nov 2026 15:13:40 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6aedeea4
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=3MjHcVyFnrRuDmB3ZfYA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=Ug1oH65mHtM4sBvSgSyWiP9pC3vWlFca2Iy9VURj7Cs=; b=CVsXojlMQOO7
	a5SgCEDmtMBdCsc84fJ01WzpZTfbExZ9trHK/0J3SzPd196sFyYflzMhLzCcFToJIO+TKTLLOZzCm
	XOS2619Z5snQScRiHJ1K3TNmC/ueoWFcwtGDmNbmo8fsAuBYeBmA4a6wjoJFZKkjUEtO2+n2RiaaN
	jLX+gWy6NF/GXqLK/G9O++pJTF1oLHdggDaQokVhjZlzImt2Tq+qt3OnOpSLPdDcqp0CddoexjLcP
	4Auc1+47VprdhIB4IPU2EQr3N1xsjCPTpsixJr3Zl2NdaAwqiswTcPsgreVhnGCMLKpIsm1WThDL4
	HUdzOVyUTC9u1XSfWVLW7Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:51444)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xPLdL-00000004Jhn-3VHy;
	Fri, 06 Nov 2026 20:43:39 +0530
Message-ID: <c92a6d5f-30b5-4c9a-8ee1-b3ca00125137@roeck-us.net>
Date: Fri, 6 Nov 2026 07:13:38 -0800
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
Subject: Re: [PATCH 5/5] watchdog: starfive-wdt: Drop runtime PM reference
 before registering watchdog
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
 Ziv Xu <ziv.xu@starfivetech.com>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-6-linux@roeck-us.net> <auydfozcvsC4yjR-@google.com>
 <au3iqjLv6tatuwyr@google.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <au3iqjLv6tatuwyr@google.com>
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
X-Exim-ID: 1xPLdL-00000004Jhn-3VHy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:51444
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFfM5a2XvtHsu3WKuiNXN4SJzZQlYnqd6O5fD6HCPN7skaS37He/lt4NF7QZbejmeE2uohWg2gQ+eXbs6mA1xq3XUJT9YVjU5PrKTcSpFVn24/7pns7q
 IOS4JpNkGY5uBxQYBvn9eS8H3UF+Ox3ST3sg6I3fM4sj73YxWuRiK/NrD30dajS2j1EBSH4uZPEAyqWvD/3P1RBcw4jBYrlLW9uh6+Jt/88f9yZQwb0qlPO2

On 11/6/26 06:22, Tzung-Bi Shih wrote:
> On Thu, Nov 05, 2026 at 03:15:10PM +0000, Tzung-Bi Shih wrote:
>> On Wed, Nov 04, 2026 at 08:44:45AM -0800, Guenter Roeck wrote:
>>> @@ -499,28 +499,25 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>>>   		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>>>   	} else {
>>>   		starfive_wdt_stop(wdt);
>>> +		if (pm_runtime_enabled(&pdev->dev))
>>> +			pm_runtime_put_sync(&pdev->dev);
>>>   	}
>>>   
>>>   	ret = watchdog_register_device(&wdt->wdd);
>>> -	if (ret)
>>> -		goto err_exit;
>>> -
>>> -	if (!early_enable) {
>>> -		if (pm_runtime_enabled(&pdev->dev)) {
>>> -			ret = pm_runtime_put_sync(&pdev->dev);
>>> -			if (ret)
>>> -				goto err_unregister_wdt;
>>> +	if (ret) {
>>> +		if (watchdog_hw_running(&wdt->wdd)) {
>>> +			starfive_wdt_stop(wdt);
>>> +			if (pm_runtime_enabled(&pdev->dev))
>>> +				pm_runtime_put_sync(&pdev->dev);
>>>   		}
>>> +		if (!pm_runtime_enabled(&pdev->dev))
>>> +			starfive_wdt_disable_clock(wdt);
>>> +		goto err_disable_pm;
>>>   	}
>>>   
>>>   	return 0;
>>>   
>>> -err_unregister_wdt:
>>> -	watchdog_unregister_device(&wdt->wdd);
>>> -	goto err_disable_pm;
>>>   err_exit:
>>> -	if (watchdog_hw_running(&wdt->wdd))
>>> -		starfive_wdt_stop(wdt);
>>>   	if (pm_runtime_enabled(&pdev->dev))
>>>   		pm_runtime_put_sync(&pdev->dev);
>>>   	else
>>
>> Would this improve readability?
>>
>> 	ret = watchdog_register_device(&wdt->wdd);
>> 	if (ret) {
>> 		if (early_enable) {
>> 			starfive_wdt_stop(wdt);
>> 			goto err_exit;
>> 		} else {
>> 			if (!pm_runtime_enabled(&pdev->dev))
>> 				starfive_wdt_disable_clock(wdt);
>> 		}
>> 		goto err_disable_pm;
>> 	}
> 
> Ah... I should have written:
> 
> 		if (early_enable) {
> 			...
> 			goto err_exit;
> 		} else {
> 			...
> 			goto err_disable_pm;
> 		}
> 
> or
> 
> 		if (early_enable) {
> 			...
> 			goto err_exit;
> 		}
> 
> 		...
> 		goto err_disable_pm;

I actually prefer the current version.

Thanks,
Guenter

