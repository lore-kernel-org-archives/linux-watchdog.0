Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985089;
	b=AStBkP7CSGMoZITHWmRAZXZjsp+OLMpm+qPvNDL4bS7XNqQgjeoxQMRnfo6XY2foat38
	 99kNui+vcC3bW7PDWB1PluWzHtDtuK2JRn2n3cgTlhEaD5NRWmQ5EZk5otXvYt75kPVDo
	 IcO3cf87c0uxpa+/jVizMXpQn/blzpa/WZdpyvT2fV9jgnGudRz50wqC58KS0xcbRyggI
	 CL/gsHMd/PNyAmpqofhjqNExN4iEXq4YzmnFR8LXPjIDYnt0YHuMK6C63bIK88bfQfASx
	 8JeiQt0UAQzTub7mD8TvWB01bQI6koomkT7XLNKz+27AqiokDA8BMgjWLWB1fcecQjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985089;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GL67RXdQa36K78wuxyhKhUCWCZT+FTnpPKTTkNMtBsY=;
	b=umOvAtsNc9lDUxj3LQ6/U5/muZDTuGHEkYQAusjyGm+E0DDXWHpoTUNquZsTtgfD/gjL
	 AP2gxi5JjjKg8cVBH8YkdIsd6ymZUU/X2BEIsCRGpT3dxhBlKG7ARaASxjU7h5D1YJWM/
	 BGCbmSNN/FGzxuCD7IeBmYw4UJbLqtzDgtDnjWj+NlOHJpan3LZ9r0KG0QdsxZoimAYdK
	 f1R2jYsnOIl+0boQbJLTaMivmc2YzD5lIM96BwRc1a3942XadsV9rTrTgXoEfjMEEZRui
	 bVDhXaX01Q8dDZrFhhjsrUHsd83PI2D8lQeeAs+JpNIWYx99/uUBxddp+jnaPZh9WLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlcD7lM8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76303606A326;
	Fri,  6 Nov 2026 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlcD7lM8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0811E1F0089F;
	Fri,  6 Nov 2026 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985089;
	bh=GL67RXdQa36K78wuxyhKhUCWCZT+FTnpPKTTkNMtBsY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LlcD7lM8L0/3og4uqb/+Tm+XaRxte9vj/PeY7kN9QDFB4kFVCRyv9wibnMt7l/+dj
	 F0758ub4k7wQdG+eETa0dDmrcIHS/9C/rViHoBjlOv1Xipx6QiaX9vd58wGqZVW7Ih
	 pi1U0zsYOJyeinMpyBuGl5fqpSrWBvYVUKET+Os2PCCDYi9V+pnsx7pYImevGeUTqX
	 stfWzcoTjnerwvPUlYvwu16aAQsMXLSpcGDgv6jcIe++yKczRidsgFtkFwE66fscYT
	 eozr1orG+Xc7KyXKRbGLZcqVkOwmZ3qZ0SyJtuHiaerhT+mMpgRuxcQSHniY9B9SnV
	 ovy6/7ZoiOQuw==
Message-ID: <sashiko-outbox-201901@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] watchdog: stm32_iwdg: add pretimeout support
 for iwdg v4.0
Reply-To: sashiko-reviews@lists.linux.dev
To: "Antonio Borneo" <antonio.borneo@foss.st.com>, devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261106163429.618392-4-antonio.borneo@foss.st.com>
References: <20261106163429.618392-1-antonio.borneo@foss.st.com>
 <20261106163429.618392-4-antonio.borneo@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:11:28 +0000
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] watchdog: stm32_iwdg: IRQ enabled before state init in
  stm32_iwdg_probe()
--

commit f781715ad1087a5b9a86d2dd54ce3b998243a348
Author: Antonio Borneo <antonio.borneo@foss.st.com>

watchdog: stm32_iwdg: add pretimeout support for iwdg v4.0

This commit updates stm32_iwdg_isr() to clear pretimeout interrupts via
IWDG_ICR on IWDG hardware version 4.0 and later, and adds a reg_set()
helper.

> diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
> index ce3e1f96ef50a..6121c23889655 100644
> --- a/drivers/watchdog/stm32_iwdg.c
> +++ b/drivers/watchdog/stm32_iwdg.c
[ ... ]
> @@ -194,11 +207,11 @@ static irqreturn_t stm32_iwdg_isr(int irq, void *wd=
og_arg)
>  {
>  	struct watchdog_device *wdd =3D wdog_arg;
>  	struct stm32_iwdg *wdt =3D watchdog_get_drvdata(wdd);
> -	u32 reg;
> =20
> -	reg =3D reg_read(wdt->regs, IWDG_EWCR);
> -	reg |=3D EWCR_EWIC;
> -	reg_write(wdt->regs, IWDG_EWCR, reg);
> +	if (wdt->hw_version >=3D ICR_MIN_VER)
> +		reg_write(wdt->regs, IWDG_ICR, ICR_EWIC);
> +	else
> +		reg_set(wdt->regs, IWDG_EWCR, EWCR_EWIC);
> =20
>  	watchdog_notify_pretimeout(wdd);

[Severity: Medium]
Can stm32_iwdg_isr() run before wdt->hw_version and wdd's driver data are
initialized in stm32_iwdg_probe()?

drivers/watchdog/stm32_iwdg.c:stm32_iwdg_probe() {
    ...
	ret =3D stm32_iwdg_irq_init(pdev, wdt);
	if (ret)
		return ret;

	wdt->hw_version =3D reg_read(wdt->regs, IWDG_VERR) & VERR_MASK;

	watchdog_set_drvdata(wdd, wdt);
    ...
}

stm32_iwdg_irq_init() calls devm_request_irq() before wdt->hw_version is
read from IWDG_VERR and before watchdog_set_drvdata() sets wdd's driver
data.  If the watchdog was already started by the bootloader and a
pretimeout interrupt is pending when the IRQ is requested, stm32_iwdg_isr()
gets NULL from watchdog_get_drvdata(wdd) and dereferences a NULL pointer,
and even with driver data set, wdt->hw_version would still be 0 so v4.0+
hardware would write to IWDG_EWCR instead of IWDG_ICR and fail to clear
the interrupt.

Initializing wdt->hw_version and calling watchdog_set_drvdata(wdd, wdt)
before stm32_iwdg_irq_init() would avoid this window.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106163429.6183=
92-1-antonio.borneo@foss.st.com?part=3D3
