Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793892115;
	b=dsY4UdJq0qFBZbrfhkrIcrafIsaafAy5L7NvxPAyK9WLyg5n3mYzEwm6gLGtnw4M9CRP
	 Y1cYpZTCIxEM+t2ecj80NNcz45r2ZfPQWtEvCAoPhwDnrfHJuBVGH88UCQUSqU/4bBeqH
	 AaaCZKafyvq6WAsrX7/0MSdl4wp3nmb3e2WQ0lktGZYMi9anYrrTgtr8jLyBH4DZXLuno
	 8xVIK+V42CliyzoEgv0mzRZ4pWANcLC8tUPqAVmgThzlZzmNTVOzN0QnLUp9AKRo56xrT
	 x6drEqmfFiaWlIjkc5+TEq8Vi6Bxu6NlOBzdLnBPnaEV/fEBzKDisCq20Hr5RAKefDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793892115;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iQv19UJJ1oGUZd++iHYdvH+hztsEDXi+pN2PHusfMBQ=;
	b=BE5jfmGwv9O5/n/rcv+HTPT3kWWvG980tpORYQCI9JenOpF8lhw3Xe6RxHuUviCau331
	 8vWVyw/LuvTbFXDdZ8JeKqfR+Fugu397H7P0wWOS/i4pY3LHPWxBpLhXgyUWAK981enqW
	 06cOZa6ounIx3a/DMiUGYoKFUVAeswInfwCvtIMPzI94epKSmBhq56PrKW4yu1iAitcTA
	 qE3SSeSzpPtI7O5wy2tFsBkD13QX0YU8/aUlAAF4Xc1O9Ep+jyj7iLusdS0L71omOQjfo
	 mvefILP4p5Ys+v2CMyUSh9kiF6IAx9DAQRdhh0wfBFKs6oPaZoaQI3n1FKjhGFzIhsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lF/LY3G8";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0904606A32F
	for <linux-watchdog@vger.kernel.org>; Thu,  5 Nov 2026 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lF/LY3G8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB651F00919;
	Thu,  5 Nov 2026 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793892114;
	bh=iQv19UJJ1oGUZd++iHYdvH+hztsEDXi+pN2PHusfMBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lF/LY3G8soDXlyLnoTaz0MVeOUC5fs2PDNDx0EIqFUhBRMC+GdIKT1PrbR01tuChR
	 V3lrua72HpH3VnRLei2XwSlAxM9z16jtBxwoIs1Nstv6Bbwz5N/EgxkDyrs3dm+0e6
	 Kv+v9v/wW/PE3JDnaxGveROio8Z7jAV1IL8NkIiCPdAomju4CK2jmzVhrIoQrBP/5Q
	 QtSPFA67Nu+MoeQXY2gLtZlL9T0ogB5l3pIWMdL4UaIoeQ0uc7SeDiWbIadOLChLqC
	 vLIWvA3hju5COsM+VGx/3rgF6XixlFQB9Q0A3TF4ECoxWaGl23jfqLN1VAaMvxLqsj
	 pwCKvHWApRT8A==
Date: Thu, 5 Nov 2026 15:21:51 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Xingyu Wu <xingyu.wu@starfivetech.com>,
	Ziv Xu <ziv.xu@starfivetech.com>
Subject: Re: [PATCH 1/5] watchdog: starfive-wdt: Drop runtime PM reference if
 starting watchdog fails
Message-ID: <auyfDx8KnqEQUWKZ@google.com>
References: <20261104164445.3209560-1-linux@roeck-us.net>
 <20261104164445.3209560-2-linux@roeck-us.net>
 <auyIwPSEVBdme68d@google.com>
 <0168a321-10ac-4f67-a279-1523a00e0972@roeck-us.net>
 <0a5970d0-7b39-476c-8238-7c05ae6b6435@roeck-us.net>
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
In-Reply-To: <0a5970d0-7b39-476c-8238-7c05ae6b6435@roeck-us.net>

On Thu, Nov 05, 2026 at 06:52:29AM -0800, Guenter Roeck wrote:
> On Thu, Nov 05, 2026 at 06:49:26AM -0800, Guenter Roeck wrote:
> > On Thu, Nov 05, 2026 at 01:46:40PM +0000, Tzung-Bi Shih wrote:
> > > On Wed, Nov 04, 2026 at 08:44:41AM -0800, Guenter Roeck wrote:
> > > > Commit 8f0ca55016a7 ("watchdog: starfive-wdt: Fix runtime PM leak in
> > > > starfive_wdt_pm_start()") switched starfive_wdt_pm_start() to
> > > > pm_runtime_resume_and_get() so the runtime PM usage counter is not
> > > > leaked when resuming the device fails. However, if starfive_wdt_start()
> > > > subsequently fails (for example, on a timeout in starfive_wdt_int_clr()),
> > > > starfive_wdt_pm_start() returns the error without releasing the runtime
> > > > PM reference acquired by pm_runtime_resume_and_get(). Because the
> > > > watchdog core does not invoke the stop callback when start fails, the
> > > > usage counter remains permanently elevated.
> > > > 
> > > > Drop the runtime PM reference with pm_runtime_put_sync() if
> > > > starfive_wdt_start() fails.
> > > > 
> > > > Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> > > > Cc: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > Cc: Ziv Xu <ziv.xu@starfivetech.com>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > 
> > > With a nit,
> > > 
> > > Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
> > > 
> > > > @@ -372,12 +372,17 @@ static void starfive_wdt_stop(struct starfive_wdt *wdt)
> > > >  static int starfive_wdt_pm_start(struct watchdog_device *wdd)
> > > >  {
> > > >  	struct starfive_wdt *wdt = watchdog_get_drvdata(wdd);
> > > > -	int ret = pm_runtime_resume_and_get(wdd->parent);
> > > > +	int ret;
> > > >  
> > > > +	ret = pm_runtime_resume_and_get(wdd->parent);
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > >  
> > > > -	return starfive_wdt_start(wdt);
> > > > +	ret = starfive_wdt_start(wdt);
> > > > +	if (ret)
> > > > +		pm_runtime_put_sync(wdd->parent);
> > > > +
> > > > +	return ret;
> > > 
> > > Or just `return 0;`.
> > > 
> > 
> > Good idea. I'll change that.
> 
> Ah, no, we still want to return the error. Difference is that
> pm_runtime_put_sync() is only called if there was an error,
> but the error must still be returned to the caller.

Ah...correct, I overlooked that.
