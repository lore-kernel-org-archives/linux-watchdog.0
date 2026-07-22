Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2404DB57D
	for <linux-watchdog@vger.kernel.org>; Wed, 22 Jul 2026 08:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784710510; cv=none; b=iUnS2qD5u+B7DG5+/Ey4P0BlytqNw/F2hoNuDzbMeVCh4KA92O57f8xcfALLVbUr/2h0Fa4udQ+JMvkKgHv+sxr6UVeiSNtxY4XOb3ofYTvCGtsNrNf9mHygNpdQtmBUPpaFSiEQnJuaM4UVHYt7HWsUHpsXlmuuvzGc2mnYrwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784710510; c=relaxed/simple;
	bh=yz6h4HZUY6EmzPvbF5UCZ9d8Gik9Ben7ek8tGlsnh9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GI01a0tGRLgdKG+TVE6Kkp/t+Pb9jrCZaituYQormk2KNjffZFVU0rGfv4B0ifdezVhb4kIQh3sWEa2EyzH3Qc+JMKyV/I/rjRFo0U3gp3W+8udSNdXttK/4eMVTcl7F4jy2xthU+hZxT3bSOUOm/Eav1ZCWwHzlfM7/P0CYc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVzNMqEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVzNMqEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E381F000E9;
	Wed, 22 Jul 2026 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784710508;
	bh=+EQd14wzhbxEUpSPKYJpfFtFCh7GLLdGl8KeT+NXOpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IVzNMqEM6RU84FWTwGlmCDKj3bbFFo07qmAbAfL9JqBuY+ug0VIOmHU0Tc3Vksl8C
	 r0Qlklbyl47jIOaBjTWxvi9msIH9ZdyQl+hRa1q91HhUKsI6VZ/F8Tw8tDh2P2rb/j
	 e8UCXSqVFPKvpDlRx0VE11zuLjf+ifVqWDcrvSAbwKXNAh68/I196Lin86dKn/RIUe
	 MS18Y6f43UeszexflT03hfsj9TEbUDjD9XgbgXcKmx4B8FVZDbCyty5IosEwL0QtaN
	 UKCUuSbM1w/apAEqUga+4nCFR/ZUq0YKsSefzogGsAlMQj/K9wjT2JdD1WO/dJn4Pw
	 Kua9/Oaxyk48w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] watchdog: realtek_otto: Remove redundant
 dev_err_probe()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pan Chuang" <panchuang@vivo.com>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260722084218.79073-8-panchuang@vivo.com>
References: <20260722084218.79073-1-panchuang@vivo.com>
 <20260722084218.79073-8-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:55:07 +0000
Message-Id: <20260722085508.40E381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver aborts probing if the `realtek,reset-mode` property is =
not provided in the Device Tree, violating the DT binding contract.
- [High] The driver does not properly implement `max_hw_heartbeat_ms`, caus=
ing probe and runtime failures for valid large timeouts.
--

--- Patch [7]: [PATCH 7/9] watchdog: realtek_otto: Remove redundant dev_err=
_probe() ---
commit e807bbe77a13713af6db50c1b1c784d911002006
Author: Pan Chuang <panchuang@vivo.com>

watchdog: realtek_otto: Remove redundant dev_err_probe()

Since commit 55b48e23f5c4, devm_request_irq() automatically logs detailed
error messages on failure. Remove the now-redundant driver-specific
dev_err_probe() call.

> diff --git a/drivers/watchdog/realtek_otto_wdt.c b/drivers/watchdog/realt=
ek_otto_wdt.c
> index 01b3ef89bacfc..e29c99cbd8140 100644
> --- a/drivers/watchdog/realtek_otto_wdt.c
> +++ b/drivers/watchdog/realtek_otto_wdt.c
> @@ -312,7 +312,7 @@ static int otto_wdt_probe(struct platform_device *pde=
v)
>  	ret =3D devm_request_irq(dev, ctrl->irq_phase1, otto_wdt_phase1_isr, 0,
>  			"realtek-otto-wdt", ctrl);
>  	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to get IRQ for phase1\n");
> +		return ret;
> =20
>  	ret =3D otto_wdt_probe_reset_mode(ctrl);
>  	if (ret)

[Severity: High]
This is a pre-existing issue, but does this code cause the probe to fail if
the optional realtek,reset-mode property is omitted from the device tree?

If the property is missing, fwnode_property_string_array_count() will return
-EINVAL here:

drivers/watchdog/realtek_otto_wdt.c:otto_wdt_probe_reset_mode() {
	...
	mode_count =3D fwnode_property_string_array_count(node, mode_property);
	if (mode_count < 0)
		return mode_count;
	...
}

Because otto_wdt_probe() blindly propagates this return value, the device
becomes unavailable instead of falling back to the documented 'cpu' default.

[Severity: High]
This is also a pre-existing issue, but does otto_wdt_determine_timeouts()
fail to utilize the watchdog core's max_hw_heartbeat_ms feature properly?

When a timeout exceeds the maximum hardware capacity (for example, if
timeout-sec is set to 60s in the device tree), the function calculates
a prescale greater than OTTO_WDT_PRESCALE_MAX and returns -EINVAL:

drivers/watchdog/realtek_otto_wdt.c:otto_wdt_determine_timeouts() {
	...
	prescale =3D prescale_next;
	if (prescale > OTTO_WDT_PRESCALE_MAX)
		return -EINVAL;
	...
}

This causes probe or ioctl failures for valid large timeouts instead of=20
allowing the core to manage it. Additionally, the function incorrectly=20
overwrites the requested timeout:

drivers/watchdog/realtek_otto_wdt.c:otto_wdt_determine_timeouts() {
	...
	timeout_ms =3D total_ticks * tick_ms;
	ctrl->wdev.timeout =3D timeout_ms / 1000;
	...
}

The watchdog core requires the driver to keep wdev->timeout as requested
by the user, and only clamp the internal hardware configuration, letting
the core ping the hardware periodically for longer timeouts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722084218.7907=
3-1-panchuang@vivo.com?part=3D7
