Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B564A2D1913
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710373; cv=none; b=RosTo1GU4zQF9oK8j9qRXKbNQvpgzZ0Sc51PfO4sS5TPpsGhxwNcoKkZNFtIQ3znEs0OjRC+CzrRuXfTeSknrv90zbg6hm8gIGyRKKQtlidvXAdhO/GdgeHdXo/i4EM4qxUZ8i/kwUSKt+1tgsV4d1oKfeHlB1YX9MErYBFNdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710373; c=relaxed/simple;
	bh=J5fhDhQ7KEOVb27a9d4uHtvPiPyc3JFXs+63/+FGCBk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XnpZhkNxo0UaRqKELOhCIPHhV2+cwit85TDm20FJYiiBco1NXg+g+dTgKT66onoNqMTAksRdE2KOeaMnMY/wFQriUfvUMSXUVDGS7wSMfkt0JjHFPZ7OlRyKN+2RWIk9HyU6L1dPYjmsLUDjzKGKc8yM2jY+iM3C93Bf4X4KH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEnGyugz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEnGyugz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC701F000E9;
	Wed, 22 Jul 2026 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710371;
	bh=jxxE/CHHY0/DAU3S3NCP0MFGz33vx+cBIAxwm/9x9TA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DEnGyugzyj8S0RHUTf8EXJbOECHUCWbdqM2ukIrqfWJbtY7AVOpINZAwErnQ730Xs
	 LBhV6o2cGkL3r/F3wGDdpKWrjmGcGMHzfXdiUWtw3HvrPka8aHQCbXaab+TkJqnds0
	 qkroctw6FMIgxanpU4gc53sm6JDNRuWd1iRGBx2AFeIbVdfLpiB2Mypzci3x9JBT8y
	 c8cNJRPfLBEVkIw8lxT8RX5yFzNC+cq2pZJr4s/FmGqcIPSV0MHa64YseI6XisZDfh
	 c+YJPzcTafKc+qkty7w3wxmECRxON0SPliwOoCiwE86/gngWKPGS7F+p4kVw5a/4xI
	 HkGRrAtEsG/gg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] watchdog: cadence_wdt: Remove redundant dev_err()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-3-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-3-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:52:50 +0000
Message-Id: <20260722085251.2BC701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incorrect handling of platform_get_irq() return value leads to sil=
ently broken watchdogs, ignored probe deferrals, and spurious boot errors.
- [High] The driver advertises a hardcoded max_timeout of 516 seconds, whic=
h causes silent truncation and premature system reboots on platforms with s=
lower clocks.
- [High] cdns_wdt_settimeout() unconditionally enables the hardware watchdo=
g, which can cause spurious system resets.
--

--- Patch [2]: [PATCH 2/9] watchdog: cadence_wdt: Remove redundant dev_err(=
) ---
commit 8e2910f9fc6c98ef77eadf7acc598ee3e8c4f9f7
Author: Pan Chuang <panchuang@vivo.com>

watchdog: cadence_wdt: Remove redundant dev_err()

This commit removes a redundant dev_err() call after devm_request_irq()=20
because devm_request_irq() now automatically logs detailed error messages=20
on failure.

> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wd=
t.c
> index 23d41043863f6..ad46b33ce5f2e 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -312,12 +312,8 @@ static int cdns_wdt_probe(struct platform_device *pd=
ev)

[Severity: High]
This is a pre-existing issue, but is the driver advertising a maximum timeo=
ut
that exceeds hardware capabilities?

In cdns_wdt_probe(), the max_timeout is hardcoded:

	cdns_wdt_device->max_timeout =3D CDNS_WDT_MAX_TIMEOUT;

If this is 516 seconds, but the hardware uses a slower clock (e.g., 75MHz
with a 512 prescaler), a requested timeout of 516 seconds calculates to
18454 in cdns_wdt_start(), which is silently clamped:

	count =3D (wdd->timeout * (clock_f / wdt->prescaler)) /
		 CDNS_WDT_COUNTER_VALUE_DIVISOR + 1;

	if (count > CDNS_WDT_COUNTER_MAX)
		count =3D CDNS_WDT_COUNTER_MAX;

Since the hardware maximum is only 4095 (12-bit), could this result in an
actual timeout of ~114.5 seconds, causing premature system reboots before
the watchdog daemon expects to ping it?

>  	if (!wdt->rst && irq >=3D 0) {

[Severity: High]
This is a pre-existing issue, but does this correctly handle cases where the
IRQ is deferred or omitted?

Looking at cdns_wdt_probe(), platform_get_irq() is called unconditionally
before this block:

	wdt->rst =3D of_property_read_bool(dev->of_node, "reset-on-timeout");
	irq =3D platform_get_irq(pdev, 0);

If reset-on-timeout is specified, the IRQ is unneeded, but an error is still
logged to dmesg. If reset-on-timeout is false and platform_get_irq() returns
-EPROBE_DEFER, does this silently ignore the error since irq >=3D 0 fails,
completing probe without an IRQ and leaving the watchdog broken?

>  		ret =3D devm_request_irq(dev, irq, cdns_wdt_irq_handler, 0,
>  				       pdev->name, pdev);
> -		if (ret) {
> -			dev_err(dev,
> -				"cannot register interrupt handler err=3D%d\n",
> -				ret);
> +		if (ret)
>  			return ret;
> -		}
>  	}
> =20
>  	/* Initialize the members of cdns_wdt structure */

[Severity: High]
This is a pre-existing issue, but could configuring the timeout unexpectedly
start the hardware watchdog?

When the timeout is configured via WDIOC_SETTIMEOUT, the core calls
cdns_wdt_settimeout(), which directly calls cdns_wdt_start():

static int cdns_wdt_settimeout(struct watchdog_device *wdd,
			       unsigned int new_time)
{
	wdd->timeout =3D new_time;

	return cdns_wdt_start(wdd);
}

Inside cdns_wdt_start(), the timer is fully enabled:

	data =3D CDNS_WDT_ZMR_WDEN_MASK | CDNS_WDT_ZMR_RSTLEN_16 |
	       CDNS_WDT_ZMR_ZKEY_VAL;

If userspace had previously stopped the watchdog, won't this start the
hardware timer without the watchdog core knowing it is active? Could this
lead to spurious system resets since the core won't send keepalive pings for
a stopped device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D2
