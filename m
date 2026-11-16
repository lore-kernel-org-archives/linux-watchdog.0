Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837917;
	b=na2fpnRqKKk0KcyJN/14k/h+Ub09r5FqV7HScn6GJZhJS3bJqYXAL1ZdqWKJSDPSWlGK
	 GQyCwkgFZhzoOt8ULO0c2qykYHF2KZNKGG8tbAPs9oCqk7LEc99SHFGkfRfeI7WcROSD7
	 jK6Rkm4U+aNwiA4/BNLfVEYXd9gOp3B3Y8M59Odt2+fmcs7eJMMjzozlQzuQBF2aZs90K
	 UYMaza9OhespfEzdcintD1H5kwcgYumbPodl0+2AoNYsK15PDOH/OYvr+AnSJSGJGD/8x
	 s6ncXK9gqtCSqH4QQsRoKQCBWVLBlDz7V2w7+2OL0DRXs6cVTVcaFeWpbSuChLcEfhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837917;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=BjAPa5gEwdibBM1bcFjKRY785JMqAknFIMes8RLqbFA=;
	b=pKeFAMwqpNjIG78dWHbdc3sitNZIcOqsNNk4dN+Bb5r8pyXow8JmWgu7qVUoxFci1Ayg
	 I+1xdOU4gDjY13I0m58xgr/rk6ecMVe57gihNlOHhuMJEGeiNhGWQOqzQOMTzZ8uObVor
	 0QBMyZJRnLwSOPQAgeDFwi7+wK9jttTDmf83PNxbhFFJxZbczYgeO958UGskXzeJonYuV
	 eJn+zY6O9qmpGZ+Y+cv0HtRGFmBbM67r5VepKJExIz6bXukRl/2NGUBgITJaxPnxrHnye
	 H2HOPcEFYtj6wnHbxWHGJdzlF8H7D+oOqQ2iI/k/uFldHh8muw2VQiTYoE+xEOsjmzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=CHAXTD1P;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0F606A32C
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Nov 2026 14:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF0F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=CHAXTD1P
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id SwJXxx57CAR1iSxKexZG26; Mon, 16 Nov 2026 14:05:16 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SxKXxCxiOuJrPSxKXxqKjz; Mon, 16 Nov 2026 14:05:09 +0000
X-Authority-Analysis: v=2.4 cv=WLZ/XmsR c=1 sm=1 tr=0 ts=6afb0d9c
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=cIE4-SQmKicfhqlZljcA:9 a=QEXdDO2ut3YA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=BjAPa5gEwdibBM1bcFjKRY785JMqAknFIMes8RLqbFA=; b=CHAXTD1PvGKU
	u8dO2qADvt1nJl5IP9nP7+yNiwe6c5+pTYRUEo8AHQrJtbp64s8BBzVqRkBNdJnPAampKsV2DPFjn
	4XJePtGOgSshbKhohhnMshckFFJCV28MqqqjbiRgezJqT8kYInF+NOQLZ6KgTvFQr8WKDFdzkY8uz
	T/TnqxB4w1RZNDARLGUn+JJm2UKcNRVIl9TneFqOX2UP1D1Vqcjvp9OoPkyX9KuCAfEtr9yjl5wL1
	WCMrjq4M7RjXy6zKcH+Ofe7C63keHTZ/bLIcpa3Lp5JFO3PWlkyTYPh2ndObJNDALILba8jvMWrN+
	i6vl/CISuUmPwD1ZHBQf7A==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36536)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSxKX-00000003ZrM-0e71;
	Mon, 16 Nov 2026 19:35:09 +0530
Message-ID: <fbf13b7f-e49d-4458-8a41-be965beab97d@roeck-us.net>
Date: Mon, 16 Nov 2026 06:05:08 -0800
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
Subject: Re: [PATCH v4] watchdog: Add ARM TWD (MPCore private) watchdog driver
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Russell King <linux@armlinux.org.uk>, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261114-arm-twd-wdt-v4-1-5a3104b36331@gmail.com>
 <db3a09f6-a560-4522-9954-8aa63eb2d5fb@roeck-us.net>
 <179468235262.1897695.7261271002700550095@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <179468235262.1897695.7261271002700550095@gmail.com>
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
X-Exim-ID: 1xSxKX-00000003ZrM-0e71
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:36536
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNbwpfXP4CJ2k8I+qfVVx4bDQmQ9M/0rNnebyiWsLPJS0FF7aaNqEjFu4VbconLO7JOyVFTV+uAYzjDhMdtTtO0V89S8Qu9C1igsWB13uAFtMpD1aSJw
 C0jEQxcMv9DbmUG2KA8pVnl38z8TsC0/MVz5Re7rPGOzyJnl2Z81j89RmPoFm4Kf3fcGJ6TI9/N6sOeaJDz1Xf2HtW7i/c4ypkPfs9zut74YarkXZR6cZltX

On 11/14/26 10:52, Fil Dunsky wrote:
> Hi Guenter,
> 
> On Sat, Nov 14, 2026 at 07:56:12AM -0800, Guenter Roeck wrote:
>> Watchdog drivers are supposed to watch the system as a whole, not on a
>> per-CPU level. This patch goes way beyond the scope of a system watchdog
>> driver. Per-CPU watchdogs are handled in kernel/watchdog.c. I do not think
>> it is a good idea to overlay that with a second per-CPU watchdog mechanism.
> 
> Thanks, understood. Watching individual CPUs was not the intent: all the
> watchdogs get the same timeout and are pinged together from the ioctl,
> so the driver acts as one system watchdog. Going through every CPU only

... but a single stalled CPU would trigger it. That overlaps with the per-CPU
watchdog timer. Maybe such stall detection is warranted; however, as I
mentioned above, it should be implemented as extension of kernel/watchdog.c.

> follows from the registers being banked, and it is what made the driver
> grow (hotplug state, CPU PM, the races Sashiko found).
> 
> The board needs one system watchdog and nothing per CPU: its boot loader
> starts the watchdog of CPU0 only, and the SoC has no other watchdog.
> Would a driver along these lines be acceptable?
> 
> - use the watchdog of CPU0 only: start, stop, ping and get_timeleft run
>    there through smp_call_function_single();
> - no CPU hotplug state: on 32-bit ARM CPU0 cannot be taken offline
>    unless the platform allows it with cpu_can_disable(), and the driver
>    would not probe if CPU0 is hotpluggable;
> - the watchdogs of the other CPUs are not used, one found running at
>    probe time is stopped;

I'd suggest to simply not check for it in the first place to keep the
code simple. It isn't supposed to happen, it does not currently happen
as you point out above, and anyone starting it anyway will immediately
stop doing so.

> - keep following clock rate changes and set the watchdog up again on
>    resume;
> - keep the restart handler.
> 
Yes.

Thanks,
Guenter

