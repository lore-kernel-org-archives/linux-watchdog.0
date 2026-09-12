Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5038288B9;
	Sat, 12 Sep 2026 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230964; cv=none; b=Fy/4IiH0dcCC23jgW5y3gjIwi/HJjGmODeahzkeRxRIc+AnsP2J3PJwl70wHm5yIkXpksAcGIzompR6z/ABCo3AzWf3pUZghA11cINOLIalWJSoYy0srgbGVJxw3t3oxnfxww581+e0GoQd1rMMBunGgAUVoxrw+ynGntqMZqjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230964; c=relaxed/simple;
	bh=+ZAZX0K22z/6cre/iqD5RjDc3W1cRoIrCcE7D5xuvdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSud8Q/pCjhoFqVyXLAUyBJu5/qUiqTacLypxdb4KcHnIfHij3xKFnLqZU15ubE7t6mgsUzsbiP+DCshwPiTPKS85HVG+zc5mz//5yj7n5zQwfamAxFMnMdmuKOp2/aLwWaGoxgDOWrK9gXroHUUUUoRnxK2PBNjXM918Dlozt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM9W1r7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM9W1r7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2031F000FF;
	Sat, 12 Sep 2026 16:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230963;
	bh=P04D5ovs37YeThA6E5X4EVCib5l+D5hS8llDrQKfPL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZM9W1r7Ko3pNB4SgeOTJu0WXK5JiKXsjI9d35BiTu5TEUSfdUY/b6FYIPGDSTR4Ig
	 i+4PDsAQUMTR8roksMIg4A3iO6ZC5NIPJfjQwkSXWA+KiRHix9dUwLCVM2BfN2lq38
	 OziWKakUs7iqnd3BgD7Ez64MwE2FFHck/rfzqlYJxG1A11rT5ruT7JXAZglSmNnjjr
	 4PXLuee+Wzjipqc4kTTowsczEyXGVyNJASeWtY/4x7S/gYUuijTzYqN/uUOCauLT8W
	 KWcc1FhChazxIZVDPhnxWf2Gih3XUJyT2awIvaOn9V7HjzASPGOk+6wj/33UZg5thv
	 c0HCjZuNcDogg==
Date: Sun, 13 Sep 2026 00:36:00 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Daniel Palmer <daniel@thingy.jp>,
	Romain Perier <romain.perier@gmail.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/9] watchdog: msc313e: Enable clock before accessing
 hardware registers
Message-ID: <aqV_cAlj-DZ5CLYL@tzungbi-laptop>
References: <20260828161348.13212-1-tzungbi@kernel.org>
 <20260828161348.13212-5-tzungbi@kernel.org>
 <d9e501d3-53fb-4ec0-b63a-8f86566fd838@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9e501d3-53fb-4ec0-b63a-8f86566fd838@roeck-us.net>

On Wed, Sep 09, 2026 at 02:14:41PM -0700, Guenter Roeck wrote:
> On Sat, Aug 29, 2026 at 12:13:43AM +0800, Tzung-Bi Shih wrote:
> > v2:
> > - Fix a clock leak issue in the error handling path (Sashiko reported).
> > 
> > v1: https://lore.kernel.org/all/20260827044700.554333-3-tzungbi@kernel.org
...
> > @@ -144,7 +157,13 @@ static int msc313e_wdt_probe(struct platform_device *pdev)
> >  	watchdog_stop_on_reboot(&priv->wdev);
> >  	watchdog_stop_on_unregister(&priv->wdev);
> >  
> > -	return devm_watchdog_register_device(dev, &priv->wdev);
> > +	ret = devm_watchdog_register_device(dev, &priv->wdev);
> > +
> > +	/* If the WDT is running and anything goes wrong, disable the clock. */
> > +	if (ret && test_bit(WDOG_HW_RUNNING, &priv->wdev.status))
> > +		clk_disable_unprepare(priv->clk);
> 
> Curious. Does this mean that Sashiko complains either way ?

Correct.

Sashiko complained about:
- "[Medium] Clock reference count is leaked on the probe error path if
   watchdog registration fails." in v1 [1].
- "[High] Probe error path disables the watchdog clock without executing
   the hardware shutdown sequence, neutralizing the fail-safe." in v2
   (current version) [2].

Current version makes more sense to me.  It balances the CCF reference
count correctly in both paths.

Moreover, if a system relies on the "fail-safe" WDT armed by bootloader,
the WDT shouldn't really depend on the prepared and enabled clock.  Note
that the WDT should be already running before the driver gets probed.

[1] https://lore.kernel.org/all/20260827050107.9AD441F000E9@smtp.kernel.org
[2] https://lore.kernel.org/all/20260828162531.7FA3A1F000E9@smtp.kernel.org
