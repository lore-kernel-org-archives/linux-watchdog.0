Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD4E3C4565
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988253; cv=none; b=ie0KtBZAj5T6vyG5VwcZEwKIqNZ/wGYjdkxHPbZWroImyiO9XasWuOZJFoXDeITV3VRY4o/TnaIQjzD5IAzCB3QWvE303rJQRgtkuHR22KFLnSCb2khONSwT9QSC3NvCR73m1ifAS74hMJGHc0+7RJfiaRhrIREhpQc+XJxjy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988253; c=relaxed/simple;
	bh=Spjf6xqG2qfvbwK7Zr0ktdFO4xP0s4DHcL0CPQWQr/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+12pqwAAjJXqoz4Tw2u0tOdfA3n1ciQ6R3vo82ETCe9AQYeRzikUkhmjjZbqF3BVSwMBDBMqxUNlxvldiPF7QHPmHBypMDUTICI+Qt5tZ1BEGNa37OmQdzwmWSfwCFb950RMJG0CEr56lvcSAbkMJjzBs8lHBmLssK3s51Lu20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIJvOVNV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIJvOVNV"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso941879a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788988252; x=1789593052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5s6tbDh0gZouWp+8QV/C1Mblvi6uIzTsyYuZmljZJMs=;
        b=QIJvOVNV7sCE1YvcXsfGWKrtq8mUptt3Ppm9xsJzHcP1oR267eOn2BlpvWvmPUwWfY
         NwUehrTA1YFFE6u7n8zSjaPs6jX0M3OzVoCzsX/fmQSeNlrYbnP7AZnVX+vGumc2JoTc
         dEjWR41DLJqY/EuVCsdiNKPQZQlnSbLoii8NMBzoJuVOFOo5V8BpTiHNOUVJJeJLhgQo
         49dnjMvZdH9P3YnUdOcVhFAVabJGAsAa4nt7Om6sIlu0108NBH/jKboNO2EJvUbub1zt
         CbkNffXlTDWP1YkdvlMqwjLIKdcTcuHt3n+aqiYSO1YkVBxOOGd0arWKRiASUZEmt36D
         oxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788988252; x=1789593052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5s6tbDh0gZouWp+8QV/C1Mblvi6uIzTsyYuZmljZJMs=;
        b=ouALWBX6NXLDCve/ch23LdZ+DrhpnA4L9yl0SWa708Bc/+TUjMwxA3k3k6ZJgSoJ73
         K/E+yTIv7egGMJuk1H4sWW0NYQowBHJy8JKZgYxz4AkjZ41VXoQMVcAEb4oeLj3/7br7
         6Wu1gtDoowpNu3llu83YbcspVLK0rrRE3usYP0MrQkWhfIqSODFMgeLEsWwZI3y0TWZ/
         oC7r+zNhWBY0YrZvKLIxXGtouu9WqssI5YeQUTfyG71Pp+ZX4XM+K6gFqnD7px3N6jZH
         CaJdRQAAdappPngqKFetMkVY9Y5DbKxT+d6CcVCqYjA1La5HEbh9SdJJRy5z1XVNNYGS
         JAYw==
X-Forwarded-Encrypted: i=1; AKwUvBxZ0qRf+8vJm7kRdLr9GQE4gKG35L73aQyu1T69Q81rsAnetFwCIjFONd8i1azxz14QTL8ObRxClyqmdj8mWA==@vger.kernel.org
X-Gm-Message-State: AFuF++koAmoGH0ajouq/nvWhpVcg1a+8X9j/zzhulsPYMODO72loyvHf
	fvwLjsjcfBaXfcMGhhGInRMZGPfMXi6odi/80rj623sAXdFAieVetB9r8hlkiQ==
X-Gm-Gg: AYBFou2wda3iXwU9dIqe6nr3Eiyb6/J8WQttjcVnoEinoljAfJ3QFx7uibQQ/Xzg1zp
	9a7cU6I6eH1pBVCnrueIduF+AUGDpBwoSRhe1rSDR7jxggwmh4oZimyvFnybs7UX/lYM/9l/Koi
	aXZ24VQdn1sHzRCxhgBruEJm/yMQM4MuYKDfynqi8mW+v2V6XQ22itVsDJh3jl8DBVvGmJA3Q/u
	Qf+xujyj95zxSsvSypBZE2To7T81LM+jFCOq72KbR3O1rQB43LDUtarjV2++u76Wwi7Y0H9w87X
	a+Y0D9WZigPQib7Hn7bQcfK4G1OxlQw3+9+ZdX27HQdJ2MYmK4i2xQBGRwwLkx81L+9x/zZSpls
	Z9ijPHKSwz4wC7MQwTvhhboLfuF/J99vBeqm9cI8TZNhObKQTESJzq8mJNECa5vCDc0JUdRU4bh
	lv555JVUmIfwS70Lkn1sNjMb08YCJ33t6EsDRiXRMu70MDUF0fBDTXXJnzWcGcOV6jqPi8VNgEQ
	9uUUmqbZc7r
