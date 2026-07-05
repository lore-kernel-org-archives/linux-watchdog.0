Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7419A288;
	Sun,  5 Jul 2026 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783258090; cv=none; b=hYm/92EMmFKCLBEDYHZYYtH2ki6SQe109g/rF/CNqWpAp7fuZ1aP2FqT68I8pwyVSbj/HNAye2dsp22XxC1QLZZorBpV/Xb9SD/EXvpJLwPKzGCpz40cCvjTGhTUXOLaTUemw1zxBqwGNZWgbOeBi4ngT0LufMSjs5dIFyeBpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783258090; c=relaxed/simple;
	bh=NJxVx0FnMjYEYCKlwwbDM9FgDv9Tf6jIFXfCGRanmg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TQWDITPpuq2jZz5YuhysQUP46c+hgpWq7KAkwVBUcni2TDaDgXjPXkxcWZYuEPCy0WJFVV8l2pNy862yXIx2GurMsa4/f1QnwDLH3jAVajgdOthbm5aWtMI0wy1KU4BX1BV+Tl9atxwDqCbwoND3DhfHxlqUpmuP5BD5c0X3uf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaBR+EVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaBR+EVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D2B1F000E9;
	Sun,  5 Jul 2026 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783258088;
	bh=UKRrUln/MRiexxs0rcUjX7DinijtWs7GgKy5OjOhce4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NaBR+EVT6q6D1r9bwa5UtvEgnWugmDV997aIdnPCHtB+fIgyu/9FJeVPBhemJbVhe
	 iu9K7E2iu0zu3e8c3p8eehs1ulGBAAo2GcSprC/4PXs5u4BWvbC0zgMr5EIjPwSKhn
	 bYwq9ucAE7rsOpGd6XEjUDmjMi66vygaececyGW95Oiaw4R1m0YjhAs70sRaXEgrAF
	 35P3C/CuItBboNk7xj8pRMuem0B1gPx0Z4rgZRt5Rqx7M9sDl3XNT6ZrImijssMpNC
	 UKc85qRgNzPHGyxCmulP3ODISnn9+tIlLnvRH5U5K+0A5WBQAL8xjnk1JhjyoeFnoh
	 QwBeGdmETimhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] arm64: dts: apple: Add minimal t8132 (M4) device
 trees
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260705-apple-m4-initial-devicetrees-v1-10-e5655ee56523@cyberchaos.dev>
References: <20260705-apple-m4-initial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev>
 <20260705-apple-m4-initial-devicetrees-v1-10-e5655ee56523@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 13:28:08 +0000
Message-Id: <20260705132808.82D2B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `aic` node has a mismatched unit address and overlapping mem=
ory regions in its `reg` property.
- [Low] The `model` property for the MacBook Air (13-inch) erroneously decl=
ares the year as 2024 instead of 2025.
- [Low] `t8132` device trees are incorrectly placed at the very top of the =
`Makefile`, breaking the chronological sorting order.
--

commit 281d92c4ca5eb8a2224c6bb0b9116c7518b422d1
Author: Yureka Lilian <yureka@cyberchaos.dev>

arm64: dts: apple: Add minimal t8132 (M4) device trees

This commit adds minimal device trees for a series of new Apple M4 devices,
including MacBook Pros, MacBook Airs, iMacs, and the Mac mini. The device
trees are limited to essential components like CPU cores, interrupts, and
serial, allowing a basic boot. It also notes that SMP support currently
remains unreliable.

> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/app=
le/Makefile
> index 6fc3349a58428..181bd0e289653 100644
> --- a/arch/arm64/boot/dts/apple/Makefile
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -1,4 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t8132-j604.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t8132-j623.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t8132-j624.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t8132-j713.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t8132-j715.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t8132-j773g.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D s5l8960x-j71.dtb

[Severity: Low]
This isn't a bug, but should these new t8132 device trees be appended
to the bottom of the list rather than prepended at the top, to maintain
chronological sorting order in the Makefile?

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t8132-j713.dts b/arch/arm64/boot/d=
ts/apple/t8132-j713.dts
> index 0000000000000..b1f779c37d5fe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8132-j713.dts
[ ... ]
> +/ {
> +	compatible =3D "apple,j713", "apple,t8132", "apple,arm-platform";
> +	model =3D "Apple MacBook Air (13-inch, M4, 2024)";

[Severity: Low]
This isn't a bug, but does the model string contain a typo? The header
comment for this file identifies the target as a 2025 model, but the model
string exposes 2024 to userspace.

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t8132.dtsi b/arch/arm64/boot/dts/a=
pple/t8132.dtsi
> index 0000000000000..715980b5c7de4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8132.dtsi
[ ... ]
> +		aic: interrupt-controller@381180000 {
> +			compatible =3D "apple,t8132-aic3", "apple,t8122-aic3";
> +			#interrupt-cells =3D <3>;
> +			interrupt-controller;
> +			reg =3D <0x00000003 0x81000000 0x00000000 0x1cc000>,
> +			      <0x00000003 0x81040000 0x00000000 0x4000>;

[Severity: Medium]
Is the base address and memory region mapping for aic intentional?

The node defines a unit address of @381180000, but the reg property specifi=
es
a base of 0x81000000 (translating to 0x381000000). Also, the first memory
region of size 0x1cc000 completely overlaps the second region starting at
0x81040000.=20

Could this typo in the physical address map explain the unreliable smp boot
behavior mentioned in the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-apple-m4-i=
nitial-devicetrees-v1-0-e5655ee56523@cyberchaos.dev?part=3D10
