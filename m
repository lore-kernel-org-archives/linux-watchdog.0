Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77942481AA3
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710283; cv=none; b=P2RvrxxIbYqSpheEa9AOi5RISN3VxaG7Yk1Lw+zHgTXjo9j8XFcQKbD9k/eBFjxxgk8Hm59bPvRNBmn6mWz5KvXll8+kaeEhwpdEfLMynJO3rAooP//BwcGk0v+oNG7M62tlpYhkXjOTE2PTZtjsthW0TQPyIFqipJQ89LLC0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710283; c=relaxed/simple;
	bh=Tn6QIjtt9ZD0Ezdc+at/nbxmdaCxApSwJ752Oj0Ui94=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u34FUJznBCSiGw373B74jaWv7zh9yvI4nJvUmwPTx3UzG+KZXEAvjNmR9Qiw/BTOIdy+/1IIJ7CQyaAi3LphBcGBNJcKt37dhGcFWJcAhhH/7rMURQopyFRIMv0K8M7MO2iWKvHR8EadirXcY2Wjz7IuihgiajRBrIJcWBtcAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+lfstxg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+lfstxg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B2E1F000E9;
	Wed, 22 Jul 2026 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710282;
	bh=nQ4nw+Th0wTzdEr/dYtbLOBBU5dvW0Y4bckaneTWU58=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H+lfstxgI8iEz/F2tg87f72Ate3cEXDuzyydBS8T2Ck1kG90nLQtmxBEsjnbBwfpf
	 5wG6RS13A+4M4A2i6dOdtQ5VXGoZd0Usc+AZUelVf+F+oSQaEwiE/uQzdE/IgTgeuK
	 OxOiJOgDmqYkQvvPfwz5n0PbYeEKYcJ0Q4fwc4iOGaHblQbZHPl10qmOAOdZgopo0b
	 TRsEZER9vwh0XwMRsvnnrfe7ufIVqKE/iDhSzRBryAxG3eYkJicEVjT8N7eRDyTZKA
	 gJCEzjc1jd7rBtrtHhFsXEq9zflpQ/2pxC8ZHDeuGlhZXHtqBEkaMImXXFilf0nm8i
	 oDwkIR+YpJ8KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/9] watchdog: marvell_gti: Remove redundant
 dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-6-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-6-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:51:21 +0000
Message-Id: <20260722085121.E9B2E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Double disable and unprepare of the clock due to a redundant devre=
s action.
- [Medium] The watchdog device is exposed to userspace before its IRQ is fu=
lly requested, creating a race condition.
- [Medium] Pretimeout value is not updated when the pretimeout interrupt is=
 disabled, leaving a stale state.
--

--- Patch [5]: [PATCH 5/9] watchdog: marvell_gti: Remove redundant dev_err_=
probe() ---
commit 2a9a85c950abb5fda8867255ce0f94190626fc24
Author: Pan Chuang <panchuang@vivo.com>

watchdog: marvell_gti: Remove redundant dev_err_probe()
   =20
Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs detailed error
messages on failure. Remove the now-redundant driver-specific dev_err_probe=
()
call.

> diff --git a/drivers/watchdog/marvell_gti_wdt.c b/drivers/watchdog/marvel=
l_gti_wdt.c
> index 298089d45ab89..31167034963c1 100644
> --- a/drivers/watchdog/marvell_gti_wdt.c
> +++ b/drivers/watchdog/marvell_gti_wdt.c
> @@ -321,7 +321,7 @@ static int gti_wdt_probe(struct platform_device *pdev)
>  	err =3D devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
>  			       pdev->name, &priv->wdev);

[Severity: Medium]
This is a pre-existing issue, but is there a race condition here if the dev=
ice
is exposed to userspace before its IRQ is fully requested?

In drivers/watchdog/marvell_gti_wdt.c:gti_wdt_probe(), the watchdog device =
is
registered before requesting the interrupt:

	err =3D devm_watchdog_register_device(dev, wdog_dev);
	if (err)
		return err;

	irq =3D platform_get_irq(pdev, 0);
	if (irq < 0)
		return irq;

	err =3D devm_request_irq(dev, irq, gti_wdt_interrupt, 0,
			       pdev->name, &priv->wdev);

If userspace opens /dev/watchdog and starts the watchdog immediately after
devm_watchdog_register_device() completes, but before devm_request_irq()
registers the handler, could this lead to unhandled hardware interrupts or
spurious interrupt warnings?

Should device registration be the final step in probe() to guarantee all
hardware resources are fully prepared before userspace can interact with th=
em?

>  	if (err)
> -		return dev_err_probe(dev, err, "Failed to register interrupt handler\n=
");
> +		return err;
> =20
>  	dev_info(dev, "Watchdog enabled (timeout=3D%d sec)\n", wdog_dev->timeou=
t);
>  	return 0;

[Severity: High]
This is a pre-existing issue, but does this code cause a double disable and
unprepare of the clock?

Looking at drivers/watchdog/marvell_gti_wdt.c:gti_wdt_get_cntfrq():

	priv->sclk =3D devm_clk_get_enabled(&pdev->dev, NULL);
	if (IS_ERR(priv->sclk))
		return PTR_ERR(priv->sclk);

	err =3D devm_add_action_or_reset(&pdev->dev,
				       gti_clk_disable_unprepare, priv->sclk);

Since devm_clk_get_enabled() automatically adds a devres action to disable
and unprepare the clock on teardown, does registering a redundant devres ac=
tion
(gti_clk_disable_unprepare) for the same clock cause clk_disable_unprepare()
to be called twice on a single reference during driver unbind or probe error
paths?

[Severity: Medium]
This is a pre-existing issue, but does the pretimeout value remain stale wh=
en
the pretimeout interrupt is disabled?

Looking at drivers/watchdog/marvell_gti_wdt.c:gti_wdt_set_pretimeout():

	if (!timeout) {
		/* Disable Interrupt */
		writeq(GTI_CWD_INT_ENA_CLR_VAL(priv->wdt_timer_idx),
		       priv->base + GTI_CWD_INT_ENA_CLR);
		return 0;
	}

When timeout is 0, the code disables the pretimeout in hardware and returns=
 0.

However, because the driver implements the set_pretimeout callback, does the
watchdog core framework delegate software state tracking to it?

Since the driver fails to update wdev->pretimeout =3D 0, would userspace qu=
eries
via WDIOC_GETPRETIMEOUT return the old, non-zero value, falsely indicating
pretimeout is still active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D5
