Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114482;
	b=4XhFG82KWLlSm/K+cvQYRU1GsAJfomH+jhYWcUa/3UZyfMqZeP0AW/2vVsXol8WGTh4c
	 Wc3XSsCmAYUK1GMEaqxnvuF1Ka2GIxWV4Ohc6JA/RKigzvVtgpzACRXMf/iK0LSb33AS8
	 rjq14vFVkD9P0az6AuRwhPO02hgfLO5N/zyuI2GMQZHmFua9Vpmab8RNTiGGoy2xi8b8P
	 QRfiHlO5vqQeUGrlycBZqIIDqDFLdH45vV1jGa6wHDnpQAcTioDdgb3OXr6yv32TNzSWT
	 +Dl3feynTyRyXwFQXXwQ+7A4E0BG+kNJYxhtyAqT1EkSJnC/A3t7YdEi0VVs9vCs7Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114482;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=bEVYe4qrtgBeDUfBP0eqQvzjZWX5q85+496DoNmFXDU=;
	b=F5tK//rNzMD7lFSo9csuxXMAb+dCODTE5BYnIyDdNEUWOGaZJGCeheCtAbc9mgKmCsw5
	 fL0YhVrNol+9VYtbKFw5IK/S75qcW0FBowVZeAKVLE4LzYK7qfe47ledmRA0bhJNk0VER
	 mGi+lU/Axm/YuK1yC6OxYLftGP1L84GlUExBQzY6EIt6YH2KG78DohkWDLuAhkvOYCcJj
	 93HhIITnv5BcZAZxBqyoH3IllgJ2C157bMKsWD9cX4i6U+zGF3cxvzdlaCujx8SsWodcf
	 xQsC/4vPGVQQb7ycSAN/YxoTdx0lsZohTAFt65oDR9qtSvoB9TLm+wI2siHZ+NZ4qCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=E1it5Hot;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE33606A31D
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 15:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBE33606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=E1it5Hot
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id LgmZxxTqav0ndLizJxL2i7; Tue, 27 Oct 2026 15:21:21 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LizIx98YboYFCLizIxWLpb; Tue, 27 Oct 2026 15:21:21 +0000
X-Authority-Analysis: v=2.4 cv=b4Cy4sGx c=1 sm=1 tr=0 ts=6ae0c171
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10
 a=P7C5aodvrJ57ttQV5vYA:9 a=CjuIK1q_8ugA:10 a=wKdU7H82fLsV3NogPdHx:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bEVYe4qrtgBeDUfBP0eqQvzjZWX5q85+496DoNmFXDU=; b=E1it5HotZ73aNEa7gWbQTS+itu
	rgcRUVb8YX+QQVgjADAdDsYZK4PAUBQrl2Z1ZZs2gX4WfGLUp9ZcQ63+t+ZC8u2hiAilSegtT5cRa
	HUf0f5DMxb7YqFtI0vg8zfBRQru61Sxni+qHChb1aWY87GMP1u3O5rrT7eBcOvvIe8e612Jzt3nBV
	J5l/XMQhgK3KUfIRafYj8zpHNQ8BYtfZym+qwJVvKqZ9uAva3tbEuwHmGHPjGy9h1lDaoDVpp9Asq
	5Xb5yw9+QOEcyWPLQ+BCEVp4PQFjfQ/OkhGGxqz3dMI1yOHrgQ1vay5iWg4/2wX4MYe/xA2p0XZvC
	xPKjXXEg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:58230 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLizI-00000000CoQ-158C;
	Tue, 27 Oct 2026 20:51:20 +0530
Date: Tue, 27 Oct 2026 08:21:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: gpio: add reset-from-wdt support
Message-ID: <09731eed-13c6-46bd-a1b0-c8c1a6c50ecf@roeck-us.net>
References: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
 <20261013-v7-3-topic-gpio-wdt-v1-2-bc98f05a4578@pengutronix.de>
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
In-Reply-To: <20261013-v7-3-topic-gpio-wdt-v1-2-bc98f05a4578@pengutronix.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLizI-00000000CoQ-158C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:58230
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIrmsTX9c+c/fJ3/iOqHNF77KkVN+ykLh5oiRzuKqbv+dAhTRHVeqho1Ldgzk9zsBquTtX0WopJ8ozn1hVqHoJjFjRzZd9YHbtCDjWzNIgypqsqFMBfz
 ZtEwp0bG4uD+EaJcEsMV4uVIhu39cmEYd9yUEd/Csu1iN2zuS9y1fOT7IR2e9IwhTSstazfizGBLgjqehlO2K1BKDaoGsdXZfJ8ESUj/5ewQzxAgDg35NZ7z

On Tue, Oct 13, 2026 at 07:54:28AM +0200, Steffen Trumtrar wrote:
> The reset-from-wdt is a GPIO that signals, that the last reset was
> issued by the gpio-wdt.
> 
> When this GPIO is provided, read its value and set the watchdog
> bootstatus.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Applied.

Thanks,
Guenter
