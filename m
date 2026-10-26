Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054340;
	b=lr/6EjbrVRrXnh07f0brjnNE5GTwu11V3mtLgzAt1bOqEug0nxrkQ+2UGd/BXcI4fQo/
	 gn0sx8akk0Fulp/4l2QTj3GdSqFHtEmmJURx1U3Aq9xTcgh+VzhXIxA2KjmEa1G8nain3
	 eeDzC/TcB3zDAHnoONOrPSzx39mpvZOkMHZmfrBXR+rwXmy8CUndEatxvjkgFSy4G6U6o
	 TdTGx7F36QVJa1sROXfTMJ0HCgcnZm9+NMq5kZlMTV6l7lGrYhgIY/OlBuqOfWjBrOgCo
	 +1VvZbJfS2OnInBWamYQiEHVZx+fWRzHiRFK8F9J3WtGusRPeUJMW5+6Te+CRFsZKMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054340;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=FTKggi0RacZ9ZRgKp/gx5uvsP4Zzh5sa3f9zHGmidIc=;
	b=MhiBcjI2SJpiZQWf7Zj3t7NlZw0tTnI+dK7iZ7p5lY5hTNyw0lfjzy3eUld+G143SUkn
	 xhqZ0WP9aYWTMVPiMcjdMeek3RXROLvVTg2TKzXEgxFcqhDvGKvEcV2dNBvZpRU0R1PjM
	 b/7K0qJWzI+AUQPxFHDdOaAnUWMCrH8zhHgPcvRQY4l+dcDM8RUklKmZiugOqojPVKtRN
	 OeipsUJjei7Rb2IdcCaM7RVBgeM+aFGMzNHIJhRn6AfwBHjK1OTuvGhMZ89ykPTnr5Jae
	 SewHSEpa4KcqsUoHBF5xCnDmBfYum35wDWp7Mt/3r9x2u8lYlPkTY1sMarggJgp9nvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=MdY20Q+9;
	arc=none smtp.remote-ip=35.89.44.39
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC23606A31B;
	Mon, 26 Oct 2026 22:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FC23606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=MdY20Q+9
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id LKuExB5Jfc3XsLTLHxaxYa; Mon, 26 Oct 2026 22:38:59 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id LTLExgZ7GJ2XTLTLHxMNyn; Mon, 26 Oct 2026 22:38:59 +0000
X-Authority-Analysis: v=2.4 cv=Lfg86ifi c=1 sm=1 tr=0 ts=6adfd683
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=V4Dx7h__d2wgc-tc1C8A:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FTKggi0RacZ9ZRgKp/gx5uvsP4Zzh5sa3f9zHGmidIc=; b=MdY20Q+9CL1J71KupKdI+SnPrO
	SzurKl9K7p6xIIb2j8tDVeeMTLPjlzg9ZHcHj3YZD14A2BAaOidqgGpFHZN4IlCaox9NgtRhTLEz5
	QAS5NQyAKWxPB2wiKQwm7JITkbU8yJ3UWWwk7J6Idro4ZBxxNHKWHnATJHQI3WStxNDlTZ/P9yBiU
	gmH3UWPtZg2j59RUNXxSdI38O2RWW6aWyod/tle6r0rlIq5tmOpHHYHcmW9NmhjxjtTJYadCS9PLl
	zRF46coEz/A1QguHCgBafIl3RmjYbmLljJ85WYXuRfwgOcn/AF1zVnlSj8t1vmEnHuBw6yAkQDRl0
	4Rpnq8CQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:48554 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLSrE-00000003s0a-248u;
	Tue, 27 Oct 2026 03:37:56 +0530
Date: Mon, 26 Oct 2026 15:07:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Robert Marko <robert.marko@sartura.hr>,
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, manuel.lauss@gmail.com
Subject: Re: [PATCH 4/5] MIPS: Alchemy: Use the GPIO watchdog driver on MTX-1
Message-ID: <25597f7a-2972-44bc-aec5-76e81519af31@roeck-us.net>
References: <20261016221617.2223004-1-f.fainelli@gmail.com>
 <20261016221617.2223004-5-f.fainelli@gmail.com>
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
In-Reply-To: <20261016221617.2223004-5-f.fainelli@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLSrE-00000003s0a-248u
X-Source: 
X-Source-Args: 
X-Source-Dir: sunilmehra.co.in:/public_html
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:48554
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 69
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKFbN81vSbxLh6oC/qCYGJglMTmON1XeSn2fiDHWrS1yBIvk6GUSIZxu0fSlTagph2YNwdsqM3JRqQUvacN3/x+bjf96Cvd/gsk0bLsOLT0uluT4mL1F
 WgWmp4LOSbTJH5bpvpFiTf+mh2FNvMTLUXXYCoufBKoedTPRqKRmoUVd1hEHHJQlbyICTZMOvUPKqOIpFRzblw6/TVM8x7Tfyj1Wbe1To4d0Eii3Ej1FVDRU
 V7jagT3jghQ6+s+9o+sbx2WwYyvTchs6J4GSjaZyQd+1W0uJo7wcHg7FIbA7wRGAg5YEH90JNACi3XCr7Q9FRg==

On Fri, Oct 16, 2026 at 03:16:16PM -0700, Florian Fainelli wrote:
> The MTX-1 watchdog is serviced by toggling GPIO 215. Describe its toggle
> algorithm and 1.6-second minimum interval through the existing software
> node properties, and register gpio-wdt instead of mtx1-wdt.
> 
> The nominal 100-second circuit reset the test board about 82 seconds after
> starting an unclean-close test over the serial console. Allow for circuit
> tolerance and console transmission time with a conservative 70-second
> hardware service margin. Keep a 100-second initial userspace timeout and
> let the core schedule keepalives for the longer userspace timeout.
> 
> Mark the watchdog always-running so the core services it before userspace
> opens the device and after a clean stop, without trying to disable the
> hardware by tristating the GPIO. Enable GPIO_WATCHDOG in the MTX-1
> defconfig.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Applied.

Thanks,
Guenter
