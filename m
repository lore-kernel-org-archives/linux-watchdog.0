Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266216;
	b=ESI/6F7pIGf3aEO6H4+4VjNTHZXZvc6J3X3K8k23m1VgYU6PnGsk+9/FrvcLJjeJLGyZ
	 rSPurRx51DXpHI0nA0ZO2td6XSLPCoodqvZcb3L4b2/g+5UZVvxPuIF63t3Yis5CLUOpT
	 n7gTujL2vlpBruEZQd1S63In0orlIgJEt8rB6NAFfZROPiURHmNPfHDp2g5yb3UXcbHOV
	 tWXZNCupvyMOMEpHmoSueweUwU/HV3rlwR1GxG5RNTTxahOhRkJVKlEpsZCg+REY2k6xC
	 joCT7/9Fr50rVoW7AXi0FNPAagY7xJhKOKlYDL9Q/f5SlYd+3mUW5jk/jzRJAHeSy1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266216;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=ourNGXvQ5Ub4aFSYZr4GTp+31ZYMvfjzPnbWU36+4JY=;
	b=ivUmFTuMmA0z9HiU6j3Om8anZZlWXM2ir+cb4yGtggW/CKIh94Uqd5EoxBzMa1NHuQDm
	 1GPTi8+FKt5EcthApKNbIsbQVgQEVqZlEsxF0uPuBARqsHewH7v5uXwgEY7jU743i03vy
	 JFDFZpvVULwGKKXel6CXqT74voWue6FUFhMQXXoX9ElvFMli+CEGWdJYb8gmaHg/t9qw1
	 sNU+jxdMoKIuOMjwKtVrL3+h7KX9+ei4sLlaRbYFWVefoEgR7KFgWC/bJ/ibyGc3rRcSN
	 hq2MWPoYG1qtrtmSnmwQXdI3GypbOoZwqDP0whxYCWs5Rq7OZsyGHgjz5jZhXcBuB2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=g8OM+qIh;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFC606A325
	for <linux-watchdog@vger.kernel.org>; Mon,  9 Nov 2026 23:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BBFC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=g8OM+qIh
Received: from eig-obgw-6002b.ext.cloudfilter.net ([10.0.30.203])
	by cmsmtp with ESMTPS
	id QVo5xtAFKVK9UQYbgxvnh2; Mon, 09 Nov 2026 23:16:56 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id QYbfx7Dab8cn4QYbfxBmkj; Mon, 09 Nov 2026 23:16:55 +0000
X-Authority-Analysis: v=2.4 cv=Qrde3Uyd c=1 sm=1 tr=0 ts=6af25467
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=yC-0_ovQAAAA:8
 a=GU2OR-2u3yUetoAu5r4A:9 a=CjuIK1q_8ugA:10 a=p49Upr6YYhNo69yxWKUU:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ourNGXvQ5Ub4aFSYZr4GTp+31ZYMvfjzPnbWU36+4JY=; b=g8OM+qIh4P8JuAXOofLquteH9V
	GA8GU+WHHy5ORMPSZWQXI2f2OHpxFOrmM6ExzkPpZDlo/xKgsF+FSDcJttYpKH6NowrZpbtzzGyzT
	D99Mj8eK3o8LtpxJHBQzwEKYH7KBe8tYLPJQ/7yQ22xZfiIRmrqJzNAIckR50HsbtEZfVR7puSGZu
	M3Pq6DIFGUP/dou1iJq4r4TPSNeRgBe32TRDERfdkm+KaAGOWtmjKLSxghGkwKkH8v2Mv4QSDT8zc
	1PY3Z99s2mFe0WYa9TvLqjk+UoN3SvAvVYe3ALxd0NIof43zNhrR0jircdZTB5idKxqkRG0rtyNe9
	UR1ibrIA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:47824 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQYbd-00000000tOY-3UMs;
	Tue, 10 Nov 2026 04:46:53 +0530
Date: Mon, 9 Nov 2026 15:16:52 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 2/7] watchdog: rzv2h: Use pm_runtime_put_sync()
Message-ID: <36f3db86-774e-4e38-9216-a5af7ccbf6a5@roeck-us.net>
References: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261001165201.763882-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20261001165201.763882-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xQYbd-00000000tOY-3UMs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:47824
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 24
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAUaH9UFquGlV/3ATWplyYEEiv9ADcjiblTIsLzrodajwFwtj/1jGpHIL0+AZgcumUMPJ/2vnYIcGEPObW9KeG7fHhtTmeoPYBWXWkRvyQT714OBABH/
 b7FVkJbIfM3cNMRW8boF0oXX+XULmg7NkusInSmNNN8X3rxk7WQJYHNsX9SadGiA5bJNZ2Pakf6yDjbr9Zew3JmpO1NZGJw/4Eo0qCVWE1g+qT1d55/rD1lV

On Thu, Oct 01, 2026 at 05:51:56PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> pm_runtime_put() may trigger the idle check after pm_runtime_disable()
> is run as part of devm_pm_runtime_enable()'s cleanup action, leaving
> runtime PM active.
> 
> Use pm_runtime_put_sync() to ensure the idle check runs synchronously.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied.

Thanks,
Guenter
