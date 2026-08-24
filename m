Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712934041B
	for <linux-watchdog@vger.kernel.org>; Mon, 24 Aug 2026 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578705; cv=none; b=QbM4KdRQ3uVTW+PopvDGV6QUNuHTab0i5DGFWp2b/lVIGhzG5yCC+6yBWX37WxfJQXl8c8EVvq4k7mgjhQZ2WeF4A/NOiIeUEm3LeFsltiNp33URXnJMlJwwafE1efAg5sBltiywlNbNF/rKcsDE5aVV8WOpl+ce8qHhbdHKHkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578705; c=relaxed/simple;
	bh=kQP/GQYo8+UMrSWf5ukSLWQPtyOCO+bCROpo0rypccA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o9KC8cXqcawt+9b6sugD1Q8OsN5jTeE+i/9bSmi4457qcGl1ZjL8vvp0q7ViZtwnh0H/YoRloYNDB6nFoaVP2yDYQBVc1K3Gbzbi20h8hRDsFkzGZc880XgSiqzL6lPe93dZoSE2HYpakgBg8Ud0h03Z9S6ndLCyv7RFih1LoCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LV9tv/GZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LV9tv/GZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884931F000E9;
	Mon, 24 Aug 2026 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787578703;
	bh=7zajAljC8zUPnP5HQcSxXWGyGe0H8Lundzj8U0CgMhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LV9tv/GZRlRB79Bto8ye6/6RDs5ajrj97BgTj6LV074zC/j54c0k7fOaQQVenl1n1
	 ypPLQlczuRUCa6uEsm0v5f+IPMEktRrv275j2cu1IujomcaaJtwO5CzRlXZaLfvNQ4
	 ajKcgZ2AEEWRFw5PDffGc+60SACo9HVAES7IN+UYyjkpF4SI915FsNvxGMU0f3ko5K
	 EOeYHUbh19fNn9OQ9sWAi5GWAf4OdiWZvoDOTwsFK+wl1tvY9l75YZllLIwJsM2uJP
	 Q/3Q2p3zYh1ZrOZEynC06FELdCwGA8IxhcEL2HCKNVejZx9Hx4LVROwedftq7N07LS
	 rKpvgXTY2dRmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: mediatek: Enable pretimeout support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wanming Gao" <wanming.gao@mediatek.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260824132914.2662346-1-wanming.gao@mediatek.com>
References: <20260824132914.2662346-1-wanming.gao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:38:23 +0000
Message-Id: <20260824133823.884931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Null pointer dereference if watchdog interrupt fires during probe =
before driver data is set.
- [High] Unconditional spinlock acquisition in restart handler introduces a=
 deadlock risk during kernel panic.
--

--- Patch [1]: [PATCH] watchdog: mediatek: Enable pretimeout support ---
commit d882d4fa54231095050976209e4b882cc24fd54d
Author: Wanming Gao <wanming.gao@mediatek.com>
Subject: watchdog: mediatek: Enable pretimeout support

The watchdog pretimeout interrupt needs to be deasserted after the
hardware pretimeout event is received. Add IRQ level control handling
to the MediaTek watchdog interrupt handler so the interrupt is cleared
before notifying the watchdog core.

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 91d110646e16f..654194272e854 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
[ ... ]
> @@ -230,14 +230,17 @@ static int mtk_wdt_restart(struct watchdog_device *=
wdt_dev,
>  {
>  	struct mtk_wdt_dev *mtk_wdt =3D watchdog_get_drvdata(wdt_dev);
>  	void __iomem *wdt_base;
> +	unsigned long flags;
>  	u32 reg;
> =20
>  	wdt_base =3D mtk_wdt->wdt_base;
> =20
>  	/* Enable reset in order to issue a system reset instead of an IRQ */
> +	spin_lock_irqsave(&mtk_wdt->lock, flags);

[Severity: High]
Does acquiring this spinlock unconditionally risk a deadlock during a system
panic?

The restart handler is called during emergency restarts. If another CPU was
stopped via an IPI while holding mtk_wdt->lock (such as during the 70
microsecond delay in mtk_wdt_deassert_irq()), the panicking CPU will spin
infinitely here and hang the emergency reboot.

>  	reg =3D readl(wdt_base + WDT_MODE);
>  	reg &=3D ~WDT_MODE_IRQ_EN;
>  	writel(reg | WDT_MODE_KEY, wdt_base + WDT_MODE);
> +	spin_unlock_irqrestore(&mtk_wdt->lock, flags);
> =20
>  	while (1) {
>  		writel(WDT_SWRST_KEY, wdt_base + WDT_SWRST);
[ ... ]
> +static void mtk_wdt_deassert_irq(struct watchdog_device *wdd)
> +{
> +	struct mtk_wdt_dev *mtk_wdt =3D watchdog_get_drvdata(wdd);

[Severity: High]
Will watchdog_get_drvdata() return NULL here if a pending interrupt fires
during probe?

In mtk_wdt_probe(), devm_request_irq() is called to enable the interrupt be=
fore
watchdog_set_drvdata() initializes the driver data. If the bootloader left =
the
pretimeout interrupt enabled and it fires immediately during probe,
mtk_wdt_isr() will run and call mtk_wdt_deassert_irq().

This would result in watchdog_get_drvdata() returning NULL, followed by a N=
ULL
pointer dereference when accessing mtk_wdt->wdt_base.

> +	void __iomem *wdt_base =3D mtk_wdt->wdt_base;
> +	unsigned long flags;
> +	u32 reg;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824132914.2662=
346-1-wanming.gao@mediatek.com?part=3D1
