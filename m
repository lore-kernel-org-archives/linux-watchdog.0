Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FE3DA7D0
	for <linux-watchdog@vger.kernel.org>; Thu,  6 Aug 2026 06:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998138; cv=none; b=c5ArJxjdaK3dfOPzs/byttXbtouuROJvFYf2A0NZBs09ZRngAq2kppo12l/u0UVd9S00A+LKo4CiGN8Zl+AuLGccSglmXVM4pFvSjQt1mUV/Hscq7ePUNffoo/cieSeVTctWFG2JlAjIkdoHdIO9WNnfyp1gQSIGYbtNIGcP6+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998138; c=relaxed/simple;
	bh=010vyqkw4qh6lzekespXu6vcHLXNeE7/im674P7R7l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lQaHSfeUTkwcFNKCOmPHBKYgGKiU8yDkfe/l4is7js7U4S7bAXLUbUjRnXKk+AB2O7EBtnUDKgyXd78Fvnb53sNgHoj5ZF7LiWoeswqsQR+0hwYGTQ48XtpvLpcP/wEAeQf07PBtWm0p/JgGH8ErkK81yRhoGcBMDShONIBhfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt2HPvKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt2HPvKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384B81F00A3A;
	Thu,  6 Aug 2026 06:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785998137;
	bh=EjN0DEzCQVXPrC/kfR+Vza1QBJ2aiqlWbWW4OmMmHMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pt2HPvKZEYWfJHqaRD0Sb3UCoNuYBZsuK6OqzeiFaSIJBMqAdJBBfNWhDzGQMili8
	 wWJDNbijvgnj7et995tgDnqHjjrCtaZT/ssoV6Avd14y18rxrWIo/54g746eXJkq09
	 KGyqzPe+Rx5Cbgy6P4z9irLE1SC8roSuCVkTtV/Q54lCpilC2ItFyuibsSdBFaSjdi
	 z24swT5ir2gYz3BPFliVqbqRhxmrkct65qPnOJdSIX126ZkiQCMtb9CWlJ26/+djRr
	 pL8uU2wnlO7MHotRFE3LBdYySJ26io0mZt/kRfCbfgAuDnSGyamgWYwQ7pRO0mlr7Y
	 0FrI3axMNrwag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] watchdog: orion_wdt: Propagate -EPROBE_DEFER from
 IRQ lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: phucduc.bui@gmail.com
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260806062812.26523-1-phucduc.bui@gmail.com>
References: <20260806062812.26523-1-phucduc.bui@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:35:36 +0000
Message-Id: <20260806063537.384B81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Returning -EPROBE_DEFER directly leaks the clock reference and ena=
ble count by bypassing the cleanup path.
--

--- Patch [1]: [PATCH 1/2] watchdog: orion_wdt: Propagate -EPROBE_DEFER fro=
m IRQ lookup ---
commit 0ad8e477efab703bb8fdf2177c651643b3096974
Author: bui duc phuc <phucduc.bui@gmail.com>

watchdog: orion_wdt: Propagate -EPROBE_DEFER from IRQ lookup

This commit propagates -EPROBE_DEFER from platform_get_irq_optional() so
the driver is re-probed when the interrupt resource becomes available
instead of continuing without an IRQ.

> diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
> index 1802634cc7cda..c132533b997d0 100644
> --- a/drivers/watchdog/orion_wdt.c
> +++ b/drivers/watchdog/orion_wdt.c
> @@ -606,6 +606,8 @@ static int orion_wdt_probe(struct platform_device *pd=
ev)
> =20
>  	/* Request the IRQ only after the watchdog is disabled */
>  	irq =3D platform_get_irq_optional(pdev, 0);
> +	if (irq =3D=3D -EPROBE_DEFER)
> +		return irq;

[Severity: High]
Does this direct return leak the clock reference and enable count?

Since dev->data->clock_init() was called earlier in orion_wdt_probe(),
would setting ret =3D irq and jumping to the disable_clk label ensure that
clk_disable_unprepare() and clk_put() are correctly called on probe deferra=
l?

>  	if (irq > 0) {
>  		/*
>  		 * Not all supported platforms specify an interrupt for the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806062812.2652=
3-1-phucduc.bui@gmail.com?part=3D1
