Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114404;
	b=PItmaKWYBGdW/qFPBHMb58O7+Q4vmAOsuR6LAZcTr9qOTN+AWjGJZc4YyPigw7GfLY8A
	 SiAOzUqaEOxQ+rHy/5DZyB5Wz1azi2YiMb7qhnIbYRCBVuzuM+JnoXo1fsrKu3+Urn4uw
	 JtToa5os5b1+xrlBxJKE/r2zAnIh317HUXXfeSr5VqtrKxb4qeKUo66bxUdXu+tppt+77
	 YFfncu0d7z+RlqEfPLnAfGJnSTQdIxHEIAVr6nFWCIEpk58NjQjEEtyC/nBER4n2t7gue
	 yAvPw3mUtzg1ERRO4sk7vC7IMmHVlA2An8JAKMf6QiGYUbUbPqqf98MqR9dmh0aSvyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114404;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=6uxXCJf6Z+6uxi+Bb07KWhh91qACRzeIvlcY6VrFK4Y=;
	b=mHE+h7yC/BmQW+1Vki3ifbD3gsVwy4pqDmZrj5i3svlbtCQM5dMkV+3G7S8kuhK5ki+J
	 JqsUULBvMMgZh7SopYoCj4hPABrhvoh/K+qZhX7UrMBP5H7tZcM6SiBrGm2u+kW/1Fude
	 9xcD0d5oHT8Ligpm5At4z6fVOJ2SHngXA2pbdJ8qXDs2jN42j++rbHaPLFqKNGxtBqxW4
	 MnT4lDvc5qlEKc0Hpm3Vostizkfy+rfaLS4tGyig9GjMW1bPQ4qKn/zMiw8Ds6kJDmxph
	 Mw8H4OzZDgoxbMW0PUyjZydfm4HMcD62iVNQ2J/zr92dVc2GhNdu7OmSNSB453xOFrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Ke3dnOeG;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739AA606A326
	for <linux-watchdog@vger.kernel.org>; Tue, 27 Oct 2026 15:20:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739AA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Ke3dnOeG
Received: from eig-obgw-6006b.ext.cloudfilter.net ([10.0.30.211])
	by cmsmtp with ESMTPS
	id LVHxxxhe9MylkLiy2xBS1u; Tue, 27 Oct 2026 15:20:02 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Liy1xEkKg6hvPLiy2xWMkN; Tue, 27 Oct 2026 15:20:02 +0000
X-Authority-Analysis: v=2.4 cv=cqCbk04i c=1 sm=1 tr=0 ts=6ae0c122
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pYUB3rPNxVkG2UVf4jEA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6uxXCJf6Z+6uxi+Bb07KWhh91qACRzeIvlcY6VrFK4Y=; b=Ke3dnOeGR18SxaXLgbUo6skakL
	Bp0OyauSisfTmO7J+1mWYyfg/js5ufkMBPfPINyFK0BuJpab8JFEhaeRpmzi3aZdQxR8i6RvyqHjG
	AqTfAWWs3l2Hkt+r0RhgUoeExO88TZlTzLHA6o8xG52JINgY4R4SJ+ijw0181g7UtZwDUtu+YyooF
	xL/fbhlyOJL1QYIqJYo7okLIPpBUAnK274aKp2gdddNXyRriIeOJwlM73JJnxcxW8acqIfy1pSz5L
	Lo+xB7jNLtNEqRxw6GaqnNa1sRI/Si0hGTl+xNarS7Y6/S7pfwivmZRvs1VASb4zdn+9IcIEYQiVx
	v/tjxoCw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37680 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xLiy1-00000000C5w-0nao;
	Tue, 27 Oct 2026 20:50:01 +0530
Date: Tue, 27 Oct 2026 08:20:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robert.marko@sartura.hr>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: watchdog: add reset-from-wdt-gpios
 binding
Message-ID: <fc628fe8-4ce5-4968-89d8-f934afb3af0f@roeck-us.net>
References: <20261013-v7-3-topic-gpio-wdt-v1-0-bc98f05a4578@pengutronix.de>
 <20261013-v7-3-topic-gpio-wdt-v1-1-bc98f05a4578@pengutronix.de>
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
In-Reply-To: <20261013-v7-3-topic-gpio-wdt-v1-1-bc98f05a4578@pengutronix.de>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xLiy1-00000000C5w-0nao
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37680
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN6HVFEmZsavBWD3tTF4qrWtWynsrMyAH9YLzKj2t23pEBEhO6wD5KRO0mXFjkxOV8BPOyHBSxCTNJro4PzzcUhv5ZQPWA6+wKz6dujz/F+ZBbW2nbEe
 9aNK9fD9+io42M1NUjMWnx+ZZBCeucvQa3Loczg8BqLTN1YMnQGKZo5zhdJwHgSjCAq4TdVV/ir5D8N85yIHT1pMYSL00SgchWBveRE+QLpiXE9YCb8kkmlM

On Tue, Oct 13, 2026 at 07:54:27AM +0200, Steffen Trumtrar wrote:
> A wdt-gpio can buffer the reset signal over the reboot, to signal that the
> reset was issued by the watchdog.
> 
> Add support for a new gpio 'reset-from-wdt-gpios' that allows reading this
> buffered value.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Applied.

Thanks,
Guenter
