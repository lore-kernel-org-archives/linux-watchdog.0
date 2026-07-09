Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10C3DC4B8;
	Thu,  9 Jul 2026 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583598; cv=none; b=n01yby6LaHbAbEGpq/2JiKj6op2TALN3PLj99X9vHkyjbrhB8q4JUw6NlHuys8JAC+t+wAv3I45DReErKl0R0giveBdRYtypqNj/wD/GHnKFi3Pvox884rQwMngn+6lSignOWz/24vqARlGgqQOSS0GyqSmf2cghaMdufvf61mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583598; c=relaxed/simple;
	bh=W3V2um5KC1HnWgGS7QrMEnBP3y+ScSMZSeWBHHR0pX8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FMun1OFkNbVfjR7U5SRkA9/r84EcOvUzeI30JcnrlpvNTh5f7HkfWHGn8fy4RAtECAD6NObzATDx3bWe4vcOH9m0QfAnfBXYd5R02XidO/YqTp/2ZEGbqR50tm4OsFcI8hCZHSvLRmta2NGrtNu7ePu25VljfyqhCwfeyVfnT6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUpx35d9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUpx35d9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB50D1F000E9;
	Thu,  9 Jul 2026 07:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783583597;
	bh=XkPPJs9uyM19Pfso9Wa4fQ/d7m/yxGW6mM7Cradxt7M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HUpx35d9sCNpfgrbng01C90T392EpvD1K+LmVFHEBB0zr1Z1yJBu/h5jUHBylD3qI
	 5krb5DRe60NituXRtZh6II0WhxPZ/OEkpe4AF2nwmaGka5eO5hxwXoSqEYA98huxv0
	 ymtUdPlTr9ihQ8K+NmbDL2aQj6ogjM3xNgEx633jCify3Pa42JzE3rsyMXh0wufWST
	 2wMwOhDk4awKF5CT1sw5VGZC6jzaB85CbwKllxC8EBGm4Zy76qHSVs6eoiD7Ogl4Y0
	 Hngf+yylVyJeiNLqDl0Cnp1ZeUU/xwHdsZLQjjJ0lrf/6MIADjkINAdS1VwqnjSj31
	 kcJiI3RFriJqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] arm64: dts: apple: Initial T603[124] (M3 Max and
 Ultra) device trees
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260709-apple-t603x-initial-devices-v1-10-55b305833123@jannau.net>
References: <20260709-apple-t603x-initial-devices-v1-0-55b305833123@jannau.net>
 <20260709-apple-t603x-initial-devices-v1-10-55b305833123@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 07:53:15 +0000
Message-Id: <20260709075316.AB50D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Duplicate MPIDR in `cpu_p25` `reg` property.
- [Medium] Use of deprecated `label` property in `led-0` node.
- [Low] Device Tree node name unit-address mismatch for `i2c6`.
- [Low] Redundant inline `aic` node definition in `die0`.
--

--- Patch [10]: [PATCH 10/11] arm64: dts: apple: Initial T603[124] (M3 Max =
and Ultra) device trees ---
commit afdb3bddf1523598fd74d4dfc1254a53801825fd
Author: Janne Grunau <j@jannau.net>

arm64: dts: apple: Initial T603[124] (M3 Max and Ultra) device trees

Contains minimal device trees for all M3 Max and Ultra Apple silicon
devices. Those are 14-inch and 16-inch MacBook Pros with M3 Max released
in November 2023 and Mac Studio with M3 Ultra released in 2025.

> diff --git a/arch/arm64/boot/dts/apple/t6031-die0.dtsi b/arch/arm64/boot/=
dts/apple/t6031-die0.dtsi
> index 0000000000000..73f079312a538
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6031-die0.dtsi

[ ... ]

> +	i2c6: i2c@39102c800 {
> +		compatible =3D "apple,t6031-i2c", "apple,t8103-i2c";
> +		reg =3D <0x3 0x91028000 0x0 0x4000>;

[Severity: Low]
Is there a typo in this node's unit address? The node name i2c@39102c800
does not match the reg property address of 0x91028000, which translates to
physical address 0x391028000. This mismatch causes a DTC compiler warning.

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t6032.dtsi b/arch/arm64/boot/dts/a=
pple/t6032.dtsi
> index 0000000000000..529e825c8da02
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t6032.dtsi

[ ... ]

> +		cpu_p25: cpu@10905 {
> +			compatible =3D "apple,everest";
> +			device_type =3D "cpu";
> +			reg =3D <0x0 0x10105>;

[Severity: High]
Does this reg property accidentally duplicate the MPIDR of cpu_p05? The
node name indicates 10905, but the reg address is 10105. This hardware
description mismatch might cause kernel CPU enumeration to fail or behave
incorrectly for the 6th core of cluster 4.

[ ... ]

> +	die0: soc@200000000 {
> +		compatible =3D "simple-bus";
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;

[ ... ]

> +		aic: interrupt-controller@292400000 {
> +			compatible =3D "apple,t8122-aic3";
> +			#interrupt-cells =3D <4>;
> +			interrupt-controller;
> +
> +			/*
> +			 * reg[0]: Main MMIO range (approx 1.8 MB)
> +			 * reg[1]: CPU Event/IACK register page (Base + 0x40000)
> +			 */
> +			reg =3D <0x00000002 0x92400000 0x00000000 0x1cc000>,
> +				<0x00000002 0x92440000 0x00000000 0x4000>;
> +		};
> +	};

[Severity: Low]
Is it necessary to define the aic node inline here? It looks like this
gets merged with and largely overwritten by the inclusion of
t6031-die0.dtsi further down in the file, which defines the same node
more completely including power-domains and reg-names.

[ ... ]

> diff --git a/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi b/arch/arm64/=
boot/dts/apple/t603x-j514-j516.dtsi
> index 0000000000000..467d95cdaf6be
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t603x-j514-j516.dtsi

[ ... ]

> +	led-controller {
> +		compatible =3D "pwm-leds";
> +		led-0 {
> +			pwms =3D <&fpwm0 0 40000>;
> +			label =3D "kbd_backlight";
> +			function =3D LED_FUNCTION_KBD_BACKLIGHT;

[Severity: Medium]
Should this avoid using the deprecated label property? Modern user-space
LED managers rely on standard sysfs directories named color:function.
Using the label property overrides standard naming and prevents user-space
from correctly identifying the LED's hardware role.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-apple-t603=
x-initial-devices-v1-0-55b305833123@jannau.net?part=3D10
