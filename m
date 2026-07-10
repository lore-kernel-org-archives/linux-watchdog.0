Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66A63E023E
	for <linux-watchdog@vger.kernel.org>; Fri, 10 Jul 2026 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670293; cv=none; b=t/jUCXgtjcDMC6TJJmOnvhVfiaFkW+bqlPJRw+fX276lOHVsuUZ/2UL/3FQXTuKBC9R5MXMbpCRq4clqBvbrFQCEIRlr2t+HHzFYbYbJyEZ7eto0+FD5bWFZqr5YptFjuMFEj8fN9b9wwP/YZalbtIxJ/0/yuI7N3jy1X6r+z18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670293; c=relaxed/simple;
	bh=m/1MY5WLIp7tFK2/Cw6ssno2U3ZaFNDy7vzOfbh8siw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=keD5kTCvBMcf9nnRgpSUQourpg8h6OpNY699DVysTUuyiQGNZotcy0MXDwNM9Bu+R7v5790tC+h1z88rb6KgC//qdehAeH7etE6G20wo9iI6rz48Xwck889132VY5PE1MI5RtlK3Cb3AibNC+HnzWx0/WYF46ayeGQ1IS5EHA6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjeHLzsS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjeHLzsS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3021F000E9;
	Fri, 10 Jul 2026 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783670291;
	bh=G654zJTwYaWd5gRljGcNdilLSWVGf8q/pv+/UgCE5jQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjeHLzsSZm9sJxCJ1VmyZRNphfbO92xSEwbvosMV0U1F/FfL3aU13IZCw/ErkvjPg
	 Yd+MCJ/cMyDKX+Gi9tWhXq3WCsh+uZJOPb6ZlqKGAu5JSBCTYEYSTMxBAzj1RkKEHX
	 iVonijT715FOnhu84AyI/gM6/PHpm6RhIbEaUKiAURrojHhX10RiJpCp+erncJIU/A
	 rANesNzGGa3ShGwvL1a/IQKCw2s0zZLOG7K6PizIhQxxsVo9R9TfmHMdb5mKpz+tV1
	 TMhPVaqZmAAShSG86KyWqUKHrRf67kHUerfKfwMZ0z8HYYUpNiwRDsz6djp8rDXBaO
	 dAbdTMO7pG4qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/1] watchdog: realtek-otto: Change to use regmap API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rustam Adilov" <adilov@disroot.org>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260710074316.46643-2-adilov@disroot.org>
References: <20260710074316.46643-1-adilov@disroot.org>
 <20260710074316.46643-2-adilov@disroot.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 07:58:10 +0000
Message-Id: <20260710075811.4B3021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `disable_irq()` in the restart handler causes a scheduling=
 while atomic bug and a deadlock when triggered by a pretimeout panic.
- [High] The watchdog timeout setup logic does not clamp user timeouts to h=
ardware limits, breaking the watchdog core's software-extended timeout feat=
ure.
--

--- Patch [1]: [PATCH v3 1/1] watchdog: realtek-otto: Change to use regmap =
API ---
commit df79c826fd293fb9a9e926fad614d84ecc05598a
Author: Rustam Adilov <adilov@disroot.org>

watchdog: realtek-otto: Change to use regmap API

To make the realtek watchdog driver functional when SWAP_IO_SPACE
config is enabled, change all of the register access to be done
by regmap API which helps us to tweak endianness with big-endian
or little-endian property from within the device tree node.

Add the REGMAP_MMIO as a select to REALTEK_OTTO_WDT now that the
regmap is used.

> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realt=
ek_otto_wdt.c
> index 9094f2189f555..5c48ffba70a20 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c

[ ... ]

> @@ -141,14 +134,11 @@ static int otto_wdt_determine_timeouts(struct watch=
dog_device *wdev, unsigned in
>  	} while (phase1_ticks > OTTO_WDT_PHASE_TICKS_MAX
>  		|| phase2_ticks > OTTO_WDT_PHASE_TICKS_MAX);
> =20
> -	v =3D ioread32(ctrl->base + OTTO_WDT_REG_CTRL);
> -
> -	v &=3D ~(OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 | OTTO_WDT_CTRL_=
PHASE2);
> -	v |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
> -	v |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
> -	v |=3D FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
> -
> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
> +	mask =3D OTTO_WDT_CTRL_PRESCALE | OTTO_WDT_CTRL_PHASE1 | OTTO_WDT_CTRL_=
PHASE2;
> +	val =3D FIELD_PREP(OTTO_WDT_CTRL_PHASE1, phase1_ticks - 1);
> +	val |=3D FIELD_PREP(OTTO_WDT_CTRL_PHASE2, phase2_ticks - 1);
> +	val |=3D FIELD_PREP(OTTO_WDT_CTRL_PRESCALE, prescale);
> +	regmap_update_bits(ctrl->regmap, OTTO_WDT_REG_CTRL, mask, val);
> =20
>  	timeout_ms =3D total_ticks * tick_ms;
>  	ctrl->wdev.timeout =3D timeout_ms / 1000;

[Severity: High]
This is a pre-existing issue, but does otto_wdt_determine_timeouts() break
the watchdog core's software heartbeat extension?

When a user requests a timeout larger than the hardware's maximum capabilit=
y,
the prescale calculation loop earlier in this function exceeds
OTTO_WDT_PRESCALE_MAX and returns -EINVAL.

It seems the driver fails to clamp the requested timeout to its hardware
capability before programming the registers, and overwrites wdev.timeout wi=
th
the calculated hardware ticks. This prevents the core from maintaining the
full user-requested timeout via periodic pings.

[ ... ]

> @@ -192,7 +182,7 @@ static int otto_wdt_restart(struct watchdog_device *w=
dev, unsigned long reboot_m
> =20
>  	/* Configure for shortest timeout and wait for reset to occur */
>  	v =3D FIELD_PREP(OTTO_WDT_CTRL_RST_MODE, reset_mode) | OTTO_WDT_CTRL_EN=
ABLE;
> -	iowrite32(v, ctrl->base + OTTO_WDT_REG_CTRL);
> +	regmap_write(ctrl->regmap, OTTO_WDT_REG_CTRL, v);

[Severity: High]
This isn't a bug introduced by this patch, but can the call to disable_irq()
earlier in otto_wdt_restart() cause a deadlock during a pretimeout panic?

If the pretimeout governor is set to panic, otto_wdt_phase1_isr() calls
watchdog_notify_pretimeout() which triggers a kernel panic. The panic routi=
ne
disables local interrupts and calls machine_restart(), which invokes
otto_wdt_restart().

Because otto_wdt_restart() calls disable_irq(), it internally calls
synchronize_irq() which will spin waiting for the currently active interrupt
handler (otto_wdt_phase1_isr) to complete.

Since we are already inside that handler, this will hang indefinitely during
reboot. Additionally, calling disable_irq() in an atomic context with
interrupts disabled could trigger a scheduling while atomic bug.

> =20
>  	mdelay(3 * otto_wdt_tick_ms(ctrl, 0));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710074316.4664=
3-2-adilov@disroot.org?part=3D1
