Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D32346E43;
	Thu, 27 Aug 2026 04:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787806404; cv=none; b=ZSVAgM8kt8BGKSyJS3ljEDnRwrZ9VTkmu8Q/NorQCq512Tq5g/nm7cnUUYs/nlbxaMlMOrV92AFOYpXpdLmGqXPNAwaySZBeYfxjoSFHL2N2SB2oWvTGcYCPIBv3fUBQkQKB5NAdiqUMFF7jcwVRTbSMCgSUOfklN7IMvt7OkVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787806404; c=relaxed/simple;
	bh=gTJqrXUDmPmlOhXdaDmayZiPEvr1bAU//RPSvEs0fak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNocGmmAXeNlDiOhfAwmErqlopXKEuNHmlZH7DuWjDQlp5hi8vssk71CG5lHnQjMb+1ctuK+t1oMh0/JouekUZTJW7VPYe9OpS8oZS/eXzLcH12Yw9hWXYwY/yckFiELJnRek8ZyplDE6NgelqUhofp5M2pT2GVw6o78pD4qn0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vnm8mpeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vnm8mpeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A7B1F000E9;
	Thu, 27 Aug 2026 04:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787806403;
	bh=TNxTJXH87MyrN/p2FhZSULngNC/hfZtET3XVBjM++5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vnm8mpeR6C3y3Ng1qPUocItKQZdiLqwo5wtco1Lus/v0+K89GEaHo3ROopl7/rCw1
	 0/UHE+5w36aE4ZgiRWzA0nynd20VBNtHiu660Efi+a/tUCq4RYKngC6Axt34vj76lQ
	 LXzueOuK3ZM1mtv5DEC4PZfA80VR03ELd7U5t8RlS/alNHUSs5bfYOVzEWaoxz6aCe
	 J826Ok2Ae7OYJrkADpS4lZBkY0BJn5kW8k4BO7FOjSiey2nHTiW3xGOPN7fWZpx9vP
	 Ezweo2ub4Kq15GmLMfpRshKYiHqEF7Y+8SbtKau1SsC6veKHVgTRSJhClw007lqw2A
	 BXSJyM+Tuo2Cg==
Date: Thu, 27 Aug 2026 04:53:20 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Triet Hoang <triet.hoang.dev@gmail.com>, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 4/8] watchdog: msc313e_wdt: Convert to
 DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <ao_CwKrBhJzA8NHH@google.com>
References: <20260826060839.203297-1-triet.hoang.dev@gmail.com>
 <20260826060839.203297-5-triet.hoang.dev@gmail.com>
 <20260826062035.7645D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826062035.7645D1F000E9@smtp.kernel.org>

On Wed, Aug 26, 2026 at 06:20:35AM +0000, sashiko-bot@kernel.org wrote:
> Pre-existing issues:
> - [High] Missing platform_set_drvdata() or dev_set_drvdata() in the probe function leads to a guaranteed NULL pointer dereference during suspend/resume operations.
> - [High] The driver accesses hardware registers without ensuring the required clock is enabled, which can lead to a synchronous bus fault.

They are real issues.  Sent [1] for fixing if they are still relevant.

[1] https://lore.kernel.org/linux-watchdog/20260827044700.554333-1-tzungbi@kernel.org

> > -static int __maybe_unused msc313e_wdt_suspend(struct device *dev)
> > +static int msc313e_wdt_suspend(struct device *dev)
> >  {
> >  	struct msc313e_wdt_priv *priv = dev_get_drvdata(dev);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this result in a NULL
> pointer dereference when the system suspends?
> 
> The PM core invokes msc313e_wdt_suspend() and passes the platform device as the
> dev parameter. However, msc313e_wdt_probe() never calls platform_set_drvdata()
> or dev_set_drvdata() for the platform device:
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe() {
>     ...
> 	watchdog_set_drvdata(&priv->wdev, priv);
> 
> 	watchdog_init_timeout(&priv->wdev, timeout, dev);
> 	watchdog_stop_on_reboot(&priv->wdev);
> 	watchdog_stop_on_unregister(&priv->wdev);
> 
> 	return devm_watchdog_register_device(dev, &priv->wdev);
> }
> 
> Because the driver data is uninitialized, dev_get_drvdata(dev) evaluates to
> NULL. The callback then computes an offset into this NULL pointer via
> &priv->wdev and passes it to watchdog_active(), which unconditionally
> dereferences it via test_bit(WDOG_ACTIVE, &wdd->status), causing a fatal
> page fault.
> 
> The identical NULL pointer dereference logic also executes on the resume path
> in msc313e_wdt_resume().

https://lore.kernel.org/linux-watchdog/20260827044700.554333-2-tzungbi@kernel.org

> [Severity: High]
> This is also a pre-existing issue, but does this driver access hardware
> registers without ensuring the required clock is enabled?
> 
> The probe function reads from hardware registers without first calling
> clk_prepare_enable(), which can crash if the clock is disabled by the
> bootloader:
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe() {
>     ...
> 	/* If the period is non-zero the WDT is running */
> 	if (readw(priv->base + REG_WDT_MAX_PRD_L) | (readw(priv->base + REG_WDT_MAX_PRD_H) << 16))
> 		set_bit(WDOG_HW_RUNNING, &priv->wdev.status);
>     ...
> }
> 
> Additionally, because the clock is never enabled in the probe function, when
> the Common Clock Framework's late_initcall executes, it physically disables
> the unreferenced clock. If the watchdog is already running at boot time, the
> watchdog core will periodically call the background ping callback:
> 
> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_ping() {
>     ...
> 	writew(1, priv->base + REG_WDT_CLR);
>     ...
> }
> 
> Writing to these unclocked watchdog registers will trigger a synchronous
> bus fault.

https://lore.kernel.org/linux-watchdog/20260827044700.554333-3-tzungbi@kernel.org
