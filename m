Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B103EEAE2
	for <linux-watchdog@vger.kernel.org>; Tue, 13 Oct 2026 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900486; cv=none; b=U69CBXetJTGR2xpQQrTXUGxqN1O775aY6hbbFITOkfjELOAz8MMj5H6I2LOKegf5ld4/EWgFZD1mrDq2ZN6jC/3XNJ6o2+78zHFXFjtL2/OAu70+Vqi0xr0gWOu1hOp1j1h69gBzSE+83P0XYVDA5bjafF5/w84N9AocQ6P9fYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900486; c=relaxed/simple;
	bh=N/wZJT5wn25p8vF7TSvOgRtkVE+KtQ8AR2YJroryt0o=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=B3yY1AFUd62erbGZijtVGXCcEDya2IvnF5oTu6Vij/2z7V4+fvwq3X9cXzbnCjJx8ypaxwejKT0zKXDogC5iXBgTZJGQE3903a6n2UVj+Ms8xEcSzvTfGo3VQUJM07hfBr6Gck27O03+pSvY/S7fZW5R01MG4xptaF9PuaHuEh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAQNWhyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAQNWhyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00E11F000FF;
	Tue, 13 Oct 2026 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791900485;
	bh=0B+zWuS24a6kUmscP2dlDgZ55fZRYsKaUtNBBTZfueQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PAQNWhyKKrb2gzZ7/XWnnsfPCFwpqvYwjVPu48SvC2+4g6V0CQZ8bCOwRF034Duze
	 yR7xA4MXUyz68FbaI07Pylm+kGdU1ScraH0uZUxPCiqP/ut4J4sRXf/RCGtFSCyymB
	 4ABQCm+x6L4msjr5zxcrh6vRgPR3Bhc4UzweJ35ueKmnHWSmbhCQAx2659409OcdeY
	 whm/jN4iMstOLJrxOCOkpq4VwaGkugT2bgFupbs3OQFUjWFuZKZf2B+41+P4TuKQow
	 y1FJVLCStUJiplIsXZMqYLvr4Dg6ovcPzF32B0iBXnQ+54MFszaLncdB3xkG5rz41U
	 G3MC4pNqaQddQ==
Message-ID: <sashiko-outbox-169886@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] watchdog: w83627hf_wdt: Add minute mode counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Louvel" <paul.louvel@bootlin.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20261013-w83627hf_wdt-improvements-v4-6-b6f6b60a9566@bootlin.com>
References: <20261013-w83627hf_wdt-improvements-v4-0-b6f6b60a9566@bootlin.com>
 <20261013-w83627hf_wdt-improvements-v4-6-b6f6b60a9566@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 14:08:04 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] watchdog: spurious hardware reboot during timeout mode transition
--

commit e9913194bed75434ff662763db21c93683fc01dc
Author: Paul Louvel <paul.louvel@bootlin.com>

watchdog: w83627hf_wdt: Add minute mode counting

All of the chips supported by the driver can be set to minute mode,
allowing timeout value up to 255 minutes. Add it to the driver.

> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_=
wdt.c
> index 0b9195e7e95ef..8f78fe64acde9 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c

[ ... ]

> @@ -290,6 +284,7 @@ static int w83627hf_init(struct watchdog_device *wdog=
, enum chips chip)
>  static int wdt_set_time(struct watchdog_device *wdog, unsigned int timeo=
ut)
>  {
>  	struct w83627hf_data *data =3D watchdog_get_drvdata(wdog);
> +	unsigned char ctrl;
>  	int ret;
> =20
>  	ret =3D superio_enter(data->sio->addr, data->sio->cfg_enter);
> @@ -297,6 +292,15 @@ static int wdt_set_time(struct watchdog_device *wdog=
, unsigned int timeout)
>  		return ret;
> =20
>  	superio_select(data->sio->addr, W83627HF_LD_WDT);
> +
> +	ctrl =3D superio_inb(data->sio->addr, data->reg->control);
> +
> +	if (data->minute_mode)
> +		ctrl |=3D WDT_CTRL_MINUTE_MODE;
> +	else
> +		ctrl &=3D ~WDT_CTRL_MINUTE_MODE;
> +
> +	superio_outb(data->sio->addr, data->reg->control, ctrl);
>  	superio_outb(data->sio->addr, data->reg->timeout, timeout);

[Severity: High]
Can this sequence trigger a spurious hardware reboot during a timeout mode
transition?

In wdt_set_time(), the hardware control register is updated first to change
between minute and second modes, immediately followed by the timeout regist=
er:

	superio_outb(data->sio->addr, data->reg->control, ctrl);
	superio_outb(data->sio->addr, data->reg->timeout, timeout);

When transitioning from minute mode to second mode (for example, from 1 min=
ute
to 10 seconds), the hardware control register is updated first. The hardware
timer momentarily retains its old value (1) but interprets it under the new
unit (seconds), meaning it evaluates that only 1 second is left.

If the thread is preempted (e.g., by an SMI or a hypervisor) between these =
two
superio_outb() calls for longer than this intermediate duration, will the
hardware watchdog fire and spuriously reboot the system?

Would it be safer to temporarily disable the watchdog (by writing 0 to the
timeout register) before modifying the control register's mode bit?

>  	superio_exit(data->sio->addr, data->sio->cfg_leave);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-w83627hf_w=
dt-improvements-v4-0-b6f6b60a9566@bootlin.com?part=3D6
