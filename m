Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6033FE65F;
	Wed, 16 Sep 2026 07:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542637; cv=none; b=WtjUk3iTSSZcxH3XvOMdmbcT6OniBV0xLDVdovebLpT2KfEMFZpbbzhdORaXROBVV0UcPOj16OMYDRUY8maqeUZNlSXzsa4aART/vYzA2nRhhb0o5yNTCbSNMuibqyDRLT95frALtHFq+/vgNtKMVs9ZPr1ek7TNv0N7a4LhwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542637; c=relaxed/simple;
	bh=711jSefBsmecoQ4QRNeAxoYCOUHjjNqFTCleoSOJZDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAYJfN13MXNhAh/Hi1B+G88iAHvF6EgiaX/2ajB7szTefiqMJJt9jO3oNJCypdtpdd15y1w3FHWKTNKxaHwY7/A6wg5gcd367Vd+bkFo+UUw3ZLR1jlDPWSy80aj53lGZgRjlEyc/XywAbV0HzxXrGj83mD/4Wo91+DB2+8RiVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrQbjuXT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrQbjuXT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879381F000FF;
	Wed, 16 Sep 2026 07:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789542630;
	bh=wtR88jIZSHW4+MkWxfx2D8N2ustZn4CObntY2/MrElk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QrQbjuXTaxMWHGtzDPemhjis+1vx2Y+0aDvGg0YyTy4yGxYsoUgOt3YT7Gxq9LQX9
	 1Spo+E0wFNvVi1cA2bVzNU83DvrlWmcbtJ7i7NXNk3B6tHT3l3+hvtykuXDAGBJrw+
	 38MsZkC/umfg3a8b+kU14MHgS9co3DxwF3SInzZgJnjr8KP8zuidr3i5y79pPxxWfx
	 Dvdnlr6/ICe+YZvhQn4CaAcMDfIGJ154Qm8Fq6ecWVlDwXielTgqBjt+SpGG+WLZMa
	 t4L2tnHSAcTzayXHc07Bo4cO35Qe9mOm1HMLVCrhISoGYTYqKpgPRGjlN5xZPPWO7V
	 jro8WienGAHpw==
Date: Wed, 16 Sep 2026 07:10:27 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: sashiko-bot@kernel.org, linux-watchdog@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3] watchdog: msc313e: Propagate error code in resume()
Message-ID: <aqpA4xln77xgBjs9@google.com>
References: <20260912164221.966851F00893@smtp.kernel.org>
 <20260916044557.74124-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916044557.74124-1-triet.hoang.dev@gmail.com>

On Wed, Sep 16, 2026 at 11:45:57AM +0700, Triet Hoang wrote:
> Sat, 12 Sep 2026 16:42:21 +0000 Sashiko wrote:
> 
> > [Severity: High]
> > This is a pre-existing issue, but does leaving the watchdog framework state
> > flags intact when the clock fails to enable cause a system crash?
> > 
> > If msc313e_wdt_start() fails, the clock remains disabled, but WDOG_ACTIVE
> > and WDOG_HW_RUNNING are still set. The Linux PM core ignores device resume 
> > errors and proceeds with system resume.

Another example that Sashiko complains either way.  See also v2 [1].

[1] https://lore.kernel.org/all/20260828162703.9F9DF1F00A3E@smtp.kernel.org

> > 
> > The watchdog core's PM notifier then calls watchdog_dev_resume(), which
> > immediately invokes msc313e_wdt_ping(). This unconditionally writes to a 
> > memory-mapped register:
> > 
> > drivers/watchdog/msc313e_wdt.c:msc313e_wdt_ping() {
> > 	...
> > 	writew(1, priv->base + REG_WDT_CLR);
> > 	return 0;
> > }
> > 
> > Can accessing these registers with the bus clock disabled on this platform 
> > trigger a synchronous external bus abort and a kernel panic?
> > 
> > Additionally, a subsequent stop operation unconditionally disables the clock:
> > 
> > drivers/watchdog/msc313e_wdt.c:msc313e_wdt_stop() {
> > 	...
> > 	writew(0, priv->base + REG_WDT_CLR);
> > 	clk_disable_unprepare(priv->clk);
> > 	return 0;
> > }
> > 
> > Since the clock enable previously failed, would this extra 
> > clk_disable_unprepare() cause a clock reference count underflow warning?
> 
> Hi Tzung-Bi,
> 
> I think we can address the problem Sashiko mentioned by making the clock ownership 
> explicit in the driver.
> 
> If msc313e_wdt_start() fails to enable the clock, the driver should not subsequently access
> the watchdog registers or call clk_disable_unprepare() as if the clock had been successfully enabled.
> In particular, we can track whether the clock was successfully acquired and make ping() and stop()
> operate only when the clock is enabled.
> 
> diff --git a/drivers/watchdog/msc313e_wdt.c b/drivers/watchdog/msc313e_wdt.c
> index 4a5cce2a16b1..437b8ace0a00 100644
> --- a/drivers/watchdog/msc313e_wdt.c
> +++ b/drivers/watchdog/msc313e_wdt.c
> @@ -29,6 +29,7 @@ struct msc313e_wdt_priv {
>         void __iomem *base;
>         struct watchdog_device wdev;
>         struct clk *clk;
> +       bool clk_enabled;
>  };
>  
>  static u32 msc313e_wdt_get_hw_timeout(struct msc313e_wdt_priv *priv)
> @@ -60,6 +61,7 @@ static int msc313e_wdt_start(struct watchdog_device *wdev)
>         if (err)
>                 return err;
>  
> +       priv->clk_enabled = true;
>         msc313e_wdt_set_hw_timeout(priv, wdev->timeout);
>         return 0;
>  }
> @@ -68,6 +70,9 @@ static int msc313e_wdt_ping(struct watchdog_device *wdev)
>  {
>         struct msc313e_wdt_priv *priv = watchdog_get_drvdata(wdev);
>  
> +       if (!priv->clk_enabled)
> +               return -EIO;
> +
>         writew(1, priv->base + REG_WDT_CLR);
>         return 0;
>  }
> @@ -79,7 +84,10 @@ static int msc313e_wdt_stop(struct watchdog_device *wdev)
>         writew(0, priv->base + REG_WDT_MAX_PRD_L);
>         writew(0, priv->base + REG_WDT_MAX_PRD_H);
>         writew(0, priv->base + REG_WDT_CLR);
> -       clk_disable_unprepare(priv->clk);
> +       if (priv->clk_enabled) {
> +               clk_disable_unprepare(priv->clk);
> +               priv->clk_enabled = false;
> +       }
>         return 0;
>  }
> 
> How do you think about this idea?

Hi Triet,

Thanks for the suggestion.

Fundamentally, if msc313e_wdt_start() fails due to a clk_prepare_enable()
failure, it indicates a much more severe system-level issue.  In such a
scenario, propagating the error to the PM core is likely our best bet rather
than trying to gracefully manage it with additional state tracking.

Also, regarding Sashiko's concern about the bus abort and kernel panic:
the driver enables and disables this clock primarily for CCF reference
counting.  It is actually a "fixed-clock" (see xtal_div2 in mstar-v7.dtsi).
Because it is a fixed clock, there is no physical clock gating that would
block bus access and cause the synchronous external bus abort that the bot
is warning about.

Given that, I think it's better to avoid adding extra state complexity to
the driver just to silence the warning.
