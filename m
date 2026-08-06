Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F76E64AA4
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998409; cv=none; b=XkYylXGHNeU8NqMuquaHr8dUV4+dijM/UiBYe0GANQNU9WlrR7P6so8uAbBBH+81aiULujVy1ASn0QHPliB2TlEkPvziEGCFsjEYg/pzxW5SgERxDP9opk0+Kq3oirdss9rfVGKV0keoZC0Qt40JEbq5pcCKiKSf54s72JTTth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998409; c=relaxed/simple;
	bh=pISriH/PNCtw1s0+N2ekkVYP4XGyftM6mR9JWij1KXo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WyOmAIlqLzf7BaHv7r13QaDkRN1B3FtlnIZJhaZuwmozk1HLE5Imc5KElU/NIoXCO3kYFCIU+YUmexxiR3oa4iWczAFkhS19V3mwAlIuUYbXR1YhTpRxpEGMFZpkYq7kxhk+G614PjBWKfsx7D2mcCgtoucUrrehUI18HlFd4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUNheupt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUNheupt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BD71F00A3A;
	Thu,  6 Aug 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785998407;
	bh=bQfrOA6Ovdsy41ZfBdagGnixkkkX8Ra7yu2yE/p9p0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RUNheupt0LCXU1ls2HmprRPTxx75VK/xT5LixSTlK2qnKXgWBBW0K+oZ7MLnz/2wq
	 jXKoje0G2dFXt8ecuHkMaqBXz7kjyvyu80/U7CJpw5LQOipYTtLT0jsrs50kkPHE6Z
	 KIohk1qsaZ7H6Dg1x26+pK3Gp3AXwrUPlKhZFZsJXeHwNVUeUPxrAOT7971yKH8qma
	 kpjABWjDid7Gmm1/kEMyzml+Y19iMDSeiOtozpausvysJbT2McaWwPNNm0gWO9ZuCT
	 zlb7alhq7CLed34i2FZ4rBRcNjwUwIjBVGJY73goG3gNSFKbDsun0oSG7xLPqUjq8S
	 GXTUfFMFLocGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] watchdog: stm32_iwdg: Propagate -EPROBE_DEFER from
 IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260806062812.26523-2-phucduc.bui@gmail.com>
References: <20260806062812.26523-1-phucduc.bui@gmail.com>
 <20260806062812.26523-2-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:40:06 +0000
Message-Id: <20260806064007.85BD71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Unexpected system reset due to probe deferral while the hardware w=
atchdog is already running.

Pre-existing issues:
- [High] Leaked wake_irq configuration on driver unbind or probe failure ca=
uses permanent reprobe failures.
- [High] The driver requests the IRQ before initializing the driver data us=
ed by the interrupt handler, creating a race condition that can result in a=
 NULL pointer dereference.
--

--- Patch [2]: [PATCH 2/2] watchdog: stm32_iwdg: Propagate -EPROBE_DEFER fr=
om IRQ lookup ---
commit dc7c8342d9ed50f0391276fabd2f26a71397adae
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: stm32_iwdg: Propagate -EPROBE_DEFER from IRQ lookup

platform_get_irq_optional() does not return 0. It returns a positive IRQ
number on success or a negative error code on failure. Return -EPROBE_DEFER
from platform_get_irq_optional() so the driver is re-probed.

> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index b356a272ff9a0..102f510849578 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
> @@ -287,7 +287,9 @@ static int stm32_iwdg_irq_init(struct platform_device=
 *pdev,
>  		return 0;
> =20
>  	irq =3D platform_get_irq_optional(pdev, 0);
> -	if (irq <=3D 0)
> +	if (irq =3D=3D -EPROBE_DEFER)
> +		return irq;

[Severity: High]
If the hardware watchdog is already running, won't returning -EPROBE_DEFER
here cause a regression by triggering an unexpected system reset?

If the bootloader started the watchdog, the hardware timer is actively
counting down. Because this deferral happens before the driver registers
with the watchdog core or pings the device, the probe will abort. Since
deferred probing can take an unpredictable amount of time, can the watchdog
expire and reset the system before the driver is successfully reprobed?

> +	if (irq < 0)
>  		return 0;
> =20
>  	if (of_property_read_bool(np, "wakeup-source")) {
>  		ret =3D devm_device_init_wakeup(dev);
>  		if (ret)
>  			return ret;
> =20
>  		ret =3D dev_pm_set_wake_irq(dev, irq);

[Severity: High]
This is a pre-existing issue, but does this leak the wake_irq configuration
on driver unbind or probe failure?

Since dev_pm_set_wake_irq() is not device-managed and lacks an explicit
cleanup via dev_pm_clear_wake_irq(), dev->power.wakeirq remains populated.
If a later initialization step fails or the driver is unbound, won't any
subsequent probe attempt hit a warning for an already initialized wake irq
and return -EEXIST, permanently failing reprobes?

>  		if (ret)
>  			return ret;
>  	}
> =20
>  	ret =3D devm_request_irq(dev, irq, stm32_iwdg_isr, 0,
>  			       dev_name(dev), wdd);

[Severity: High]
This is a pre-existing issue, but can this cause a NULL pointer dereference
if the interrupt fires immediately?

In stm32_iwdg_probe(), the interrupt is requested here before driver data
is initialized:

	ret =3D stm32_iwdg_irq_init(pdev, wdt);
	if (ret)
		return ret;

	watchdog_set_drvdata(wdd, wdt);

If the interrupt fires before watchdog_set_drvdata() is executed, the
interrupt handler will read NULL driver data:

stm32_iwdg_isr() {
	struct watchdog_device *wdd =3D wdog_arg;
	struct stm32_iwdg *wdt =3D watchdog_get_drvdata(wdd);
	u32 reg;

	reg =3D reg_read(wdt->regs, IWDG_EWCR);

Since wdt is NULL, won't dereferencing wdt->regs crash the kernel?

>  	if (ret)
>  		return ret;
> =20
>  	wdd->info =3D &stm32_iwdg_preinfo;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806062812.2652=
3-1-phucduc.bui@gmail.com?part=3D2
