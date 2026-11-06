Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974896;
	b=BhI3FpPROM84VMGJIiSRfQIjaRDpxCIKEtROGUBQnaDWFREv9aGvS8beLOFEGcYmkFc5
	 hd9Ppr9b7hjlhflqc7v6xCGOBOSOz2EClJaAFpzU8TBvcIr9Cx6eBJ5h1kNV49cRY0//j
	 sPHouKnZbSSRw9X4IiorG4aoRtbyd0uDZQasP+LmrkYZpFRqUf8liTKcPue8ckbRYdqPa
	 W+fh/FBTqbVXHGYXQ1OwkdLzBDifS/omKPttUA65YlzlBWWOialAX3nBz4QDP42ctQzBh
	 yMm9a46X/hXbvuKOLxpVuLeC4L1WaEfCKbgvObb8dVSNQTHuvIwFdxs7uADS8hb45Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974896;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XjEV+leK+bMyQWHCPA38fubo4uyu5HT01Th78nJny48=;
	b=U5MWeA+UWWmFIjzyPZQbcK5iUzlpl+D3vU+3r6yOmLCOePijpKnS5RBtg6Tjca4ZAwPm
	 0oPPIkJdXlPYJQBhvbje65aWXcpm6lm1mtJLHgESRrajui74VdLuol937JW0WBgKj/SUf
	 xtS60boWBYuucbxAD8P6/ZTu02vaDiv2Tkol2pqjE6xZKmlwyDwZm4IrPxrqQPiTRschy
	 6FSMEO8pOKDDCvpvyESY9/ARH9ewKhnZs181sZLxEXMe46kLHeTvswCmGRIb7SNl0qgcU
	 90GN5L6HGew8ocHdpm3aolPB7wGuYjE7IszqBstYvy5D62317W3NxGUuRLwaTYveY7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op1qOOx9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6A606A326
	for <linux-watchdog@vger.kernel.org>; Fri,  6 Nov 2026 14:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Op1qOOx9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A0F1F008A1;
	Fri,  6 Nov 2026 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974896;
	bh=XjEV+leK+bMyQWHCPA38fubo4uyu5HT01Th78nJny48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Op1qOOx9Vei/lY2+r9lBrZAXrq2Bte8PhDALpu9n4Gr4M1a7AkCZ+F2lUtjDdZ4dU
	 sr1pglLbbxfeRQwfxW6V9GuB4N6c2xqNSiAuyERCW38/QWQPjLKvlQfacrwitLL3VA
	 UiuPJMnml5sDXMRjc4TSCJGUhCSOFhUEI51rWOY2pLbXSBL5dJYyWNmu/UHJCkfI7P
	 jkara57T7vcUSIivR7hZPZyy6OpduyjA2BF3sn4rgLQweZQKDTMeTfpc90LV8VMRxX
	 MGzxFEpDlrBHo/TaYNrfzxBXexaRnvCvE7GHZo0/Fiikgfcdmbf6AHQzkqWYOOfJwX
	 MuPhpCqe5H3bg==
Date: Fri, 6 Nov 2026 14:21:33 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH v2 8/8] watchdog: starfive-wdt: Avoid unclocked MMIO
 access in starfive_wdt_set_timeout()
Message-ID: <au3ibSdPUIKvUWNa@google.com>
References: <20261105190530.2371854-1-linux@roeck-us.net>
 <20261105190530.2371854-9-linux@roeck-us.net>
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
In-Reply-To: <20261105190530.2371854-9-linux@roeck-us.net>

On Thu, Nov 05, 2026 at 11:05:29AM -0800, Guenter Roeck wrote:
> Only program the hardware registers in starfive_wdt_set_timeout() when
> watchdog_hw_running() is set. In addition, reload the initial counter value
> via starfive_wdt_set_reload_count() in starfive_wdt_start() (preserving

Is the additional change relevant to this patch (i.e., avoid unclocked
MMIO access)?

> wdt->reload on resume) so JH7100 loads the configured timeout into the
> counter when started from probe or after WDIOS_DISABLECARD.

Is it really JH7100 specific (not for JH7110)?

> @@ -344,7 +344,7 @@ static int starfive_wdt_keepalive(struct watchdog_device *wdd)
>  	return ret;
>  }
>  
> -static int starfive_wdt_start(struct starfive_wdt *wdt)
> +static int starfive_wdt_start(struct starfive_wdt *wdt, u32 count)
>  {
>  	int ret;
>  
> @@ -357,7 +357,9 @@ static int starfive_wdt_start(struct starfive_wdt *wdt)
>  	if (ret)
>  		goto exit;
>  
> -	starfive_wdt_set_count(wdt, wdt->count);
> +	starfive_wdt_set_reload_count(wdt, count);
> +	if (count != wdt->count)
> +		starfive_wdt_set_count(wdt, wdt->count);
>  	starfive_wdt_enable(wdt);
>  
>  exit:
> @@ -381,7 +383,7 @@ static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = starfive_wdt_start(wdt);
> +	ret = starfive_wdt_start(wdt, wdt->count);
>  	if (ret)
>  		pm_runtime_put_sync(wdd->parent);
>  
> @@ -412,11 +414,13 @@ static int starfive_wdt_set_timeout(struct watchdog_device *wdd,
>  	wdt->count = count;
>  	wdd->timeout = timeout;
>  
> -	starfive_wdt_unlock(wdt);
> -	starfive_wdt_disable(wdt);
> -	starfive_wdt_set_reload_count(wdt, wdt->count);
> -	starfive_wdt_enable(wdt);
> -	starfive_wdt_lock(wdt);
> +	if (watchdog_hw_running(wdd)) {
> +		starfive_wdt_unlock(wdt);
> +		starfive_wdt_disable(wdt);
> +		starfive_wdt_set_reload_count(wdt, wdt->count);
> +		starfive_wdt_enable(wdt);
> +		starfive_wdt_lock(wdt);
> +	}
>  
>  	return 0;
>  }
> @@ -497,7 +501,7 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>  	watchdog_stop_ping_on_suspend(&wdt->wdd);
>  
>  	if (early_enable) {
> -		ret = starfive_wdt_start(wdt);
> +		ret = starfive_wdt_start(wdt, wdt->count);
>  		if (ret)
>  			goto err_exit;
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> @@ -575,14 +579,8 @@ static int starfive_wdt_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (watchdog_hw_running(&wdt->wdd)) {
> -		starfive_wdt_unlock(wdt);
> -		/* Restore watchdog state. */
> -		starfive_wdt_set_reload_count(wdt, wdt->reload);
> -		starfive_wdt_lock(wdt);
> -
> -		return starfive_wdt_start(wdt);
> -	}
> +	if (watchdog_hw_running(&wdt->wdd))
> +		return starfive_wdt_start(wdt, wdt->reload);
>  
>  	return 0;
>  }
