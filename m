Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAEC357D08;
	Thu, 23 Jul 2026 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787521; cv=none; b=QJwuEgzxJjuUzxBi2IhMF4gcXL0s3IrxBNfBgEZFuZNrZya7syk4652WmO5ClqZx6Hz7jX+6NZRA29fXYyzLqZba6Ul412MnuNHKbxUuEapeDP0QjVTN+oop6I3GPNyY5DBg3A8FtCIvVNkYdFoDZ5xX+PvxGU03zTCVRBn24WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787521; c=relaxed/simple;
	bh=SSmMqUVUMSRBL5Gz0dHbUNVu1Q6dXvT/Rd3l6ndtAkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nfImr0htZE9L4v4zmh4MHp5yLJuUkwasiC2yNGb84bQDQJ6Mc1xO2egU/QL4lVRz16uFk9MIFLsQD9CwDrNCxOScqU9w1+1ECTGnxhLTPVw1eOXx7R16OEOXMG4cWWPGRKbBg9MEbEPuUaSYviwK/tk4w/RcPvNTQl29Mb/8aaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZhl3mRl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZhl3mRl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2531F000E9;
	Thu, 23 Jul 2026 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784787518;
	bh=kprNeMjWHoTBCgnoD5IHOrPoQVCQYxFndnj/sQUexf4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kZhl3mRlCf7GTmgscJSxahmWW1bM9XdBRGN8XULgTY2TgAAr1PjPdbpsYe8uhCnTq
	 zBxFVipPXx8xNc8YbLsaeA4CRyUKsc6I71Rf+K2QWqCIMxDDC/pc5XdqwiYrc3Ge/j
	 CAPfHRHaiPdGYimZH6ALN68rlb8Bdhoa39KEtUKqOvWUiEYxcol3FpKK5oaNl50bOk
	 NSw6wZRmDVpPHMLL8Ti/ZVn/DUy3+pISoh9hwvSJavhzrAwNNgI+46kPBIjp+mWrgm
	 wi6xKphabTJEf6HChWlkEqQhwI81mYH0/6Ux6oJ9cpuEhrDosFoqTnTRT+MZT2Y+a4
	 g9tF03o22Phhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: nuvoton: Add WDT node for MA35D1 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi-Yu Chen" <zychennvt@gmail.com>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260723060755.1596858-4-zychennvt@gmail.com>
References: <20260723060755.1596858-1-zychennvt@gmail.com>
 <20260723060755.1596858-4-zychennvt@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 06:18:37 +0000
Message-Id: <20260723061837.DE2531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Error check for platform_get_irq() is always false due to u32 type=
 mismatch.
- [High] Resource leak due to missing device-managed variant for wake IRQ s=
etup.
--

--- Patch [3]: [PATCH 3/3] arm64: dts: nuvoton: Add WDT node for MA35D1 SoC=
 ---
commit c2bd64766eedbf6c5de5bc325d96283f217c6464
Author: Zi-Yu Chen <zychennvt@gmail.com>

arm64: dts: nuvoton: Add WDT node for MA35D1 SoC

Add Watchdog Timer (WDT) device node to ma35d1.dtsi.

> diff --git a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi b/arch/arm64/boot/dt=
s/nuvoton/ma35d1.dtsi
> index 7228ad4735b5c..14fd17cfdc5ae 100644
> --- a/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> +++ b/arch/arm64/boot/dts/nuvoton/ma35d1.dtsi
> @@ -82,6 +82,13 @@ soc {
>  		#size-cells =3D <2>;
>  		ranges;
> =20
> +		wdt1: watchdog@40440000 {
> +			compatible =3D "nuvoton,ma35d1-wdt";

[Severity: High]
Does adding this device node trigger a probe regression if platform_get_irq=
()
returns a negative error code like -EPROBE_DEFER?

Looking at ma35d1_wdt_probe() in drivers/watchdog/ma35d1_wdt.c:

	ma35d1_wdt->irq =3D platform_get_irq(pdev, 0);
	if (ma35d1_wdt->irq < 0)
		return dev_err_probe(dev, ma35d1_wdt->irq,
				     "failed to get irq\n");

If ma35d1_wdt->irq is a u32, the negative error code is implicitly cast to a
large positive number, making the check evaluate to false.

Will this cause probe errors to be ignored and devm_request_irq() to be
called with an invalid IRQ number, resulting in -EINVAL and breaking the pr=
obe
deferral mechanism?

[Severity: High]
Could this also lead to a resource leak when setting the wake IRQ?

Looking further in ma35d1_wdt_probe() in drivers/watchdog/ma35d1_wdt.c:

		ret =3D dev_pm_set_wake_irq(dev, ma35d1_wdt->irq);
		if (ret)
			return ret;

Since dev_pm_set_wake_irq() is used instead of the device-managed variant
devm_pm_set_wake_irq(), and the driver relies on devm_ interfaces without a
.remove callback, will the wake IRQ remain attached to the device structure=
 if
the driver is unbound or a subsequent probe step fails?

Can this leave a dangling wake IRQ and potentially cause a use-after-free
when the device is destroyed?

> +			reg =3D <0x0 0x40440000 0x0 0x100>;
> +			interrupts =3D <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks =3D <&clk WDT1_GATE>;
> +		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723060755.1596=
858-1-zychennvt@gmail.com?part=3D3
