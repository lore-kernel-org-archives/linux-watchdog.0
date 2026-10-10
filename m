Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23670342510;
	Sat, 10 Oct 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791652194; cv=none; b=E3FJhGX6CgBljxydYg1tMZnasRqu2HCjPdWUbwlUIJJnnRGAc7WE3hVNWxI/yNMqbgNl9rUARYZtyqn430N0sMrYiPTiWeLNjr70yg3E2SfzgPvbM1T2pYOUSeu4+ksgHNyzIbrUSxv0taxgHtbRGdxDRNvxLg2b9zhVe81AiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791652194; c=relaxed/simple;
	bh=JV50tX2bt5EvtYNweGm/iZFunqLomki9FAcSg4k1tM8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ht0GOOl/9rHf7dQZUTm26ntOAq0MV3ePYQGv1W89sm/5sfmIdk+5KKI9bf70+FHQE5erpM6AITuBZeiR3jvCh85p7LJFn+sQjl4401kCH8BoGE9O7q2E2w0ZDC5ojKFot5ppLKVZ4/x+/GJx0YfdjtlVTg0/0UsUlC+qV+gF2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAPPrmqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAPPrmqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355A01F000FF;
	Sat, 10 Oct 2026 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791652192;
	bh=9loafavYlsAfLHpFI6f3pgcI3U9O4OtKC3AJ6HSvP9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZAPPrmqstsIEVFenWnzFOanTtEmw8qLrcq2C246Tzi7PFHqhpLcJEU/ufumj8gxRN
	 pA/epc5YIHwDGUpLrtR+4tn82cagkgy+QhpKKsPY36KnlrWX7i0GFAe+3MabhbH50v
	 P+7SwUYhdqXowAGXGrrEeLH9oD7/ZEPiAwmN+1oHAa4j21v20dhHD43NQkBGHo/8/k
	 FIUXo3+Gg7jZuhBKCgAaqEhT+1aA8HjuhVrv0x1YCWuJ0JFut5087PCRYp1rH2Tgoz
	 rmPxKrvk3xN3IQ01JmRKDUhVu0FevGg2QRoVyghVsmdSaQUrIQ3RflcO3jEUTdP7M2
	 PedsVmJ8qbbLw==
Message-ID: <sashiko-outbox-166760@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] arm64: dts: apple: Add minimal t604x (M4 Pro/Max)
 device trees
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261010-apple-m4-pro-max-initial-devicetrees-v1-10-781fb3f2d9f6@cyberchaos.dev>
References: <20261010-apple-m4-pro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev>
 <20261010-apple-m4-pro-max-initial-devicetrees-v1-10-781fb3f2d9f6@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 17:09:51 +0000
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] dts: Apple desktop Mac devices reference disabled simple-framebuff=
er power domains
- [Medium] dts: CPU cache sizes lack 0x prefix, causing them to be incorrec=
tly parsed as decimal
- [Low] kbuild: Makefile entries for new dtbs are not sorted alphabetically
--

commit 12545a49c68dd3594dd8e8ff795d304076ce814b
Author: Yureka Lilian <yureka@cyberchaos.dev>

arm64: dts: apple: Add minimal t604x (M4 Pro/Max) device trees

This commit adds device trees for various Apple M4 Pro and M4 Max
MacBook Pro, Mac mini, and Mac Studio models. It defines the SoC
characteristics, CPU topology, power management controllers, and
framebuffer settings.

> diff --git a/arch/arm64/boot/dts/apple/Makefile b/arch/arm64/boot/dts/app=
le/Makefile
> index 4f31beeb11ac4..12fc777405b3f 100644
> --- a/arch/arm64/boot/dts/apple/Makefile
> +++ b/arch/arm64/boot/dts/apple/Makefile
> @@ -94,6 +94,12 @@ dtb-$(CONFIG_ARCH_APPLE) +=3D t6031-j516c.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D t6032-j575d.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D t6034-j514m.dtb
>  dtb-$(CONFIG_ARCH_APPLE) +=3D t6034-j516m.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6040-j773s.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6040-j614s.dtb
> +dtb-$(CONFIG_ARCH_APPLE) +=3D t6040-j616s.dtb

