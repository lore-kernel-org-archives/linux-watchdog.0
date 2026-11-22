Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=44.202.169.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795310931;
	b=g0uhwI7oOwk/xfz3b/ShY95XGO/znM65GU8hsO6UgRZp20coPRbMWv6jlCxSDUKNrzzZ
	 SSfax996wz0zywHopv4LP8T9OVMe1AG0dpiXkZFsZDbQ/bvKoBen6ufy9U6bvGBNmThMG
	 sc7Hvwh+zNYw+Dbn60XGfYxYa9y/s7Gu3NvGTPMNIK5Tyb97V1Zms7hyoUcPnTWg9frL8
	 k19FHIyBGO1ZSDApeRqK9Jd62IU74gJy66skNrevkqCCkJAFbzo5nFkrbThvDtBYBHzWH
	 JFB+SC0MkQT00MkqDAnN7Ib6O0nZ68CNRFRKuH9jVSvif03zALUFQgDAuO7pyrXvU1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795310931;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=j7wV5xYsKk+AnKzewK6ED1DY0tL9Fq/vDgt6ZBEAmrk=;
	b=jtbt2lBoUyHLx6ODh/Ehe/ubkHveflyukEUBW3NkY0T+6q1QBqB86R8MhIdiwzWQdwnS
	 uyGKtngjhJXU3lS29jQG3w/nHXDXNw94Gr9eajboR4ne3ChcwCXG0rCpzskGnGTrdQ+vw
	 rbUMYt2zNUufIm68Czhd15rVkY0PdZpKrSk/6QlDzKsDqK1VBdNfmPf3YC9fDaRr+QEWz
	 euwe02Occ2WyHnRyo3s9xY5Kr/a0UieLI6Mh0b6eTkcLcUw36YAOPz9PBe9O5AlY3SZvG
	 3tx5d197WOZ8vm0yMYwa91iQ6o1WRN+4Sp0xE4t2vn2pqufAH/6Aw/cJAIMbsrIa7mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=g229YHOB;
	arc=none smtp.remote-ip=44.202.169.37
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D21606A332
	for <linux-watchdog@vger.kernel.org>; Sun, 22 Nov 2026 01:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69D21606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=g229YHOB
Received: from eig-obgw-6001b.ext.cloudfilter.net ([10.0.30.143])
	by cmsmtp with ESMTPS
	id UaOaxlC05V16IUwNuxflvN; Sun, 22 Nov 2026 01:28:50 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id UwNtxcihzdRrRUwNtxLLmh; Sun, 22 Nov 2026 01:28:49 +0000
X-Authority-Analysis: v=2.4 cv=LOhmQIW9 c=1 sm=1 tr=0 ts=6b024551
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=1pp0S3YwmL9lSNfLDwgA:9 a=CjuIK1q_8ugA:10
 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j7wV5xYsKk+AnKzewK6ED1DY0tL9Fq/vDgt6ZBEAmrk=; b=g229YHOB7tCg4Z/SwqMpPNGxUW
	q9a9a3lR9qOm0D75rmzC8VvgTIasiwDBGOxUuSbtvGsj4OkaQL3epxwaRaOEAeRzGodMaF2+Al4Xs
	0GQ7DMM3G8KIUUtyS1VtVywo0GHyHJV45QCZUH1J4FQHvW8FEO2exYG4y8ooBWGJDNGpqGIX7n3KK
	GujjwKUoTMEBxVdDw4UUmE5aruOzchol+1RMY3CAZa/iYJFD5wkAGxnNYb1qp1SunsLXNZjfeWP/d
	kdjiLh6KQEtqUPQXCEhWydzOikLmY58+0AfL+pZHasEIlI5bNJUYcO6ovVga8GngYP7SWRAk/8K1S
	y/XLCrLw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46818 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xUwNt-00000000mlw-17XS;
	Sun, 22 Nov 2026 06:58:49 +0530
Date: Sat, 21 Nov 2026 17:28:48 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: David Yang <mmyangfl@gmail.com>
Cc: linux-watchdog@vger.kernel.org, stable@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jongsung Kim <neidhard.kim@lge.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: sp805: re-enable the clock in the restart
 handler
Message-ID: <e07b2b4a-514b-4697-b7e4-e2101130f8b2@roeck-us.net>
References: <20261121204528.2435533-1-mmyangfl@gmail.com>
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
In-Reply-To: <20261121204528.2435533-1-mmyangfl@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xUwNt-00000000mlw-17XS
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:46818
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 11
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKfzsz+pjyMuhDqwd78KEiQLsBtO0z96hMVWq2cdqBgDSKfYWgKOFTxGi2IyxiESl3Al/Tp9NZQWQb/ALiadHWCfsA5756WODoquoPKqpmqmFfSyIagR
 5npang70SyFyuFbXc3s4JWZvO2VtGVorxEH5Puyf/pHSV3d6HXVKP1eH3yBC9hjal9nLyPJ4Gi1g6VWbKDHxmF0vZz1fNFf4Ky+GQH1+fQ9THQMpFgdxewpn

On Sun, Nov 22, 2026 at 04:45:25AM +0800, David Yang wrote:
> wdt_restart() fail to reboot the system if the watchdog counter clock
> was previously disabled: If userspace cleanly stops the watchdog, the
> core calls wdt_disable() which disables wdt->clk. No reset comes.
> 
> Re-enable the clock in it as in npcm_wdt. The watchdog .restart()
> callback runs in atomic context: get the clock with
> devm_clk_get_optional_prepared() at probe time and keep it prepared for
> the lifetime of the driver, so the restart handler only needs
> clk_enable(), which is safe in atomic context.
> 
> Link: https://lore.kernel.org/r/20260911031916.A8E051F000FF@smtp.kernel.org
> Fixes: 6c5c0d48b686 ("watchdog: sp805: add restart handler")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Yang <mmyangfl@gmail.com>

Applied.

Thanks,
Guenter
