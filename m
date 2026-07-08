Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1926ADC
	for <linux-watchdog@vger.kernel.org>; Wed,  8 Jul 2026 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479849; cv=none; b=LdSOKJoCH14Gv0i0p68CTxi7CFHms7SpOvDvDzVHvny1Xhnk10lH/2A+d7TZMqcAaPL05GMFSYDVNcFoH8NFoLzoodZCtNdBpliQWoUwzmtEqHPHRFeFR1tY7APrJy3mrq06z/yyM0wUHelShX5fBdXMlfFTiBTEN2ONKeu1yd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479849; c=relaxed/simple;
	bh=zC33v2xiKoAFWk+ozHk0jQRGkfFYbKL9TEJv55TIe8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mk3zQE+LDCKb8Febr2pTwBVW2yknrukHfnssBnQdM0tshLeiFHSsOdezL4flBZtDmMkV5Us2nFnKroCpwzhBGflMinb4tUPOX/i6W85uVxp6D40WLHwT7ldEhwTUhUv8M+v1ULRKfHe/QINckc9zIBxCtygctXABxdQc7XAEyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3VJ3Zo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3VJ3Zo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB901F000E9;
	Wed,  8 Jul 2026 03:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783479848;
	bh=6TOQEUCvg7s+zO9jkFt96qvzUpleHO3jBjq6Y7607Jo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3VJ3Zo0mRY3dmAjJGxqBHUsu47gGqtr4RDSp+MsOyAkvKMzHX01PizZ4Eyq7m17o
	 A5aBEsq7/quSTnfkTBKr1nNKXRSmZi+Dcng/ijBn0Xg1QFgNIZzPtIBrgnT0RApHLj
	 PoSelNTCG5d/pkZQxYc6JSnQtRFhjor3SSDxDEagqPp1Cz/UDrPy88S23BMYkiznB+
	 sZArqhhJ5rWMeGpZmwUT0jr6iLV2rOeQblxAjxU9UgMEURxPtlNoFqxwPIDqnDc4B9
	 Ul1Crh6pCgMWGs8Cz8SMf1yC9EXjaDcAjszHA22PRcocczulBpf+yOBhL9QbVZGh85
	 1dBIttA/vJUXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] watchdog: airoha: Prevent division by zero when clock
 frequency is zero
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wayen Yan" <win847@gmail.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <178347932594.81327.4834644880399144119@gmail.com>
References: <178347932594.81327.4834644880399144119@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 03:04:07 +0000
Message-Id: <20260708030407.DEB901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unvalidated module parameter directly assigned to watchdog timeout=
 leads to 32-bit integer overflow and immediate system reboot.
--

--- Patch [1]: [PATCH] watchdog: airoha: Prevent division by zero when cloc=
k frequency is zero ---
commit 3c89565f34ffbc693201939b137238a0f581ebf6
Author: Wayen Yan <win847@gmail.com>

watchdog: airoha: Prevent division by zero when clock frequency is zero

This commit adds a check in airoha_wdt_probe to ensure the clock frequency
is not zero before using it as a divisor. It prevents a division by zero if
the clock provider is not properly configured.

> diff --git a/drivers/watchdog/airoha_wdt.c b/drivers/watchdog/airoha_wdt.c
> --- a/drivers/watchdog/airoha_wdt.c
> +++ b/drivers/watchdog/airoha_wdt.c
> @@ -147,6 +147,9 @@ static int airoha_wdt_probe(struct platform_device *p=
dev)
> =20
>  	/* Watchdog ticks at half the bus rate */
>  	airoha_wdt->wdt_freq =3D clk_get_rate(bus_clk) / 2;
> +	if (!airoha_wdt->wdt_freq)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "invalid clock frequency\n");
> =20
>  	/* Initialize struct watchdog device */
>  	wdog_dev =3D &airoha_wdt->wdog_dev;
>  	wdog_dev->timeout =3D heartbeat;

[Severity: High]
This is a pre-existing issue, but does assigning the heartbeat module
parameter directly here bypass watchdog timeout validation?

It appears watchdog_init_timeout() is not used to validate the module
parameter. If an out-of-bounds heartbeat parameter is provided, could this
lead to an integer overflow in airoha_wdt_start()?

drivers/watchdog/airoha_wdt.c:airoha_wdt_start() {
    ...
    val =3D wdog_dev->timeout * airoha_wdt->wdt_freq;
    writel(val, airoha_wdt->base + WDT_TIMER_LOAD_VALUE);
    ...
}

With a watchdog frequency of 150MHz, a timeout of 29 or greater results in
a multiplication over 4.29 billion, which overflows the 32-bit val
variable. This wrap-around would cause the hardware timer to expire
prematurely before the core ping worker expects to service it, resulting
in an immediate system reset.

Similarly, if heartbeat is 0, is it possible for the timer load value to
become 0 and trigger an immediate reset upon device open?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178347932594.81327.=
4834644880399144119@gmail.com?part=3D1
