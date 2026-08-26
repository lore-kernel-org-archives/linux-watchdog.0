Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3B82D0C82;
	Wed, 26 Aug 2026 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787718980; cv=none; b=K7uBaj+jkw0JfAdVaLYzzn/MOUSR1YtBwlcfT22fITei/HOfsxeDebdseZkxtAHmvMx9nGIiLuOdUE1XnH6nsCb2lJqco/ZjhJZQO/bovPLfsDp9q0n3m17GDYnBfo4yvdQlnyk950CHyUhS3Qkol/YBhUWqsebgUKEUYlQ6LDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787718980; c=relaxed/simple;
	bh=5eV60yoYBfgOvT67MiJqiSLwhtCF4XuUgZJNDairIzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3OfcuxXAE/Ci7QyJYJa1R74LFePdd1aKmh/FMjc6Nvl2bEFe33QXx8VZS2vmUYreiSLqUDA30bp6+q5sx4e2JHDWsGdyUfix8M0JnWMqQwd0SkBtWreirXZ//LY3Pq4q00zWOWRvrXdzEY8Nxd3CZcNxSGo05sRi0xZt1r+1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6cdIBw8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6cdIBw8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7EC1F000E9;
	Wed, 26 Aug 2026 04:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787718979;
	bh=T+gJeU2dc10TfJV4Gm5lOdGKUdKdZ06S42Vqs2ccrTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S6cdIBw8TwHvQD8GPFRr78Ke1orCC5v2BfndzPKmYejPOHwCEDMlCuqUirhYwx1X9
	 Wk4sRbTWZoxI8wN8jG6QLGAe2jzeVgZ5b8rMIQQx34JjsN+HoA4/GsDEA0fIQNQZ2m
	 2s09Xa+aj5L5ZAA5LFWgf1UrY8pNFir8e2meH2fupUDmWY3zHK5vVmIkYs42Dpw4HJ
	 QEyV7yva3TpHU++kdi7CUraRcHBR6fh0Xp2uXQlfWwNG/hS3tWxJL7/YIbqd4OChsY
	 MLqslnJMk9lcwpnK/pL1PEnecNKmVa8WSiDmL1483H1oqQd95ro/9llpZwFQeent+l
	 PnyxBzGVuSPgg==
Date: Wed, 26 Aug 2026 04:36:15 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Wanming Gao <wanming.gao@mediatek.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, wallace.yu@mediatek.com,
	Jarried.Lin@mediatek.com, vince-wl.liu@mediatek.com
Subject: Re: [PATCH] watchdog: mediatek: Enable pretimeout support
Message-ID: <ao5tP40Wi-9jJgKk@google.com>
References: <20260824132914.2662346-1-wanming.gao@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824132914.2662346-1-wanming.gao@mediatek.com>

On Mon, Aug 24, 2026 at 09:29:12PM +0800, Wanming Gao wrote:
> The watchdog pretimeout interrupt needs to be deasserted after the
> hardware pretimeout event is received. Add IRQ level control handling
> to the MediaTek watchdog interrupt handler so the interrupt is cleared
> before notifying the watchdog core.

This could be clearer.  Please merge this with the third paragraph to
explain the why rather than just the what (e.g., explain that the hardware
uses level triggering and requires an edge transition to clear the
interrupt, if that is the case).

> Serialize all WDT_MODE read-modify-write operations using the existing
> watchdog spinlock. Initialize the lock before registering the interrupt
> handler and hold it across the complete 70us IRQ level toggle sequence.
> This prevents concurrent watchdog start, stop, or pretimeout updates
> from overwriting the temporary IRQ level state and disrupting the
> deassert pulse.

Please expand on the why here as well.  The 70us delay specifically needs
to be explained in the commit message (e.g., waiting for the clock domain
crossing to the 32KHz clock).

> 
> This avoids leaving the watchdog pretimeout interrupt asserted, prevents
> a potential interrupt storm, and allows the kernel to handle the
> pretimeout event properly before the final watchdog reset.

As mentioned above, please merge this with the first paragraph.

> 
> Test: Boot ok, trigger watchdog pretimeout case and verify the
>       pretimeout interrupt is received and handled before watchdog reset.

It is expected that patches are tested before submission.  Unless you are
specifying the exact board/platform you tested against, please drop this
section.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
...
> +static void mtk_wdt_deassert_irq(struct watchdog_device *wdd)
> +{
> +	struct mtk_wdt_dev *mtk_wdt = watchdog_get_drvdata(wdd);
> +	void __iomem *wdt_base = mtk_wdt->wdt_base;
> +	unsigned long flags;
> +	u32 reg;
> +
> +	spin_lock_irqsave(&mtk_wdt->lock, flags);
> +	reg = ioread32(wdt_base + WDT_MODE);
> +
> +	if (reg & WDT_MODE_IRQ_LEVEL_EN) {
> +		reg &= ~WDT_MODE_IRQ_LEVEL_EN;
> +		iowrite32(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
> +		/*
> +		 * Wait for two 32KHz watchdog clock cycles so the
> +		 * hardware can latch the IRQ level change across the clock
> +		 * domain.
> +		 */
> +		udelay(WDT_IRQ_LEVEL_SYNC_US);
> +		reg = ioread32(wdt_base + WDT_MODE);
> +		reg |= WDT_MODE_IRQ_LEVEL_EN;
> +	} else {
> +		reg |= WDT_MODE_IRQ_LEVEL_EN;
> +		iowrite32(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
> +		udelay(WDT_IRQ_LEVEL_SYNC_US);
> +		reg = ioread32(wdt_base + WDT_MODE);
> +		reg &= ~WDT_MODE_IRQ_LEVEL_EN;
> +	}

Is the main purpose of toggling WDT_MODE_IRQ_LEVEL_EN simply to clear the
interrupt?  Since the value of the bit doesn't seem to matter.

> +	iowrite32(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
> +	ioread32(wdt_base + WDT_MODE);

This read deserves a comment.  Otherwise, it looks like a NOP and might be
accidentally removed by someone in the future.

> +	spin_unlock_irqrestore(&mtk_wdt->lock, flags);
> +}

The function can be simplified a bit, e.g.:

    /* Trigger a state change */
    reg ^= WDT_MODE_IRQ_LEVEL_EN;
    iowrite32(...);

    /*
     * Wait for two 32KHz watchdog clock cycles ...
     */
    udelay(...);

    /* Restore to its original state */
    reg = ioread32(...)
    reg ^= WDT_MODE_IRQ_LEVEL_EN;
    iowrite32(...)
