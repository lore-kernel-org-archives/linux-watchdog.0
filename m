Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23983424D7D;
	Wed, 15 Jul 2026 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784107676; cv=none; b=cXKbqyZKzEHNIk2D6E2E3/MfVvxrgSzwbIFOK2roP43ivItpbaRWpKl2cQuPJHCO1cUhVhdu4lCp2ie7zc/m/e3/oeLtz7BVNvHd5f8JcfH5FK++UyHQUVTrJRjFaFysDsE3KHJyY/HUydsETuNr8fsw1CTW7ZUBZECU+QNEbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784107676; c=relaxed/simple;
	bh=acleQbU3WWcCL6FBtF/aSBF1471Vfid/GxaEhvnhotk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WvqH5fRrw3PeqacKTo0KgTNRbpkk+DN7PKSHSTIIJPSWbrVrxUZJDJEYO7f4F+PKAi7zu35OzAtC155I9DKNCnB16Ki+TRmRhp+6uJbNDncLwArpNQuGB1aWBUhzCfQttYmKOtMnToHjQSqXlsVGoC5F7r9Cm+MhcdwiT5Q/UIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH3nnRBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH3nnRBp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989531F000E9;
	Wed, 15 Jul 2026 09:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784107673;
	bh=T5Dpv6FrqSoPtTua9l54lASEzaAoxaNh+SuNBAMZIQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jH3nnRBpMPRhaDSj4aKyjZzh5THnmud1Ti+wU2zPzmwCJyY8HLmUCeuzIh5sI/qLN
	 s+AvW8XowOm0X0xuEMY/5zLYybgahVjkPoSwhIDKo1JjTJH45yYsIXH4HEpCk0Bf5y
	 fXG/zV1yT5l/pLZjThw+UDlMVl1ezCINp8amEBpk2FjdP4Iqg481sKSHv2/4lnFd+l
	 +uzqpGtlqyWbknu/VI5c+IhxQn6fj8evTy366mQQldkiN9etFgOgQE3UYwDzcG7pVi
	 E6RzLSeptJXv5rHS0ymG9yAoX9iemxfevmQEWrbbI5eGPVRfm5LP5EuurrHPAtKoJ6
	 bv8Du3ajLbt5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/10] arm64: dts: apple: Initial T6030 (M3 Pro)
 device trees
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260715-apple-t603x-initial-devices-v2-10-df65b2485710@jannau.net>
References: <20260715-apple-t603x-initial-devices-v2-0-df65b2485710@jannau.net>
 <20260715-apple-t603x-initial-devices-v2-10-df65b2485710@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 09:27:52 +0000
Message-Id: <20260715092752.989531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `pinctrl_nub` device is missing its `power-domains` property=
, which is explicitly defined as `ps_nub_gpio` in `t6030-pmgr.dtsi`.
--

--- Patch [10]: [PATCH v2 10/10] arm64: dts: apple: Initial T6030 (M3 Pro) =
device trees ---
commit 2e87765dac6c4901eb4d023fc0b86ec40441a4ad
Author: Janne Grunau <j@jannau.net>

arm64: dts: apple: Initial T6030 (M3 Pro) device trees

This commit introduces minimal device trees for the M3 Pro SoC, supporting =
the
14-inch and 16-inch MacBook Pro models from November 2023. It includes base
device nodes in t6030.dtsi and device-specific overlays.

> diff --git a/arch/arm64/boot/dts/apple/t6030.dtsi b/arch/arm64/boot/dts/a=
pple/t6030.dtsi
> new file mode 100644
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6030.dtsi
[ ... ]
> +		pinctrl_nub: pinctrl@3641f0000 {
> +			compatible =3D "apple,t6030-pinctrl", "apple,t8103-pinctrl";
> +			reg =3D <0x3 0x641f0000 0x0 0x4000>;
> +
> +			interrupt-parent =3D <&aic>;

[Severity: Medium]
Is pinctrl_nub missing its power-domains property?

The ps_nub_gpio power domain is defined in t6030-pmgr.dtsi, but it doesn't
appear to be referenced here. Does this node need power-domains =3D
<&ps_nub_gpio>; added so the genpd dependency graph is complete?

> +			interrupts =3D <AIC_IRQ 472 IRQ_TYPE_LEVEL_HIGH>,
> +				     <AIC_IRQ 473 IRQ_TYPE_LEVEL_HIGH>,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-apple-t603=
x-initial-devices-v2-0-df65b2485710@jannau.net?part=3D10
