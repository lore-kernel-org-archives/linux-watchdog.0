Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288770;
	b=rlxHuEeUPuaMtzyh+bi+sm1KvYO0ewQdOfso1UTa7GVKM1FzI9r1Hf69ear8nfYmSzsU
	 iR6sHZ0/VpSfhsNEHPUW7/RquMYLNNUaeUrZqvjs+OzQFYj2lIkp+DgqI8Bx9KlIgxBVk
	 jEtiHNHlmSgDDBQCYZ72cxXFn1h1wkhxroOKUlusHpCd9lYsM0kComorKcXVQhc/TYIO2
	 hr6M/55WcvFiSjkrUEHu9KXE0DffO9Y1biCd7ClKsVH7oVSk7UL0HQxAeSwZXxXp6lvit
	 Ii9U1+e7EpJQOaDmtKT+xRj3HOsyvCnKwOGqLCiAX+nspbEe6m+yuXOuuNx43A4oVvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288770;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=3bhbT5sSoOacf8FjozZAYDlzsEriGzVZIcNpmoXkHp8=;
	b=NFl/4qLcYtDFAkPEjBYkQXdl3eqZzZUc0MtQDmPH7Fh2BKfLerD7CEtyIpNErgc1cmND
	 fZREmQ6b1sqKZu0EH1q5uNBWVeHQQJ6SRGwjqmTlGfYJD+V/CJW2WOIiwiSsEofDMf6Wd
	 j1yQyU5u430T1uykMjHqWYpH4uIP6PUdK+SHDeUcoZpDGo3H0W3a01mGJuiUjBYj5T+BM
	 6cpOxWi6VogO13d8W4BSJXy3I7fTAAqB4gPOIJJOLoiyu0eARyYEP8i2L3gK3bMkPJtIc
	 bI+UU4PHsQ5ci5ByFiDnNyZsoIW+yZwhI1YtbyxN+7wGEZgG91SVik+dlp9jFXWwhdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Jub3IfJd;
	arc=none smtp.remote-ip=35.89.44.35
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB5B606A32A
	for <linux-watchdog@vger.kernel.org>; Sat, 21 Nov 2026 19:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AB5B606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=Jub3IfJd
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id Ul6lxn9NKRiNxUqcUxBinz; Sat, 21 Nov 2026 19:19:30 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id UqcTxcVmjGh2BUqcTxGrmo; Sat, 21 Nov 2026 19:19:29 +0000
X-Authority-Analysis: v=2.4 cv=Aszu3P9P c=1 sm=1 tr=0 ts=6b01eec1
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=pGLkceISAAAA:8
 a=FJDGcDrgIeDdKcADFjUA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3bhbT5sSoOacf8FjozZAYDlzsEriGzVZIcNpmoXkHp8=; b=Jub3IfJdr9jYiubaN6G2xwFAxx
	+q3B3vAYeQvpNYfC8KX+VJjXtobc4972FDFZ61+Qjv7wAYDLl1v7++j3EpofqqLKSPC5G3AWeMYyf
	te3RBnlzGBxY4HDb19lhKa5IpnYCYmpLt6ZTyRLRX5pzHBTBW+pQ+ttP6HlBA1cbPBhJ0U1Cdt420
	KOsspN7qujEdZdNufPD+01H6klpPcP+ov9ZAm95PwPyhr/PijKlLv6NRy1HazwfMs9BPmz58wF8zp
	CwtKvE9P4U9Z8RR3VTWsfFqCDkCJ4qzhuzun/Fn8bksefTeZs8WvG2BHsM45nelcnH8jm20ANwf6b
	q0PLCB8Q==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:60736 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xUqcS-00000002aoY-43HK;
	Sun, 22 Nov 2026 00:49:29 +0530
Date: Sat, 21 Nov 2026 11:19:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Fil Dunsky <filipp.dunsky@gmail.com>
Cc: wim@linux-watchdog.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@armlinux.org.uk
Subject: Re: [PATCH v9] watchdog: Add ARM TWD (MPCore private) watchdog driver
Message-ID: <9ac8b2fc-db33-44ce-a477-481dff84e92e@roeck-us.net>
References: <20261121-arm-twd-wdt-v9-1-8118d048cfde@gmail.com>
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
In-Reply-To: <20261121-arm-twd-wdt-v9-1-8118d048cfde@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xUqcS-00000002aoY-43HK
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:60736
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 3
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHIK0K9ykCh7sZKJsyGVCXaBW48db/jqq0fHt6o5NzC3ffo3t2vRZH7hs4IGzsd1e2DnMcKxoaOSOmv3+xcS7VPg0zTe+Hv4TpuonBEdeZL5Ru8G8ZqE
 4aN5pwMHRvWZ/gMaTmUnJ+vIztkqi92Hvlbao9KFiZ22EcaFyau2DMi4IBy9leLSHhKEcsTjDmWU0Qa0Ar+I0mtxp6Vx639aXnBna2tBzImJTNSmWB2Oazm1

On Sat, Nov 21, 2026 at 09:51:29PM +0300, Fil Dunsky wrote:
> From: Fil Dunsky <filipp.dunsky@gmail.com>
> 
> ARM11 MPCore, Cortex-A5 and Cortex-A9 MPCore systems have a watchdog
> next to the local timer of every CPU, banked at the same address. The
> binding "arm,cortex-a9-twd-wdt" exists, but there has been no driver
> since mpcore_wdt was removed in v3.11, among other reasons because it
> only ever programmed the CPU that ran the ioctl.
> 
...
> 
> Signed-off-by: Fil Dunsky <filipp.dunsky@gmail.com>

Applied.

Thanks,
Guenter
