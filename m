Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B44A0EE8;
	Fri,  4 Sep 2026 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551995; cv=none; b=YXcEp4Bmm1sVCPEREqVpc6EvocK0BcTDQc0bbl/qBW/O+PsDoyv7ESZLyDPby77lV6Wa9lyDXzis3ZGeRbU5Hx7Cf6nZVC4NOYRcyK38pOAEmp2hnZC9MRBTA8dYGoraO5gmnrHgYj/oHj2XmYEFcpyZQDlyWHegUCH9/u5cLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551995; c=relaxed/simple;
	bh=4lvg9tM1WNn9SUq5jsYMY14Vw2c0FV3JHDjOy0wvuFc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RT5qODhqFvLUH7QJVE/x45Up3Fnj0t7dmfBMWXiY+08GsQyZ2nePUh09NIYPVNK6ffLa+w8N+6kAMIgKneI3L9hlxydaMdMd1mkzMKQ208l/zJFQ+z+E57wQPcfacIHZLlOfAD9O0qd2Oor9vJ61OeFPMcAkm6eT/bQ7WmQrgSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmyYRqJW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmyYRqJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71321F00A3F;
	Fri,  4 Sep 2026 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788551993;
	bh=dVTAe2pw13ILcdCCxQeGIoeTUZABVZ+l3g6BDJFs5Mw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KmyYRqJWW1bfs3jor4FowPq8bav21BYIHf+YNCOHoq2cgxBT8gBOU/zCo+MGca6Wg
	 g05uRTSk+VXyNtvm0HyyaEFKHJl7oTsHGvZihWPVUP2Z/r9cOe9WEDyslbUpJ6nB/c
	 3RF6Zw7hPa/jZz/VAEf8Qskp9ZZQ1yD9FZtYtfdxfou7PZb9SizEamxeyuIUN9akGz
	 9hmPltiP5/iIkJjKQYBFYNhtaZUZi1Xz3kyjKI14wSXx1RneMrrTKhw58/INH97WTd
	 w6QaXKhtDzvHdE8qYBujiWxyGxlMZ3oPq0sMo5a1QeF+n9neTClhB5dtBXPCAuqsDc
	 AnjTd7pgtShgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] arm64: dts: apple: Add minimal MacBook Neo device
 tree
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yureka Lilian" <yureka@cyberchaos.dev>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-apple-a18-pro-initial-devicetrees-v1-6-0c25401d165d@cyberchaos.dev>
References: <20260904-apple-a18-pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev>
 <20260904-apple-a18-pro-initial-devicetrees-v1-6-0c25401d165d@cyberchaos.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 19:59:52 +0000
Message-Id: <20260904195952.C71321F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Device tree unit address mismatch for the memory node.
--

commit 7bec9f4da6b6b3c3359561db2b7a13c4d806d885
Author: Yureka Lilian <yureka@cyberchaos.dev>

arm64: dts: apple: Add minimal MacBook Neo device tree

This commit adds a minimal device tree for the MacBook Neo, based on the
t8140 SoC (A18 Pro). It includes basic devices like CPU cores, interrupt
controller, watchdog, and serial, allowing the machine to boot on a single
core using the macOS 26.6.2 firmware.

> diff --git a/arch/arm64/boot/dts/apple/t8140-j700.dts b/arch/arm64/boot/d=
ts/apple/t8140-j700.dts
> new file mode 100644
> index 0000000000000..029d6fdda3ade
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8140-j700.dts

[ ... ]

> +	reserved-memory {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		ranges;
> +		/* To be filled by loader */
> +	};
> +
> +	memory@800000000 {
> +		device_type =3D "memory";
> +		reg =3D <0x100 0 0x2 0>; /* To be filled by loader */

[Severity: Low]
Does this code cause a device tree compiler warning? The node is named with
unit address 800000000 (which implies a reg base of <0x8 0>), but the reg
property specifies <0x100 0> (which implies a unit address of 10000000000).

This mismatch between the unit address and the base address in the reg
property typically causes the dtc compiler to emit a 'unit_address_vs_reg'
or 'simple-bus unit address format error' warning when compiling
t8140-j700.dts.

> +	};
> +};
> +
> +&serial0 {
> +	status =3D "okay";
> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-apple-a18-=
pro-initial-devicetrees-v1-0-0c25401d165d@cyberchaos.dev?part=3D6
