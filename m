Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1725F3ACEE0
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988492; cv=none; b=rcV3g9PmZH/cpYZ40RORV8WxMvxkAJx/1qnqQiD9KPhuAeJyIBFwLnIvCgkTycwSBGJkkomLC3dVqQh2WTtFglEt8DwJ94SHOTz7V1cc+QT68LAni5gw30Qcud6cPLUV076MX/5FoRRkMPja8fUNwKGt9E7V7lsM6bogTmJpu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988492; c=relaxed/simple;
	bh=MnEDALe6uwOaXe/sMQyhmeqQexZ0FL6u6wwzWWIRwuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7aWLQHgnorjvZxSvBtObhnadOASicUOHlCd4+C/HPhFGYHQ+rpzQnEk78GwvY8EHSxmuaGHWcM8Z8w0yuJVtdHjFoVqwMi5lbFIBx5OwLRSnWdN2ib45ADfYQUJz7n5Jj8+06oQ6UjaWKu5yf+MpBKsUGzO4ruSiZhHFIXMMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnw1bVAa; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnw1bVAa"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa0220f2so554388a12.0
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988483; x=1789593283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yxgxA+Z3MXKBfp6ZxROey+7ykV72GFbg4Bcj0PBfYIk=;
        b=qnw1bVAaD2BRxJaur85L8eho8U1QSX2kgzNHSlYg+1wsNIElEhl5x1euBbrIwOgeUM
         N7Fuo3ZoEF8f4KA0bo2rsjLGBDCxx/ftiamvGvuivwuoZ0G4jcCqMeOFvLmy514Q852x
         LEOR7nWm8LTKHeq9rBiUX8Mkdjgk3Xfac3ln4e80+s+kd2l/YIZHK16EMJnrUu5NVLhq
         d2W1qttEzEqD2dbRxPkbwmbsXMBoQRr4UvsUrWbUZURbcTN46in4RklMyObnh+/Vi5JF
         tKeQVBAr7Em3ewzMMLEORMSylKKd6IN/bsJtSCxYsj6E4DuhpbVkq3ZZkqqlVyQA5nhU
         m7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988483; x=1789593283;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yxgxA+Z3MXKBfp6ZxROey+7ykV72GFbg4Bcj0PBfYIk=;
        b=d9SNdswqVIMjG00e8+xMlUv64aSK3JA3QvWtRzI+ltGPvjV6H8Dds5RVGTU6yx7a9B
         18419cRqloc7eKAbkS5jqJnUF/y9MnOFOwsafTslOOtbUBmJvdNg7VZFaWf2xuqwK3Xt
         jYBiM5jq9ovRZmSQXybB7NN3xELMDTiAnE7IXaRDHIRbUYfKG001SGCXAipxtvjPYAzL
         ZajJN0GZ0jqjkdHUGOkRGNzRzRMTRJ4B5E4SrWh+ccELBeyNQLtu1fi7OEUUwg1aqUyj
         PrTOH1n86zN/Gs6ghWzaj7TXBMJdmnKZF3gAa8JNBRJfeV/3PkVRWEDU169imemp4csN
         6EnA==
X-Forwarded-Encrypted: i=1; AKwUvBxDmFjOURkxrKHuo9OQBTbag8TX1QTF22azdC2am0rMuKpPjDy7NxwenWcLYq86rnSFc/BYehI9P3kQYUDMHg==@vger.kernel.org
X-Gm-Message-State: AFuF++laEhAu8ShJBqycrlZEflK5bZirTsMLMqN39Oe71Pz6mtMsZU5k
	6G889cVPqaxCd+AB+JmSWrfejs/nvBb3WLugM1TMiTzc/CI3ypX7nvtQ8NGvrQ==
