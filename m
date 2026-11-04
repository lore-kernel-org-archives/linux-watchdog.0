Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.39
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830090;
	b=DGVAKvp/RrozHQI9noGHnJMX+fwnW0PGWdP+C1dmr1Zxac8EBH4D8CZ7DwYjEyExC06A
	 YwV+6z5OMWX7O9DqVD54vOsPofRQxVF+QHmGJNcYsN0lAiEuc+LuJ0rYp6PpYBfK0ztP4
	 BBf+35VEefr6xKNoD2hzsurLHFi1CNYTO/YFLfyVokAQQ21i+Mnuzx/yoH66aObDwI555
	 i6Hm7jG45s+99SBty69M6Vnv3vZBsiLJ9/mGKH/NH3TaX7urcn/aERzGGx52hGrICNoGQ
	 IcXSqfPU+SHkChNElfvNnbzDxQYDTH/QYXKLagjy0kvGflidD62Y+OkXOqLtDzfw//g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830090;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=uPpZHIHN2f+krnoJTSXhizzaZXUBHGCxVWnErBLk0sw=;
	b=sw7TD9Z4LfCjxYMOzRJsT7qii6w0goQPIyhrX351ASckGlLCbeSsY/Wyao5W5TOHWRm1
	 6JrlYz5hm/0XRai+05T7/tr1J5UNJvaYBsTSy1Ds49YKxpzwKTG4cZVBl2SdBVXwPbYnB
	 33EQK3wp60fnAbX2eCufF1N2BQko3vuC49XuP9BEcYF81BFQSz3/FWgKHD4Tqc2UAnmvJ
	 tF/doUgUYhq9S/JetCK6aICzu6hh3qMgolZcgS03/OH26GSDocEVQ0pH2ly41CVlpmY5j
	 dKJpEZFMMkTHJJeiW//I/xfzNQKwpsjfKNrwOL4Qo8FncoN5pDaxjXzDI/f5RHUGGmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=SyA6t0X5;
	arc=none smtp.remote-ip=44.202.169.39
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B79606E83D
	for <linux-watchdog@vger.kernel.org>; Wed,  4 Nov 2026 22:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B79606E83D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=SyA6t0X5
Received: from eig-obgw-6007b.ext.cloudfilter.net ([10.0.30.166])
	by cmsmtp with ESMTPS
	id Oazhxj25aOOJnOj9GxUTdg; Wed, 04 Nov 2026 22:08:02 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id Oj9Fx3uKSBdeUOj9FxIbeR; Wed, 04 Nov 2026 22:08:01 +0000
X-Authority-Analysis: v=2.4 cv=AaexH2XG c=1 sm=1 tr=0 ts=6aebacc1
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=mpaa-ttXAAAA:8
 a=AhJusznchYkEs9MMiQMA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uPpZHIHN2f+krnoJTSXhizzaZXUBHGCxVWnErBLk0sw=; b=SyA6t0X5HCcBfATZNI8Kbb4ksm
	hTB7osa3MOtNNirjIdy8uJ8HAWGaphLEybiIZNPeTBj+JeVI80v8EElmkTd4hWBuPa/Z3+pl5092+
	g1k8ogbs00esl5aa6vfujqZm05BPnNOXAYmYbS6FjwVyliDV9z2cyOaHG4eoufGv3F7acBqjphECZ
	a83clvz33UqYtmcmVN1kGQ5M1xWyCr2hbVp50kXGgewihE3mWC+1JybQabLER4T44tNtuEGUblraT
	lHRp8qKk/AeTvLQK/pMznIjGWDG3GjfQaHKI0mbyQQ+eTJPQwxlS6gFmQctKCwhoIFmA/PrMwIFA4
	RISQ6J5g==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:36806 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xOj9E-00000000ul0-2R7W;
	Thu, 05 Nov 2026 03:38:00 +0530
Date: Wed, 4 Nov 2026 14:07:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Zexin Wang <ot_zexin.wang@mediatek.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	light.chen@mediatek.com, Fred-WY.Chen@mediatek.com,
	Yt.Hsieh@mediatek.com, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] watchdog: sbsa_gwdt: Limit the MediaTek WS0 race
 workaround to revision 0
Message-ID: <055e6366-83db-435d-af3f-4168a822a870@roeck-us.net>
References: <20261104083714.3026535-1-ot_zexin.wang@mediatek.com>
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
In-Reply-To: <20261104083714.3026535-1-ot_zexin.wang@mediatek.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xOj9E-00000000ul0-2R7W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:36806
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOKQ/g4KBQXXGVBf0wjxr2XWT+uQvCmLPG5y9JtXxoPzjmMCf+N5ny1P6p1T+/YLLu1CxNLKL1PNS+Y10Lsqc4I9MVlP0A+y0ct860HgTtOJzwNKewxx
 jKWIh+3kJpQm1uHCD4ddVARc0hSNi2XzldWXGo5MUJTehLHwpZJWPOepj9d7dna53OlMWJwFUebAt2JQno1e9cp9HyMRiIgjYfnmgVgWTDHrXOoNws3+TpUD

On Wed, Nov 04, 2026 at 04:37:02PM +0800, Zexin Wang wrote:
> The WS0 race workaround is currently enabled for all MediaTek SBSA
> Generic Watchdog revisions in single-stage mode. However, only
> revision 0 is affected by the race condition.
> 
> Read the revision field from W_IIDR and enable the workaround only for
> MediaTek watchdogs with revision 0 in single-stage mode. This avoids
> unnecessarily restricting the minimum timeout and adjusting the
> keepalive interval on unaffected revisions.
> 
> Signed-off-by: Zexin Wang <ot_zexin.wang@mediatek.com>

Applied.

Thanks,
Guenter
