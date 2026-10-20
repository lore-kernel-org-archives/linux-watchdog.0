Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502982;
	b=xn1y/vi45xT3VnZXeQ0ZEsmPPtPJlyaGAV/RyLMQFlQMKPxB1mhwSvKtX7SvVwDYk5Bb
	 CgWNSmdLNXfjws1d5pIxYqacHRdxFwuLQ6Do9LW0RAs5YJb75sXsEohgpT+JaddvwN7f8
	 isUk+JeX0hhJGaFKY60nJMDj5w85/KP2F+GD38lv1rAwztgpMip4yOA8r1dhSExi9rFdF
	 Xt3tuTNhxS+2dSsA4feKvMobXnfsUdjX1gaN+js5KeUXfqHaKnNuR7uFPJcP956lJ6gIQ
	 h3qHB2sy57XnbJFTzEgTZfu4ez5vg7NtLcoPWwP006o3njaCo5oxAZEokHJy+02NM1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502982;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kDKbaNfYDehzMWX5kRyBX1HmBHtBOnHiqsywfRMZhtk=;
	b=nWgu3/nKpYMrkpPI3YbxYc3cLP3zGUC+cUDXGrQ4UX1riiZEuPvWMzdOJ5fRjHTLyzmE
	 Qq50kkwDo7/bxpPP5p5Ghg9MYL/y6Otil3qmoiuslBwOQY8bHot0KaxkO9n0wLxG5eGr8
	 GevAdqLXiJhTXK37St9zOD2gGG07ZUpNpnjsQJIcAytYvyh2Oj1niMVR4zi/+aWV3487V
	 fOYr3r6IGJXSMeqBAltwoMli4NELmfO9gGDYFuYpcxTGKQvOa6F3E5Uh3huu39W+boBJ1
	 4CxNzCCFNNfYi0XIkSUtlLS8gGSDqeeeIO8M5DfPq0xvt18Jivf2ZPbBmcGsxdcUtew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edg+8MHq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262B606A33C;
	Tue, 20 Oct 2026 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=edg+8MHq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9881F000C4;
	Tue, 20 Oct 2026 13:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502982;
	bh=kDKbaNfYDehzMWX5kRyBX1HmBHtBOnHiqsywfRMZhtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=edg+8MHqmvofWsj6uauILWNgYFHTbaDyFJf1ub6DuiCyf4QDOU2byYBopg/jBJY1c
	 RRznMao/fRtX6JZZx3pDZ6tmJOfFIJKdvUg00VyoFD/v5IxYptHW3eGTP1J5GwKUFQ
	 ZQ6EkzGShLjpkEPbKI9LUDiwePmNFG2jz6gcV62RRWmvHskCi+/hMGIp+9KV4OQ6xL
	 CZBp6QR1fdzSjiQRdhRxSjJou2uKAkihecokw4u1LrvMAHxniLjtgJ3DC75NoTVVOz
	 ByIcRSglfvBK7R2eJu8Ku5hwqug9f5+Nvxw/7bQTireYMIiItieEAAwO+tzH1yJvCR
	 QGuRHfARWTzzg==
Date: Tue, 20 Oct 2026 13:29:38 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 2/5] watchdog: w83627hf_wdt: Convert to platform
 driver model
Message-ID: <atdswsr3flA_GFtj@google.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
 <20261020-w83627hf_wdt-improvements-v5-2-90b226684fc7@bootlin.com>
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
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-2-90b226684fc7@bootlin.com>

On Tue, Oct 20, 2026 at 10:11:55AM +0200, Paul Louvel wrote:
> This driver is not yet converted to the driver model.
> Convert it and add missing error messages in probe.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

I'm not sure if the W=1 warning reported by 0day bot [1] (also flagged by
Sashiko [2]) is still relevant as the truncation can never actually happen
for now.  Even if the truncation really happened, it should be harmless.

Given that,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

[1] https://lore.kernel.org/oe-kbuild-all/202610080027.3OsJDwfo-lkp@intel.com
[2] https://lore.kernel.org/all/sashiko-outbox-178668@kernel.org
