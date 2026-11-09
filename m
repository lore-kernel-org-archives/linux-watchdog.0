Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266454;
	b=HTYZK0nfyi6wmbrKGQKmDkiKdnR3wSZ84Vj1FlnwVutCWhz6U1SMon7uMt9DKmXWpHyl
	 9t/kEUuKFKtt+CLhciuHEw27PO4zEwTmZ6f01iZECMhsHpeun9172qccMIw11rWZqXoRf
	 PAsj9WQddWutwYokEXVl/qynqdIY2v63fBhwqnIJISJmDQNbvP/00Az1TDChaq/o4HO6M
	 dT/DYap8kzzEtKAoXAfGkabulob4pjH2+Qq4UBiEYP0ZR8li07zTCJhRUbcJpDVh1HzgI
	 W/22DpJjKV77PfQ0Wxj+jb0XWbbw9eEMEWMsd0pOrqNwcPWFGLqCV+TrXGiwXuPhiFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266454;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=kc4oDmW8i9mozpJcU9fAYFRzqCZe3WS8+JFCNRvi5+I=;
	b=f/cCVWLWHyiQoBUL5iQEC4M+UCAkbtnpcLRpYbCLWWFrQr6UhqwvkdVQfFQL/I3w8cWK
	 RmvKeNgG58Xar/tniiDhequv+R/2zHwsXqqSRLzTboGJoW4m/9eocs7/dboG9CD5Ww5Le
	 YZTWiyY8X3ElxFj7JjoDW37f5yTmfVFnYm4/Mz5ZgfU3SCga33yDQZoTa9pkhYKnjknTu
	 7UJTiKh/nLY2HfvUUTYc61YgqRM9ADr1nFGxW5tKKfWJihZouEMNu+MD5nAcm/nwiOkZo
	 8m8xUpZ6eW0iWOewMGrQpsaTv9Mda22Qq0zHo6qkdFXUlPXsuKMgErANbqTEWz7z4AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=E8btDvfl;
	arc=none smtp.remote-ip=44.202.169.35
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F39E606A32A
	for <linux-watchdog@vger.kernel.org>; Mon,  9 Nov 2026 23:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F39E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=E8btDvfl
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id QRrFxpF8M4vCDQYfUxCNKF; Mon, 09 Nov 2026 23:20:52 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id QYfUx3xPz3nNNQYfUx38F8; Mon, 09 Nov 2026 23:20:52 +0000
X-Authority-Analysis: v=2.4 cv=TuLmhCXh c=1 sm=1 tr=0 ts=6af25554
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=yC-0_ovQAAAA:8
 a=37JH_sIDIT6TzvarxRIA:9 a=CjuIK1q_8ugA:10 a=p49Upr6YYhNo69yxWKUU:22
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=kc4oDmW8i9mozpJcU9fAYFRzqCZe3WS8+JFCNRvi5+I=; b=E8btDvfluYKpR6zkKPcc0jUivp
	kDnYfv6Tc5ZseBCm05ZdMtYPt2NFrHAiK9PxjtDtbgnvq9YDyAYWHlC6VwcR5gSTfWOrlxDG0+oPd
	Kq7sSWrGz+XYvaLgT76Gq/NAQ0mmg9nrqJe0aE9uUfRgBWOXOgtgfm/cRo0Okw0X6bdvNUI6Cv61C
	HUZqW7W7rsJRrXXd4GMfbkHSBxHByB67B/fxLgjK2sGsJhQ+uriqjLe+cIA/sRB0jftWLj2QoNc8g
	9rtTvavHA+wnsfrkQgPv8DZcWABl/0h1E3IN2E/+Skzmvv60BGRfpCCMVvGLrYcdoQlbZ8RIKt7BS
	KYHsVOqA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37146 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xQYfS-00000000vde-1nZf;
	Tue, 10 Nov 2026 04:50:50 +0530
Date: Mon, 9 Nov 2026 15:20:49 -0800
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
Subject: Re: [PATCH v8 3/7] watchdog: rzv2h: Drop WDTRCR_RSTIRQS define
Message-ID: <bfb40baf-7f33-4f66-ad80-57bef1d6ef1a@roeck-us.net>
References: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261001165201.763882-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20261001165201.763882-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xQYfS-00000000vde-1nZf
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:37146
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 44
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNp9cRWXIiH3LQPENjsF0eLfNeParfX9Ia2P5KqA0UA0KB2nDiONbst291L07EX6QUinH2eNRkCvyb7TQ/ZSmTVUqTd97qt9MuQJKTN5FILTixdAub6x
 +vhqZB4gPwpCjPuBoAEP5dYfIyPB3z6nar2rCLMbM9rlyJUDNt44rktFhQhAmJsh0E3pM3yuqBPrjm0zEIzJpZNwjeVZL/3N+hM1Chy+S6JxlLgYHGt2teWy

On Thu, Oct 01, 2026 at 05:51:57PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> WDTRCR_RSTIRQS is unused, so drop it.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Applied.

Thanks,
Guenter
