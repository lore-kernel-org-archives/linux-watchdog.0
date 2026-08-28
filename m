Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F6D2C21F1;
	Fri, 28 Aug 2026 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934434; cv=none; b=bEcNzUk3GE6uwSTKIDhNERifJALk6yptpt7Kk1GreXC2ys43Tji/1wXPELNyz4i8f6InQp5LjCrxGTiZikLhGm4UqcPUjTK82R3qmwA9wUk2NsB1Sjhwt4qmHbxa7fdo107ihh2Xu0HNdTK7dAZXtEGvD9v29S3mY5fMCCppdqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934434; c=relaxed/simple;
	bh=Zp3gl3BLHIFjGhPdB7/HixUPcsrcKbxO2UTGW+H53a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHD3P569R85/tdEeO9c71YcKwKlFe7Oypy/zsiPFEXRl1782SeOWF3F7nwVHEWjvPG58ZwbCSmlT1daQuLLJI2o1nE35N7PojUOlFnv8yIMEVjF+mqeyVSm/pOGrneefaUn4EfIAS74EyH3RBrps09xUIRSJj3j2gEBv52u4oQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lN7xAN8z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lN7xAN8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FFA1F000E9;
	Fri, 28 Aug 2026 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934433;
	bh=aqGzQQ0lZSOLhL3NUGJDbil/FFvt+SQxvywbO9biUXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lN7xAN8zpobkoEFcbiXxb5GhDgrcehV9TJ6ic0sUHqZ/oTI4OTyB0Z20m6GsrtknO
	 6KCSqdr2IXm4EOCYGSq5Y6UKEJBco6KbWOD/u5RkNfVgZqXapSs6cgdL/RTMtE6k65
	 Qpc/9xRu509cIN7HeFW9Z7xSo8U/25ro2ODGVDJHX9n1t/diXe2XXZXOo8cpKN3aFf
	 5jeVQ1DJfNAy1dvH/KbZ9U33GEjuer9NjltsmImWgNYcI1KmArp9HdtLf7hSlXpIuo
	 LkrGnb4WS6QHgrHRHtyItG5v9l/rGZSv0A70O13AahScGBDs2E4dwpx6fl9MnfBK+T
	 F1cwMGHy65l6g==
Date: Sat, 29 Aug 2026 00:27:10 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: msc313e: Fix NULL pointer dereference in
 PM callbacks
Message-ID: <apG23kG_hz_pxsSI@tzungbi-laptop>
References: <20260827044700.554333-1-tzungbi@kernel.org>
 <20260827044700.554333-2-tzungbi@kernel.org>
 <20260827045746.C79091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827045746.C79091F000E9@smtp.kernel.org>

On Thu, Aug 27, 2026 at 04:57:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Hardware watchdog is not properly stopped during system suspend if it was started by the bootloader but not opened by userspace.
> - [High] The resume callback ignores the return value of msc313e_wdt_start().
> - [High] Potential division by zero during `max_timeout` calculation.
> - [High] Clock reference count leak and unintended hardware activation in `msc313e_wdt_settimeout`.
> - [Low] Struct initialization uses commas instead of semicolons.

Proposed fixes for them in the series [1].

[1] https://lore.kernel.org/all/20260828161348.13212-1-tzungbi@kernel.org

> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_suspend()
>     if (watchdog_active(&priv->wdev))
>         msc313e_wdt_stop(&priv->wdev);
> 
> [Severity: High]
> This is a pre-existing issue, but does this bypass stopping the hardware
> watchdog if userspace hasn't opened the device?
> 
> If the hardware was started by the bootloader but not yet opened by userspace,
> the ping worker is frozen during suspend. Since watchdog_active() checks if
> userspace has opened it, will the active hardware timer continue running and
> trigger a spurious system reset during system suspend?

https://lore.kernel.org/all/20260828161348.13212-6-tzungbi@kernel.org

> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_resume()
>     if (watchdog_active(&priv->wdev))
>         msc313e_wdt_start(&priv->wdev);
> 
> [Severity: High]
> This is a pre-existing issue, but is it safe to ignore the return value of
> msc313e_wdt_start()?
> 
> If the clock enable fails inside msc313e_wdt_start(), the function will
> silently discard the error. Will subsequent register operations in the watchdog
> then access unclocked memory and cause a system crash?

https://lore.kernel.org/all/20260828161348.13212-9-tzungbi@kernel.org

> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe()
>     priv->wdev.info = &msc313e_wdt_ident,
>     priv->wdev.ops = &msc313e_wdt_ops,
>     priv->wdev.parent = dev;
> 
> [Severity: Low]
> This isn't a bug introduced by this patch, but are these assignments using
> comma operators intentionally instead of semicolons?
> 
> While syntactically valid, this violates standard kernel coding style and
> could cause unintended behavior during refactoring.

https://lore.kernel.org/all/20260828161348.13212-10-tzungbi@kernel.org

> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_probe()
>     priv->wdev.min_timeout = MSC313E_WDT_MIN_TIMEOUT;
>     priv->wdev.max_timeout = U32_MAX / clk_get_rate(priv->clk);
>     priv->wdev.timeout = MSC313E_WDT_DEFAULT_TIMEOUT;
> 
> [Severity: High]
> This is a pre-existing issue, but could this calculation result in a division
> by zero panic?
> 
> If clk_get_rate() returns 0 for an uninitialized clock, using it directly as a
> denominator here will trigger a division by zero exception during probe.

https://lore.kernel.org/all/20260828161348.13212-3-tzungbi@kernel.org

> drivers/watchdog/msc313e_wdt.c:msc313e_wdt_settimeout()
>     wdev->timeout = new_time;
> 
>     return msc313e_wdt_start(wdev);
> 
> [Severity: High]
> This is a pre-existing issue, but does unconditionally calling
> msc313e_wdt_start() here cause a clock reference leak or unintended hardware
> activation? 
> 
> If the watchdog is already active, this would increment the clock reference
> count redundantly. If it is stopped, it inadvertently starts the hardware timer
> without the watchdog core tracking it, which could cause an unexpected system
> reset.

https://lore.kernel.org/all/20260828161348.13212-4-tzungbi@kernel.org
