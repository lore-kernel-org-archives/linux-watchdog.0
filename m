Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472623F54B7
	for <linux-watchdog@vger.kernel.org>; Fri,  8 May 2026 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257769; cv=none; b=pTIoUchJtjWPxdfCJRqtjf9wM5zW/WIOYljn5HJ06O8BoTbg+kpKK7NTNl07Tl2DMTg4cEqQ1lDE71cFLI9XiQeVIpuxgecOdJS3tc9GwY90O2YPstzIegoqQ+6fsF1ZJ2uou18RTVrIQvPSqY7DCunQpn/fIurI8nVrjfXVsrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257769; c=relaxed/simple;
	bh=bMyP9BaD/PCksUzPZtT4YtBtuXzutXem8/hGbSSDiXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owVJER2m0NzzbJKJFWyWcADcXjav/Hw/+F4vI0F1JtkQe1Eq9DHfCHIqWCjp6hcLvaaEQQFvxQ0cJNQSp/D3EfqsNnVReHM9+lY3xV5NbA8Ok/MBEYRysyzTzQNjKkVgQItn6P9O87JvNU3i9h7a+S0JnxB+mM0QCbGdUZELir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMPQQ4l9; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMPQQ4l9"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-366375c43c2so1087491a91.2
        for <linux-watchdog@vger.kernel.org>; Fri, 08 May 2026 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257767; x=1778862567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2NiOOX/BlUiU/VwTTl1u77ZEF4f4t+Er+IIs4D1x6jo=;
        b=EMPQQ4l9mL2cBqOHw9IS0l9xb57xIa5saM9EFcjOR5NFH3gfRTpK5cN0tgrnRr3ylE
         BfRbDDfHp+XVFhxw+Aph8PYvPPiiGbTTSQEfYkASzZUPYjMSSPMjwXuT/LbFopiYHeQe
         mMixD2bzfFQpIrd6Mkk+z0I9uhi+FffqGdPtakRWcmTpnyHZd4n58FcQdPL6kmS3T8Dl
         sablR0asUl+5CZJ66qdRAZvFI0vmK7d/PkF1b7PkYhMlJ4vd7L3nFJugq3E5ndkOjo2n
         +cdGLsLpAjSvmt+ut6mAmrp84wO1Dnk8cGWBGERwjy9QOS6o5jWDepLcjboEiRaoo0TV
         HBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257767; x=1778862567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2NiOOX/BlUiU/VwTTl1u77ZEF4f4t+Er+IIs4D1x6jo=;
        b=Z+5tuBQhb2BVPkoJAs+5MSzEJL3sIqcdI1et9yPC/7gEQ2VgzRCO2Fg6U6Mqi0AKmx
         p6F2bl9q4GZNGNK+2SAFChO76uqcF1aXNyW8ExPjDiCuZuGCExJL0Sjd7b0oZ6LR2lox
         SB3C6XSHbS854or1exxBCPjNaNJKqAiDBsrnpGeBKyoJxrRvKab5s6sjC2Ox49/snfFY
         hIeidVuOT/VKw4rVLhOY/G5Wpt7pVC3GwT9r40Jsr749Nz/2gvIPMkXZCS7vrarmeTUt
         +N6nNYT4ifWJ/WGv63YG1dvHkvc9GSITUW9PfZyV3sQQUdyVzlxV3BfiDSfIZRX+K1pU
         ntXw==
X-Forwarded-Encrypted: i=1; AFNElJ/1U1ADxGloNlgZwrDiqR6O3Xdp999bPJtz8uTYN6XZV1Qu6au9AIjODStbyPqaDkujH6gespMJsERRRIqb4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwScs3sK1FRa47IE+piv6KO0WcOxPbNBoHc4VAV03bG9jtOh1rv
	INMiwKsRvhYiGvSilsc0P7cAxNjQsMKyqGnpHBFtbBDaqMFxCsd1RZLP
X-Gm-Gg: Acq92OF+oQ6ig7IoZjEO0DHTDvIX0WTMKxuOCem7UwI1CRvpg9qLBS4s7gynFn9mgdZ
	Pgml4mTIjXnt0XNTsVbg+ScZUmpNOPxJuPdW7JasRgp+IrR+bJIbWnkOAYczVhwey0RGBcjVkqJ
	ulTNxZUvmUnCjTg+h2XNGcOUmTv1Ok5AIhFJBDIpVwvb38QP9bIeA7i4uD9u25XIlr1yVlcXeGn
	VulN3UvBtP+tqYDeKXixRy84Iw+AW6yVFJAds0YfEx0/V9yMSGer6hEogM0vS/nf95SgjISsp6y
	KtekXUmJrJ3kfkyjRcjsJUzUJ9LuhFdLtkEMyBOig8wj9b27u9TTn0DK9hhiSRnNmQeoBiwIwH0
	DgH6ws7ge1DRly8BDeG7NXmXsmCoaW7RowoAjl3FmL5aPlprxvLrNpKsjHn6e0qt6lD8sT4NGco
	SBXHYG4n4dFSyEKSAIqN4x1m+bmAQitarS+5TgRbENBz7KRs8=
X-Received: by 2002:a17:90b:4b8f:b0:35a:189b:43db with SMTP id 98e67ed59e1d1-3664c8dc391mr3471558a91.4.1778257767538;
        Fri, 08 May 2026 09:29:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c119fdb6sm267213a91.3.2026.05.08.09.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:29:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 8 May 2026 09:29:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	"Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 1/4] watchdog: rzn1: Fix reverse xmas tree declaration
Message-ID: <dc7b42b1-65c7-4fa8-a001-931df263cb96@roeck-us.net>
References: <20260507102410.43384-1-wsa+renesas@sang-engineering.com>
 <20260507102410.43384-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507102410.43384-2-wsa+renesas@sang-engineering.com>

On Thu, May 07, 2026 at 12:24:06PM +0200, Wolfram Sang wrote:
> From: "Herve Codina (Schneider Electric)" <herve.codina@bootlin.com>
> 
> Variables declared in probe() don't follow the reverse xmas
> tree convention.
> 
> Fix the declaration in order to follow the convention.
> 
> Signed-off-by: Herve Codina (Schneider Electric) <herve.codina@bootlin.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied.

Thanks,
Guenter