X-Received: by 2002:a17:90b:58d0:b0:39b:5622:d645 with SMTP id 98e67ed59e1d1-39d7743f69bmr933364a91.0.1788988251631;
        Wed, 09 Sep 2026 14:10:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d77122566sm1331358a91.9.2026.09.09.14.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:10:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:10:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] watchdog: msc313e: Fix clock leak and spurious
 timer in settimeout()
Message-ID: <23a329d0-f183-4efd-af9a-fde95a946403@roeck-us.net>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-4-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828161348.13212-4-tzungbi@kernel.org>

On Sat, Aug 29, 2026 at 12:13:42AM +0800, Tzung-Bi Shih wrote:
> msc313e_wdt_settimeout() unconditionally calls msc313e_wdt_start() which
> introduces two severe bugs:
> 
> 1. If the watchdog is already active, calling start() again will
>    increase the reference count of the clock again.  However stop() is
>    only called once, the reference count is unbalance.
> 2. If the watchdog is stopped, calling settimeout() will start
>    the hardware timer accidentally.
> 
> Factor out the register-writing logic into a helper function.  Only call
> it in settimeout() if the watchdog is running.  Otherwise, simply update
> `wdev->timeout`.
> 
> Fixes: e9800b799464 ("watchdog: Add Mstar MSC313e WDT driver")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Applied. Comment below, though.

Thanks,
Guenter

> ---
> v2:
> - New to the series.
> ---
>  drivers/watchdog/msc313e_wdt.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
> index c3018b970164..8ce24df8e338 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -31,20 +31,26 @@ struct msc313e_wdt_priv {
>  	struct clk *clk;
>  };
>  
> +static void msc313e_wdt_set_hw_timeout(struct msc313e_wdt_priv *priv,
> +				       unsigned int timeout)
> +{
> +	u32 t = timeout * clk_get_rate(priv->clk);
> +
> +	writew(t & 0xffff, priv->base + REG_WDT_MAX_PRD_L);
> +	writew((t >> 16) & 0xffff, priv->base + REG_WDT_MAX_PRD_H);
> +	writew(1, priv->base + REG_WDT_CLR);

I wonder if the write to REG_WDT_CLR can come first, to fix the
problem outlined by Sashiko in one of the subsequent patches.


> +}
> +
>  static int msc313e_wdt_start(struct watchdog_device *wdev)
>  {
>  	struct msc313e_wdt_priv *priv = watchdog_get_drvdata(wdev);
> -	u32 timeout;
>  	int err;
>  
>  	err = clk_prepare_enable(priv->clk);
>  	if (err)
>  		return err;
>  
> -	timeout = wdev->timeout * clk_get_rate(priv->clk);
> -	writew(timeout & 0xffff, priv->base + REG_WDT_MAX_PRD_L);
> -	writew((timeout >> 16) & 0xffff, priv->base + REG_WDT_MAX_PRD_H);
> -	writew(1, priv->base + REG_WDT_CLR);
> +	msc313e_wdt_set_hw_timeout(priv, wdev->timeout);
>  	return 0;
>  }
>  
> @@ -69,9 +75,13 @@ static int msc313e_wdt_stop(struct watchdog_device *wdev)
>  
>  static int msc313e_wdt_settimeout(struct watchdog_device *wdev, unsigned int new_time)
>  {
> +	struct msc313e_wdt_priv *priv = watchdog_get_drvdata(wdev);
> +
>  	wdev->timeout = new_time;
>  
> -	return msc313e_wdt_start(wdev);
> +	if (watchdog_hw_running(wdev) || watchdog_active(wdev))
> +		msc313e_wdt_set_hw_timeout(priv, wdev->timeout);
> +	return 0;
>  }
>  
>  static const struct watchdog_info msc313e_wdt_ident = {
