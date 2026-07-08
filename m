Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C033B895B
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783522852; cv=none; b=WN/CvraHvHVHvUCaNS4hOny5bUnFszYzpGfRFzPa89PjIrJe9cvfInh+RIZuKoax2gZ9/+bF+QuNLWxKjpPu7gQHPFbysvG2wPFJQezjLn5IdtEsLYSs8az5wnveE7E3q19eqpEgtK3ElUB8F7naykEMSZ3gZBYAftgnlxe6bWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783522852; c=relaxed/simple;
	bh=uHFWmVrUeOlZaEWmnvD52vwC4a4XcDJHL10YpD3MkCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR3sFUCWMPkDTsKn4qTyFqZz3Z+oUv4JIBbnWX39v8kWy0JAwCx5n8SWqEoYG2IPM0ivjOJ9rONQjziSIujgutpxCrpaq3B9FonyUE37fqYSjA+LksorTXSxZDYW6otMbiI4h6Lm0RL4CyvvmwMzTOrj89zJrq6GDJ4tmon5rbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBu/P2qn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBu/P2qn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so28130465ad.1
        for <linux-watchdog@vger.kernel.org>; Wed, 08 Jul 2026 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783522851; x=1784127651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tYuVY5F7u+tjilXdn0sCLCn6tq1/qV8ZcSRBJ+tEesc=;
        b=WBu/P2qnduqZgjH+CeQFT/T/uNI0baYsAran4Xs6xcLK3oa59CD/THMe1ignQasZno
         3xRxBuiWPTPI+cCwEPWbAj/YppvqyGEXUeRPksPS9A0pGrFID9p5/DlSxBagzyT92l23
         c7NvBKym0jPDAME85o3aTTKJNgkwP3ENaYmcB4bgbowPPWw/sW+4HVTwNFuuQLQH2NEZ
         ny+/hpZ2WNjdwxtug+QeDuVymuwVMmtlsH4MZzKbd0WtLsgXlRRfT7ox3AFRgL/2rieg
         OtCQGSTQ+Hw72oe8yO7Udf4Z8iWrc2xK3OPEoD0HP9QixmHBguVEPt5f+HInWubwo7Ng
         d1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783522851; x=1784127651;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tYuVY5F7u+tjilXdn0sCLCn6tq1/qV8ZcSRBJ+tEesc=;
        b=ODIz1hXmLYzOyRACMO58AUHBM75AiCBSToCLc/sR5kE+Fclb0UZ0UKOKBa7UII2W95
         1LPd8ssKKnSfA1GBBoi1vePTefs6bRo8aVwHm8zsBNqURuUiHAEHMqMXPCu3sLNTWCzs
         aPzYEAy3AkFc0ZlkspTD7dzgQAW/NgoKrUV6KsfG6JmjLaO1JS8Y+9QIb4X7GvuQdYKL
         BmcdHPJAeugOIAU137pPjPkGHdI3WkL1THWEWcivBb1OfLG2nITXlu9S2uQnrKbmAKN6
         qPOSoRTwSHI8AfFJ/MDaGxTDqe6WNRgL0stSAQYHGrIvUFkaIoisr6uRUCNQ0xK9uuCu
         2l/g==
X-Forwarded-Encrypted: i=1; AHgh+Rpu6nvnIRSSGGM1c95+tgbRLBo6OR92woAxF0EbyvSgCD7YxDyxfU4pSmXOxNsYEbxlBaiyLM7ydRhS++AJ7A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyri/cZ7t3wt69aJYBTPtkbyxXFaCdfAD0Et4PQ1YbX2ClDQRVc
	krdGQB19Z+dSonbXsHCcWbHU1xKllugbrqtu5ppRSIwdNbFsd63HNhtI
X-Gm-Gg: AfdE7cn4cOCHIE+yQdwcWsQR0AtsC5bfQLMIz0WmK/GOe2fRfTu4lScZu+HcUcT8I+0
	9UH0cpmqbGBss8atXwKhT8+dxPvL6p+LvJwhFgCTiXjFvHjsPv6+9c7cwpXhcu0PsLL2DcXvNln
	g83hxVF7DUMb7AIqbKo4nHSkmQrZIB82yZOIvOO/cMEwyvhT+jeOaiuy2Nk1s6AqUADWqBGhqsx
	LeRgjUv9oHBBbxr/oVs9pbidSgKR1DTHVGjE7+oGrAb20qWQuabfV6nEl66E/LiGy1q5sLmUjLc
	Qj65WRmqQmELIFaqeKXUG4p/XynrWd5AItMoPeObfeE2v+pC6/B9KOIjai2gn/Zj5U23EwWJ22T
	+VYT894IJe12GfQGuzzPmEhnJRlcefDz40JPq54UN1bRD1ehYNfUCvbFLA8M35+H3MURoKYLRPU
	RzN8Khw+m6Lml0oq7oHgYu8hUSug==
X-Received: by 2002:a17:902:e003:b0:2ca:b3e4:858f with SMTP id d9443c01a7336-2cccad7f768mr46634955ad.14.1783522849948;
        Wed, 08 Jul 2026 08:00:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb76asm30607025ad.12.2026.07.08.08.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 08:00:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 8 Jul 2026 08:00:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: lenovo_se30g2_se60_wdt: Watchdog for Lenovo
 SE30G2 and SE60
Message-ID: <6e6b5d06-be4f-4a60-a382-f636f50e4ec5@roeck-us.net>
References: <mpearson-lenovo@squebb.ca>
 <20260706145412.3833185-1-mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706145412.3833185-1-mpearson-lenovo@squebb.ca>

On Mon, Jul 06, 2026 at 10:54:00AM -0400, Mark Pearson wrote:
> Watchdog driver implementation for Lenovo SE30G2 and SE60 platforms.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> ---

Applied.

Thanks,
Guenter
