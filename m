Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782382;
	b=jvQKpCZYsJldHnBxKazEYTV2DRWmfP3nC16BduSumbAsMzt2v+bskFz8W+EFCHLseEd3
	 CcUl+G1tdbvOxLp4nr+IYLvB1sFb86VufiWrMGRfC36YxhLxLW1CZRwIZJunNwhBqXF9W
	 oPqUaR6mt2pANAsgysLtEeGjNEBmIVJ0huvXcK3sQGDxu3KmfFbhMIqtikThC0BtDN8TR
	 QuT4FzAi80iAUgd4h+GEowQ1AvHfGuoqTSg2OytkwrEj3vU12A9O7dT6ouGAgDSdS0RvD
	 8FRNHZL6WkOZtpOz9D7KgH8ANfUhf809cAtFgMJmpcgdmPKU9fHTr5LkcGxiwZKgimg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782382;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-BWhitelist:X-Source-IP:X-Source-L:X-Exim-ID:X-Source:
	 X-Source-Args:X-Source-Dir:X-Source-Sender:X-Source-Auth:
	 X-Email-Count:X-Org:X-Source-Cap:X-Local-Domain:X-CMAE-Envelope;
	bh=QJyd6HCIaaTvcuVGrB3oSb9PcvIB0O1Dg8GiEWgja0Y=;
	b=MI8tTKuPB5iiux9o9eQPsxEKOwNd7fnEEb1emgdUrls8FPJgaGiZ16CnPKjqk058FuSH
	 +1BocAGKk63Nkb3ZPlHn5MkmXn1hVd1wuLYRccyQRL/bPRc/gwmdRE+/pdwMtZAyKtAxN
	 EvZqoF8lprTkycfpNRV+A7wob6vn9rNHkgBd7jZhKQqU+fgH8DF+q2IxVueJsYh2yd7jM
	 CKWtNkWNbOqs4R17pUltAj7cf/iX3Eb0GrJa3Z6Mz6noVzDAt2FYmXC94MNnEaCTj34xs
	 AkEnlK5IEMoxBq/J9/2UGlPvmwn1+DIR3yTT2Zik+837VvPEAuMf2yhrUvAc+SmPwxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=SljBbvOG;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83689606A329
	for <linux-watchdog@vger.kernel.org>; Sun, 15 Nov 2026 22:39:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83689606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=SljBbvOG
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id SfV6xKG44RiNxSiswxIFwU; Sun, 15 Nov 2026 22:39:42 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SisvxImJXFhzrSisvx2Cqk; Sun, 15 Nov 2026 22:39:41 +0000
X-Authority-Analysis: v=2.4 cv=JY+8rVKV c=1 sm=1 tr=0 ts=6afa34ad
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=p17y3UlcgzNCgfqtCmUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=QJyd6HCIaaTvcuVGrB3oSb9PcvIB0O1Dg8GiEWgja0Y=; b=SljBbvOGbg5j
	06HQ5uhEIdVBwZK9K3EmCkuowUlYp5tW24d3Dx/qzYJCHFPL59J0xRwAvZWocBLxsubZBVUskZRkr
	TRjq0H6mubexgrUK0EqxyRIpzwjzFDwj8LdzUUy/XVEVOX5Ql7NWIAXOfV6btBCNhjUk/kf/31Wvr
	3/PWVwi1VYelCGseKIq8t0wjDL+dLuQj/DfBAqM0x6AM7HH4tYrdhZrlBiJGAm1Oiv+uwv7lW5zCZ
	2paQsFL4MCLgqjOe1xaI/JSCgc6HmYpF5f9KNxnBFTktpKbn+Ff6SxgjM15KzNGNEdDraCtVosfrI
	Usc8aOmVRW818/c00OUSbA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:42868 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSisv-00000000jJm-18Xv;
	Mon, 16 Nov 2026 04:09:41 +0530
Date: Sun, 15 Nov 2026 14:39:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?V=EDtor?= Hugo Silva <vitorhg20080@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Diogo Ivo <diogo.ivo@siemens.com>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: intel_oc_wdt: Add INTC109C ACPI ID
Message-ID: <8df779d7-eaa9-44c4-a0d8-e9187fd8819e@roeck-us.net>
References: <20261115205408.99849-1-vitorhg20080@gmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261115205408.99849-1-vitorhg20080@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSisv-00000000jJm-18Xv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:42868
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 2
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJ3/DKu4yuR8/Xs/CcKvytU5FLuReRe7UEndHaflVSz2wbUy2130uMGf8ZO22U352tn0NRLRSS5sJlbPG2K7rLii8LJR5u7yN8QB4rIUbeX4VmD5al0B
 CD6jZF8vw3wigIMGFZOAJTUJ/hu3HUJBlsRaKULRuoC1iA/0p1/3aIhOwnYoTHgwrtUfNTAbYaS/PePReR/LkNIKUdOJAqehgaJIuWOIgOWfEQw+MRY0tiLB

On Sun, Nov 15, 2026 at 08:54:08PM +0000, Vítor Hugo Silva wrote:
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
> AI assistance was used for development of the test harness
> and 'peer-review' the patch.
> 
> Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/watchdog/intel_oc_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> 
> base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
> 
> diff --git a/drivers/watchdog/intel_oc_wdt.c b/drivers/watchdog/intel_oc_wdt.c
> index 0b012aeb1..a78fe1e5f 100644
> --- a/drivers/watchdog/intel_oc_wdt.c
> +++ b/drivers/watchdog/intel_oc_wdt.c
> @@ -215,6 +215,7 @@ static int intel_oc_wdt_probe(struct platform_device *pdev)
>  static const struct acpi_device_id intel_oc_wdt_match[] = {
>  	{ "INT3F0D" },
>  	{ "INTC1099" },
> +	{ "INTC109C" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, intel_oc_wdt_match);
