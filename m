Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4B2F8EAC
	for <linux-watchdog@vger.kernel.org>; Thu,  7 May 2026 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187592; cv=none; b=Q63dqsUpoac1ajh4gSiZ4UmjCDuvf6NtGMUgduYkrQlqVMMF/LFvbB/FmBTkINUuuoRRYVXhXKyBrAGQeKv4yU8XJyE3zFgi2GssfmUMvPYcwb2GKSL+bZ7IWCOXJD9ngeYytccIkRxRX311kcC0u4w5kHsTN+/2v0V3ouizn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187592; c=relaxed/simple;
	bh=a/AdweqGBAybqDekXcBGlBeJPcOvZaHtnxIj3rG//fw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b84VaL+EJCINRZuMQaGpaMOlWAbT23JJpyHUIU4NNK3gr8CDbD5eFy8rttLczjXJTaH7whTBvhwllNRgY+U/oUJ8Uv1BJVLkCiXX7Dbj9mi5iaeCk93MlJT4rh7wCjUvp/w+6CP9wBRevym0hr49NAZ+eVsU7McznwGdzVn1fvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMCqtG5U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMCqtG5U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B58EC2BCB2;
	Thu,  7 May 2026 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778187591;
	bh=a/AdweqGBAybqDekXcBGlBeJPcOvZaHtnxIj3rG//fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=RMCqtG5Uwgmqg3wx+gP0jlUJA7QnPaM5WS0keTNA6kkP0uycex4uduM4eGSODbDE3
	 80EaRxKedWxDkodVLrbWPSIwPv8SSQT6zwFCqdelrlUMF9Bm9vtm3goTTC33mEL0TW
	 W8lG7dOCLYa3dnphmq4yxBfHhnkGZzx0sHKAfceQA5l0PztrPInUO1WBwCCtj6OiAR
	 KA7XA4kqibZveF34xeHP30m9l2Mp6qhUwONzY67WP39MMWF5eCVygEXB/YeGtj8DUE
	 tOOFwREreuUPsGBbcoBiGZ8Al2YAauBhquSbQl6oeFKA/hmhrQArrzm5YbZsbh82i9
	 SV4vxlRPGLRiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] arm64: dts: apple: Initial t8122 (M3) device
 trees
Reply-To: sashiko@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-watchdog@vger.kernel.org
In-Reply-To: <20260507-apple-m3-initial-devicetrees-v3-5-ca07c81b5dc7@jannau.net>
References: <20260507-apple-m3-initial-devicetrees-v3-5-ca07c81b5dc7@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 20:59:48 +0000
Message-Id: <20260507205951.9B58EC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] The `aic` node uses a new compatible string without a fallback=
, which will prevent the interrupt controller driver from probing.
- [High] The 'aic' node defines overlapping physical memory regions in its =
'reg' property.
--

commit 14b9a4a178ff9110e283f578f130160b0dd626f8
Author: Janne Grunau <j@jannau.net>

arm64: dts: apple: Initial t8122 (M3) device trees

This commit adds initial device trees for all t8122 based devices. The devi=
ce
trees provide a minimal set of devices, including the CPU cores, interrupt
controller, and basic peripherals.

> diff --git a/arch/arm64/boot/dts/apple/t8122.dtsi b/arch/arm64/boot/dts/a=
pple/t8122.dtsi
> new file mode 100644
> index 0000000000000..c6196225e96ef
> --- /dev/null
> +++ b/arch/arm64/boot/dts/apple/t8122.dtsi

[ ... ]

> +		aic: interrupt-controller@2d1000000 {
> +			compatible =3D "apple,t8122-aic3";

Is a fallback compatible string missing here? If the driver does not yet
have a matching declaration for "apple,t8122-aic3", the interrupt controller
could be ignored by of_irq_init() and the kernel may fail to boot.

> +			#interrupt-cells =3D <3>;
> +			interrupt-controller;
> +			reg =3D <0x2 0xd1000000 0x0 0x184000>,
> +				<0x2 0xd1040000 0x0 0x4>;

Do these physical memory regions overlap? The first region starts at
0xd1000000 and extends for 0x184000 bytes (ending at 0xd1184000), which
fully contains the second region starting at 0xd1040000.

> +			reg-names =3D "core", "event";
> +			power-domains =3D <&ps_aic>;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-apple-m3-i=
nitial-devicetrees-v3-0-ca07c81b5dc7@jannau.net?part=3D5