X-Gm-Gg: AYBFou1bPzckf/0JOn6m+5iPQUKf8T6EooryL/ylEw75w8V9ZeyMWCb+Tiw8Sr0Z9QK
	LuGlb1x0MDyR9F9dhzXRdPSfQfrOdHBQ7XkMAxp04+8pzCFIRnnHcSs3PNHW7nPLtJKQjqSi4hu
	MaXEC7yZ4RyuZaJYS0R1AOlqaWoigDB+FhNaHKEzHKc7soxfUDHffKKg55RP6L5EfkYjXh+nTMk
	UfJYzKU2xLnx2msd3bJNDMGNUE5gClxXRyXaVzPbAv8rnQ5qaixKDu59SRTeQAGu+ILKmiESXfj
	NsazBg8kCzTtKCgFpLUJy1kZaQEfHElNvIShhUYNAlNN2hsg3GEsrfy0be6B1oe6qQ4Wi1EFA3b
	SHMiZAEq2yIdNqg5U1+uPnGNsLXtx64OkQsmYm5Gh4WM1I+bxWwnGmgNYOyub39wa2qBpQw6CQK
	PUNqjl/K3J/TvncHjLMF+QnyJQDLhQVR2MyM4bWead13sBeZ9gSQvDlZByY5k0sMMtY29nOXn7e
	dUo2JFRfkg7EZ2i8E9v8Ic=
X-Received: by 2002:a17:90b:4c86:b0:395:5f43:4ec4 with SMTP id 98e67ed59e1d1-39b25f78ab8mr52972022a91.0.1788988483245;
        Wed, 09 Sep 2026 14:14:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d770e39c1sm1379938a91.6.2026.09.09.14.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:14:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:14:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] watchdog: msc313e: Enable clock before accessing
 hardware registers
Message-ID: <d9e501d3-53fb-4ec0-b63a-8f86566fd838@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-5-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-5-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:43AM +0800, Tzung-Bi Shih wrote:
> msc313e_wdt_probe() reads from hardware registers without ensuring the
> required clock is enabled.  Furthermore, if the bootloader leaves the
> watchdog running, msc313e_wdt_probe() sets WDOG_HW_RUNNING without
> increasing the clock's reference count.
> 
> While the clock is currently supplied as a fixed clock by the device
> tree (`xtal_div2` in arch/arm/boot/dts/sigmastar/mstar-v7.dtsi) which
> masks the physical issue, this still violates the API usage.
> 
> Call clk_prepare_enable() before reading WDT registers.  If the WDT is
> running, leave the clock enabled so the CCF reference counter is
> balanced.
> 
> Fixes: ffd264bd152c ("watchdog: msc313e: Check if the WDT was running at boot")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied.

Comment below.

> ---
> v2:
> - Fix a clock leak issue in the error handling path (Sashiko reported).
> 
> v1: https://lore.kernel.org/all/20260827044700.554333-3-tzungbi@kernel.org
> ---
>  drivers/watchdog/msc313e_wdt.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
> index 8ce24df8e338..7c4593566781 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -108,6 +108,7 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct msc313e_wdt_priv *priv;
>  	unsigned long rate;
> +	int ret;
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -133,9 +134,21 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
>  	priv->wdev.max_timeout = U32_MAX / rate;
>  	priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
>  
> +	ret = clk_prepare_enable(priv->clk);
> +	if (ret)
> +		return ret;
> +
>  	/* If the period is non-zero the WDT is running */
> -	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16))
> +	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16)) {
>  		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> +		/*
> +		 * Keep the clock enabled. The watchdog core will skip the next
> +		 * start() and a future stop() will balance the CCF reference
> +		 * count.
> +		 */
> +	} else {
> +		clk_disable_unprepare(priv->clk);
> +	}
>  
>  	watchdog_set_drvdata(&priv->wdev, priv);
>  	platform_set_drvdata(pdev, priv);
> @@ -144,7 +157,13 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
>  	watchdog_stop_on_reboot(&priv->wdev);
>  	watchdog_stop_on_unregister(&priv->wdev);
>  
> -	return devm_watchdog_register_device(dev, &priv->wdev);
> +	ret = devm_watchdog_register_device(dev, &priv->wdev);
> +
> +	/* If the WDT is running and anything goes wrong, disable the clock. */
> +	if (ret && test_bit(WDOG_HW_RUNNING, &priv->wdev.status))
> +		clk_disable_unprepare(priv->clk);

Curious. Does this mean that Sashiko complains either way ?

Thanks,
Guenter

> +
> +	return ret;
>  }
>  
>  static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
