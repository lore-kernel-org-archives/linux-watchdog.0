Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2F476CFD
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710201; cv=none; b=Ysi1HdkL1yhH+pUxcviqpfjtFhSMciGXY5kzKSrIuLIf8nKIJqdh+3OO0qF8Ec/hhOLZmIwVxFr1sXmcCmTreb8fWkIjIhItdNeM9NK5lNtaHPb5Q4srBTuDnky7VoXvoiH7q+RSCEe46OlvzE9WADDM1CC4d8AA1NGLc2GwZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710201; c=relaxed/simple;
	bh=TCo8+2+0u1Mgd4o8xqGKo3gUI7FxLfX8hnvC9gKGjcQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JYxP8JUBDqAO+XK/EsbBGnDHzuHRH/kOwQkB7DYWMkukl1hyLHGIAw7fcxlEoYgaK+VlFt65uSA/4L/mxn+D6Zflj4H1FO7BuUs1lpRDRq2gHIVlSl+Vc3HA10m5HQyipj1of/wQMdQaDCLQtZsvYIH+7fhyGIHUa1s2dMtjMaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgATcZgs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgATcZgs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC851F000E9;
	Wed, 22 Jul 2026 08:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710199;
	bh=5VliWknZOrvqziSYvLYinNR/MevktjzVkxuXmtshP84=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgATcZgsnE4H5/zNIT7D2Aedao5zrW2KBQf4GiVn+LKiYVcUIxESJDNCYcgsqVK0h
	 W6ODIIDqfLulrBML1Cj5L3T42Quhowts4LB3UgZ0OsPmWcyJPRXeWHAbYk4cNZQRob
	 4Blw99DCIDYx7iZnXxzO1sNtUqaifewCs7E5ccQ61A2y07/O/qhPS9cASMerTYTNtL
	 uTo/nErzKohOfR90Bf6l2l5jIVgQe+DMe1AUZuUcI19eusplbAMja25/ZVjjLmNz/y
	 2/bw5VP3BAr+dy4kiLqQyvGbNA+DplnQQsRvlIGflhN5PR43SL6sUKv/kgXbqlB8Fk
	 tA+kCBih89Mug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] watchdog: intel-mid_wdt: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-4-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-4-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:49:58 +0000
Message-Id: <20260722084959.4AC851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver advertises the WDIOF_SETTIMEOUT capability but lacks th=
e required .set_timeout callback, causing timeout updates to silently fail.
- [High] The shared IRQ handler mid_wdt_irq unconditionally panics the syst=
em, violating shared IRQ semantics and risking spurious panics.
--

--- Patch [3]: [PATCH 3/9] watchdog: intel-mid_wdt: Remove redundant dev_er=
r() ---
commit f0c7169449cddf6ac1b4686957e0ef5aa4340ca5
Author: Pan Chuang <panchuang@vivo.com>

watchdog: intel-mid_wdt: Remove redundant dev_err()

This commit removes a redundant dev_err() call after devm_request_irq().
The core function now automatically logs detailed error messages on failure,
making the driver-specific logging unnecessary.

> diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mi=
d_wdt.c
> index 756d262dc5808..b1e1b77ed1905 100644
> --- a/drivers/watchdog/intel-mid_wdt.c
> +++ b/drivers/watchdog/intel-mid_wdt.c
> @@ -165,10 +165,8 @@ static int mid_wdt_probe(struct platform_device *pde=
v)
>  	ret =3D devm_request_irq(dev, pdata->irq, mid_wdt_irq,
>  			       IRQF_SHARED | IRQF_NO_SUSPEND, "watchdog",
>  			       wdt_dev);

[Severity: High]
This is a pre-existing issue, but does this interrupt handler violate
shared IRQ semantics?

The interrupt is requested here with IRQF_SHARED, which explicitly allows
other devices to share the line.

However, looking at the handler:

drivers/watchdog/intel-mid_wdt.c:mid_wdt_irq()
{
	panic("Kernel Watchdog");

	/* This code should not be reached */
	return IRQ_HANDLED;
}

Since it unconditionally calls panic() without verifying that the watchdog
device actually triggered the interrupt, couldn't any other device sharing
this IRQ line cause a spurious kernel panic?

[Severity: High]
This is also a pre-existing issue, but does the driver support updating
the timeout properly?

The driver advertises the ability to change the timeout to userspace:

drivers/watchdog/intel-mid_wdt.c:mid_wdt_info
	.options =3D WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE,

But the operations struct is missing the .set_timeout callback:

drivers/watchdog/intel-mid_wdt.c:mid_wdt_ops
static const struct watchdog_ops mid_wdt_ops =3D {
	.owner =3D THIS_MODULE,
	.start =3D wdt_start,
	.stop =3D wdt_stop,
	.ping =3D wdt_ping,
};

When a userspace daemon attempts to change the timeout, the core watchdog
subsystem will call the .ping callback instead of programming the hardware.

Does this result in the hardware continuing to use the default timeout while
userspace believes a longer timeout has been set, potentially causing
unexpected watchdog resets?

> -	if (ret) {
> -		dev_err(dev, "error requesting warning irq %d\n", pdata->irq);
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	/*
>  	 * The firmware followed by U-Boot leaves the watchdog running

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D3