[Severity: Low]
This isn't a bug, but device tree Makefile entries are typically kept in
alphabetical order.

Could these entries be resorted so that j614s and j616s come before j773s?

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t6040-j773s.dts b/arch/arm64/boot/=
dts/apple/t6040-j773s.dts
> new file mode 100644
> index 0000000000000..751c29f60d9cf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6040-j773s.dts
[ ... ]
> +/ {
> +	model =3D "Apple Mac mini (M4 Pro, 2024)";
> +	compatible =3D "apple,j773s", "apple,t6040", "apple,arm-platform";
> +};
> +
> +&framebuffer0 {
> +	power-domains =3D <&ps_dispext0_cpu>;
> +};

[Severity: High]
Can this cause the simple-framebuffer driver probe to fail indefinitely?

The ps_dispext0_cpu power domain provider is explicitly marked with
status =3D "disabled" in t6041-pmgr.dtsi because it is managed by firmware.
The generic power domain framework will refuse to bind to a disabled
provider, leaving the system with no visible console output.

Should this use an enabled frontend domain like &ps_dispext0_fe instead?

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t6041-j575c.dts b/arch/arm64/boot/=
dts/apple/t6041-j575c.dts
> new file mode 100644
> index 0000000000000..0bd50072e463b
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6041-j575c.dts
[ ... ]
> +/ {
> +	model =3D "Apple Mac Studio (M4 Max, 2025)";
> +	compatible =3D "apple,j575c", "apple,t6041", "apple,arm-platform";
> +};
> +
> +&framebuffer0 {
> +	power-domains =3D <&ps_disp_cpu>;
> +};

[Severity: High]
Similarly, can this prevent the framebuffer from working on the Mac Studio?

The ps_disp_cpu domain is also disabled in t6041-pmgr.dtsi. Using an
enabled domain like &ps_disp_fe might be needed here to avoid the screen
staying black.

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t6041.dtsi b/arch/arm64/boot/dts/a=
pple/t6041.dtsi
> new file mode 100644
> index 0000000000000..258048167df63
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6041.dtsi
[ ... ]
> +		cpu_e0: cpu@0 {
> +			device_type =3D "cpu";
> +			compatible =3D "apple,brava-e";
> +			reg =3D <0x0 0x0>;
> +			cpu-release-addr =3D <0 0>; /* To be filled by loader */
> +			enable-method =3D "spin-table";
> +
> +			d-cache-size =3D <10000>;
> +			i-cache-size =3D <20000>;
> +			next-level-cache =3D <&l2_cache_0>;
> +		};

[Severity: Medium]
Are these cache sizes intended to be parsed as decimal integers?

Without the 0x prefix, the device tree compiler reads these as exactly
10,000 bytes and 20,000 bytes. This will cause incorrect reporting of the
cache topology to userspace and could lead to suboptimal scheduling or
memory access patterns.

Should these be prefixed with 0x (e.g. <0x10000>) to represent 64 KB and
128 KB respectively?

[ ... ]

> +		cpu_p00: cpu@10100 {
> +			device_type =3D "cpu";
> +			compatible =3D "apple,brava-p";
> +			reg =3D <0x0 0x10100>;
> +			cpu-release-addr =3D <0 0>; /* To be filled by loader */
> +			enable-method =3D "spin-table";
> +
> +			d-cache-size =3D <20000>;
> +			i-cache-size =3D <30000>;
> +			next-level-cache =3D <&l2_cache_1>;
> +		};

[Severity: Medium]
Similar to the efficiency cores above, do these performance core cache sizes
need a 0x prefix to be parsed correctly as 128 KB and 192 KB?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-apple-m4-p=
ro-max-initial-devicetrees-v1-0-781fb3f2d9f6@cyberchaos.dev?part=3D10
