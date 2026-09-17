Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061F30594E
	for <linux-watchdog@vger.kernel.org>; Thu, 17 Sep 2026 00:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789604604; cv=none; b=Tv3FDTgE8xgdTbbwYVwxKkSAM2CVEjcphi1+D5LIo3A1TUTqha8ZRgEQiku/LY8jQ9o1LAUGfCVtcESEvp8pEmVEh7wSjs2lMTDuc2kSAZmTp5wIB5c7lrTI+Td4MjSfSRmYAVVeZWz9AIfxNcjHZmZCVpmHz7LreXBThKN+clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789604604; c=relaxed/simple;
	bh=fRTzk8Tsb9XbfrKN9MKNP5cRdfgkEgmvGrInVQyVVVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5rhgGDFe+6FZ4MlxxSyy+qV0trSyUCxyDDtxoW6umlKaJ+JzqGHbONSrbobQH6wcoNPVi17XrnlgHbjwFn+ZT4hal/iFrfSUBRyV2uwwwW6tVB1jeroUHmnJTUnWOA5RHWVVuklswfJwLwlmO3UfckMn+IN4oWJyJUaDLN5MKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDds9EFs; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDds9EFs"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so129680a12.1
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Sep 2026 17:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789604602; x=1790209402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V5+rr2Hz7pYNSHpXmMkjUXrv+pPNwAt6cwic5RLRtWI=;
        b=VDds9EFsIgX/qQumKnEbJ+screFroIx8SMDPS1oLDdIhyKJnsSQFruc0R59d1otYhP
         p3fkkc6oIHuwO62x3bAiLktcreDgo7tjFe5/woQX068LhKP9PZ+5DOWROZ8qomLRs0Mz
         ZDNo5TShKZpUUE+hG+b4jy5R2ZgW1gJ6c9Uyo3zbxlZE2v5pJiTXOUG/Sj+zTWTKBm6G
         fh5+XGP1HMqCwqakswJfAVKbOcRDqYCvg1mm42nLOsfjh7FO0NQM4xwRn1/P/h350G0Z
         y+A0AjsWvmcO/zIJQEcLPNlD5F251fHEDdEgyvCSIiMg4It4x8rsCJl2Y/hZQCQjy2ou
         4mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789604602; x=1790209402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V5+rr2Hz7pYNSHpXmMkjUXrv+pPNwAt6cwic5RLRtWI=;
        b=vB/GawpO9+xNY1o7US7cHLigvzIf4N3wJSiOGBQ8mJPLsUHH/HXtd6nyx3ks2touJE
         xxTUMofADMYZeB2WGF0s5qzOMNP0vrFTgLjLFRtEdtuYU0DmUkPKPeuRAChMixRdV5So
         vr9TDUTbw8LU3JRDDKrSoKwSCkq9NjpwKchKooPPyrf1sWoCJ6TjVZ2vKx0tGPfUbYp4
         V3bYXGd4piYbEJ9H5y/T9LoQdR2/Gx9A0AysVIswF42Nf38sXjKywa5KzJDTpbhPZ/yO
         BzUrci6XMtkIPkTnA+iya9kgU76/dlXCpPGPXN9flcmJEEi6esX7pGtXBumurDSdUp89
         4rew==
X-Forwarded-Encrypted: i=1; AKwUvBwoptX6k+DwqZCpeVRKAMxhxGBgEqeEJttNtpzrosH6NHsEWyCacpbk+Sc3h6zxlFe3MU5YHvrHO/WwUUlYoA==@vger.kernel.org
X-Gm-Message-State: AFuF++lZxzev45P/pqXyOR+X2xnMxSgRua0xzmhW0bSpnhi9nnMomLtc
	KA9Hr+FXS/3bDGI7uUM5dM/tSijSjrtAVuug2qeP0krTtuqFdlS+xhd7
