Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADD3D6CA4;
	Thu,  9 Jul 2026 07:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583829; cv=none; b=dp7SBzsXeP4Ps/scVS5OTKuRu2wJojMp35Zwke4KZbAL8XbMcsUlK8s+cM460tDvoJs4oDsU9E+jA+9s8uLqrAFPamlUpCxJB119FxekwbQCh898W8RmRPf4SmM7u6nYZ4wUD8VKTZRrdRFiET/xmiKnBhc/dvaXSDHT0p/TFbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583829; c=relaxed/simple;
	bh=vx4ZOWY1pXeJiNfO4/RjNhrRWepiCTVeKLxuTQmSdPk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=entjAK/Nn7P+XRj+2OUg8ebzBh+Aq5lmxYRqyS5oDT+PC75EinFPyGF8rnzbQioGJrY7TjAutfB7gRje62HOU+K7HPLAD0L6ltyjXF450e/Fe7aQdtMXx+mjYjSMQy1Ibrpi2JKpSk2T2cR55kYc64h0HqCUWHpTuINWCRrMroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZ4xm6b0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZ4xm6b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B180E1F000E9;
	Thu,  9 Jul 2026 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583828;
	bh=637hh54O/BX1i5s54RMUqvzQDP3+O8GSnJYOmxVydF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HZ4xm6b0VcXTlvHlN74WO7j0jAiETSFKyh6eyV/i46JW9pLdYwZ+sZbbFusdiJo29
	 XWABYq6mq8TSiR25/J4xVs19VN7CAurQcFO7i50aq3aH+2aJVIXR15tOmuIUTonHVs
	 wp8LCtP8J2DVbeFGZvxhfCJ4OdVWs48nc/hfC6p2UAjTreL+zJfxRSeNmT2cD8fj3h
	 Y0D/AVsVU1wrrrzYfrFKuK6DKY867ncN30eiTl4HqbowNl1gzYLqB2lyVa6qkALDbv
	 bCWOnaIvcb0wPgImMEk77FHYdxnNJ4Utn3wf90P+j6I+VlcOzq3ZdbW/7lTaN3mojk
	 Cud8vDBgoC+8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/11] arm64: dts: apple: Initial T6030 (M3 Pro) device
 trees
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-11-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-11-55b305833123@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:57:07 +0000
Message-Id: <20260709075707.B180E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `gpio-ranges` for `pinctrl_nub` and `pinctrl_aop` incorrectly refe=
rence `&pinctrl_ap`
- [High] Missing `power-domains` property in `pinctrl_nub`
- [Low] Incorrect unit address for `serial0` node (extra trailing zero)
--

--- Patch [11]: [PATCH 11/11] arm64: dts: apple: Initial T6030 (M3 Pro) dev=
ice trees ---
commit fa2e19405991d7d2172c7f5e2dd0812674d702eb
Author: Janne Grunau <j@jannau.net>

arm64: dts: apple: Initial T6030 (M3 Pro) device trees

Minimal device trees for the M3 Pro based 14-inch and 16-inch MacBook
Pro released in November 2023.

> diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/a=
pple/t6030.dtsi
> new file mode 100644
> index 0000000000000..f79fbadaa92cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6030.dtsi

[ ... ]

> +		serial0: serial@2892000000 {
> +			compatible =3D "apple,s5l-uart";
> +			reg =3D <0x2 0x89200000 0x0 0x1000>;

[Severity: Low]
Does this node have an incorrect unit address? The unit address
@2892000000 has an extra trailing zero, as the reg property resolves to
0x289200000. This might trigger a simple_bus_reg device tree compiler
warning.

[ ... ]

> +		pinctrl_nub: pinctrl@3641f0000 {
> +			compatible =3D "apple,t6030-pinctrl", "apple,t8103-pinctrl";
> +			reg =3D <0x3 0x641f0000 0x0 0x4000>;

[Severity: High]
Is a power-domains property needed here, similar to other Apple SoCs?
Without it, the OS might not track and enable the NUB GPIO power state,
which could lead to an SError if the hardware is accessed while powered dow=
n.

> +
> +			interrupt-parent =3D <&aic>;
> +			interrupts =3D <AIC_IRQ 472 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 473 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 474 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 475 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 476 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 477 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 478 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			gpio-ranges =3D <&pinctrl_ap 0 0 37>;

[Severity: High]
Does this incorrectly reference &pinctrl_ap instead of a local pinctrl
node? This would map the NUB GPIOs onto the Application Processor (AP)
pin controller's domain, which could break GPIO operations for the NUB
controller and clobber the first 37 pins of the AP pin controller.

[ ... ]

> +		pinctrl_aop: pinctrl@374824000 {
> +			compatible =3D "apple,t6030-pinctrl", "apple,t8103-pinctrl";
> +			reg =3D <0x3 0x74824000 0x0 0x4000>;
> +
> +			interrupt-parent =3D <&aic>;
> +			interrupts =3D <AIC_IRQ 394 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 400 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			clocks =3D <&clkref>;
> +
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +			gpio-ranges =3D <&pinctrl_ap 0 0 54>;

[Severity: High]
Is it possible this node also incorrectly references &pinctrl_ap instead
of its local node? Similar to the pinctrl_nub node, this would break AOP
GPIO operations and clobber the first 54 pins of the AP pin controller.

> +			apple,npins =3D <54>;
> +
> +			interrupt-controller;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-apple-t603=
x-initial-devices-v1-0-55b305833123@jannau.net?part=3D11
