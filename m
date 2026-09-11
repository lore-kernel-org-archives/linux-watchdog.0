Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92383282F27;
	Fri, 11 Sep 2026 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119053; cv=none; b=nwBdT9OSwuU+gdyW9wc0ItVf1ILttQmBgzW6mwuo5UO3IZU/j75/mEZMEgMQ5HmdDLgI8SBTAkwfI1SKWGQUnHpc9xYmTjk4uT04Sidt7wP+G358ZI/zWDIg782KltYMmyPsa8eGTOYlpBSeQg9FAkNaeizXIeWFwpq+3ViPNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119053; c=relaxed/simple;
	bh=8qj2PWVeYrIbdbsJc4hEcpxOJI66XfS2rTovjY/NoxY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jrpnHnL3oaSgus7KaeZRiA/MhNzU4pskd1kBEo7rRW0brLZPM306GN0L1FOZFHbZRnX9TYUEgRb5MoaMLzfOKgFfGe+ogB+tojAoTtZctv1z1whf2vTCqOJ8h0ycelsF/JW8NyYoXyuz+nkBAfxUepv94jtUdUX3cNgFrAH1SiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOJy8wl4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOJy8wl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B671F000FF;
	Fri, 11 Sep 2026 09:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789119052;
	bh=t2aOjt5tIh6MDe3T1ATlDNgu1p8ZG3wm9qIF1VZyhv8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SOJy8wl4QMQflGk3bIjOR5JIz8HoTYI7obRj/Aa69VUCDNdh4F70QGHbP74nDfiO7
	 ++2+mxVqJKjKWuTR22iXJNMDqLgOEZelLKo2w75umK2qq8a6MRPKDQiwTuY8XQKFrC
	 NMjeLr96IEgrHX8+e9ZUK/no5kXS4KlqAm7nhvKvAEbLXd7fpYz3jdOY4KywmSZ7se
	 YTxHVnoEe6eQpfVk8Z1ltzoiTJUDoDWjfLIrhnRs2NAJTGnpikpfeE1zSwXAVbOZBk
	 JOAh+Xx2apnLCd5Lk5ImHsvran/EJmto2WmanG/wM3hIkYiRastqSzHgOGXDSqNR/Z
	 HM3yN8eCShcWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] watchdog: omap: Add support for reading boot status
Reply-To: sashiko-reviews@lists.linux.dev
To: "Diogo Ivo" <diogo.ivo@bootlin.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260911-omap4-wdt_boot-v1-2-637d778a4a1e@bootlin.com>
References: <20260911-omap4-wdt_boot-v1-0-637d778a4a1e@bootlin.com>
 <20260911-omap4-wdt_boot-v1-2-637d778a4a1e@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 09:30:51 +0000
Message-Id: <20260911093051.D2B671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] omap_wdt_is_running() fails to detect a running watchdog if the =
bootloader configured a hardware prescaler, causing a false negative.

Pre-existing issues:
- [High] Missing return value check for pm_runtime_get_sync() leads to pote=
ntial system crash on unclocked MMIO access.
--

commit a118768ddc7f3bc1aec5e3a2e71d0f63ab1a2766
Author: Diogo Ivo <diogo.ivo@bootlin.com>
Subject: watchdog: omap: Add support for reading boot status

This commit adds support for determining the boot status of the watchdog
during driver probe. By checking if the counter is actively incrementing,
the driver can maintain a running watchdog previously enabled by the
bootloader.

> diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
> index f8a76df3c7882..d9ab46c70f8c8 100644
> --- a/drivers/watchdog/omap_wdt.c
> +++ b/drivers/watchdog/omap_wdt.c

[ ... ]

> @@ -225,6 +228,20 @@ static const struct watchdog_ops omap_wdt_ops =3D {
>  	.get_timeleft	=3D omap_wdt_get_timeleft,
>  };
> =20
> +static bool omap_wdt_is_running(struct omap_wdt_dev *wdev)
> +{
> +	unsigned long period_us =3D USEC_PER_SEC / RATE_32K;
> +	void __iomem *base =3D wdev->base;
> +	u32 value;
> +
> +	value =3D readl_relaxed(base + OMAP_WATCHDOG_CRR);
> +
> +	/* Give the watchdog some time to count if it's on */
> +	usleep_range(period_us * 10, period_us * 11);

[Severity: Medium]
Could this wait duration fail to detect a running watchdog if the bootloader
configured a hardware prescaler?

The duration statically assumes an unscaled 32kHz clock. If the bootloader
enabled the watchdog and configured a non-zero prescaler via the PTV bits in
OMAP_WATCHDOG_CNTRL, a single clock tick will take much longer.=20

For example, with a large prescaler like PTV=3D7, the 32kHz clock is divided
by 128, meaning a single clock tick takes around 3.9ms. The hardcoded wait
of ~330us would complete before the counter increments.

Would this cause omap_wdt_is_running() to return a false negative, leading
the probe function to incorrectly conclude the watchdog is stopped and
subsequently disable it?

> +
> +	return readl_relaxed(base + OMAP_WATCHDOG_CRR) !=3D value;
> +}
> +
>  static int omap_wdt_probe(struct platform_device *pdev)

[ ... ]

> @@ -267,7 +284,7 @@ static int omap_wdt_probe(struct platform_device *pde=
v)
>  			wdev->wdog.bootstatus =3D WDIOF_CARDRESET;
>  	}
> =20
> -	if (early_enable) {
> +	if (omap_wdt_is_running(wdev) || early_enable) {

[Severity: High]
This is a pre-existing issue, but does pm_runtime_get_sync() need a return
value check before we attempt hardware register accesses in this path?

If the clock domain cannot be enabled and pm_runtime_get_sync() fails earli=
er
in omap_wdt_probe(), proceeding to call the newly added omap_wdt_is_running=
()
will result in reading from unclocked OMAP registers.

Can this unclocked MMIO access trigger an asynchronous external abort and
crash the system? The same concern applies to omap_wdt_start() and
omap_wdt_disable() where pm_runtime_get_sync() is also left unchecked.

>  		omap_wdt_start(&wdev->wdog);
>  		set_bit(WDOG_HW_RUNNING, &wdev->wdog.status);
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-omap4-wdt_=
boot-v1-0-637d778a4a1e@bootlin.com?part=3D2