X-Gm-Gg: AYBFou1NlIB+wD/oHtzOjaYU6SACpyDgOTiB61fJeFAQ7qHlyjtD8y3fdu8v3D6gNeT
	mks8d0ZDIcXdogSkZ9dS8V1Tgo/Mc7ZM1kYsPwiTAM/sGqDq0P2prsOqk2pTlS3UNruy32CYuYF
	juMC3Fr3x79jJEYXPGU21GGGFZjUsH7mSJ8PBOR/Up7Ne6pGnDKvCRdgcoCNOd/ept1MUl4lSPC
	usjALhfLelF+PCiyFPdwVF+ZprYzcQoVxGcgCYc7q23PBCISHjx6hNtGjPbr6ZtEuc95KGyHuPg
	ZCZ+LbOQdlAK1gs8XPp78dH/FU35vch3r4n7oWkKH4+agPksO1c4I06SyUzQekb/MM+TC1aRe65
	i6gOHK+EHafMffDHd2wPhRKeG4/vadJ/TBMlw2I85otVir/VsCNa1apdekOkGgxxF3lct2gtnrq
	h1W48Hdf/6jjrFcZbNwVxxi1Y/Si4qNnBTkZp+rW79x96QkP17m0K+hWIZyd52tlT8qFZLPsCtU
	08gevtRW2tGVAljjOYwBayK
X-Received: by 2002:a05:6a20:6a0b:b0:3d3:ae1f:d7f3 with SMTP id adf61e73a8af0-3dd5f73ef30mr11625223637.19.1789604602016;
        Wed, 16 Sep 2026 17:23:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab7776fsm2280282a12.14.2026.09.16.17.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 17:23:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Sep 2026 17:23:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cong Nguyen <congnt264@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: shwdt: register device only after full driver
 init
Message-ID: <9c91a7c7-c6ff-4002-b2e3-ce609ed2401a@roeck-us.net>
References: <20260914123609.2186477-1-congnt264@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914123609.2186477-1-congnt264@gmail.com>

On Mon, Sep 14, 2026 at 07:36:09PM +0700, Cong Nguyen wrote:
> sh_wdt_probe() calls watchdog_register_device() -- exposing
> /dev/watchdogN -- before timer_setup() and pm_runtime_enable() run. A
> start command landing in that window calls mod_timer() on an
> uninitialized timer (NULL ->function) and resumes via
> pm_runtime_get_sync() before PM is enabled.
> 
> Move timer_setup() and pm_runtime_enable() before the register call,
> matching the order already used by rzg2l_wdt.c/rzv2h_wdt.c. Add
> pm_runtime_disable() on the now-possible post-enable register-failure
> path.
> 
> Fixes: 8f5585ec3d17 ("watchdog: shwdt: driver model conversion.")
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Cong Nguyen <congnt264@gmail.com>

The other problems in this driver make me wonder if this change
is worth the trouble. Is this an actually observed problem ?
Because if not it would be better to leave the driver alone.
If this _is_ an actually observed problem, the code should be
rearranged to depend on the watchdog core for timer handling.

Thanks,
Guenter

> ---
>  drivers/watchdog/shwdt.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
> index 719f100aae60..c22b8e760476 100644
> --- a/drivers/watchdog/shwdt.c
> +++ b/drivers/watchdog/shwdt.c
> @@ -263,19 +263,20 @@ static int sh_wdt_probe(struct platform_device *pdev)
>  	dev_info(&pdev->dev, "configured with heartbeat=%d sec (nowayout=%d)\n",
>  		 sh_wdt_dev.timeout, nowayout);
>  
> +	timer_setup(&wdt->timer, sh_wdt_ping, 0);
> +	wdt->timer.expires	= next_ping_period(clock_division_ratio);
> +
> +	pm_runtime_enable(&pdev->dev);
> +
>  	rc = watchdog_register_device(&sh_wdt_dev);
>  	if (unlikely(rc)) {
>  		dev_err(&pdev->dev, "Can't register watchdog (err=%d)\n", rc);
> +		pm_runtime_disable(&pdev->dev);
>  		return rc;
>  	}
>  
> -	timer_setup(&wdt->timer, sh_wdt_ping, 0);
> -	wdt->timer.expires	= next_ping_period(clock_division_ratio);
> -
>  	dev_info(&pdev->dev, "initialized.\n");
>  
> -	pm_runtime_enable(&pdev->dev);
> -
>  	return 0;
>  }
>  
