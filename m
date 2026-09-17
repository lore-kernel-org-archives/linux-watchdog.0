Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80692DB7BE
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789605927; cv=none; b=MXTp9vhwctyjkQDsvOcHIiBtmxvTZwtUyv8YmbuOfBOjwwYpnAjEIiJyovaOh5ADDJjSO1el8uusNGkA3bivjzVS9mGCTYhrLf4+vdo3wZwETZAUxvPWtaxBqjjZUw55TUhOd0kBifXH1CaAK3VGof9FHGPgopLQi/g5KKUr120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789605927; c=relaxed/simple;
	bh=pSIUYIx+0OkhedIaRJFFytc27jwrdIPiXSe8d8kKDuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSLovZ98H5Uh1pHbMsU6MgjFUDPKt5Uim2z71EpIdhJrc970pEy3DkGwyxbX6y5vk+mQot1x8sOnIyRxtDvYlEOPGD/38Ju7Hhk5RoOaEPJ0syXRBm3LMrwErdpjYuIUBDM2h5AJK5plF8nvvYW4vr7uACynEBsc9rS1TCzxHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku1amnl1; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku1amnl1"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8674704dab1so349700b3a.2
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789605925; x=1790210725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vK4WS6l3ITRV/oYCqfxSRTjx+VRSZj9i6Ex84U5fmjM=;
        b=ku1amnl1rOi/dNSYnVA2p0mOi5pzTP431ph81+tN5amFHqXTbk8mwhBTq+LNgqYuqJ
         mTm12WgP+ZSQ1NJSanS892fNSAzKxxX5qg6g32LJXpbUr6G6/FaGQSW1V/js+81J5ArG
         9Wl5iERzDpuqkqpStr4tPKIYYaeWaMcpG5hKwZF4Ta8YmkRz5NJ+rYV8NRJiHfoQpft3
         1uFgP18qMuenlIGSrxzB7vFj68kXvXXWtS998CsB/ceoih1kR+IyAeuS+dSKtYbfWXnO
         pJvJClVR9xWd21s+lgkLAt94hAdoDOYfCWgm/A09AF/LhF5RXA3RgYsWobfw4VGFtK0m
         ZRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789605925; x=1790210725;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vK4WS6l3ITRV/oYCqfxSRTjx+VRSZj9i6Ex84U5fmjM=;
        b=mzKYUKLLTzJDiKaLWLkeCm5QMj8Oh5D0rQ+3STtPZnzAtiU5q5M1Z/Qk5pM4q8NW6d
         aIkxJ8L2ICOJWvxoiDGIep8KLekZOyKDLzE/vmP4iAbAqLA2urUzz8uHiw4IuKg2mTGG
         g2nHKqlTY0iRu8ZEdfeJcODSgPG3ZrtC1pbQruIJs2ZzA5JB82dJTmwVyHFrUJaBbAza
         +ciqVr8oDFdq5SnO4KP2KhWYVemczLCSTOGpfH80Q6Tm4Vv4Aob5qcy5ewszCcvO8rnt
         h8PGvzRfXjq7ooZ7uBnxDr4JeFtXdgvlP26o6QFp+TKBW0OS2enCVG7tsZsDjBEycEZB
         BAQg==
X-Forwarded-Encrypted: i=1; AKwUvBxxuyQqx6OssFr8gFVbICLDeUfvSlPKpjHG+8V084tej2+c842dHJv/eQnMh18qzay7fcckDutLKJ4KW/iLPw==@vger.kernel.org
X-Gm-Message-State: AFuF++nv7GNt1G41OfWEGnQf3tAR2KYPUSqfjeN/erqHzQmqSKCFu1L4
	E/iz4ij488yfRyd7KPXzSEI2MwbtmpKFFauyYHQfZbJgbOkFQ3DNmRbA
X-Gm-Gg: AYBFou1ft4LPpN/Wu5tZgQ/YXBcYwRDogh+AMpnxV9GZoKo45KUAEMb6OSG9x4rjFEK
	/87F6jY/wU1uDkE4UJW37Zp6+mvcU3Fzuopf269KRGvCaCSZDHRqH//0E/MdmbCDerexIux3Jpa
	/Qx0dFtRJmU2Jm4Ni0hnw7BVvpBkR4RW/BpkfYBbduyIQfPcf/kAlUszhJfQ95S+Jz2+Q9zs7il
	OvpRKONLPXDGbbyL0Lb2M0G9h8a+kCXBnf/ypXrGGWkbZ2Eco1W3cw0k8v+vybxk4Hb/6hEaqb1
	FEmd0BqI5smG2IJo5v/31W6iz3LP/nTqLGm5WuR/aodDOCW/PDOFD+48p/VAsM10PXcxRVcT4ER
	EtQoSYo7zxCQTJvg8JEMoLxPJ3GF1EyG9KymkpCd3A3bwu4vvcXNUaMNJ1O39pkzmVVLNAjSU+f
	OlS1w567mKdxdPwDqj0nZUSnzlxV7Q5KiTntQe66hamy50rKUShIm/K9pEe5MtpUFiWhoAD8wMX
	cqc5x5DE+22
X-Received: by 2002:a05:6a00:4613:b0:851:c2a6:172f with SMTP id d2e1a72fcca58-8723b87eadfmr9178684b3a.7.1789605925335;
        Wed, 16 Sep 2026 17:45:25 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87201d1da2fsm1952194b3a.52.2026.09.16.17.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:45:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:45:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: emil.renner.berthing@canonical.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
	xingyu.wu@starfivetech.com, ziv.xu@starfivetech.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: starfive-wdt: Fix runtime PM leak in
 starfive_wdt_pm_start()
Message-ID: <dfebf1ef-0496-4b4e-acbe-847064bf09e0@roeck-us.net>
References: <20260916170704.2086331-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916170704.2086331-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 05:07:04PM +0000, Wentao Liang wrote:
> starfive_wdt_pm_start() takes a runtime PM reference with
> pm_runtime_get_sync(), which increments the usage counter even when it
> fails, and returns the error without dropping it again.  The watchdog
> core does not invoke the stop callback when start fails, so the
> reference taken on the error path is leaked.
> 
> Use pm_runtime_resume_and_get() instead, which keeps the usage counter
> balanced when the resume fails.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Applied.

Thanks,
Guenter
