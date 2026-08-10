Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740DE3A9856
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350993; cv=none; b=HMh0RRt0DWK6Z97/MLrAhDAzf/c+MB/oaGunASVDDkwNac471zh6iMnz7SxIrxigvSDmuH7EXMVWP8sVjE+J+PrRRwCuDjlVY6n4qohqXcUj0DsGv3ZtJSQ6XVEa6T5aptbrJ348p8s78UKgmqOuzPlvjnM1oUGQPrQsNZAsg50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350993; c=relaxed/simple;
	bh=YOjRdWrr2e/C4yqgvGWwocsY1VHPMSTCVvmZtiFW0dw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P9IdQ5JFcaOk2wggjnvMzl4DUeunrh0utdaQ4VHWjyI5UOWhQ4jgq8EY4Cj22BfK7JyxTw4PoaHjXIL7r7vcNvKxEf1d/qmdz2qDvaR3AMbJPiy8gMQp9aE9Nu7zxSglOFy0xkTox6hF7v2hx4WS0ViDdrfUH+8kLUivoBjp6BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNPou9WL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNPou9WL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B29D1F000E9;
	Mon, 10 Aug 2026 08:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350992;
	bh=wtA9HN9UcwzNowX5LssseMCxg8/g5fLhzFrDtU6eZFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNPou9WLBI3vjkrZg5vhjAKir6wx+IzBvlVBikG5ar95LSXPY/6ZwJY88qEH6Zx2D
	 C4RNqw1iphdfxLFzTE5PqTqDiNTlEsCidbHJf/p+rpziOHMjcDoDxtXpaPdDgRS2Wv
	 GFHz/BGpMleJ/c1E930nQYxXQRy3H6txU1JMmPgiB/k1qiOsEdPlAC90EQERxY9Y8f
	 UAjm7z+0tMSgOzafbtcxTMjwQ4gWMVGT/TRchLGNj2A7u5sSLmuSg1V8NZw3Hnj34h
	 PMTiWAWphlVhHG/wlQvO2MmZiB/KTs1PH+3wTsfFlxaoaoxc8fQ37EJRr+3iw7iUa4
	 SjIo7dJm0OpNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] watchdog: orion_wdt: Propagate errors from optional
 IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260810082606.42623-1-phucduc.bui@gmail.com>
References: <20260810082606.42623-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 08:36:31 +0000
Message-Id: <20260810083632.3B29D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe deferral of optional IRQs causes a running watchdog to reset=
 the system.
- [High] Race condition in driver removal and error paths allows IRQ handle=
r to access unclocked registers.
--

--- Patch [1]: [PATCH v3] watchdog: orion_wdt: Propagate errors from option=
al IRQ lookup ---
commit 18f3c178650daa4e1cc407d2909bc28318084819
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: orion_wdt: Propagate errors from optional IRQ lookup

This patch updates the orion_wdt driver to propagate errors returned by
platform_get_irq_optional() instead of continuing without an IRQ. It routes
errors like -EPROBE_DEFER and -EINVAL to the disable_clk error handling pat=
h.

Link: https://lore.kernel.org/all/20260807080447.35479-1-phucduc.bui@gmail.=
com/

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 1802634cc7cda..0ea946823b0a7 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -606,6 +606,10 @@ static int orion_wdt_probe(struct platform_device *p=
dev)
> =20
>  	/* Request the IRQ only after the watchdog is disabled */
>  	irq =3D platform_get_irq_optional(pdev, 0);
> +	if (irq < 0 && irq !=3D -ENXIO) {
> +		ret =3D irq;
> +		goto disable_clk;

[Severity: High]
This is a pre-existing issue, but does returning -EPROBE_DEFER here cause an
unintended system reboot if the hardware watchdog was left running by the
bootloader?

If orion_wdt_probe() detects the hardware is running and sets
WDOG_HW_RUNNING, but then defers probe here, the watchdog core won't
register the device or ping it. The driver jumps to the disable_clk label,
but on many Armada platforms the shared clock doesn't physically stop.
The timer will continue ticking and eventually forcefully reset the SoC.

> +	}
>  	if (irq > 0) {
>  		/*
>  		 * Not all supported platforms specify an interrupt for the

[ ... ]

> @@ -619,6 +623,10 @@ static int orion_wdt_probe(struct platform_device *p=
dev)
> =20
>  	/* Optional 2nd interrupt for pretimeout */
>  	irq =3D platform_get_irq_optional(pdev, 1);
> +	if (irq < 0 && irq !=3D -ENXIO) {
> +		ret =3D irq;
> +		goto disable_clk;

[Severity: High]
This isn't a bug introduced by this patch, but does the disable_clk error
path leave a window for a fatal bus fault?

The driver manages interrupts using devm_request_irq(), meaning devres
cleanup runs after orion_wdt_probe() returns. By manually calling
clk_disable_unprepare() in the disable_clk path before the IRQ is
unregistered, the interrupts remain active while the clock is gated.

If the pre-timeout interrupt fires during this window, orion_wdt_pre_irq()
will access registers of a clock-gated peripheral, which causes a
Synchronous External Abort on ARM architectures. The same race exists in
orion_wdt_remove().

> +	}
>  	if (irq > 0) {
>  		orion_wdt_info.options |=3D WDIOF_PRETIMEOUT;
>  		ret =3D devm_request_irq(&pdev->dev, irq, orion_wdt_pre_irq,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810082606.4262=
3-1-phucduc.bui@gmail.com?part=3D1
