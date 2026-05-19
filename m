Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CB1325485
	for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 22:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779230041; cv=none; b=m83kDIvzbrIoMqvVG0MvCLcA4qUtR77mNAHGiKWne2xsdzcOnU64ZM9nGMXXtJAd4QBYuY9Yvf+szvF+OBaPAEJoPjO+MrK54aKGWVWdstskAbZkETq6jolBJnSKs/eXjVc4FG4Xz1dskp+6H3GguskMYF8UrF95g2fFrLtMB3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779230041; c=relaxed/simple;
	bh=DkmRHOCAPLcW9L9sbxbwG5yeqwxYIDxym2ahyiLRwxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUfg1530mJ7PQZUC+tXbElt6oXfwFS76pdp9rICt3+4oIR+VQgT/00MZ5ZXm+OK7XtZJUdg9s2vQhaTGiu7M3e0uDpk2/RfaO343F39VTPWFjFlLkXTB+UtzfjcmwYVJDIQ0MPQvd9tBtxrORHk7QKT5Z8JkXKeqACcLJCpTjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mw8eu0Ua; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mw8eu0Ua"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304106b1204so705225eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 19 May 2026 15:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779230040; x=1779834840; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MeTNA54YFbd2QZDqA80ZM3Z12aPCAGjrTUN6JkUc4lY=;
        b=mw8eu0Ua4z7Xq2dNM2tcO44Oi3EePofjjDOwklTjQLCkpw97vJ9IzzciUuANchPDka
         nNQL9Qy1qD8T/U2no7Gy2wlO23Ld/Fa18XMDI4UHY6coEinRedKKYsxZsTTQfyqSHqdd
         /srA03OGG/SyzI/owWpFxJ+z7agQzkHjqVPVh2QGGHMXBpKFrUIfmYSoSLmQH9HYLxaB
         R20DY9CEdtyzeRDdccfOEjLalG1A/x7gtpQByTFFVL3teZGXEg0+lBuScOGiWrSXyN/T
         S3m/EJF3X5HitOEIoVB19BK1oZHIW7dbbOeUBx7BG/gc4PYIj5U7aLj19V9yjmEX/e78
         7miA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779230040; x=1779834840;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MeTNA54YFbd2QZDqA80ZM3Z12aPCAGjrTUN6JkUc4lY=;
        b=XgPHvfWwrXG9zdag7+uAQbkIowC4VOOsCT7FE7wxlyWHYJuganqJ3ulfz9vcJzCOqv
         MKfwnph13WdD+cbhoLtqiDVb2NrsDndi+0x98U3Yr01KvS5E8XI2zItGeBDIuJJVGFnv
         0FGwgkIxZWpEUhd8IgiSUARF5UXpQROJhEkQCDZsmmEBEPxfbPOX9UuhwWqNFizBtPtp
         fCNhIXPnIuWDXkWoa6CNtuQR7vfwiLZdPTkh5bvdJDj3AuPFtr0CfcKQxXBggnkfJHVG
         yNJ39VX2DnWELyjUvmRRogE5r5DeLnt20d0rBd09EYDfGT1vuL2O2hWVrhCFzOcSMt0j
         O1jg==
X-Gm-Message-State: AOJu0YxhtjOqLQYPK8DxST2ClSrO1GGeO73qzcECH4xzM4mXk3Fbfybe
	MryhZKhHVB4bEHi7ScsedVVsxfI4qq87ysWB9BtIDpfbGH8T+RoQh+zCsij0vtXl
X-Gm-Gg: Acq92OFWqU2+C3W070OKz6bWpBcnIB415sAS35u2gOKyxEcKPE3dnyd49djj/kq+tLa
	DJSDBUO5M0dRA1VS/DVJCfbnG6sCuxBh+/iLS4PYnt5DVm6D06sdHSSzjFu0jDdFyoiutMAMGXI
	HS2Ad22QEvLbncvBsAs5FkEUndwYmeO4NIggyk59QSTuaAjj6X6pOuqBqXi8B/c5lFYj93HC9IH
	dlq3uVndLpFFOPgGlQwdeYsHUL+xmooB+JoOYJ8XA1cAvBQr31cd6CduyNtPkjRr2lz9hJyXZzj
	UHLe7r7wytTzDM+sjVUToeMJBoGC/6UJwipP31Rgblc6fUiaKAkQdJsGm2drQryQPsS+088AJCf
	ovXUVAJCPftU18VPovw+/9aCsTHjjlKl+9HmeBZVqEkBCE+kwl+ybJDf6gB45atBQiaH0XyzqG8
	AT5iOF4V0R93rijjq7x1UCTRQmFkdf0MZ+Sibv
X-Received: by 2002:a05:7300:8621:b0:2ce:25be:c8e8 with SMTP id 5a478bee46e88-3039867e53fmr10742802eec.17.1779230039478;
        Tue, 19 May 2026 15:33:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304052f79ecsm3137511eec.11.2026.05.19.15.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:33:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 19 May 2026 15:33:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] watchdog: orion_wdt: Use devm APIs for clock and
 watchdog management
Message-ID: <61a24e1e-2490-4791-811a-3c1c85fda05b@roeck-us.net>
References: <20260519214229.16656-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519214229.16656-1-rosenp@gmail.com>

On Tue, May 19, 2026 at 02:42:29PM -0700, Rosen Penev wrote:
> Replace clk_get/clk_prepare_enable/clk_put with devm_clk_get_enabled
> and devm_clk_get_optional_enabled so the clock lifecycle is managed
> automatically. Switch to devm_watchdog_register_device to eliminate
> the manual remove callback and the disable_clk error path.
> 
> Switching to devm in these functions is fine as the proper
> platform_device is passed in.
> 
> Assisted-by: Claude:Sonnet-4.6
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

drivers/watchdog/orion_wdt.c: In function 'orion_wdt_clock_init':
drivers/watchdog/orion_wdt.c:82:13: error: unused variable 'ret' [-Werror=unused-variable]
   82 |         int ret;
      |             ^~~
drivers/watchdog/orion_wdt.c: In function 'armada370_wdt_clock_init':
drivers/watchdog/orion_wdt.c:95:13: error: unused variable 'ret' [-Werror=unused-variable]
   95 |         int ret;
      |             ^~~
drivers/watchdog/orion_wdt.c: In function 'armada375_wdt_clock_init':
drivers/watchdog/orion_wdt.c:113:13: error: unused variable 'ret' [-Werror=unused-variable]
  113 |         int ret;
      |             ^~~
drivers/watchdog/orion_wdt.c: In function 'armadaxp_wdt_clock_init':
drivers/watchdog/orion_wdt.c:144:13: error: unused variable 'ret' [-Werror=unused-variable]
  144 |         int ret;

On top of that, the APIs are not 1:1 replaceable.

I am so tired of this. Please stop. I am no longer going to accept any "cleanup"
patches.

Guenter
