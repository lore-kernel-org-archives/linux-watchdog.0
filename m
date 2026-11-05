Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793891714;
	b=FZP9h5Y6r7/ZgIGFusUfBYHJkPaHawJ0qs82mRkEd9T7yyQt9sd195l2XAtg+/ccu1oP
	 XrnkstBBoAx5Jxb9j5o/Dt6B6kUNrRYkldFTlnW3PBjQZvkO3R2ylqKi8y23rqRnGDFTo
	 AwzXS8gRoWKhYJRu9tkaM2jwpJLLaKvr0rNQHUX7f0cph3a+mfJeTvEgQjmaGIdKW5KJw
	 ulYGsRQ2IYS6nXx1nMMy7h3EJwBanjZKA4+5YnRjRDHJfjo1jC0ri+E8cgJso3A5Jnmdy
	 VI96KdLAxluYJdJHUILLdeo+vckNJwR2UNPG+hnUJIGm1mOenjhae1M6ZqD8/7FcslA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793891714;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HhSLVqkns9ZxUcgZNCKkgXC8eHczv55ceNMLsyHM0Vc=;
	b=PTPhkUVBIIVsHrmaSWpM8Aj4WA22RwO7LHn7c3JPK6YBpe/q7cm8GNVGRmT/NzPpHHZo
	 NcQMBwJmbSJDqv534tMfJzBcm7ssC9kiSNRjZOuhkTyNEOytM/BX0iAvDoZ5RGgXuXY+N
	 7RvT+33CV9cTE0rsr8HATdtFTzcHMRjiuL8Xbq02F4LUQ8rV9cFQjYtlhKS1tjLdVohY8
	 2SPskCX1cn3OuhinAbytT8nCktAQFwqG+VW3LU3qYUNHJnk4mKsqnF6rXfb7k0Yh4iq+g
	 g8TZs3uTGkXHE8lVDc3WcQcqSQc0i0xMT3Ar0xNthsj2Dpq9tBIlTNiTkyd44GVUixg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KW16yf6/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38054606A32F
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KW16yf6/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8641F000C1;
	Thu,  5 Nov 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793891713;
	bh=HhSLVqkns9ZxUcgZNCKkgXC8eHczv55ceNMLsyHM0Vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KW16yf6/QTQGRPbBJLVdqkLd8nd/ca43Y1Zfh6078dPwiXwqTsw/z34//DzZDxi+9
	 TYiiIlRGHkM9W0K1BRwGGC+h6Kh9IobhAtjJV0HNUiSSxmTL+dwxhgOvVeoDif8lue
	 z8EBKkhlDdUyRhgT8qWqx2d5CGi8MzEaxI/ZsYRIDI4dnt4HwKpe1f69D647qtgrR9
	 uknnl4bsCkqcxNIlJoH8RVjrThbQbJytmxKSVt1Ft+gg+OOWurxECGSvE1Hhbxn/Kg
	 zMHxw9x4CMDPA2ByvQBclZIrSbcuk4pIvi2gGOkR+mrMM9GoKkLFvfIXDtwmUjjBmT
	 T/mjbaRSJmGfw==
Date: Thu, 5 Nov 2026 15:15:10 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 5/5] watchdog: starfive-wdt: Drop runtime PM reference
 before registering watchdog
Message-ID: <auydfozcvsC4yjR-@google.com>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-6-linux@roeck-us.net>
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
In-Reply-To: <20261104164445.3209560-6-linux@roeck-us.net>

On Wed, Nov 04, 2026 at 08:44:45AM -0800, Guenter Roeck wrote:
> In starfive_wdt_probe(), watchdog_register_device() is called before the
> probe-time runtime PM reference is released via pm_runtime_put_sync(), and
> any non-zero return value from pm_runtime_put_sync() is treated as a fatal
> probe error.
> 
> If userspace (such as udev or a watchdog daemon) opens /dev/watchdog
> immediately after watchdog_register_device() exposes the character device,
> starfive_wdt_pm_start() increments the runtime PM usage count. The
> subsequent pm_runtime_put_sync() in probe then decrements the usage count
> to 1 and returns -EAGAIN (it may also return 1, -EBUSY, or -EPERM in
> non-error idle conditions), causing starfive_wdt_probe() to unregister the
> working watchdog device and fail probe.
> 
> When early_enable is not set, no hardware registers are accessed after
> starfive_wdt_stop(). Release the probe-time runtime PM reference right
> after starfive_wdt_stop() and before watchdog_register_device(), without
> treating pm_runtime_put_sync() idle return codes as probe errors.
> 
> Fixes: 8bc22a2f1bf0 ("watchdog: starfive: Check pm_runtime_enabled() before decrementing usage counter")
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

The patch looks correct to me.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> @@ -499,28 +499,25 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>  		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
>  	} else {
>  		starfive_wdt_stop(wdt);
> +		if (pm_runtime_enabled(&pdev->dev))
> +			pm_runtime_put_sync(&pdev->dev);
>  	}
>  
>  	ret = watchdog_register_device(&wdt->wdd);
> -	if (ret)
> -		goto err_exit;
> -
> -	if (!early_enable) {
> -		if (pm_runtime_enabled(&pdev->dev)) {
> -			ret = pm_runtime_put_sync(&pdev->dev);
> -			if (ret)
> -				goto err_unregister_wdt;
> +	if (ret) {
> +		if (watchdog_hw_running(&wdt->wdd)) {
> +			starfive_wdt_stop(wdt);
> +			if (pm_runtime_enabled(&pdev->dev))
> +				pm_runtime_put_sync(&pdev->dev);
>  		}
> +		if (!pm_runtime_enabled(&pdev->dev))
> +			starfive_wdt_disable_clock(wdt);
> +		goto err_disable_pm;
>  	}
>  
>  	return 0;
>  
> -err_unregister_wdt:
> -	watchdog_unregister_device(&wdt->wdd);
> -	goto err_disable_pm;
>  err_exit:
> -	if (watchdog_hw_running(&wdt->wdd))
> -		starfive_wdt_stop(wdt);
>  	if (pm_runtime_enabled(&pdev->dev))
>  		pm_runtime_put_sync(&pdev->dev);
>  	else

Would this improve readability?

	ret = watchdog_register_device(&wdt->wdd);
	if (ret) {
		if (early_enable) {
			starfive_wdt_stop(wdt);
			goto err_exit;
		} else {
			if (!pm_runtime_enabled(&pdev->dev))
				starfive_wdt_disable_clock(wdt);
		}
		goto err_disable_pm;
	}
