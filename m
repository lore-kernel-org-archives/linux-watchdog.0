Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792681793;
	b=LTcrjq26rxBC1VpHITInf9QZAa45v1JHHusWddJ47e2l/D4xBfkgJE0qPJmY+CM/8c2Y
	 zEbkUmzgbK4jf0DI8vTCc5DnH/dfk6pjgl/vAvbmF7aLgzy3Y0VED2tAP3YnsAYQHJyjO
	 xD2v8JMtkB0g19/zJTww+ek3Kd4Lhgvj1jONrohT2DWyoVJ1vwUYclIpVzHHOwmt5wtHJ
	 mp5/dWGZIAdk6D/SumFtl7P10Om11cvY0HqJ2tEV94+uB6BJ0FdEz+uFg9wGAk9sf6k7c
	 dDCdrFAqGtwh53uY95sfH6/C3EyiALuQfpimCB8z4cKQHP/kDLpKfQ7ZX1RiNd8OIAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792681793;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J8GucFFt2SUKZd5ajHpdJB2lsv/eRd0ZaK/jdlnHp8M=;
	b=IJkmC3Wfl5dIrgvVAT7j7My5weyv/Wc8S6FCzos/Rwyl3mrOI76ie1YvPx8YisxtLpS1
	 4vfG3r9qYbymebh3PLNSTWm9WHXJ68xyFVPA5YsXkScKAvZ8XXFXXvxfG8RBbPc7cXtSN
	 UOYlVv21f4JdsiY6zYq7Eu5QH0YQ3SANLl6Eupoj37ac5q8RjlFgfh2sPC83CcvS+Vzcm
	 j19fCO4DwWydDAvRdABYx1M8YirSBOsWpGPu0+twxrNGMrYI9OVU/s5NBCq56bRY3k49d
	 NZ01cttLpgSulSHRps1zc3EBeGb1RtdkRMSRHFJMuj/8CC2ngOXohuDj7qZwleklLbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZS6e9eX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15F8606A33E;
	Thu, 22 Oct 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZS6e9eX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463BE1F01825;
	Thu, 22 Oct 2026 15:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792681792;
	bh=J8GucFFt2SUKZd5ajHpdJB2lsv/eRd0ZaK/jdlnHp8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TZS6e9eX+6V+mQGJBFYf9cZJts52Zfr72j3v98XJK/8FZmINRakub/RjGvDmFs/0n
	 TgTLS1ncmanEf/MZxxZF/vJB43uqTePPc6YTLcUqnIBwAvMgTf3a0gEww/q4kP4tBR
	 1VIDBVqvPtwHTELdGmVe1+7uPMLLT4HLSUhCx5e6DwbYqy8RhqxnRxvUechmPFbFSU
	 bT7093dU/GoFc12bbVuI1PAI9tJdeo2icpoSUrz29JBG/kzM0rab3lguYjmswlZOwZ
	 xycnrW7LcA7lREZdJnxfJR7q/+1HPcQOgD55svgj5Fu9JSQpNxDUQsfZq8cvnZf9of
	 rJBY86HemWh8Q==
Date: Thu, 22 Oct 2026 15:09:49 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Paul Louvel <paul.louvel@bootlin.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 5/5] watchdog: w83627hf_wdt: Add minute mode counting
Message-ID: <atonPYaCken3EItA@google.com>
References: <20261020-w83627hf_wdt-improvements-v5-0-90b226684fc7@bootlin.com>
 <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-w83627hf_wdt-improvements-v5-5-90b226684fc7@bootlin.com>

On Tue, Oct 20, 2026 at 10:11:58AM +0200, Paul Louvel wrote:
> @@ -258,21 +263,10 @@ static int w83627hf_init(struct watchdog_device *wdog, enum chips chip)
>  		break;
>  	}
>  
> -	t = superio_inb(data->sio->addr, data->reg->timeout);
> -	if (t != 0) {
> -		if (early_disable) {
> -			pr_warn("Stopping previously enabled watchdog until userland kicks in\n");
> -			superio_outb(data->sio->addr, data->reg->timeout, 0);
> -		} else {
> -			pr_info("Watchdog already running. Resetting timeout to %d sec\n",
> -				wdog->timeout);
> -			superio_outb(data->sio->addr, data->reg->timeout, wdog->timeout);
> -			set_bit(WDOG_HW_RUNNING, &wdog->status);
> -		}
> -	}
> +	data->early_timer_val = superio_inb(data->sio->addr, data->reg->timeout);

I failed to figure out why this block needs to move to probe().  It looks
equivalent to me while introducing a redundant `early_timer_val`.

>  	t = superio_inb(data->sio->addr, data->reg->control) &
> -	    ~(WDT_CTRL_MINUTE_MODE | WDT_CTRL_RISING_EDGE_KBD_RESET);
> +	    ~WDT_CTRL_RISING_EDGE_KBD_RESET;

Why this change?  Wouldn't wdt_set_time() overwrite WDT_CTRL_MINUTE_MODE
anyway?

> @@ -297,6 +292,15 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
>  		return ret;
>  
>  	superio_select(data->sio->addr, W83627HF_LD_WDT);
> +
> +	ctrl = superio_inb(data->sio->addr, data->reg->control);
> +
> +	if (data->minute_mode)
> +		ctrl |= WDT_CTRL_MINUTE_MODE;
> +	else
> +		ctrl &= ~WDT_CTRL_MINUTE_MODE;
> +
> +	superio_outb(data->sio->addr, data->reg->control, ctrl);

It doesn't need to set `data->reg->control` if `!timeout`.

> @@ -305,7 +309,9 @@ static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeout)
>  
>  static int wdt_start(struct watchdog_device *wdog)
>  {
> -	return wdt_set_time(wdog, wdog->timeout);
> +	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
> +
> +	return wdt_set_time(wdog, data->timer_val);
>  }
>  
>  static int wdt_stop(struct watchdog_device *wdog)
> @@ -315,6 +321,17 @@ static int wdt_stop(struct watchdog_device *wdog)
>  
>  static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
>  {
> +	struct w83627hf_data *data = watchdog_get_drvdata(wdog);
> +
> +	if (timeout > 255) {
> +		data->minute_mode = true;
> +		data->timer_val = DIV_ROUND_UP(timeout, 60);
> +		timeout = data->timer_val * 60;
> +	} else {
> +		data->minute_mode = false;
> +		data->timer_val = timeout;
> +	}
> +
>  	wdog->timeout = timeout;

Can't it just use `wdog->timeout` instead of introducing a new
`data->timer_val`?

> @@ -332,6 +349,8 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
>  
>  	superio_select(data->sio->addr, W83627HF_LD_WDT);
>  	timeleft = superio_inb(data->sio->addr, data->reg->timeout);
> +	if (data->minute_mode)
> +		timeleft *= 60;
>  	superio_exit(data->sio->addr, data->sio->cfg_leave);

The scaling can move out of the superio_* block.
