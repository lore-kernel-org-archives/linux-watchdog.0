Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3D27FD43;
	Mon, 14 Sep 2026 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789365249; cv=none; b=k54oAxv+ii3jlNhwOodVYo/x8Z3Xj4te9o7deTBqpxy0Tas8GsqO/HH5hjKF+9+SGcLbnIoz1oxPzvp3CYhvSEL47mDbc0H5wEeVLrwsiScoDF+ikkOJTn1Saqr1IjVyt/xk8QhdMoimLvJReFZzmwtZ6461of+axNuJBVHX5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789365249; c=relaxed/simple;
	bh=kU3DjBXVPjnJithhh/EnnmDaRkjpkuJ1OIfEWmfJJ7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZZ+SzEsnwzfJWI0gQt47k03oUuzJc4V7PTYHvYyIHlyZC1EiApD9gKwaHRcLZhHwkueiQi79JaQyNcsPqunStofBZRt6WgsBWOzquHOjuzxIkr6IVRP7HxX37RqKrfKBuf0/OetNTIxOjKt3DTK79RXGRADu7DJNezJoa1KSXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=U2O5l5rl; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="U2O5l5rl"
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id 4220844083B;
	Mon, 14 Sep 2026 08:45:34 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1789364734;
	bh=kU3DjBXVPjnJithhh/EnnmDaRkjpkuJ1OIfEWmfJJ7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U2O5l5rlMnHBmr9HnKPnEK+cuO3n/LE3kssp1A2Bbb4bnh0bCZoADkx4V9cKvXFpl
	 YhcRLBAopfTNAQEA2Fbrywg42BF3czK1pmZX02Eq0HNBq8k5lcFwUb6lu66gE5g0ra
	 a742Y5qzalEWot78JwvKIAuFDnTCQ0H0Bag+HAMIH003BD9mErWWm4a2hcYYkn1pN0
	 AAAXS4HUPv/hANo3KmanQdGvh9BOUlg/kZDYtmBcy4MI2yuYVWkrwsA2Mcf3aneY20
	 PURpiEVGO25XO9H+f840TYy7rcKL+mp/dse3tjYn1LPxSUjwqNmuVAo5TGDHQ9jW2i
	 vlQjgzQBNtnnQ==
From: Baruch Siach <baruch@tkos.co.il>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,  Guenter Roeck
 <linux@roeck-us.net>,  linux-watchdog@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: digicolor: Avoid division by zero
In-Reply-To: <20260913064851.8239-2-tzungbi@kernel.org> (Tzung-Bi Shih's
	message of "Sun, 13 Sep 2026 14:48:49 +0800")
References: <20260913064851.8239-1-tzungbi@kernel.org>
	<20260913064851.8239-2-tzungbi@kernel.org>
User-Agent: mu4e 1.14.2; emacs 30.2
Date: Mon, 14 Sep 2026 08:46:03 +0300
Message-ID: <87a4pkgzc4.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Tzung-Bi Shih,

On Sun, Sep 13 2026, Tzung-Bi Shih wrote:
> clk_get_rate() could return 0.  Avoid a division by zero panic.
>
> Since get_timeleft() cannot propagate errors, check the clock rate early
> in probe() and cache the rate in the driver data as it is unlikely to
> change at runtime.
>
> Fixes: 336694a01dae ("watchdog: digicolor: driver for Conexant Digicolor CX92755 SoC")
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/watchdog/digicolor_wdt.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
> index 073d37867f47..de1a3267a972 100644
> --- a/drivers/watchdog/digicolor_wdt.c
> +++ b/drivers/watchdog/digicolor_wdt.c
> @@ -25,6 +25,7 @@ struct dc_wdt {
>  	void __iomem		*base;
>  	struct clk		*clk;
>  	spinlock_t		lock;
> +	unsigned long		rate;
>  };
>  
>  static unsigned timeout;
> @@ -61,7 +62,7 @@ static int dc_wdt_start(struct watchdog_device *wdog)
>  {
>  	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
>  
> -	dc_wdt_set(wdt, wdog->timeout * clk_get_rate(wdt->clk));
> +	dc_wdt_set(wdt, wdog->timeout * wdt->rate);
>  
>  	return 0;
>  }
> @@ -79,7 +80,7 @@ static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
>  {
>  	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
>  
> -	dc_wdt_set(wdt, t * clk_get_rate(wdt->clk));
> +	dc_wdt_set(wdt, t * wdt->rate);
>  	wdog->timeout = t;
>  
>  	return 0;
> @@ -90,7 +91,7 @@ static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
>  	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
>  	uint32_t count = readl_relaxed(wdt->base + TIMER_A_COUNT);
>  
> -	return count / clk_get_rate(wdt->clk);
> +	return count / wdt->rate;
>  }
>  
>  static const struct watchdog_ops dc_wdt_ops = {
> @@ -130,7 +131,11 @@ static int dc_wdt_probe(struct platform_device *pdev)
>  	wdt->clk = devm_clk_get(dev, NULL);
>  	if (IS_ERR(wdt->clk))
>  		return PTR_ERR(wdt->clk);
> -	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
> +
> +	wdt->rate = clk_get_rate(wdt->clk);
> +	if (!wdt->rate)
> +		return -EINVAL;
> +	dc_wdt_wdd.max_timeout = U32_MAX / wdt->rate;
>  	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
>  	dc_wdt_wdd.parent = dev;

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
