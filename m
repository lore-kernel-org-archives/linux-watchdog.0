Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C743D3482
	for <linux-watchdog@vger.kernel.org>; Fri, 12 Jun 2026 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268293; cv=none; b=PmevFn5+aWJuRFZHohz5apc9Nnwhn+WV66rt32bVPqQnva3zsNsMan1Dq/HtQRQa2RxU/hZdXnuHtZeah0tXl+fSIU4e4NTVgu1pbMvbaVAc6nkEhDkTP8SV4h5WgRAOx1i2vQIvG9gWe0GHmsQMZiH3R+AI7U/oyKPMgxGDsnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268293; c=relaxed/simple;
	bh=FYt0/fSakT70dB77x/fy15QuYYHwhTLaY2kIcK9G8yc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jUf5h+8vfRKXgd7Hon+YbfU1lPys2AqVEhTfekaQf/RgrIr6etADUr8rElDYHqOi0AUb54xafl/0ynB1ZeiEyg7JU7lQarMaqjc/WvXUAxWqBjXkaMNw4RkAN0oiVUQSoob5snZHD6gnPbayJdfplns4Z/fkc8J/jjE6Lk2A4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnEaLvmv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnEaLvmv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000B91F000E9;
	Fri, 12 Jun 2026 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781268292;
	bh=hD/aCuT8O53qC717tjs4lZgAjUyPl6hllc7+zkaPtgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bnEaLvmvAaQ/ll6OELi1na7fS0WULfaQ1TrVlD8BJ8djIxnWGqEiOX7VX7038kzvl
	 6pOlQlw1NgmNfwh0CN089NbC4TIG2QtclAWDpdwgD6DY4RB3iBymjRbzSY/SU00D25
	 deKMK0edMB1zOXDb2KH6P6/64y+HvwkGqpiy77LVeeY8DIxNN1Z2VEuM2OKN3M/bzY
	 5aB+xl4O+TVJFJfWLxEOXAnbv54xFZ/Va/WdEyYggpvGSB9ABYcDU78wPVqVNsI2oQ
	 6IKjDxstZgYnEGOmc+RJ+9f2tGYPL3IRJtc5lqvX8t6chISIG52AEGAAANUlpXC72B
	 I7aCFmHJmH+Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: stm32_iwdg: Base pretimeout on timeout when
 not specified
Reply-To: sashiko-reviews@lists.linux.dev
To: "Benjamin Frost" <benjamin@geanix.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260612123203.1331849-1-benjamin@geanix.com>
References: <20260612123203.1331849-1-benjamin@geanix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 12:44:51 +0000
Message-Id: <20260612124452.000B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Medium] Userspace cannot disable the pretimeout feature, and the patch i=
ntroduces a state inconsistency where the API reports the pretimeout as dis=
abled (0) while the hardware interrupt remains active.

Pre-existing issues:
- [High] The driver fails to validate and clear an explicitly configured `p=
retimeout` when a new, shorter `timeout` is set, causing an arithmetic unde=
rflow and continuous interrupts.
- [High] The pretimeout calculation mathematically underflows when the soft=
ware `timeout` exceeds the hardware's maximum supported limit, resulting in=
 an immediate interrupt storm.
- [High] The driver fundamentally inverts the logic of the `pretimeout` UAP=
I, treating it as elapsed time instead of remaining time.
--

commit 53fd4e70debe020df0adba54327baa8bf331b885
Author: Benjamin Frost <benjamin@geanix.com>

watchdog: stm32_iwdg: Base pretimeout on timeout when not specified

This commit introduces a local pretimeout variable to hold the effective
pretimeout value. This prevents the driver from modifying the configured
pretimeout, ensuring it is recalculated when the timeout changes.

> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index b356a272ff9a0..a38e204129ff4 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
[ ... ]
> @@ -97,17 +97,19 @@ static int stm32_iwdg_start(struct watchdog_device *w=
dd)
>  {
>  	struct stm32_iwdg *wdt =3D watchdog_get_drvdata(wdd);
> -	u32 tout, ptot, presc, iwdg_rlr, iwdg_ewcr, iwdg_pr, iwdg_sr;
> +	u32 tout, ptot, presc, iwdg_rlr, iwdg_ewcr, iwdg_pr, iwdg_sr, pretimeou=
t;
>  	int ret;
> =20
>  	dev_dbg(wdd->parent, "%s\n", __func__);
> =20
> -	if (!wdd->pretimeout)
> -		wdd->pretimeout =3D 3 * wdd->timeout / 4;
> +	if (wdd->pretimeout)
> +		pretimeout =3D wdd->pretimeout;
> +	else
> +		pretimeout =3D 3 * wdd->timeout / 4;

[Severity: Medium]
If userspace disables the pretimeout by setting it to 0, doesn't this logic
force a fallback to 3/4 of the timeout using the local variable?

Because the hardware Early Wakeup Interrupt is unconditionally enabled
further down in this function:

	if (wdt->data->has_early_wakeup)
		reg_write(wdt->regs, IWDG_EWCR, iwdg_ewcr | EWCR_EWIE);

and wdd->pretimeout remains 0, the API will falsely report the pretimeout as
disabled while the hardware continuously generates interrupts.

[Severity: High]
This is a pre-existing issue, but stm32_iwdg_set_timeout() lacks logic to c=
ap
or clear wdd->pretimeout when a new, shorter timeout is set.

If a user explicitly sets a pretimeout of 10s and later reduces the timeout=
 to
5s, wdd->pretimeout remains 10s, which then leads to an underflow during the
subtraction below.

>  	tout =3D clamp_t(unsigned int, wdd->timeout,
>  		       wdd->min_timeout, wdd->max_hw_heartbeat_ms / 1000);

[Severity: High]
This isn't a bug introduced by this patch, but does this clamping logic bre=
ak
when using long software-emulated timeouts?

If wdd->timeout is larger than the hardware limit, tout is clamped down
(e.g., to ~32s). However, pretimeout is derived from the unclamped software
wdd->timeout (e.g., for a 100s timeout, fallback pretimeout is 75s).

When the code calculates tout - pretimeout below, 32 - 75 will underflow,
causing ptot to be clamped to tout. The early wakeup register then equals
the reload register, causing the interrupt to fire instantly on every
worker ping.

> -	ptot =3D clamp_t(unsigned int, tout - wdd->pretimeout,
> +	ptot =3D clamp_t(unsigned int, tout - pretimeout,
>  		       wdd->min_timeout, tout);

[Severity: High]
This is a pre-existing issue, but does this calculation reverse the
watchdog UAPI semantics?

The UAPI defines pretimeout as the remaining time before the reset triggers.
The hardware uses a down-counter that triggers when it reaches IWDG_EWCR,
which means IWDG_EWCR should represent the remaining time.

By calculating ptot =3D tout - pretimeout, a 10s pretimeout on a 60s timeout
programs the register to 50s. The hardware starts at 60s and triggers at 50=
s,
meaning the interrupt fires after only 10 seconds of elapsed time (50 secon=
ds
too early).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612123203.1331=
849-1-benjamin@geanix.com?part=3D1
