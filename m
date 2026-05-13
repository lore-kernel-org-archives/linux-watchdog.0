Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DC3955EB
	for <linux-watchdog@vger.kernel.org>; Wed, 13 May 2026 22:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711994; cv=none; b=VaKNipZIAU+3HXkwQYSV8IUUKRZQzL/J4oYGiZ4mhtu26iSCuj+CV1SGZhzm/UZTQa6qrsmfwZWVk+DiC+IMfFzus1L6eNwP9sLl/QxnMoVrpTbQ3FpH/WXW3Ph4ZFKLrLk4TruBm0k52gPHgm+JXya9zffu5+Z5IZ4hTg+h8Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711994; c=relaxed/simple;
	bh=0VqbTRVEZlpoi5Ld1YnV7oWMDYNnumYR5TrZ6zn2sPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8SlwHSVvvRxJIgvGJoh1uG8sx8Z8mimT7Hsl7xD8sP8hwP7CA9Yp/jiqYA6le0m77qW9/b8ovo4Mr+6W27l+ksS/3vyRpxdOKg/ov5IuVj04U2V2Giz1yxxmomdPs2eEk5jJ/sKTOuURFuBhVk8frVaUZ0dzhlnbUzawxrU0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbeZA5pN; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbeZA5pN"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b4650d5f5cso29201775ad.0
        for <linux-watchdog@vger.kernel.org>; Wed, 13 May 2026 15:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711993; x=1779316793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=miM3jTAggAFQJz2CzbBvHc0aYdt6SXz1ObmRHBqYD2M=;
        b=XbeZA5pNH6IFvMJCizA0sjWapJaKNJH27lSsQWG2InYGMKMUThiey6ZJYqg8cIEVBm
         r0UhW9S02zUKEVHkMH4P3XarBQw0dUFBvfmZ7INC6HwSqiipCGAsyhqND4I8fcr2oskH
         eq9ygmWEDq7l8NrXuWqB4XNmTUnx0PcFt68WAtD7QAzA2htqUjxGlbO+laNAMjCJQDsg
         iAqFlhkWcSV/PvlkLNcy+8dRc0bCACySGPN7zKZn+TCPTqpGNbWdrkbO9eim840oPYY9
         aHh6TEpRu/kCWv+P/xlY+oBniDIsXDOZoFzRnFs6XWFIT45iwLXXQCpF9RvnmAvs7YsD
         Kc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711993; x=1779316793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=miM3jTAggAFQJz2CzbBvHc0aYdt6SXz1ObmRHBqYD2M=;
        b=XFTh+SDjEQfZy61nFBW/k2LQt5W0t0s5lISKeX2FRGKi1y1e4lltNhExW0WwWjKmJM
         n9U/VwGsQoSXEI8wl0xiiJaLS7kONeO6OK9XOd7lxnhRi/l+GZCcaYeyAfntpulwydyi
         G/FFUExjll0BplXcc1gn5X3itwe+N8TOfxFDBXAms8FeLvcv88fxldt0lG+RkZJ3TY6r
         n6Z+yve9tjdQnJ1osXqdgGcCl1jSrF6nlIpnSA9Tavr6qDR16H6JB4CORYy+RtUwoz3U
         yHfVv1M7RsOFUSqr8kOYbzwyVVeSkU3ODS0x9mfkiS7JyzM84/1M1d2pmOoAfi2wRsrJ
         k1KA==
X-Forwarded-Encrypted: i=1; AFNElJ+X5f3jvRPWKwGYuLH2eIkHLHyK3QBIW+Sm0ddAMEH6o2YvqiX+dRAl0SNGQsdc9QW/KY0tkgb54IhqEcJGqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYX5QuXMjB6ZSOSVBDuUxehINAV1hT6nQ+Zp+Q3AV9aK7Qqbv
	gCbFshngERVOEzoVYM5EfV2bEkqh7pku3gPa67JdAC7vMwHmrv217WDX
X-Gm-Gg: Acq92OFF+POvnJr0zz+Aqqw++MpZbJ5XNCpk3i3miZEUOQQlws1B4+W55x7tW+SKte4
	gUE0iqxO+1JVENlcjWBveg19ki8NI8nhzBEeuz1pTxyT5bAe8hc21eidp03netOWl0I2FyacYkT
	zRaV27thu4eMOzHdzwfd1Kpx6H8slKSfYiQmirSHYJRsZBKMclG6STYuMiqA2LGFjo1dFxhMufJ
	alGiqqix3OGZ9uqIk7rDTw3tPIVNWyG01BahwpH+4oMrYy6fQy30QUwr0bzd8kUVT5NASpMV+ZS
	ajZhwXIRNbch5BsNYWhyYy1JI8mWcMRm4xd0B+YagkyVBG2arKcbsSttz/25vgsu4Fs/IGh2zed
	38rOcJZAU4i7EnFDeJnyW+8bjNRaB/kN8fRorUIsRBqCN1cH6ryDXyh81TiHULgIj4BoBOxHl5k
	2PrXrqjXr/e/6IvLA/jQlNnV58h3tk1OXFh8Is
X-Received: by 2002:a17:903:2f4c:b0:2b7:a350:463f with SMTP id d9443c01a7336-2bd2f4e4c49mr48108145ad.10.1778711992677;
        Wed, 13 May 2026 15:39:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f2e7sm2853795ad.5.2026.05.13.15.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:39:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 13 May 2026 15:39:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dt-bindings: watchdog: renesas,rzn1-wdt:
 interrupts are not required
Message-ID: <c06eaf33-6817-4016-9ff3-600027501445@roeck-us.net>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
 <20260507102410.43384-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507102410.43384-5-wsa+renesas@sang-engineering.com>

On Thu, May 07, 2026 at 12:24:09PM +0200, Wolfram Sang wrote:
> It is now understood how the watchdog can do its job without the need of
> an interrupt. So, it is not required anymore but optional.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Applied to my watchdog-next branch.

Thanks,
Guenter
