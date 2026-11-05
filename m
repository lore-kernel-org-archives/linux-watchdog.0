Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886403;
	b=LEYPZhyjYOu8XSLmGLx6QTNznDaxE0YVIfJ9RD3F4OINE32Y64u7G/OZigM0ZMS+/0uA
	 B6WTasFuwHDQfvANyNqmR1tmPU0+4kscpFf7B5LcxWnipSpcOEgmTT4KFE677lVh5DW+O
	 nvffU/NGgAwQMXKFyZLA3/O1M2a88dcmqzCnt868ZIx3q7EWwygJWtzpywSylisVhwlz6
	 8TI2iRRzkGXaAkvWYxWwdmfAO8L1+yHk4v4Vd5zM88H7cova9kNyHyYBEKMdIYvF3TOKw
	 HTGjNzTBMEstS0eicw71Kmls49SM36rFBhb0Tnc/wEocvefqkNx0JxzhmGVGN7oJscg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886403;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yIcTQBvA/xYcgVd68wSbAEhfe0+I0WGXSyl3Xe9/bM0=;
	b=mDCzcKhsaNxLMUf7wP55XjMrsNTQqjX8ETlepxYOUiJVS3dI6j8n7uKKq/mtMjdN70uT
	 cyFKi9eLwjeeg5ewoy/qgpCD4IrvlTwsuPndLKs+/l/8p7DTagvhBkrbRkrv2pxY6E0L/
	 LgXQoHKui+Ui6LAUOZ6IH475M4FT/qJ6Zb18I1P4nS2fHuJ9GJgODwZC/E6spirVCWT3H
	 M/U0rwQG4OHQACFzBbgBd25onPQMoXR8ryZoaUZ8KzAoQ+oVhKFdwT9NStp2rKcbcY1ah
	 8TZH7chtfPkoUUgHH45n5RZb99t+LT5PNYA3jd7PWR+qn+sx0GD6P6vsM4rAwPnJ/Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5zhgGhp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0607B606A330
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S5zhgGhp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F5E1F00A17;
	Thu,  5 Nov 2026 13:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886402;
	bh=yIcTQBvA/xYcgVd68wSbAEhfe0+I0WGXSyl3Xe9/bM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S5zhgGhpQUA+zvpqQ4QiXqEQ2YLveC34AhcM0BP/hk5KHU3/izS4HjKMcYYl65mKZ
	 hRQe1LNyXSQO+JwJAHQN0GGPBEwDxtq3ess2O+WnxtPFleI1OX1chNnXNGLSjcxh6O
	 1yXaooeuG1LEu0BevTuCfSlSQQjESrrZ1PefauWv8VfCJHYm4HVrEMUc544tY2sGxo
	 cFQHzh7HbIK8bjMX2kEzIbLUis0x27e+mjgKTeMmXwGA72Qi7AIg5boUpniRAUhwSH
	 DDwwiArXKAXm5dNvnju/4ICR/VQAZwT1kDj+vI8sY3/b3DAZUvSZiN4R4yo2PsxhHh
	 AHU4EWRLySjsw==
Date: Thu, 5 Nov 2026 13:46:40 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 1/5] watchdog: starfive-wdt: Drop runtime PM reference if
 starting watchdog fails
Message-ID: <auyIwPSEVBdme68d@google.com>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-2-linux@roeck-us.net>
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
In-Reply-To: <20261104164445.3209560-2-linux@roeck-us.net>

On Wed, Nov 04, 2026 at 08:44:41AM -0800, Guenter Roeck wrote:
> Commit 8f0ca55016a7 ("watchdog: starfive-wdt: Fix runtime PM leak in
> starfive_wdt_pm_start()") switched starfive_wdt_pm_start() to
> pm_runtime_resume_and_get() so the runtime PM usage counter is not
> leaked when resuming the device fails. However, if starfive_wdt_start()
> subsequently fails (for example, on a timeout in starfive_wdt_int_clr()),
> starfive_wdt_pm_start() returns the error without releasing the runtime
> PM reference acquired by pm_runtime_resume_and_get(). Because the
> watchdog core does not invoke the stop callback when start fails, the
> usage counter remains permanently elevated.
> 
> Drop the runtime PM reference with pm_runtime_put_sync() if
> starfive_wdt_start() fails.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> Cc: Ziv Xu <ziv.xu@starfivetech.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

With a nit,

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

> @@ -372,12 +372,17 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
>  static int starfive_wdt_pm_start(struct watchdog_device *wdd)
>  {
>  	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> -	int ret = pm_runtime_resume_and_get(wdd->parent);
> +	int ret;
>  
> +	ret = pm_runtime_resume_and_get(wdd->parent);
>  	if (ret < 0)
>  		return ret;
>  
> -	return starfive_wdt_start(wdt);
> +	ret = starfive_wdt_start(wdt);
> +	if (ret)
> +		pm_runtime_put_sync(wdd->parent);
> +
> +	return ret;

Or just `return 0;`.
