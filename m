Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778181;
	b=lf/UrdFsVKunInlb0DEUUWigawfBh7pdNQ66K9cJiDPJO4BeMXNs0eV7Isyg9MiJsQoK
	 5FaNZE8ygGCVdu6TzTINNNSldss+KCX3oH/f5WzsBij+dmTn9Z4JqgVelS16EVzB6Sj+W
	 xInrzpCzj1dssOsiXFa8yn+ynxDjhRQoI/XcNKSAL3zsOHKkW5Bsiuz1vM2+r3Gt3Ltud
	 o+2yrTGF6eT6EOL3Y+6wPGDuwp+jrHbi1J4WHsFaVD1DB9qj98oPyq4TcbR9DuPOOmAf9
	 NGF0ZJv+vSLpIWErJToFTAJiPeu6ltZ0yzKpH1HGeIUWLAQfOVfs1v0rXljE7R4Xxcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778181;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:
	 X-Source:X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=P9VrrWxvRwU4UhUNuvsViyvt2ldk3Lk1/YlnZNzZ1NQ=;
	b=ZW809hb8Xk4KnzGiKUnJrQRmMZO12eA/pKlqaZSJVG3/G9KcVXoCjBexYIZDB28G9nBD
	 Jenefy/26w1Q328nw1cIxnIcWBNH0Za3TFWB1HCQIIKbhLWG69lBTsfAB4tJMV176myVa
	 EjVY2VAPNkkb61j4yl8IZqzkz8ffzTZH/ywbOnEywf1epu8rxGwvCq1roaHD+rU3eNroi
	 JJeTRfr5f2IaAwZTY3YI83Nl+Vg0JoceLgJ5iTY5BRxrwNtMmZdqG0ea8accr5kwFtv4P
	 Nftzu6hK4N7RaaRW6KT2sTLkA9gLaMjGUnFQtqK0TSSSs1ndLnC5jrVi1IXe5pyBRhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b="a8ia/Zjf";
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD909606A32C
	for <linux-watchdog@vger.kernel.org>; Sun, 15 Nov 2026 21:29:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD909606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=a8ia/Zjf
Received: from eig-obgw-5002b.ext.cloudfilter.net ([10.0.29.226])
	by cmsmtp with ESMTPS
	id SI2lxfxlwyb4YShnAxm1j3; Sun, 15 Nov 2026 21:29:40 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Shn9xc0Jzb2qJShn9xSo59; Sun, 15 Nov 2026 21:29:40 +0000
X-Authority-Analysis: v=2.4 cv=A7tsP7WG c=1 sm=1 tr=0 ts=6afa2444
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=p17y3UlcgzNCgfqtCmUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=P9VrrWxvRwU4UhUNuvsViyvt2ldk3Lk1/YlnZNzZ1NQ=; b=a8ia/ZjfSx20
	Qi+cH483HSfKAPFiFXR9AtiYwatCNqcQUjsaFqMvm+Gz9FnoS/BqoKguHvBQLIcmkrMhzgfdh3PjT
	5onE7JjcAxCn6dPq5HO4UVEIW0WAPY4cbx1xPe8peIVvykLmJ/lW5CoQU6IUycoY3KNyCQdfXMHRl
	W+8DIffN9DQ8Dp/ZdbrcOk1quQ24K+Eu4cCwAJ56HdL8RDYCiOvMmNuzKuNoOabct7m6wlEbyKYDD
	3DCzSr1JUyixKN3aNcBNX+hO8PrNKfEgvCT5lRMl1fDR9ajkrXSuIBw9sZV9QzaFC/3vbI8fcFLI2
	e4oRjZeAFcIGOJkVInxshQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50840)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xShn9-00000000FTn-1jFW;
	Mon, 16 Nov 2026 02:59:39 +0530
Message-ID: <e0b7871e-5dae-438a-bde1-327fe450dc8d@roeck-us.net>
Date: Sun, 15 Nov 2026 13:29:38 -0800
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
Subject: Re: [PATCH] watchdog: intel_oc_wdt: Add INTC109C ACPI ID
To: =?UTF-8?Q?V=C3=ADtor_Hugo_Silva?= <vitorhg20080@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Diogo Ivo <diogo.ivo@siemens.com>, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261115205408.99849-1-vitorhg20080@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20261115205408.99849-1-vitorhg20080@gmail.com>
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
X-Exim-ID: 1xShn9-00000000FTn-1jFW
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net [108.223.40.66]:50840
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLTn3Kz8gyT2ueSvpWhqc3p9LAmU3EJ6U4lhESym9RbBYqqusKbUk+htR+GA8nmEgJrTFtpEWYd27WWc5ZkHJY9I2hqWgl1yRlE+uKMhinJm26nqCmoC
 ydrzQjVcINpGqTo2aoDQD5oBJA5w1neq6FbijPeru8ZEOPkWiyu2Lg1DMBuLGkG95MQ7Qw+iJPQm5wqyVULd15Lk/R10mn3Dp3XUxAPd1Y99jjIXgkZmAtEV

On 11/15/26 12:54, Vítor Hugo Silva wrote:
> The Lenovo laptops with an Intel Core 7 240H (Raptor Lake)
> exposes its OC watchdog as 'INTC109C', leaving the device
> unbound, because this ID is not present from the driver's
> ACPI intel_oc_wdt_match table.
> 
> The firmware selects INTC109C or the already supported
> INTC1099 from the same CWDT object's _HID method,
> depending on the processor signature. Both paths share a
> four-byte I/O resource at PMBS + 0x54.
> 
> Add INTC109C to the match table to use the existing implementation.
> 
> I have tested as a module on Fedora kernel 7.3.3-300.fc45.x86_64.
> I did verify device binding, timeout configuration, start,
> keepalive, explicit stop and magic close. Register reads
> confirmed the enable and timeout fields. Expiry-triggered
> reset was not tested.
> 

Why not ? That means you don't know if the code actually works.

Thanks,
Guenter

> AI assistance was used for development of the test harness
> and 'peer-review' the patch.
> 
> Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
> ---
>   drivers/watchdog/intel_oc_wdt.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
> index 0b012aeb1..a78fe1e5f 100644
> --- a/drivers/watchdog/intel_oc_wdt.c
> +++ b/drivers/watchdog/intel_oc_wdt.c
> @@ -215,6 +215,7 @@ static int intel_oc_wdt_probe(struct platform_device *pdev)
>   static const struct acpi_device_id intel_oc_wdt_match[] = {
>   	{ "INT3F0D" },
>   	{ "INTC1099" },
> +	{ "INTC109C" },
>   	{ },
>   };
>   MODULE_DEVICE_TABLE(acpi, intel_oc_wdt_match);
> 
> base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa

