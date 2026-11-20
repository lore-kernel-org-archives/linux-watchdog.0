Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795148985;
	b=jV4a3GB9wSS2JgSXzeSluM7Za2aEs7YIT6XHpk7ZZcNIGuAC5Wkl6yO+0go46RVkq2xW
	 f3qlBA15iqlpRZxO+W0Xt7rW1NnTig3TBCL7AqkkM4VG3L4UrCj07kHODNAjk32HuLYp6
	 DK1Zdr581FU35tjFRW2FZ0V10iWlQ4PhhaaLymyMs2dDYg1JYFbWSF6QSM1UWII5U9sTV
	 sKixMPUCk5mwVcUtOi6bJmPFVttl0d+H3jpdNrCSvruZAw6DD8wws4RCUa3LlkCpaHXo0
	 F8fZXGfky+XOXAXrf9ZArtQCeTHihrCg52fDxoPIuqj6jb/eEPLl5lJjhdk3q8W8QjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795148985;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=NwKyPi+EXp0S/WOyO+1mrzsEeZFSZSXM/L2QcxcxUKw=;
	b=DG0pz0wYWhWyWG3uLd34Uiy/BRjAf9HIRBmrSddCyFm631AxcQJ0NIJvAOkMPr5FU4Ic
	 tBcxA3dxL1an0zixojSbGVHSmVEgx3tQ0HofP/ZnogMmYQYl3gNi/v7LhLSB6yM3z6ucT
	 DpPdvVtGJn6331V7dlmc8psUX6N1+hoZvFEehEmnnWMU/t32avV78xz305YQ3xfc6ybGb
	 XBpNIyiM24qalHIWEr/d7cNUz/KGraQJxGTdvPqVPdgvUropeDV621CmIuMYTAMcrX3Gw
	 2IiJf6+i3QronFMbPrBqIVm+mpQVfiaF8LKU45lb3VTbvUmEMYYuwevVyQIiBxG1nqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=4XV7rKRI;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BDB606A32C
	for <linux-watchdog@vger.kernel.org>; Fri, 20 Nov 2026 04:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72BDB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=4XV7rKRI
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id U9IWxj45xVK9UUGFnxZVul; Fri, 20 Nov 2026 04:29:39 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id UGFmxV7G60288UGFmx65Q1; Fri, 20 Nov 2026 04:29:38 +0000
X-Authority-Analysis: v=2.4 cv=a5Iw9VSF c=1 sm=1 tr=0 ts=6affccb2
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=zpOVymEVAAAA:8
 a=sfOm8-O8AAAA:8 a=RSmfSHFI2LoBTrHSb6wA:9 a=CjuIK1q_8ugA:10
 a=LCD48ZUe64JR9pieE8wa:22 a=TvTJqdcANYtsRzA46cdi:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NwKyPi+EXp0S/WOyO+1mrzsEeZFSZSXM/L2QcxcxUKw=; b=4XV7rKRIxdtmrGqva0T2IrI2fZ
	RbG62Z+GkHytSWmn3OK7x5TcoHPqi2jjO++MwW+nrzqIj6wGDIXNuU3DKMGjBJ7A15TJXXJtGffXP
	Wpx5BPtFNj4E/jP4wP3PWOv6ucUEyGYvFB3j5Jmm2PB3Jly+/q8dNtWn+qJqwr8pCj7/douzEkBD7
	5KOjlIXhDObzVwKzdztx8aRyoW2m85f0vxQTvBWdGYvoMXD1URp5oj7zoPYC9wCLCKV5dVrnjkzNI
	X69gtLKLCLQx8MKJtNFYTnUmZ7zGBeMi9OaZekp2SCQwaen3jA8+tkz9sGZFgE8JMMgxZx/+U4MUq
	mes/Lmog==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:42072 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xUGFl-00000003dbL-2YK5;
	Fri, 20 Nov 2026 09:59:37 +0530
Date: Thu, 19 Nov 2026 20:29:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Ben Grisdale <bengris32@protonmail.ch>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] watchdog: mediatek: add mt6797 support
Message-ID: <f0ea8f8d-eef7-4d13-8180-ea3e297c407c@roeck-us.net>
References: <20261110-6797-wdt-v1-0-7f07755b6074@protonmail.com>
 <20261110-6797-wdt-v1-2-7f07755b6074@protonmail.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-6797-wdt-v1-2-7f07755b6074@protonmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xUGFl-00000003dbL-2YK5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:42072
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 20
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLOg6MYhBCmRfRkTYTyevRWUb5zajw2Pw9PkHYHSa0sUhnh7t0IjqTzS9IMF09eR2l7WjLf9xXYBscp6jK3WuiuyCR2PoGrP7wXf2f321QzvrDdyiyfU
 mT14dcJZvgXRXT3OYA9Zeu1fer9ZWoNAd4k8CburcnxvYYyBuG+ebXZzm8chYYvGNmWkrPPwub2wQOdAgGF+8CXjrUoRbjz1/llJKk+BFCmQiBS4rNzuGMB5

On Tue, Nov 10, 2026 at 09:22:22PM +0200, Roman Vivchar wrote:
> From: Roman Vivchar <rva333@protonmail.com>
> 
> Add support for mt6797 SoC watchdog, which provides 17 software resets.
> The mapping table uses bits from the datasheet [1].
> 
> Link: https://www.96boards.org/documentation/consumer/mediatekx20/additional-docs/docs/MT6797_Register_Table_Part_1.pdf [1]
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>

Applied.

Thanks,
Guenter
