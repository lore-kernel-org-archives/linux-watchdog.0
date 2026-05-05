Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23345426EC5
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984057; cv=none; b=IFingG7/HiZYKEl0Q7hvLcfginUhIlKx27hh+waTkFyhaztWpVFrYxs50trmH4EOtJU/YBB/G3Je2tvpSeo3C4TR/GnZtj7RW9YINsMwnLc1Brxm0ZMkrZsjTg9LHZwzLiRjUZoLnvtb3O71ItQOLnfx3UvWtyGBqYS4ZmS0jBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984057; c=relaxed/simple;
	bh=vIigGyCnNDwLqEbldvMg9diviaKaiIpao7ry/Rapno8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gKb/ahVp1HuxfhcSXh0kOHPK/D5o1SliNFKj72Fs2gd8Z60VEpUPLn7LRmlnMrNUgyZ5kF4tJ9CQw2Ie3ePmr7kh7NBKWQZ4pqP32JgWH5LypYOWvhUcscBZcOG07koj2Ed9bFwApksaoLycYaBetJZlwFPGiPE4you2l0WAjZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AP6AKUZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AP6AKUZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CCAC2BCB4;
	Tue,  5 May 2026 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984056;
	bh=vIigGyCnNDwLqEbldvMg9diviaKaiIpao7ry/Rapno8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=AP6AKUZzN1jTEqB4sFRYYbdX4P+T67FzTjBNDVupo6SpFAlAGK3J6WItIXXVSF3N4
	 A5D3uIqYctx02v4fOEoiDb65vi0xw8RtHVfjYSzpNp/cO+2IB2hIZB2a9tJbY4keiK
	 clw7tU6Ho0ojkhW0jYYpIbTJg18KdIDrRRdrlhPa4ntsw7CLmrOBeQoh/fVUveXohV
	 oT77P0VkS1pwTmw326GBmMdIB5MeoXFfoYmbH0JdYrwmxH7MPJ/AaO89K/ZBXt5o8c
	 FuJ74wIbYo+4Nc2VUwPFKI0EceEV/Xtu+Rpi2fz1bw5vbLzRCyuUYBMeY6tfo5IgFq
	 KlgzLTPgCMaxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] arm64: dts: apple: Initial t8122 (M3) device
 trees
Reply-To: sashiko@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260505-apple-m3-initial-devicetrees-v2-6-b0c2f3519e0e@jannau.net>
References: <20260505-apple-m3-initial-devicetrees-v2-6-b0c2f3519e0e@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 12:27:36 +0000
Message-Id: <20260505122736.94CCAC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `pmgr` node's register size is too small to cover its child no=
de `ps_disp_cpu`, causing out-of-bounds regmap access.
- [Medium] The `ps_sio_adma` (Audio DMA) power domain has an incorrect depe=
ndency on the Fast PWM (`ps_fpwm0`) power domain.
- [Medium] The `aic` (Apple Interrupt Controller) node has overlapping memo=
ry regions for `core` and `event`.
--

commit bef1d69fa7e259eaf8dc310010b063110b9823c0
Author: Janne Grunau <j@jannau.net>

arm64: dts: apple: Initial t8122 (M3) device trees

This commit adds minimal device trees for all t8122 based devices. It
includes support for the iMac and MacBook Air/Pro, with a basic set of
devices like CPU cores, interrupt controller, and power states.

> diff --git a/arch/arm64/boot/dts/apple/t8122-pmgr.dtsi b/arch/arm64/boot/=
dts/apple/t8122-pmgr.dtsi
> new file mode 100644
> index 0000000000000..64093792e0ade
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8122-pmgr.dtsi

[ ... ]

> +	ps_sio_adma: power-controller@310 {
> +		compatible =3D "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate=
";
> +		reg =3D <0x310 4>;
> +		#power-domain-cells =3D <0>;
> +		#reset-cells =3D <0>;
> +		label =3D "sio_adma";
> +		power-domains =3D <&ps_fpwm0>;

Is it intentional that the Audio DMA power domain depends on the Fast PWM
domain? This looks like it might be a copy-paste error that will force the
PWM domain to power on alongside the audio DMA, while leaving the audio DMA
missing its actual required parent power domain.

[ ... ]

> +	ps_disp_cpu: power-controller@10000 {
> +		compatible =3D "apple,t8122-pmgr-pwrstate", "apple,t8103-pmgr-pwrstate=
";
> +		reg =3D <0x10000 4>;

Could this regmap access cause an out-of-bounds error?

In t8122.dtsi, the pmgr node is defined with a size of 0x10000, which sets
the syscon regmap's max_register to 0xFFFF. This power controller is declar=
ed
at offset 0x10000, which falls strictly out of bounds and might be rejected
by the regmap subsystem with an -EINVAL error.

> +		#power-domain-cells =3D <0>;
> +		#reset-cells =3D <0>;
> +		label =3D "disp_cpu";
> +		power-domains =3D <&ps_disp_fe>;
> +		apple,min-state =3D <4>;
> +	};

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/a=
pple/t8122.dtsi
> new file mode 100644
> index 0000000000000..2a042b6fbebcd
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8122.dtsi

[ ... ]

> +		aic: interrupt-controller@2d1000000 {
> +			compatible =3D "apple,t8122-aic3";
> +			#interrupt-cells =3D <3>;
> +			interrupt-controller;
> +			reg =3D <0x2 0xd1000000 0x0 0x184000>,
> +				<0x2 0xd1040000 0x0 0x4>;

Is it expected for the core and event memory regions to overlap here?

The first region spans from 0xd1000000 to 0xd1184000, which completely
subsumes the second region located at 0xd1040000. Overlapping windows viola=
te
standard device tree conventions for distinct hardware blocks. Could 0x1840=
00
be a typo for 0x40000?

> +			reg-names =3D "core", "event";
> +			power-domains =3D <&ps_aic>;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505-apple-m3-i=
nitial-devicetrees-v2-0-b0c2f3519e0e@jannau.net?part=3D6
