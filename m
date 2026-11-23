Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464888;
	b=gpBOoqzh4To8EporCXj/c4Ta56y/oIApKQeF8ugiiGWz5N2tMb9Ceyav0xS88iZSGcyD
	 zu95QlFuW8jMB6S0aQoAtda5gKpNvFEUpDuznKPZPolVi4MDV9k82iOORszVXvxjHLp0B
	 DlS5vjKw0DuqR1IqFcqipCaxdyB+N/oo8q/1YXbi1PIyZFuClR26tGUxhETVLTs2p90O8
	 FqBDn06UvJRlGjUhrBQntuSPM4vdLVh+KXUu++bTOjT/7CtfG1LswiSJv6bn7SxpI0TR1
	 hbclmtlXpQnXVk8w2/FIYP/YkzzhbMy52ckd8vBxhS/IhKA9bDPiz/fIa+dHVGZPB1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464888;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=Znz/EHw8pGjnVb+24THLSzwjj9xCRhxrR3p+gGFhSv0=;
	b=eeoqdWBvi5+EwG2hTQO0+tWK1c5oDBttZWoXKQZLLZRoNEwg7JueDHWYEPip8OH4/ePC
	 TxFDplKbAJjlsQC2uXH5LLBWvbjx0Pkr3SSexts++KhzJAuYjqroGm1WjgtCsZcGbdl4R
	 /Ej2ADEgYHwn5IwUKhPH1t7w7Fbb2vmmbUon41NaxQJrmbWv/2Rptg2yg/H/ulLf61581
	 70v5ExYp5c4I+KqjXz5CjFp8jvF5nTzCfU3zmDoz84w81lbNy/lbaBfuyzzow3OOURL/E
	 zGHQ0F4v67TaGVdZ+9eEilUwvkan3h+t/NMYnQXE8OhVPHa8glvj3LBoIKxHC0P3Vvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0JY4wPg4;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C45606A32A
	for <linux-watchdog@vger.kernel.org>; Mon, 23 Nov 2026 20:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C45606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=0JY4wPg4
Received: from eig-obgw-6004b.ext.cloudfilter.net ([10.0.30.210])
	by cmsmtp with ESMTPS
	id VaCpxK9hCOOJnVaR5x8hkX; Mon, 23 Nov 2026 20:14:47 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id VaR4xjUQzlaNKVaR4xQiOl; Mon, 23 Nov 2026 20:14:46 +0000
X-Authority-Analysis: v=2.4 cv=UbpRSLSN c=1 sm=1 tr=0 ts=6b049eb6
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=vsWaLUaKAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=eMddLIfAi8SY0Rflj0oA:9 a=CjuIK1q_8ugA:10
 a=ZAjiiiQUslnskKx8wA3N:22 a=AbAUZ8qAyYyZVLSsDulk:22 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Znz/EHw8pGjnVb+24THLSzwjj9xCRhxrR3p+gGFhSv0=; b=0JY4wPg4lQatPuT+RzaNpzWaxh
	4vjqPfVlAaAotDLwhzu5P68Y9CDpqgF9Ix1HiqTZKvhWGvmUP2SbWYbhWvqDAUnSOgkaWhOp7zaY4
	4gzT7xmT2GOcFFKtLX8OqI5xweA3YOHvi3jbRP7A2NT7F5J++9/kF7Z76Us3vAdFniZLal16URCBU
	4VHSiJRnA3z22qhFVHivGS+bAYr0R19LTcDMbPYyzHdtFpDUbdOUhA+8XUF6378z3LELcz3ggdxmC
	GdmRZz1JTHNRfCscBtdRXTj13ViWMAT23c3kknIGZ+nz0jjksoLfYcL7Pb5tvmO/DrxmNHK09SeqF
	G/HoNtlg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60706 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xVaR3-00000001eYv-0aUE;
	Tue, 24 Nov 2026 01:44:45 +0530
Date: Mon, 23 Nov 2026 12:14:44 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rui Cao <i@udp0.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org,
	linux-serial@vger.kernel.org, phone-devel@vger.kernel.org,
	Roman Vivchar <rva333@protonmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 MT6833
Message-ID: <352ec537-ea94-41ef-bba2-44964fb8ebd2@roeck-us.net>
References: <20261117-mt6833-base-v2-0-058a0685c40c@udp0.com>
 <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
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
In-Reply-To: <20261117-mt6833-base-v2-2-058a0685c40c@udp0.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xVaR3-00000001eYv-0aUE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:60706
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 33
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDaEbf1ECYfDaJpvm3RB6OXhcVJpjOJ1RzDTDC6I4lYa+aof4wSyu5IVbAZdKgbOWXgJKe9aWB3nwXB7l+Jdzf2uUwMFTL5HOfWFMzdflIPx4JOFHhCk
 ha5YlzSesaPeo4Pb4DYAHZB+hlEfGd17vhmFvfySx+DJRTrUKb0PiUxgEYhLtm26vqFGj+sE4YRkpJMlm1z/7Ol9DelkaJtCIM5NnbI7vJ+l0EWQZyxkfqd6

On Tue, Nov 17, 2026 at 05:11:32PM +0800, Rui Cao wrote:
> From: Rui Cao <i@udp0.com>
> 
> Add MediaTek's MT6833 (Dimensity 700) as a compatible of its own.
> 
> It can't fall back to mediatek,mt6589-wdt, which also describes
> MT6589's twelve TOPRGU reset lines: MediaTek's kernel for MT6833 resets
> the connectivity CPU through bit 12 of WDT_SWSYSRST, past them, and has
> no full reset table for the SoC to take one from.
> 
> Signed-off-by: Rui Cao <i@udp0.com>
> Reviewed-by: AngeloGioacchino Del Regtno <angelogioacchino.delregno@collabora.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied.

Thanks,
Guenter
