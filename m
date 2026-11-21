Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795236400;
	b=cVVLkPBXKno8PRgh7kiEkMsaar3O6DBnlKjg40CymL0Y62X6wT74l7ZocHDhYc3nCTnG
	 a/XSW3v3yqyUmLkPMr16rXMNb6a2H9fhqwidO8xl81c3WUh04aauL6FW1y3V44eEALrA5
	 D4ZVMZMfCyWrVO6XrdJuu88J54zbOAX8EIkf1UxNBuprDwKg7GFZd8i7wDWBpY2dYGDcP
	 D3Erx+s+/fhRHEgX9/LTFngvTLdDzsadNZabifMcUxL5PoVDWIFxiTUkPlEXNJuBPa58X
	 bvzAwCpM4Zs/xRietP7zpSP9rvNKkppYBgKlBSZqVWKmQ2HDzb7QqZQpR/pjQCzw30w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795236400;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=C6CPCEFe3UxyZLZ+8IDnLmwHXl9Q5H7VbT0By79lRUw=;
	b=idiFBCemFL1ADM/uyeAlrtStuurP3I2mySdJA2i0dO9vSC9E536LwUZbluADjeGJHL46
	 ivFhssgl+2Q92SV+5gjPQsTIY8zkDv8zO/uqBkc4GzTIKhDENVW9MfG5WZYRhaKSvq6gf
	 Ueba0imu0lZRsHaTWlWQJ2Og3Sz+M6hItMbdFK7bP1pkEvsn9+oRlBLPcKhPa8TwQSs+3
	 /VSOisXnAH5W9mcWMM3HvbMqoUI/M+Gj8ZNmo7E9W7IftNB1her7Gds2zPPaYVjLtJw3u
	 mq/6Z5CgADwdnpk0gI/hp6L4hbsqo/vX61AcXwGcO6YTZYPhUtBYado48Ql2I1aQdvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=FEMYH5kr;
	arc=none smtp.remote-ip=35.89.44.33
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB983606A682
	for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 04:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB983606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=FEMYH5kr
Received: from eig-obgw-5007b.ext.cloudfilter.net ([10.0.29.167])
	by cmsmtp with ESMTPS
	id USyuxJIdSAR1iUczgxK08Q; Sat, 21 Nov 2026 04:46:32 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Uczfxkn8dxqjjUczfxH778; Sat, 21 Nov 2026 04:46:31 +0000
X-Authority-Analysis: v=2.4 cv=bZxrUPPB c=1 sm=1 tr=0 ts=6b012227
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=c92rfblmAAAA:8
 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8 a=t2Qs6IjK45CjxcMyCK4A:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=T3LWEMljR5ZiDmsYVIUa:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C6CPCEFe3UxyZLZ+8IDnLmwHXl9Q5H7VbT0By79lRUw=; b=FEMYH5krfbl0PKHAZtclbWy15P
	UiT+b+oAY88XvU6Kd/jdaLTpAcsYde20rwdTXOH+CnKBEPG96aNRZuTRt/L7QZqYBdB4R4i4yGZzE
	VWwQ0gHJlo1+9HHyRJdp5BujGdsBu3FqOvsV7yheA7o3k401j9Y6P1b5LLgcEQahvr/p9X4f4rx7S
	6Ft8+mXybOAxxvSKqSxyQNSmvSxUw4T0R1As5LrAIZWYj3zNEaWltKpG5JzmdxmMFiLdH69RbJ4iy
	CYqYONnv5WJBIHumipGB+bA61S/z8FJEWsWWbMarwW4EjhKGqS5y+t+MEZQvOeo32512hrR5v2u2l
	17rISX1Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41286 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xUczc-00000000sGv-3wYv;
	Sat, 21 Nov 2026 10:16:29 +0530
Date: Fri, 20 Nov 2026 20:46:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Yannick Fertre <yannick.fertre@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	=?iso-8859-1?Q?Cl=E9ment?= Le Goffic <clement.legoffic@foss.st.com>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4 07/15] dt-bindings: watchdog: st,stm32-iwdg: add
 access-controllers property
Message-ID: <5f53da81-1478-41fd-8013-c2bc619cb654@roeck-us.net>
References: <20261116132416.1184447-1-antonio.borneo@foss.st.com>
 <20261116132416.1184447-8-antonio.borneo@foss.st.com>
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
In-Reply-To: <20261116132416.1184447-8-antonio.borneo@foss.st.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xUczc-00000000sGv-3wYv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:41286
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 11
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDFt2tMLfzzehPxGQdMlbh7B42aPMVNoQ0y4+FxjHFLLUYye0RArEMfPLusO1zKafJMKl73lajD/SIybdwGTaDqwzmjyk3vxc0EE+3iXTV0Kg6KujWn2
 Ue0275n4zjETVBGx8PFu7TFa+XfVVtWgLCw2mg0OcLS1CZGonr6ycipO9aTyDiWxHPS8XqwGTNkPyDOLXKdadLhBQ5FSVNvk5g0VCjtgrUqEQvDMmy/UUFCW

On Mon, Nov 16, 2026 at 02:24:08PM +0100, Antonio Borneo wrote:
> Add the optional access-controllers property to reference one
> domain access controllers protecting the watchdog peripheral.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20261106163429.618392-1-antonio.borneo%40foss.st.com?part=5
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter
