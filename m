Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=35.89.44.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794676967;
	b=Zf6XZ6KSpm7Ss0P8Y3q+/uTlKeO/Oe8P1WzPwGRf14m81Yc77NLa8C28DopEYjl47/As
	 bDkSf1K0PQ3eRMOZQ15hEpeig4j9tmWwwBafD4T81Tk8VQPXsN+4KxLmf6ayk9aCU1naQ
	 +QOB8mjm2PtaR/dZUyP8SXoGd6aI7ovorfTLHw7y8R/fRJLh73ePwaQCWidRRKN670sRS
	 qjWYoPxUXo+ldgvsiR0RBLZOf6pPosHOYHkJ8Yb7rjUOl7a/ZI+TF1WhuFly7AG40vXs0
	 lthH0aDtiw99a1L8yTvEWnC0s35hUvHtrchQRc2YPdfFg+9kktBtozgiCzc2p0Jq8dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794676967;
	h=DMARC-Filter:Received:Received:X-Authority-Analysis:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:X-BWhitelist:X-Source-IP:
	 X-Source-L:X-Exim-ID:X-Source:X-Source-Args:X-Source-Dir:
	 X-Source-Sender:X-Source-Auth:X-Email-Count:X-Org:X-Source-Cap:
	 X-Local-Domain:X-CMAE-Envelope;
	bh=PkmzYMQrJ+f+2RbIonUJxeJ2n2q97YNDRbeN91mqvik=;
	b=mCghYKXPJwfQmjoguiwJAWH1zoTM718dVL3N/PAqv/zXipYaR7GoZW4quoXWR+W1rs9c
	 ZCcdLJZU8TQDHpwxtLpS97dbwQ6E0kSQ6KfdlC9rks826OzqcL5+/utrjH3912YCyXJvp
	 gOJxBq7ia0eIrYo4VhVA9RY5bMk3tIkqzLvrKq+3yaEXIErJedxKNnM4Sn/6ZluZiZyC/
	 I+RvzFTzBHIA1UAHLfVl5jNX2Dup0pECX6YeHvQtSUT27itPOaeGQ/lTtWRFTj8GAvIol
	 q86+ZJW76z8uIZK4TwLyKwqt9t5yObMERYJxzKf6XUWEpz3+dSqIrKrKUy/m932kTRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=fail smtp.mailfrom=roeck-us.net;
	dkim=pass header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=vNMRetAN;
	arc=none smtp.remote-ip=35.89.44.37
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0AF606A334
	for <linux-watchdog@vger.kernel.org>; Sat, 14 Nov 2026 17:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD0AF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.a=rsa-sha256 header.s=default header.b=vNMRetAN
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id Rtj6xGXNPVK9USHSgxmWqC; Sat, 14 Nov 2026 17:22:46 +0000
Received: from 162-215-252-36.unifiedlayer.com ([208.91.199.152])
	by cmsmtp with ESMTPS
	id SHSfxwQPUxmi7SHSgxA3Bd; Sat, 14 Nov 2026 17:22:46 +0000
X-Authority-Analysis: v=2.4 cv=KuFN2XWN c=1 sm=1 tr=0 ts=6af898e6
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=M0FbrtG7MMAA:10
 a=3h6KpzBizPpaPHiOcEgA:9 a=CjuIK1q_8ugA:10 a=KPbNTLLc3YvdawN95zVk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PkmzYMQrJ+f+2RbIonUJxeJ2n2q97YNDRbeN91mqvik=; b=vNMRetANoN4dxqqFfQ1I0nEJt8
	VdPC52+NTgVIpETzcJa6D6zkyYsKlGVJigXEpUW7qUyOhs4mpo6XqZ2gyOPzv9Act+HTwFf82He2G
	UC5o9GL+HHj2QFECaPTjlyas9gaf6blTTaC7vt7eduoqfbzy9yoEXNu2a38XcecXy14OKGm9FlOMd
	ZO0ZsEytSEtgx5AfI/dRnqcaoFUyzbbDEci7soGWTj8Mi5sNbAjwviIGn9Ff0jWucIEktH6WS6Btx
	W5RgZKX70rQvaqzyrEMibc0eWVVO2Mj7BTs7c/ysctAq7cOJqyX328+hhkPojA9g+jHzGc4Lcr2AD
	Q6BNehVw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:55400 helo=server.roeck-us.net)
	by bh-25.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <linux@roeck-us.net>)
	id 1xSHSe-00000000ch6-38VG;
	Sat, 14 Nov 2026 22:52:44 +0530
Date: Sat, 14 Nov 2026 09:22:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	clamor95@gmail.com
Subject: Re: [PATCH 2/6] watchdog: tegra_wdt: Move SoC specific parts into
 match data
Message-ID: <ea2ab23d-d628-46a7-9cad-0bbcd8722869@roeck-us.net>
References: <20261110-t20-for-upstream-v1-0-5923449951fe@gmail.com>
 <20261110-t20-for-upstream-v1-2-5923449951fe@gmail.com>
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
In-Reply-To: <20261110-t20-for-upstream-v1-2-5923449951fe@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1xSHSe-00000000ch6-38VG
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (server.roeck-us.net) [108.223.40.66]:55400
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 29
X-Org: HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKVNiGRQkWOhDj+83vh+0hpqAlwvcM8B2Xo/WXQIl4JEOidBcg6veHr8N+aevFWseccJZA1lFQrg/VfZOTlcJmdxXIdsM30NSZRWzrlmAX24zRX5Fazf
 4HIbaWQG3vbW2rIxowQc1QY7Vc1YdpIh0xaTIsbBEr890uqqk951lh/Y+sfGXGKyWtYyLewfNmQv1FhqwOaM+rk5fbMNETuj3vsUFvPLLYLBR2OQLyMvFwtu

On Tue, Nov 10, 2026 at 01:39:07PM +0100, Artur Kowalski wrote:
> The driver only supports the watchdog blocks of Tegra30 and later. Move
> the parts that differ between SoC generations, namely the watchdog
> operations, the maximum timeout and the register setup, into a per-SoC
> structure selected through the match data, so that support for Tegra20,
> which has no watchdog block, can be added.

This does not make sense. Literally every watchdog operation is different.
Tegra 20 support should be added with a separate driver.

> 
> Suspend and resume call the operations through the watchdog device, so
> they work with any SoC.
> 
> No functional change.
> 
> Assisted-by: Claude:claude-opus-5-5

This trailer is obsolete. Please have your agent follow AGENTS.md.

Thanks,
Guenter
