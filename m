Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815126;
	b=z0GKf9SzcNC/YPADbsq+J0MLLl3S4tUz/dciJuStgat4deHC6iM3sceGHXLCtIzbImra
	 PAKJof1TWeuuBINmMcikhupXZxT+KjZat+i1Um0sLH5+obMVPUKga5tOFVjkPiAsbzGEl
	 5nzW3bbFIbcjmFvDhrK3PPcDIquJX3a7GU38re5oB8BnB5PCLZKZmLDFXNrL8Z2RaySgP
	 TBwotrDLa5XHYnHRw29ndDv4KvFyqaZ+TBT9c6rhwAvlIWwwRKdPexGtx+wIsi1c9NoZG
	 OZrx5wOwZOSUN0j8TXLAQOdL2Bi3ZUioIjO3IgD2ZjR/D3cZvoB0cr0MA2g20U/Fz7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815126;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:Autocrypt:Cc:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=kJBR1X6YrecDdeDdf95LKQMPOXhqdKULeKpOhORv8lk=;
	b=y36nj849QUFC2M0JYRdHcvuV/JpApfT0i/p/UPdn0etUc/J6gXx50dv+qgAht9cGhbr2
	 sTqHBzee0YXmvhyxzPIZXtX47OBETuSAFwjaRMNGvKAojC4GntK50KrBS3nm2DWtSS1oy
	 EvwM9ViHBODxq35B2pvRwzFd7HuuLBq3m2W3CfAejLU8vA7Mk0x4gh4108PSIDCw3yGSC
	 R4ccVhqX9yysfn8yfXoXa/U7MjfFtIHFnB9uYgadylThxf7zxGWGErKlMBpm7NHqZdyTC
	 QG+5p4wPjNoUcgxVH3sT5/3fdNb/8DlULP02hUqSAbNye0Rd8+p3o+4/pPDhAvkzZrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Z0PuXnLW;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD8D606A7DE
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 17:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BD8D606A7DE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Z0PuXnLW
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id OdFjxYFheVK9UOfG2xGhPL; Wed, 04 Nov 2026 17:58:46 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id OfG1x0L4S0w3mOfG1xwsMB; Wed, 04 Nov 2026 17:58:45 +0000
X-Authority-Analysis: v=2.4 cv=ZtntK87G c=1 sm=1 tr=0 ts=6aeb7255
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=BaI_k71-5Xq0wtSmigoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=kJBR1X6YrecDdeDdf95LKQMPOXhqdKULeKpOhORv8lk=; b=Z0PuXnLWJnUc
	B0MwXP3xABxH3WgVwvRN8s7QvLEaIYB3XpWy8KKoUcYszIPZKF3TB0o6CCsYhu8BCqRvwoZWbJXRC
	8+xrk8LH9ENGZNRah0Lbm8NtCfoztX9b39E8B2bXEJswGxquEKnC2+IyP1kSR4POH5c0VzyZ9nVAr
	W7a3DhYVU6Jvgu0a4F5mKnSmvMTEBsKp2A1paj9zX5a7GluWxlsR1opV1ZsX7KXEMPQn8pg1Y1nUs
	O2MEOktvuljbuEnl28cQOK1yyDg8S/hdUnBHaVR4FphRvJmt3086Xl/AABzbiAKUHGLYRYb5yeFRO
	CUlrUq166LMeANsYuaY83A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:53612)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOfG0-00000003FDQ-41sH;
	Wed, 04 Nov 2026 23:28:45 +0530
Message-ID: <1a258aff-8d41-4fdd-9f50-bddaeff7620d@roeck-us.net>
Date: Wed, 4 Nov 2026 09:58:43 -0800
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
Subject: Re: [PATCH 3/5] watchdog: starfive-wdt: Avoid unclocked register
 access in remove and PM paths
To: sashiko-reviews@lists.linux.dev, linux-watchdog@vger.kernel.org
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-4-linux@roeck-us.net>
 <sashiko-outbox-197706@kernel.org>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>, Ziv Xu <ziv.xu@starfivetech.com>
In-Reply-To: <sashiko-outbox-197706@kernel.org>
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
X-Exim-ID: 1xOfG0-00000003FDQ-41sH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:53612
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 5
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCz5C3Ke7FatKy/4UiTjT9KRaRMJqZ2JF4ueFAw8jzIGjEJAKWtEao97TbYEkkzMWWdy8PNhRstrDFG9hb7JoMn27nzcvLd6yC6iAlD9ZJoBs9KcrbZ/
 8zDhvR0kEmpYkE8+i/6IrJ/WLP1/IWidxxSkC0JJmmD/7lATVm6XkUc5jI4SC3SFEQpf6qo+61FZs1mg9MRHlulAzXkDzcmQwN3B5iHRd95GHr/HD0ar5FHH

On 11/4/26 09:02, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] watchdog: starfive-wdt: unbalanced runtime PM put in starfive_wdt_shutdown()
> --

I really love/hate Sashiko :-). A manual run did not report any problems.
On top of the issue reported here, it also found a number of additional
bugs (reported in its bug database, not here) in the driver, related to
MMIO access with clocks turned off. I'll get all those addressed, but
I'll wait a day of two before sending out v2 of the patch series.

Guenter

