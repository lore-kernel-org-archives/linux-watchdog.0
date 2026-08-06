Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71541D4F3
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051545; cv=none; b=dzDI+yHZPUk5umick9cUSN+IZJMHxhLh1uJuYV3Y8tOA4gKKp7d1wwzS1pbh2L0K0amfYv56FQuEM/I1rLUToVaXU2tCbgQktYktzbTlOElIlguiqW0Ta9U/OQflfkxK9fsn3ERamVH3QhDKYTmab/EzaJcfnMOGcyTEGu8fX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051545; c=relaxed/simple;
	bh=iw6NzlpbIscSaSSY0m8/q/eiI4pkG7adwwd0ooQiK1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcHTHvLoGm7Xi5wnWpm6hdBg5OwTL58J9gtv4F2vx/eT6b6pPO0vMvkC2L0Oa9pjA/Ale+Avxw/FIA6mv18xiOl/1SHLik4OTnjE7UEgMBFc0IacQFo6yeRnIiWrpJUUgz4XcoHSqYoZbeahcpsoLYtkk3ehsBgcTsnfxbVxRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUqLoDVD; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUqLoDVD"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2caced6038eso18221415ad.0
        for <linux-watchdog@vger.kernel.org>; Thu, 06 Aug 2026 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786051544; x=1786656344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=U8JFZqlB50uswLR58OmnyCXaxlSBWX6UZAyFotochoo=;
        b=WUqLoDVDjqHHIBswJJjVP83CcD9bAA3O2RBaLH4+cKBS1ZU9DVZDIBY+7fYRalIB6G
         GHIJMNT6hQJ1xPZfFURtEDRTQN3MJjA2+32O6GNeRHimoT4uzn9tR3LAEE+cXJFcbSbC
         fmYllSn1A95FvNa09969ROpV4cbsb6TdzBdYvY1Ns8n+W8jwXs8gYVEcX3zf7ObWDzRT
         Uy8G/cIBiZxvTf50+1gI4dt/aKGYIcCaDEeawLgGgqJLCmkIs41qTW4nc4gjA2R2bckH
         nOAORRFcCbSR4Jnr/pXnKqwl6iKewc4MhaoXVM3uWlZK5bQmNsuFvvYiJqmduf8lsdOo
         kx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786051544; x=1786656344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U8JFZqlB50uswLR58OmnyCXaxlSBWX6UZAyFotochoo=;
        b=YxMW3+yl4Kdfb9xOlQ/OefnLrBLNsQUjRCs2LXUUtdFJPKjGKR07+5SQBz9HoO5cQs
         IuLlPggdmy5u4zrhKml8XS5/DTDT4VzptX2hH2SUZYvyYE8rYdCyrq8M1m1jvrldrdpS
         Sktzl2rQSae/vazFeCn0r9sQU6gldmLk6lUdHXA47Yh+yz2w/RpSGmG6IhL2pjCUaDx1
         Oa/YBx0w/6ofu5L0VFx/dc1b6R4ZfNgmCmf91gbkG4H48kzLwxBNEgWLGtkkObMzfm4o
         AMV28Rj7r4joPWswbZCQkqJhL7/hD08ZTWeqwec/Zj4g/FBf6WnzgumYIQQQKEe4kkUj
         nbWA==
X-Forwarded-Encrypted: i=1; AHgh+RrFqunbGHl+LguLzJhjSjUrPmMeT4H2Lmoniwwn+3iUkHRdSiC6xIC+jTijugRYohhshG//x5WD6BNdsEwj1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrGchEiiAVUHINHIPXmQNGvji4v0QFxxeJf20B7oJK+aboZVvS
	OOkCBRm/x62Q03vZ5tQZ/HsLjbK6j75IfsO9+JhVhz5wtzYykdWWiNPU
X-Gm-Gg: AR+sD12s0Z0mQcUMU4ey6ODY+1espDEA2GJSSVBtKGlpF0kr7pF+/N5KZRUoP2BM/xu
	JYiqhMVwEMKTXo1MCgSCoA5FTDw4d8o/t1JSIqphsZAshpDHxTsZco88qlvlb8hVhmeuwEdwm4m
	2Un5iqiqFRe8jbgpL7mM9wbPoMWZ9b9VCytmVfkpkuG9iNg7dYNJsVWBcdo2HcP71tyPTg32AGW
	rlxyJ8HCSHeLVuhfksuG/R27wrnd7QrLif8pNqd4uwe56AyAQwYdiT2O8X5XH9wzzZsdYgMcpOk
	ZlZfaj/bO7dgKS1+pVdxUWRIpU/q5kFhVWexawDV3zznArh9TU3fqtrT2XxQFqi0YFSv4ZM5eA6
	pSTR/uNO9acB05xQAt2gVz4QqE7j2mAXXU2LNxvoxMVWovpo26T1B8nOJV0G0GgRgMHaKO8Tz2U
	LPHRhujtqJcI2jvMTBplXQOChUGQqVkT+8zm5sbLiPXiLa2VCznq5ZrQjTE1Mf8POudn+6VfAuG
	A==
X-Received: by 2002:a17:903:3846:b0:2cf:6e5d:23e9 with SMTP id d9443c01a7336-2d0f1c5f19dmr118531195ad.14.1786051543613;
        Thu, 06 Aug 2026 14:25:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4ea157sm179095ad.78.2026.08.06.14.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 14:25:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 6 Aug 2026 14:25:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Zi-Yu Chen <zychennvt@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] watchdog: Add Nuvoton MA35D1 watchdog driver
 support
Message-ID: <60f4cc17-d545-45ab-8fe1-589dbbd153ef@roeck-us.net>
References: <20260804070351.1846165-1-zychennvt@gmail.com>
 <20260804070351.1846165-3-zychennvt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804070351.1846165-3-zychennvt@gmail.com>

On Tue, Aug 04, 2026 at 03:03:50PM +0800, Zi-Yu Chen wrote:
> Add driver support for the Watchdog Timer (WDT) integrated in
> Nuvoton MA35D1 SoC. This driver provides standard watchdog functionality,
> including timeout configuration, ping, and system reset support via
> the watchdog framework.
> 
> Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>

Applied.

Thanks,
Guenter
