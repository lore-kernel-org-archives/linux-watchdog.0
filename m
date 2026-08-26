Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8A33242D9;
	Wed, 26 Aug 2026 04:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719001; cv=none; b=qtdLiyQO23afmFyRi4IEtRm2UbmQ614UMuMwNkyMDcl+KXKsjXZ/pRJvxkBF51Re1Sb/vQi46nucjG62el8g0i5IMbc8WZ8vbwcj8tzaEqJW/reSymbdZVzjteJtYOFNjAkq3C/1p8UDdea6NV2KvK1vZ4QGtAtzd+8DC7kDU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719001; c=relaxed/simple;
	bh=XtU2mh97knpLCJ2602JJ33nuXKeHg8Sn0/yN7aDD7xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMkuhNrm+I1jR1bTsEpAoHaSgC8Gr/B9b5Qp2KTq2fZAWGKfqBF9YIQAZD8Jw2nETPyEyPSML+eC3nNcmHXsbeO9NG3VoQhBmE7PM0ZxEz5RYvCuFq/REMrcc4+T788v9lvuhHi2JxKCzxMButEZ81h6nSYN1GC+tkP5f16W1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLIHnr7X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLIHnr7X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998E61F000E9;
	Wed, 26 Aug 2026 04:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787718999;
	bh=wQJpuKQVyofqXNydKg7+rvhxd0UaO08shOn9OeCnGg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nLIHnr7XaI8bb2QkcKNcufMAHiZkkPRjexpuXKlS6sr4thugydK/FjLTqyFrSSpbO
	 pUJYR/t4gEMENiWwP3Ra0ToF1hk4Smyd1oKldch8z4swQ0TqKCiwX1d3e49TjcNtRV
	 Ng0UwbQmV/6uJtWLuskMIJc7nOu4MmkjJHxcHstLe5eVBveZCNoQ5Za1NWwfhifAQB
	 z5yoLeVbQPMTlWqOhs2YHvVqGsDyauhPqW1fGDtUVW6Y193ThLf6vjeJ9C7CvUVg28
	 qWRdfkXcs1FQvLqJpyYvTWHxkMkO9h5rMijXFbSkMOgyr9JjI8ftFBM13gP6IjJzfA
	 S/Cj2h1DC5wQQ==
Date: Wed, 26 Aug 2026 04:36:36 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Wanming Gao <wanming.gao@mediatek.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: mediatek: Enable pretimeout support
Message-ID: <ao5tVCpb1pMu14Tb@google.com>
References: <20260824132914.2662346-1-wanming.gao@mediatek.com>
 <20260824133823.884931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133823.884931F000E9@smtp.kernel.org>

On Mon, Aug 24, 2026 at 01:38:23PM +0000, sashiko-bot@kernel.org wrote:
> > @@ -230,14 +230,17 @@ static int mtk_wdt_restart(struct watchdog_device *wdt_dev,
> >  {
> >  	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdt_dev);
> >  	void __iomem *wdt_base;
> > +	unsigned long flags;
> >  	u32 reg;
> >  
> >  	wdt_base = mtk_wdt->wdt_base;
> >  
> >  	/* Enable reset in order to issue a system reset instead of an IRQ */
> > +	spin_lock_irqsave(&mtk_wdt->lock, flags);
> 
> [Severity: High]
> Does acquiring this spinlock unconditionally risk a deadlock during a system
> panic?
> 
> The restart handler is called during emergency restarts. If another CPU was
> stopped via an IPI while holding mtk_wdt->lock (such as during the 70
> microsecond delay in mtk_wdt_deassert_irq()), the panicking CPU will spin
> infinitely here and hang the emergency reboot.

The .restart() callback can be called during a normal reboot or an emergency
restart.  In either case, local interrupts are disabled and there should be
no other concurrent CPU running this piece of code.  The lock acquisition is
unnecessary here and can be safely dropped to avoid the deadlock risk.

> > +static void mtk_wdt_deassert_irq(struct watchdog_device *wdd)
> > +{
> > +	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdd);
> 
> [Severity: High]
> Will watchdog_get_drvdata() return NULL here if a pending interrupt fires
> during probe?
> 
> In mtk_wdt_probe(), devm_request_irq() is called to enable the interrupt before
> watchdog_set_drvdata() initializes the driver data. If the bootloader left the
> pretimeout interrupt enabled and it fires immediately during probe,
> mtk_wdt_isr() will run and call mtk_wdt_deassert_irq().
> 
> This would result in watchdog_get_drvdata() returning NULL, followed by a NULL
> pointer dereference when accessing mtk_wdt->wdt_base.

To prevent the race condition, it would be safer to use IRQF_NO_AUTOEN when
calling request_irq() and call enable_irq() when the driver is fully ready.
