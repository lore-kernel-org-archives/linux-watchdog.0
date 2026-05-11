Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511753FA5CC
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508266; cv=none; b=BOrCDuGa6/GN08mWtkHCVWfjmMx0zos4/QBuBifLMNrc3ADUzlqDsRsTCZBRYOVm7QyV/fKTBK4CugN8qoHpCti6zzQTVT7LwVypStk8KY2C8yaDwXgGnP6/pZ50Rj57YscmzOS6oOx6HQbKcA4ASzMiLYE1utFMrTgVUq/5Ou8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508266; c=relaxed/simple;
	bh=AX1Zk6/eGznmnS4ph6+vfj8Fy71FvHX/m4IeROCTXqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcvKMlAtOmpZ0YaZy62MPH0/b4wqqab9508fb+xf6pEd5Kaqy1hqXoUigyduRE7Wno7EF4OsPU8wjbW7katJ+YCtaNv3rgKtSOKSvOBzYLS4OxscaPjMBdyI9oGP6+aE+3yvS0DieuQRstvz2Om8DW/Xmz2Kkp4AzcJcJCSe5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MphwHYF7; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MphwHYF7"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1329507c387so7380317c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508264; x=1779113064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iH3rO19odGUqCMhpZ/xU1p2BIeedWHGic3C9w+3oAVE=;
        b=MphwHYF7uBMd+p+rzVYJy9D+8E6+PWaXIzU6nTp/aUDak5+NqH9BW/FQ6gzMw6H9hv
         kiyvCnMThls2kHT1UX67ugnzVyilB7FZYUF1fjiimvyg9xsJjlMxHnxThvP9pj7FWXZB
         jtuagVvfhC06O6VIsk9m6Z1v4x9jnxXTHoG26Nt1+RSL66cSjCrohW5AWDODyl6kDHfV
         cwgvMv5JAZ5Q/MXpmwzE7KUw1DdQ2Zj0rUaQA5fqoq7FSyQtgrh9DFdmPC7UbgYP3LrM
         KXaC49VxDM2BjOtfF/aPAO2k0Lo1KSpEVloL/xu+YS8BiTFRGLGnYTQoKxre7b+3eCpn
         ccjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508264; x=1779113064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iH3rO19odGUqCMhpZ/xU1p2BIeedWHGic3C9w+3oAVE=;
        b=dNkF87lmQPbPb1C1VGAsl8rHZTJCkd0yf+hPTMEWXBAdtjY0mDjwMYik+ZiT2hdEj0
         IUP+gqGP0QbRblqc+AtISBrBMMcj57wp6U0sDg3DuiC1oY85A/n5saOlZKk328IIlRyE
         d7vOu6sKKTLjW7bEsrT6HYE6lzfF3P0RI5xc6bjsfPOR0EqkUohMEaAkc37+AIog7aWR
         GO812BgrkYbCiyYzr3LgdGkJnYDhLS3q3sX8mHRo8WY71d1oRI92xSbgGfl3RC8jDZs0
         CCf2sanNVawxtHD2JgdlC5d3lt7XGn+wKri3sT7hVdU3feVF9KqRcHtJkckIJ3YnQi9b
         GCaA==
X-Forwarded-Encrypted: i=1; AFNElJ8F5FUVCq34D8l8qEr2N98ZDDnwRVru+NrhXbj+3MA/CiajxSOtUFY+U0teRUDIM28+Nfphbc68Z3k7Bpt11A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxotLV+JXVA6kXqGisoWQm6XEhb+c9+SeE5uAu+6v0BnDANTLNs
	YLFFthq9hlKK/c3lZTGTqEhvHctlxoM5p5ZvzCqjupS53cyfbitdPwmL
X-Gm-Gg: Acq92OFD1VhvnUIgdeTy7EjVHFcHw5XXmqQYer2a/Hu7nrHOW5s2Q87DUeJ9CYNJrNV
	AnFW/KlXqlpAdW5DtKrTYfKBZId1S6em7pvI+vFzgkoXYXPHMSY/otS1QzPsa0h6TZOhSIZloR3
	KN+HlFfTi9JLn+Pgq1h5orPUUEURFwaCYSCBoRjRGOylgj9zb9qAi+wLX2M3I5uQckmC5/FPcon
	tgqew/j7SgIRMB9lJ57G5ORtiCekyL8uglb7AK9fEPTFI8MuWraG0FCJn0pcCXGsQQrjtW3ZWIT
	9vw5Wgqt0dHOovhvG9KRya0l0UlEaHYYLke6dqhROr2Ale31ysb0XeKXoGnPnfPXGD4z+KVakZP
	Wn32NfIToXvthqyueiU/K2RQru1G/qIc/KFM1cRP+jT7AfSBjGysXpCj285m6blcLRzzSE9DJzk
	xfHsMuSPuOBVGZ4dmxN9ulkUFFl5w2dDcveNUy
X-Received: by 2002:a05:7022:ea22:b0:12d:de3f:d844 with SMTP id a92af1059eb24-1319ce5634cmr12752150c88.39.1778508262863;
        Mon, 11 May 2026 07:04:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865955fsm18373850c88.11.2026.05.11.07.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:04:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 11 May 2026 07:04:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>,
	Wim Van Sebroeck <wim@linux-watchdog.org>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] watchdog: apple: Add "apple,t8103-wdt" compatible
Message-ID: <87766879-ca5e-44cc-a341-87b2afa70910@roeck-us.net>
References: <20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231-watchdog-apple-t8103-base-compat-v1-1-1702a02e0c45@jannau.net>

On Wed, Dec 31, 2025 at 01:07:21PM +0100, Janne Grunau wrote:
> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,wdt" anymore [1]. Use
> "apple,t8103-wdt" as base compatible as it is the SoC the driver and
> bindings were written for.
> 
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@kernel.org/
> 
> Fixes: 4ed224aeaf66 ("watchdog: Add Apple SoC watchdog driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Janne Grunau <j@jannau.net>

Applied to my hwmon-next branch.

Thanks,
Guenter

> ---
> This is split off from the v1 series adding Apple M2 Pro/Max/Ultra
> device trees in [2].
> 
> 2: https://lore.kernel.org/r/20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net
> ---
>  drivers/watchdog/apple_wdt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251231-watchdog-apple-t8103-base-compat-8a623e9831b6
> 
> Best regards,
> 
> diff --git a/drivers/watchdog/apple_wdt.c b/drivers/watchdog/apple_wdt.c
> index 66a158f67a712bbed394d660071e02140e66c2e5..6b9b0f9b05cedfd7fc5d0d79ba19ab356dc2a080 100644
> --- a/drivers/watchdog/apple_wdt.c
> +++ b/drivers/watchdog/apple_wdt.c
> @@ -218,6 +218,7 @@ static int apple_wdt_suspend(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(apple_wdt_pm_ops, apple_wdt_suspend, apple_wdt_resume);
>  
>  static const struct of_device_id apple_wdt_of_match[] = {
> +	{ .compatible = "apple,t8103-wdt" },
>  	{ .compatible = "apple,wdt" },
>  	{},
>  };
