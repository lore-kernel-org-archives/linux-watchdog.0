Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAEA368291;
	Fri, 28 Aug 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934411; cv=none; b=g1qf9V/Db5chdyjEaECy6WJZf/67aEUqSRIxJxsKHqdOnpZNhNvUOFcz23dVigJne3siid/bavxK+E4LDp11L6DvUjSOEGrIsXR0EN2F4wNxGbpuud7Q26slZPyMon9mHzLozUdmBVN0JkYolom0Kes/Ths+lAG8XBWCiS2XR0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934411; c=relaxed/simple;
	bh=uGU/tK761axMKObg46mrHlRLkSOHLCWFRvMNEXpmAC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCzAJO8Fl0VJ5smp7fsvsa7BVbfR98sGGFTwZI+9FIjceUnYH2sM7KUh0DRkPAAiIEO6hafZVyBVMO4RW3cT4YcEUIqBEPuOLW/xAy/ly/l0hg7iLHgeNqkLtebK0PzzYjdSj1sssAQCP/vdD5cdPpu8SCleyZnWf6Tz1WOtA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EspMPQUd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EspMPQUd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0611F000E9;
	Fri, 28 Aug 2026 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934409;
	bh=lxj6QhoYnrSKWwkA3HA7HCTk0UWUeubmFmIa1ZNkJ3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EspMPQUds4Vb6rPojif8ugDkDXhmVPhFPvLH5nvnYla4hOHEIMsVkacdf1HpzJ9AZ
	 Bu4Hfh+qXBPR4loF9vFsWd1eAhhBzk94yhydq8LCKJr/fZApbkC3y6YWq3UitSsQPv
	 tsMkoXH/6xS4f2oEGTW2DSTwccL5kvzrIdbu6lb3eZqrkwv5ecgPgPfcdAOeVwsvUE
	 ss2n+JZwQWSFvVAIRRD4YRFfPadVntIqtJuV6IznjsbuyO1wYgqYFry5hcx7YWRPop
	 HrMMjNzTrNi4f2KIYPenCiNI/KXXMdmw+2lZ/WPcTXADTcjekoHwLipT+FKU5P2RtD
	 8e7QLeWR8g4qQ==
Date: Sat, 29 Aug 2026 00:26:46 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: sashiko-reviews@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: msc313e: Enable clock before accessing
 hardware registers
Message-ID: <apG2xtpMxylEoCmu@tzungbi-laptop>
References: <20260827044700.554333-1-tzungbi@kernel.org>
 <20260827044700.554333-3-tzungbi@kernel.org>
 <20260827050107.9AD441F000E9@smtp.kernel.org>
 <e860d0c8-99c2-4978-b15d-290759ae4f7e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e860d0c8-99c2-4978-b15d-290759ae4f7e@roeck-us.net>

On Fri, Aug 28, 2026 at 07:48:18AM -0700, Guenter Roeck wrote:
> On 8/26/26 22:01, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> > 
> > New issues:
> > - [Medium] Clock reference count is leaked on the probe error path if watchdog registration fails.
> > 
> 
> That seems real.

Fixed it in v2.

https://lore.kernel.org/all/20260828161348.13212-5-tzungbi@kernel.org

> 
> > Pre-existing issues:
> > - [High] Repeatedly setting the watchdog timeout leaks clock prepare and enable references, potentially leading to refcount overflow.
> > - [High] System will unexpectedly reset during suspend if the hardware watchdog is running but was never opened by userspace.
> > - [High] Potential division by zero if clk_get_rate() returns 0.

Proposed fixes for them in the series [1].

[1] https://lore.kernel.org/all/20260828161348.13212-1-tzungbi@kernel.org

> > > @@ -120,9 +121,21 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
> > >   	priv->wdev.max_timeout = U32_MAX / clk_get_rate(priv->clk);
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does this code cause a division
> > by zero panic during device probe if clk_get_rate() returns 0?

https://lore.kernel.org/all/20260828161348.13212-3-tzungbi@kernel.org

> > 
> > >   	priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
> > > +	ret = clk_prepare_enable(priv->clk);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >   	/* If the period is non-zero the WDT is running */
> > > -	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16))
> > > +	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16)) {
> > >   		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
> > > +		/*
> > > +		 * Keep the clock enabled. The watchdog core will skip the next
> > > +		 * start() and a future stop() will balance the CCF reference
> > > +		 * count.
> > > +		 */
> > > +	} else {
> > > +		clk_disable_unprepare(priv->clk);
> > > +	}
> > >   	watchdog_set_drvdata(&priv->wdev, priv);
> > >   	platform_set_drvdata(pdev, priv);
> > 
> > [Severity: Medium]
> > If the hardware watchdog is already running at boot, the driver intentionally
> > leaves the clock enabled here. However, if devm_watchdog_register_device()
> > subsequently fails:
> > 
> > drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe() {
> >      ...
> > 	return devm_watchdog_register_device(dev, &priv->wdev);
> > }
> > 
> > Does this regression leak the clock reference count on the error path if
> > device registration fails, since the prepared clock is never disabled?
> > 
> Yes, that will need to be fixed.

https://lore.kernel.org/all/20260828161348.13212-5-tzungbi@kernel.org

> > [Severity: High]
> > This is a pre-existing issue, but repeatedly setting the watchdog timeout
> > leaks clock prepare and enable references, potentially leading to refcount
> > overflow.
> > 
> > drivers/watchdog/msc313e_wdt.c:msc313e_wdt_settimeout() {
> >      ...
> > 	return msc313e_wdt_start(wdev);
> > }
> > 
> > drivers/watchdog/msc313e_wdt.c:msc313e_wdt_start() {
> >      ...
> > 	err = clk_prepare_enable(priv->clk);
> >      ...
> > }
> > 
> > Since the set_timeout callback directly wraps msc313e_wdt_start(), does this
> > sequence unconditionally increment the clock refcount every time the timeout
> > is updated, without a corresponding decrement?
> > 
> 
> Worse, it starts the watchdog even if it isn't running. Separate problem, though.

https://lore.kernel.org/all/20260828161348.13212-4-tzungbi@kernel.org

> > [Severity: High]
> > This isn't a bug introduced by this patch, but will the system unexpectedly
> > reset during suspend if the hardware watchdog is running but was never opened
> > by userspace?
> > 
> > drivers/watchdog/msc313e_wdt.c:msc313e_wdt_suspend() {
> >      ...
> > 	if (watchdog_active(&priv->wdev))
> > 		msc313e_wdt_stop(&priv->wdev);
> >      ...
> > }
> > 
> > If the watchdog was left running by the bootloader (WDOG_HW_RUNNING is set)
> > but never opened by userspace, watchdog_active() is false and the driver
> > skips stopping it. Meanwhile, the watchdog core suspends its background ping
> > worker.
> > 
> > Since the hardware timer continues counting down without being pinged, will
> > it expire and reset the suspended system?

https://lore.kernel.org/all/20260828161348.13212-6-tzungbi@kernel.org
