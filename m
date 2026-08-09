Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7C30C37A
	for <linux-watchdog@vger.kernel.org>; Sun,  9 Aug 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786288047; cv=none; b=LoIeZUDB4czRravPt+oRHv7fYfw0CeGuOPey2Q2rGcBMtmuAJUiSWbInC4Udv36sXOAh7tF6db46qyUmnoR5BkV2TnATAU2vC995k8cYpdzPRdW/1svTVjj6qxgYfC7cd5k3RGzojEVjRfDKZB+LnO1ehL9893aadqDrI6KjCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786288047; c=relaxed/simple;
	bh=2cicJZ8RE/CjxYTwQcqC0IfOpXTmsqFE1LUv/9Cabm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ2DrWulywPiVPWZoVwi1t9okpLhLJMKLPZf3v0nSrtXD0dcox2AAifkri94oH+5YAxPWpUKA30P1xG4ux/fKm2HGC3w5GWyIvrPzwtiHdmOk5HwHZzs7zldX2zffUZD7Lp/rK6UtGXI8gCVMSOyoR7cGUWGgXFKZp28ymcgIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cle6DpzZ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cle6DpzZ"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso764164a12.0
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 08:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786288045; x=1786892845; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tpoOGtZKUJbl44PSTEgBUWooLvbSUBKzNBgWzjZO7y8=;
        b=cle6DpzZbDkVf/C9zcbiHPp/UEMBdCtRX7j9+byza+aBryDsv62BK09NjuEy0jomIN
         k8aPM0ucwSC8eu6Xn+DesU05JxVh0SHtfg2j7QVaH8ACHBBez5TfxeATfATn7feJrWl5
         J9V3aW+59j39zIAp1kq5TKn7Vpp+D3f47rbpVaad+/VoyVo2rkk6YEjIO9WqX1rHH++4
         klB6OKv2vacArcBM+K6sfr9oxngGH5DLow8zhU4PhB02CW0Sul3+mXaaw6HDgfFX0pQz
         te4cEqCOeCrBPh40463Y32JDUwffl3w5uj7sAOe8B2Vka1cSCuaCWA/VDF3wvxyMvVfk
         J3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786288045; x=1786892845;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tpoOGtZKUJbl44PSTEgBUWooLvbSUBKzNBgWzjZO7y8=;
        b=srIsri1Je0yGRNDYwUfS8DDRMg+In5ssqxMc9YPbR+8f9etKrGHJvDpMazxfOQYt8Q
         kTZ5RfPep22+kRDZqluLvLa2so08mtPq3WZhbS9se8njtHN5WjQoVtN21ri1WknsJeHl
         Fmfll7XuUTanOagnt6UnVgZiybLI4oadjcGTHcZcH0PE/9O+IJwL7TTbuVP54cwMKSjd
         MkazgUR7Zfmdl51ja1bNo5WHKaAXVOCTY2X/5/aQUdpNrnWvugw9P65EJQDSwG7BB/4m
         fpAmmnhXLoXaruDAQ95owINtBhNjYqbHU3b+3y1l104hWxnf8ZDKPZ9MP/ysVKtZaQLB
         UPnw==
X-Forwarded-Encrypted: i=1; AHgh+Rq1ygwyCc/sDoksVIhiibab5+g3B83JB+uiC1iV1ur/9/+Lwn53Jj9zmW4KwxdCPhulqfaYXwemGKL2XF1WCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+s1WHrgLFqRz5Xt8G02i45kwfKDyt6kPWu3p4bHMp6cRHN0gM
	SmEsH3R7WSZzRquRCv0ZCj5EntGk0W8/ybeQFEXxRaKW9zzLMV2pwFqF
X-Gm-Gg: AR+sD12lnchBsgKf/pMI88QhrTZnotUcr8DAyEhywdQFci5yIyvdbbL52057ewG8u95
	pA8+dwszkgtBiNt1rCfF0ZV+eESFX6zCZ2U6SJjAT+3/L+uUbz9PjAJARhd3E4mV/bLNpdr6TSm
	yAqq8AMVD1r2YEKQehzi9SJu/UjqUu79wBa5U3nOAb8VaR5XTrS3mpO9hG8iXFRzxJZwZqol5xV
	qCts/EJQxnfAf7fgR6phcomahIA6/kMmFeRz/3AlFr+JUjhJKtn6h9F4MHcScYJ1cEIHBM9tTir
	SmgpZac6E6+Mr/GSkiPKeFg4mdywP79auzrRh8jQ4XFglmNd7NtGZm4xCGifZF6LIvLE9wt82BL
	p/V75P3e2wfIJPysk+jTP1w90zeq9RSdOcTihiSKSTSMRvqzId9NSwdQlLnMW2fMemh6RR+bdB3
	dCfN/cEOyiGDUHktDkLnH7zZW7DC8+O22ccBZr3NVvVi4m9C8Ms/yjGWB2ORy48/87w6AH2s5AM
	fc=
X-Received: by 2002:a05:6a21:7704:b0:3c1:b9c:4890 with SMTP id adf61e73a8af0-3cb85ea4e17mr43246334637.22.1786288045445;
        Sun, 09 Aug 2026 08:07:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec68468sm34471013eec.31.2026.08.09.08.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:07:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 9 Aug 2026 08:07:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] watchdog: stm32_iwdg: Propagate errors from
 optional IRQ lookup
Message-ID: <84fbf9f7-4b30-48d4-895d-efa10cffcfc0@roeck-us.net>
References: <20260807080447.35479-1-phucduc.bui@gmail.com>
 <20260807080447.35479-2-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807080447.35479-2-phucduc.bui@gmail.com>

On Fri, Aug 07, 2026 at 03:04:47PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
> probe without the IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applie.

Thanks,
Guenter
