Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464724;
	b=Z6P02ARWRdD80vO/9qPHvv2Gyv/v2/pXbkF0t3QbDjfO08Ke6X3CArBUgPjpQaQ3o9m9
	 uUVy2sQ7Jp1BuJsmT4MRNbCiw0W9+d2JyeKxpHs7aL3v2PvEHRKlW3p4FrwCh7wCtJQDh
	 LjBF04JnLsopcoTK/sQcvw/R0PPESapgAh1ktVpT033C0hOheEuWB9xrzhDuawJWjksgp
	 ROzzwq3HHkurktSCrUxwm5ZVrUGhfqs/rX7WlZ71on0GUyCGYMEKfbRKOqf9eb3GpIMX+
	 EHEgnhB8XxddndYXasV7FjCf3/GpU29u9VSbcEsj36CKsE9jtsNRDsEoTRNiyq2DSQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464724;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=NK2TAdN7QxXlztQobC5fKCMiso1wIiEVmRdbWsstQAk=;
	b=XLrZdYIPhQ83FTLcR/JwDZHwVCYCCONdkooF5yx+9UCy7XakBeyzmsOEadj/2qMy+6H2
	 3Fr+9B85YG3hzmRWll5Y5KgpOx5SBPd0FAP6n89AUTFMeEUgoQH5af1Dd/qJPJ4Pm+Trv
	 XuMn71NMjcRYZ4pgVJZEPB+N7fnTHO9W5Q7kvGFYwMcos7tLIxt2xoQ/X+DOEuArKkcwM
	 VGnAnTsFF//mYVfngq4DoRzl3Mf1Jcfo/5djfC3NNxYkbQE7IzDGMuSYyhhPDIwAVFSrK
	 pXUytrdjAb1Rq/whv1K3EffaOcRFf6PTOOcA4+GRXJsx+wjKy+kGDkRULgQfPfoolhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=nqwqg11w;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0B606A326
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 20:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=nqwqg11w
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id VYWMxwcDq4vCDVaORxDwHb; Mon, 23 Nov 2026 20:12:03 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id VaOQxE3Y7YskhVaORxGVo1; Mon, 23 Nov 2026 20:12:03 +0000
X-Authority-Analysis: v=2.4 cv=CKMqXQrD c=1 sm=1 tr=0 ts=6b049e13
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p6fxDhJg9I0BSXovcPcA:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NK2TAdN7QxXlztQobC5fKCMiso1wIiEVmRdbWsstQAk=; b=nqwqg11wPGBOPBl0au8ZN/l02z
	mOqyg267Xy8LoWIcDlxOs3ZjdSTIQdidEv+vDmzYr9onPkx+WhTmH0f23M0+PMAZg7FFSbOCJ67LE
	MOBCINlW5qfxUiryS7sF+ZJXH2gRoZzknafRaVwDLrif99Vpts4sq119kfdlfVXgt7aeTK4s/k5LR
	N6OBoJldfk6ZYxDQiRc22tRjzkW7s7zYQ2uWiPJ1SnQwoylcAQNNIVeNDsvC9lmm18YAlkNYXVZtR
	LmCe1m3f6AtqmAamDEe0OvPfUwqYDJxM8+D7AxiFwktxrTbAEcg9ZJWHZu68DAzvUos4wZ10hyErQ
	yqb6FFQg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49156 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xVaOQ-00000001dt3-1HPJ;
	Tue, 24 Nov 2026 01:42:02 +0530
Date: Mon, 23 Nov 2026 12:12:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Yang <mmyangfl@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: arm,sp805: reference the
 PrimeCell binding
Message-ID: <1266dc98-b755-4112-8c1a-0ad54164dbaf@roeck-us.net>
References: <20261114184257.535546-1-mmyangfl@gmail.com>
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
In-Reply-To: <20261114184257.535546-1-mmyangfl@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xVaOQ-00000001dt3-1HPJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:49156
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 27
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHunjyTh6cQV4JLpIcw+YP6OtgRHo3NL6wifxtqtIWGkxOOWvuMcUP7gnfL7fx6VRb5AIlK6J/w6FOIXs/5Xs/Fr7eoPV4RfG+2nMBxNTlK+6v+A4y2Q
 b/datfhG+PGFjD6rUmZIejwPx6QvKrUoBMhG+3zJFfj/LO1/VeNl5EfZE1CgRCaPXGEDkoxTMEwiR0LjxkYf4/LnVdHR9+Fp4OK9RXzgX6OqEMSL9dxT8Xoq

On Sun, Nov 15, 2026 at 02:42:33AM +0800, David Yang wrote:
> Unlike the other PrimeCell bindings, the binding ends in
> unevaluatedProperties: false without referencing
> /schemas/arm/primecell.yaml#, so arm,primecell-periphid is not an
> evaluated property on an arm,sp805 node. Two nodes in the tree carry
> that property regardless -- watchdog@a2c000 in hisi-x5hd2.dtsi and
> watchdog@8000 in mps2.dtsi.
> 
> `make CHECK_DTBS=y`:
> 
>   watchdog@a2c000 (arm,sp805): Unevaluated properties are not allowed
>   ('arm,primecell-periphid' was unexpected)
> 
> Add the reference so the property becomes evaluable; both nodes then
> validate.
> 
> Fixes: 73d3e43f9813 ("dt-bindings: watchdog: sp-805: Convert to Json-schema")
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
