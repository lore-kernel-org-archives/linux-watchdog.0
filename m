Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35AB37F8DD
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371408; cv=none; b=BMhnBsh1i+zecOl2n3MJkVUHRHG8THg5iI1IMRA8ZrwccjSfcJOu7mO/8JavURtU3n9kV99B6jsIdtpzMail7klAfooEUYotLK38wA1UMauJY47CET5Lk80S5FSb8+wnA96zOfy7g/s0p7MEk4+fVwxooRxcR2Fw7JB78IC6F4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371408; c=relaxed/simple;
	bh=EoNxgc9KtzYoR6dP5gz3OiVtQzHtUZBri5ff853Uv4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUABmUF3WWrJWPZrckp6i15tXQ9Y9w/dLVNGfZCdauroTvMqX7e7pfWCCItNDGOhgHlE6us23zsh6E8M3OceNqPPEAJ3mnP6EUh6FyQ2QgHOmQXVSSHcplq1GMLnKrb2O1As86/eh8fUtlZNGn2Na7CJn4EoYbQcLCnzrtviSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NH8k+AXu; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NH8k+AXu"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38511175ad3so1801224a91.2
        for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 07:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786371406; x=1786976206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AyTK6GEN9WOThC9UrKPlxdUe4XgPNPIkc/LonxXL24o=;
        b=NH8k+AXubTI79PtKjSF8zx+W7ANQM1j90mmboy+rtbAWQBkpZQ88FFccFBClkG1KAa
         2JAW18aFdKDG/kIwhX7XtR5ic2meOK3hb//3iUHJdqo5aVNEzmsnFFZSNYMAMp4rjq25
         /XDnhg2utUEDWPQZ31FDO7+A+jQMg0GFMGyTUmpJoxiF0LeZWmFuKOzys3WKjaA2iQFM
         FJjTDA/1JqXEUNtzaY7hSVDB51FvLCZ2ZlFHeryI1ngEpg8AOcjo8AnCkpE4lJ9seo7y
         Sawr0c71zP9GiGqrNSXo7r90d6nazpoLTgVPX+vQJR9xkXEgJElcCPA3LkXscTuo8Gui
         qw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371406; x=1786976206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AyTK6GEN9WOThC9UrKPlxdUe4XgPNPIkc/LonxXL24o=;
        b=B/iFq0ffYAhE/EjW6C8p4AyEWUnvOVTLNiyYONR9rq9QWgpJrDAIRCWHolYLI2oPOM
         zaeBUVqQecG7CHExo1Iqaaz1jJB/xhQzPcDRltU7eEhAsaqC/ZcreCMU1BP6PKHyngNl
         MzuNjiOqyrMhYxw/WOS1N0uS776NQoSfTyt7M84x1sPtPTdNQkR2r0eFyXsF8OtGT4V6
         /t2L4TjI9dzG7eZV5kUMJUD56SkhWg9Nil75c44nLa1OZh0Sgc0idQWA5gj/DSicQxPY
         KEhAuZabXKlq0nmv54NoV9OdAPAsTHH+DZRthfri4yCYGwQ+yGMEpBVSUqNL2cYm4uKT
         Lnfg==
X-Forwarded-Encrypted: i=1; AHgh+RoGMbUKmXgusRvCKm7Ct5xNFe0bANwOQQxQPLCWJLCFcJkO1uC/jjctODeTYIc6D4ouSpyZJth36WPxJ9Dmhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4uHcjII8p3kBRqzmmgUXxMCkNcQfdJwMtaHnzFOGtkTr7QuO8
	/3SnmHph1D6tOGlDjfkFZ6aScmZtbR1UIr4u30zUbnYs4/cWzeGcHpht
X-Gm-Gg: AR+sD125in7E0JL6zv8ljcYQc4kmq17hB50fuu0u7D96nF6EwYKOsdcIwWvqbkdIRRp
	IrdunOT1NUmWHc57hSQLVw5sihDgK8S/QlornMuLZEc8AL7dz+iV32Kl0DazdsB91kjJfjMXF/9
	sH3YRu73pChBXbAkljay7772OlLH3fNYDq2dvx3qywCU++rCgSmP4CA/8T34i541G6Q8RL4BVzL
	X+AQQadDZqfvFMIOzgqTWmD+TYqbD2D6Nvv+VCIJHZiS1SxuR88AU78nIThO/THdCsUcTu71sWn
	hlXwv+bnFtdmDh8qOCwzTe6P3IAnTl0Z9qgweOeSWZL65AashZaPHCbsm120ItRAHZ9ePghB6WE
	uYTOY26Jyz8LOkfedgwAlVAdjQe9Mc/m//4wxNwxhA989hq1VwZBVD82d5K7HFOblFBs+Dtac9a
	gpIRLSouZK1cARMcl2iPQtvduOTC3awY7q20q5fXCvz4XbdMg96dbCphRC6GPWuabYZ0Ma7g8zB
	Q==
X-Received: by 2002:a05:6a21:2d8b:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3cc1a0bc45emr2856624637.3.1786371405704;
        Mon, 10 Aug 2026 07:16:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec2ec20sm51806975eec.28.2026.08.10.07.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:16:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 10 Aug 2026 07:16:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] watchdog: qcom: Propagate errors from optional IRQ
 lookup
Message-ID: <ed1510c4-7614-4086-9cd7-ecc5640dc714@roeck-us.net>
References: <20260810105101.55945-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810105101.55945-1-phucduc.bui@gmail.com>

On Mon, Aug 10, 2026 at 05:51:01PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Instead of only checking for -EPROBE_DEFER, propagate all error codes
> returned by platform_get_irq_optional() other than -ENXIO, so that
> failures are properly reported to the caller.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied.

Thanks,
Guenter
