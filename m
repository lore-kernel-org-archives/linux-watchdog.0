Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830867;
	b=fvXXMjgxQj9uEjuI+D+jXqfIOsi2AW8iM4a5eEypkudhDS4LIhltPCf3R5HQtojsSoVN
	 AgxsPlG0ypK6+dbpy3SIq/YlErF8ce0OGQnKjtNiS7XkskOd1TBzyRWpnqFI6GFawvHAY
	 QgYvOFpEIn6Tz/xMMJHWD5Dtfwfj9/82erVg/eYd6GvCL4hyQmdXPro5CZ0YikRpTG30C
	 ShmZP7NMzcy0GccauZ6Illpngg53rZlQ9bevbsVeQIvmM4XzXdN/0yvsNChPB+8Xk9SkW
	 L41L8vUTpPNiHKxZVS718klGcJWI1YbJLJ0gGRqYbUbtui5OWzLMMPJuaHzWAeRHn2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830867;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=78k269yKdOV/ST/uY88OrjOsdXVjabWHCavJe9c0TjY=;
	b=Js25ix7OXm1tZd7KFPmZn4J5ryrE5/Hb/X0UJSj8eTEz6Vtya/R++rIYOJ75ZYxr/3dK
	 bwOiVm3gq5gHgYxHNyElcsSGAcy4c2zP1BVQMqkqpVdlvK0PU1uQqMAIe/YJRegoWMycb
	 ybHayPg1usqNZL/amn72UUxFtBGRSpjTig11Pz7PjEcy3wy/nJE32cyWGTxM1PRhEq0P9
	 W7/BoofKt2aJ4YK2pz5Yd/H3XeBGp2oQgjkhdPQnLIGI5K1uWY0ZIDNqFHhTp1U55So9G
	 gNKXmNGNIp3B1HlPendb53QJsa2iRXLVfUodHrtOp9pZ8yrx/nxlLxXI9W+OwIOpYnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="sgBlW5/n";
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFC1606E806
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 22:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEFC1606E806
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=sgBlW5/n
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id OgNzxDWNgJFmFOjLtxVLkj; Wed, 04 Nov 2026 22:21:05 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id OjLtxjUBRuJrPOjLtxKy45; Wed, 04 Nov 2026 22:21:05 +0000
X-Authority-Analysis: v=2.4 cv=WLZ/XmsR c=1 sm=1 tr=0 ts=6aebafd1
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=7kedt0ebssWPXWSPxHcA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=78k269yKdOV/ST/uY88OrjOsdXVjabWHCavJe9c0TjY=; b=sgBlW5/nKe2j
	WDdiju0Of3igI0J1tDZCrpQFdaM9Hyq3+PNp9Zi8+w1XLD+3y4Cubm2PXhSJIhsBNVHzEDmSFQi3F
	k6ccv7MhZdKj5NmKOqDP24CAGnN2NGhhSted2+0f6Z/JocCcSL7/qgbE3q418BmQ/G0Fl7xTqClVl
	8mcFzCjUaEs3Lnq/WCwUgbQatREnTmspqKUo4tb6KesNZ0XbCDvMcD4Fu7zLSqXldhi+iBzuP3btQ
	9koWLnwG35BCwJq/gIYfOcVUHxvffg4xzWLxL+oak2fCZYaSIocZNMrFCGt37PHk301BFSSkGxzOK
	Z5tAjhaS3yZZosByJA1oHg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33306)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOjLt-0000000128t-0i90;
	Thu, 05 Nov 2026 03:51:05 +0530
Message-ID: <4008c8e3-8cb5-4200-96c3-f35c46f85457@roeck-us.net>
Date: Wed, 4 Nov 2026 14:21:04 -0800
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
Subject: Re: [PATCH] watchdog: omap_wdt: stop starting the watchdog twice in
 early_enable
To: Krzysztof Kozlowski <krzk@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-watchdog@vger.kernel.org
References: <20261104021535.1468760-1-vulab@iscas.ac.cn>
 <20261104-melodic-emotional-pony-ff5ddd@quoll>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261104-melodic-emotional-pony-ff5ddd@quoll>
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
X-Exim-ID: 1xOjLt-0000000128t-0i90
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:33306
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfH6dpHeva80ePB6sbqDRMslkiIWbgclbaOs8c125AAG/ZkeNuh/CgPVoZRStMt2HJcwrUvO59SmMiy6SKrFqNueyUfyEIVw2aId/47wPXYEZNo7857Yx
 HpUAQQxFy+x9Cv00aaqbSJQWA54nBHkMu9PN8OTtrHw/ikgmXkZ1ABEMjy8yrQSFQP1PP+eCpq3Qb9DDUE/vc49rFqFUSqW2Jvuo0bYemauEgC3VaiDD4YAD

On 11/3/26 23:12, Krzysztof Kozlowski wrote:
> 
> On Wed, 04 Nov 2026 02:15:35 +0000, Wentao Liang wrote:
>> With the early_enable module parameter the watchdog is started before
>> watchdog_register_device() and the WDOG_HW_RUNNING bit is set, so the
>> watchdog core keeps pinging it.  The start that predates that code was
>> not removed, so omap_wdt_start() runs a second time right after the
>> registration.
>>
>> Every omap_wdt_start() takes a runtime PM reference with
>> pm_runtime_get_sync(), and only the reference of the probe itself is
>> dropped at the end of omap_wdt_probe().  The second start therefore
>> leaves one extra reference behind: the device never runtime suspends
>> after probe, even when no user has the watchdog open, because the
>> usage count can never fall back to zero.
>>
>> Drop the duplicate start.  The watchdog is already running at that
>> point and the remaining references are the ones that keep it clocked
>> while it is armed.
>>
>> Fixes: cd004d8299f1 ("watchdog: Fix OMAP watchdog early handling")
>> Cc: stable@vger.kernel.org
>> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
>> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>> ---
>>   drivers/watchdog/omap_wdt.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
> 
> Multiple things here:
> 1. Your team ignored completely previous feedback. Multiple times.
> 
> 2. You use multiple identities with this email address, thus I doubt that we
>     speak with an actual person.
> 

This is indeed a red flag. Thanks for noticing.

> 3. Your bot does not even bother running checkpatch, right?
> 

To be fair, [almost] everyone doesn't. On top of that, the checkpatch
warning/error is a bit misleading, given that Assisted-by: used to be
a valid trailer. People think that checkpatch doesn't recognize it,
and most don't know that it is no longer supported/accepted.

> 4. Nothing of this was reproduced nor tested.
> 

Besides that, the fix is incomplete/wrong (as was commit cd004d8299f1,
which indeed needs to get fixed, but differently).

Guenter

