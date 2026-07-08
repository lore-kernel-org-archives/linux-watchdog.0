Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E33466B4C
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522750; cv=none; b=m59WhEM+mrdHLnqNHybvTLRqfdAg52beq61qLJBg7fsGBo86UqzIl91x8KtFRfOE6kQPKa265BmohbYMVe16Jr7uJ3rxp+11FAR0wHS4B33264xMj9Cy66iykub2jTTlkwXfHINgvLqjMgC+FepNCKsgyBr4WCT380f9XDTVH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522750; c=relaxed/simple;
	bh=dP+1oVKUTmFugT3dimWC65zo/IFGdPWysyFdijtRUSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnbXJo1h9Esc3jBh2X/D1GIZ5av/pDxv8tv5qYH78m5x6uN3DiymlgQpywDQGE5vqbjIJ/HKhEF5xXXAD5W77yHa7Y9TibKpzYC6kF32YSxXSapMXsN+WNdJPXAjYB/LRv7UuCamvkSaZAO17ilHe8GASYghZuyYInrSyXYsgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UF764L39; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UF764L39"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383cb94f742so714988a91.3
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783522749; x=1784127549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KUMYJWqEEV5Gd16v7ACrt4uz2UjqluExzYIKIzuUY/A=;
        b=UF764L39lqDWHWvgX1DRbdvLojqtdqlpLwRsScOgL8FN8ZYsIZq1yZ6oWEh52PiYiJ
         SJKwQXvgWP0f++YlOJ1oWhtnM0JI9p+XvhlyLYa6OkOU2Xgrfvxp3/aeX12JaKUzqv8W
         hQ2irXGCupKJwkLuvo1mx5wvg0UOnovwTWUlGUDzM6I+7KN/1kIwt1/lV4/bfiil2AQE
         81JVzNqBi7OEkgklrdnLnrP8PD/6h0v82WJqupcP+OEV1VZoJPNm+aGTGnSbi13QT5/f
         /TLq47NsGp9esTMgd+hTMxz9iuXoCF62YNpF1tUflcAe09VHTw33etXmWDSBW+coNEla
         f1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522749; x=1784127549;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUMYJWqEEV5Gd16v7ACrt4uz2UjqluExzYIKIzuUY/A=;
        b=MdvPzIlYPzP4SklHMfqWPzs+OTR+PBh90IMPuWIzo+A2/DsvVMMl8FSduo/dfapQyg
         hoeeDylOXVJF0GJYBLBslI64eBzE/uM719uPm97DVBD0jSchEY9NkfbgOD3KKiJ7e5E4
         84EkteuxcMGcI0OOJQLMJvsm6w4e3ab6sIv7to1KCkBjCWN46n2YRys2jYwJKKjzGgie
         bsSGAzFbpXhReQwSUhrO7cqh/BwW04Q/yrGbsg8LjgwNgBjXtU9loF8d7hO2FKXxHLhn
         KWURnvyF5Nm+GxXJEUeR9gb8R9gNqf3TuSg1bY6HS2WR+rm3u+g1xZQEW4u286JJQ93u
         B2nQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCuSEGMs1z60c75I6t8ZD/P9jitrsr9gC7gG3b6Z6FYoT1QJTstZY4NItCJGVCGaXwgGdVsYU6wUy20f0gFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpwcsdc9dsWxfU8Ofu31OCH6Hl/n4uMS3O5rOeNoHTCBQdFcpb
	Iv+u/aNDiLyhiKSdvGkExwcoqUfytNRPj+1Kfvqxw0fJbQuiHpDvQxpg
X-Gm-Gg: AfdE7cmkiJjjcCxZub2gl//lKQjejGuC4LyHY4M5rYykDG+YXoqYSxFOOfzEJFtve3c
	B96ymI8a9jCAwtBWcRcsS6yWMpFmwwkNEezqfanTjbuJktWSEHh2sbBFNkmHP+URNwrgoy1wklK
	aFcVSoPuTlsbmdsBZEx4dF/7eMBvdr45iC1LRjr9d2dZFR2h5YDadrpIjnFqHA+yhYDcDpaMGbP
	l+QV6+PWFZzbF9jaUBhmbDKPwKe9Kx2p56qfKQA+kMFFCR+fX1hjtuh0rvJMDe4trOSOePMaBXr
	OPeJGgSI9ssmox+7OppIvl7dU2bg4IKVrgoMu3Sv0h440iMwsXcjcXTF6+OjAAHqFrnGyVRUmsK
	JwToMR6KzwTShQr7Yhh/aZrF16UK4pB3ZVTOlDebCN1FGLHgBV1M3n50+Wfbla0I1eRpeB6wA8F
	XztsFTM+QQDMTaNL9u/0eg7Z3BuA==
X-Received: by 2002:a17:90a:d2d0:b0:387:e0bb:57fd with SMTP id 98e67ed59e1d1-389421ad4c6mr3022140a91.36.1783522749079;
        Wed, 08 Jul 2026 07:59:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d3c675b1sm2823895a91.15.2026.07.08.07.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:59:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 07:59:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/3] watchdog: w83627hf_wdt: Use WDOG_HW_RUNNING for
 running chip on boot
Message-ID: <a7444618-0ac2-4b35-a626-6b3b7abf1458@roeck-us.net>
References: <20260707-w83627hf_wdt-nct6126d-v4-0-829e5f63d548@bootlin.com>
 <20260707-w83627hf_wdt-nct6126d-v4-3-829e5f63d548@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-w83627hf_wdt-nct6126d-v4-3-829e5f63d548@bootlin.com>

On Tue, Jul 07, 2026 at 05:45:03PM +0200, Paul Louvel wrote:
> If the watchdog is already running when the driver is initialized, the
> driver currently refreshes it once using the default timeout of 60
> seconds.
> 
> Since commit ee142889e32f ("watchdog: Introduce WDOG_HW_RUNNING flag"),
> the watchdog core can kick an already running watchdog alive until
> userspace open the device.
> 
> Add the WDOG_HW_RUNNING flag to the watchdog status if the watchdog is
> already running.
> 
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>

Applied.

Thanks,
Guenter
