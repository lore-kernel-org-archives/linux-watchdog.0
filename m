Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2BF2EB874
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507545; cv=none; b=HH0GYEbA2xnAoNoSN7KN21kqK6+vm1mz0qOp1aCE0U3aRkAbwDItq/0tktoucBxJQDtDW/LAHflEjAzjwv4dyVlP3mGaRJN0SXmB9rnlwMH8OCqNnoSnbF5vi1XJo3AExPMblDcf3QbSpnR9O4sahD73qKeD09ZPCYiff8OcnZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507545; c=relaxed/simple;
	bh=qGQfqnawWpbY+XpHbq61+Pa6BFYANsxyv4TEz4tj5Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y13WtTY4J96MI5gJ+A7Ij2t9PGVUtQDiiJkyU9HUgiBcNaM4TNXbUbyNJUMSPDmQ+DqhtOhmfwI5CGpMKLDmZyjq3I1T1VWg6AaUDZ8HELIJCVMZa/ZtDzHdHNJdtWaklCWNTPuQ7l3p0kT7UfSgmKL06pmxVRG6AWuvojPI9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gxxj2Acv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxxj2Acv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf50c6f235so11291135ad.0
        for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785507543; x=1786112343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fTYBSSPgB/XegWgUFYA7t76lgdxNVuQG5kRcXDSKizY=;
        b=gxxj2AcvXEQGpXlAcxymx/JXDWlZsYmJglxVR+HGqXARVLnZtgjt9tCJczHg8lu6NG
         Fya95z4gR67qdag8HZTXwNsu/oZZWzWDFWn6U5b1mqqKmCXmjB4+ZY8qexSUHchfxScp
         UlAZQmSflwjm5DDhSUc/xBdnOCcDzK+1bzeGm012PoiizFT1bp8XG6vSFUwK50ucR0DY
         lsxsdlA6MTWeo7eL2l2KhJoLuJYQdWWfKSYQz+2VY9PVAo3d96an9A1VIX+qAhlk9Gvm
         5qRfX85gApOLrkRZph5yBxrgqmb+Me1fzV++MYj2oLcy4sdcLzoqtwxxaelCMZJ34y+y
         yiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507543; x=1786112343;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fTYBSSPgB/XegWgUFYA7t76lgdxNVuQG5kRcXDSKizY=;
        b=jAcdcHoJcy/Lhdk9Rcvx4I7OMBQ/KRCZ/zMtfAS3/8CwoRTbxAYEdI3NbbqhmH829b
         +aPyUklbKZ8yy+NrXdGVpIrCi3VcSiBAa1wormjtIZ1Fm12g9d20mrz5wiE/jy+wcC4u
         KTdjx0kYNn3Z1Gt1M3Jo5QDPqR9kIX6UXXVsQtqmFWLTseeUXwbweIU4ap8U4rn1wqQ4
         UTyVC1hZIpc43m8owII+f+mMpOhSqyfjjJ5q1fPz06QL+UppRipHUCvtITchOqgNiIXX
         pLYXW5yy8NJ93stNUJnjlR1YF5EbauSuWYitK0yJ5kjhgsh2lMFi43+Y7GO8KCFUwiSJ
         RY8g==
X-Forwarded-Encrypted: i=1; AHgh+RppMfKeCZgA3cUmnUtBJUrgJYCZqckjcVzOuH6t39HRehMccFrXmowfmskg9Ks+/dAwXmm8SfbMiNp6tZTOqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuwc+qsNL9560f1+eNORsn+pDsAZZHgonYFc+hdmayYX38I1nG
	abQyUVHKS92s9OGK3ZJBCU3XPlJAU4qmL6kVqvzreb/jj5GqKEVf0nBo
X-Gm-Gg: AR+sD13hsdI2PxPqyHvN8E5T61l6+PJGr3uKBhBCBwGkbG0OI5qhadxzOZM86TEdAlI
	LTuBRUe+ZTgfwwFs8SCeA0eArZdSxE2WCMMI2UJJcRfLAu3c6UyufZCG61qoGsqub9SWdV1jPus
	xDCL0nyCavCLfRhnhZtqsV0QbDXMlsHndlM8saQ52O0UvGMO7GFqQJ0Q7SpelVnKmlp8KwcYCev
	mCL2SZisELgPiRS5EgUl5i8eNkfl4paYGxhyY9BxwBK7wHSy0K1uuWoL4lwJVZwzMIdq0Uc2l1H
	oUEf5WbhNesuLmP4tpQiYDlR51cZGq0WacWTn0B0Faf263ybZT9Y7UjKpmPfLsPlMdHqO/yENT7
	AsoZDsTM18rFyg+S0okGR+Xa89ZpvgRAam3U75nrZmiVcQXyikHAYo8JbnaFfYeuTAhljG5OSXN
	itB03/V/pfSY5e83vbT2Vgc2bcdJE9pc0SRq9Wv4ln8kla3fSYUcxETJm1//kOTQCzeQJXld9RD
	XU=
X-Received: by 2002:a17:90b:2741:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-38fbc3e5978mr128907a91.6.1785507543167;
        Fri, 31 Jul 2026 07:19:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2962928sm760497a91.3.2026.07.31.07.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:19:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 31 Jul 2026 07:19:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: bd96801_wdt: Fix timeout for enabled WDG
Message-ID: <171ccbd1-0a65-4ba5-ad63-16cff58d3977@roeck-us.net>
References: <amxskHmQbi9v-8_l@mva-rohm>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amxskHmQbi9v-8_l@mva-rohm>

On Fri, Jul 31, 2026 at 12:36:28PM +0300, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> When watchdog is enabled at the probe time, the bd96801 driver retrieves
> the timeout configuration from the registers to set-up the heart-beat
> values.
> 
> As Sashiko pointed out at
> https://lore.kernel.org/all/20260722085819.495211F000E9@smtp.kernel.org/
> the timeout values are incorrectly computed in driver, resulting wrong
> heartbeat. This leads to devere problems if watchdog was enabled at probe
> time.
> 
> According to the data-sheet, the "too fast" ping limit is configured as
> multiple of FASTNG_MIN. Furthermore, the "too slow" ping limit is
> configured as multiples of "too fast" timeout. The FASTNG_MIN is set to
> 11, meaning 1.1 mS and "too fast" and "too slow" limits are computed from
> this. Hence, converting the limits to mS should be done by dividing by 10,
> not by dividing by USEC_PER_MSEC.
> 
> Fix this by dividing the timeout values with correct scaling factor.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 09dad69757b6 ("watchdog: ROHM BD96801 PMIC WDG driver")
> ---
> 
> Also, drop an extra whitespace while editing the file - feeling like
> that single whitespace fix doesn't warrant own patch. Just let me know if
> I feel wrong ;)

No problem (since you let me know and didn't do it silently).

Applied.

Thanks,
Guenter
