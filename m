Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FF422301;
	Thu, 16 Jul 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219578; cv=none; b=IaMCPUg55pqxGgpN5VRoSEr6OFvUm3AQJ+RstkwuO5f5YEsj1groOZ1Ar/GbQGT5JHlTtvfWpcshRayYZcZdgphWWA+nfq/c1G0T3IpOLEKZyMUKJas74qdUQEWK+AeglqPa5QSc4uRTQCQOuQ3T/MCS6g0ZNRwBL5zb5vA+l5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219578; c=relaxed/simple;
	bh=oG65htyBZ+Qx+UlJEyl3JkK3S7MacMN/H7s3h7hm1y4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUDib/GfxrDYJ6DxFdT7hk4QQA+KacLBcWskP5PihwCY6mpiHwCInJJsaQiE1Stuia9aZo+QyPThrNS5/ifLvslZLLKMrvU9v3yswJ4QrwZkbsC/IQMDIpXwxKriQ/R8Gi+V3v/JPyw4gWgE7C9yc5XubuR8jMTyh81JMzbysZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeFOYpzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeFOYpzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6821F000E9;
	Thu, 16 Jul 2026 16:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219572;
	bh=cQS1rPSQ6shCfXs5DXNQTIh/IwWxPpAGfZYgalAMG4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YeFOYpzgGidPoc9z6sYYcXKzxUC/nqmg8MNN+PQmyiI9XupLvn4Oi+0p65RiLp2O3
	 n1uZ7RbYEdLeinKtNy7LOuRWPupIwC2Gpm4tSbCtbtEpF99Yr7nOm3Af5isTpiD+dE
	 BFaKGvRy8PI5RnqNPbfrQC2t5Gd8ye5fxYGX2ONDRhnbWQJSxOAWQ90KYD9EOYm+/l
	 fvWM+GX7doxJl2fTmIkWc6GnAdH1OQraF8tiJlEJEPpE5gXDdJf+uXx6S4mDaMYdFl
	 /87jrrNh5BDrDnAcYzor0FyXFDaQNicNQJlusFPYCaqyX6ZT6ECwe1YaYhNw7cHhvP
	 o7jTWBu8KEvcQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] arm: dts: mediatek: mt6589: add reset support for
 wdt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akari Tsuyukusa" <akkun11.open@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260716161923.266315-8-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-8-akkun11.open@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 16:32:51 +0000
Message-Id: <20260716163252.3D6821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The dt-binding schema fails to enforce `#reset-cells` as a requi=
red property for watchdog variants that act as reset providers, such as `me=
diatek,mt6589-wdt`.
--

--- Patch [7]: [PATCH 7/7] arm: dts: mediatek: mt6589: add reset support fo=
r wdt ---
commit 3940ed1252e6cfe8fc145910821de71c2c72776d
Author: Akari Tsuyukusa <akkun11.open@gmail.com>

arm: dts: mediatek: mt6589: add reset support for wdt

This commit updates the MT6589 watchdog device tree node to support TOPRGU
resets by adding the #reset-cells property.

> diff --git a/arch/arm/boot/dts/mediatek/mt6589.dtsi b/arch/arm/boot/dts/m=
ediatek/mt6589.dtsi
> index c6babc8ad2ba6..4d29ed495d31e 100644
> --- a/arch/arm/boot/dts/mediatek/mt6589.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt6589.dtsi
> @@ -136,6 +136,7 @@ uart3: serial@11009000 {
>  		wdt: watchdog@10000000 {
>  			compatible =3D "mediatek,mt6589-wdt";
>  			reg =3D <0x10000000 0x44>;
> +			#reset-cells =3D <1>;

[Severity: Medium]
Does the device tree binding schema for mediatek,mtk-wdt need an update
alongside this change?

Adding #reset-cells here indicates this watchdog variant now acts as a reset
provider. According to the dt-bindings subsystem guidelines, when hardware
gains new provider capabilities, the corresponding standard properties (like
#reset-cells) must be added to the required list in the schema with
appropriate constraints.

Without an allOf with if-then conditional block in
Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml to enforce
#reset-cells as required for mediatek,mt6589-wdt, functionally incomplete
device tree nodes missing this property will silently pass dt_binding_check
validation.

>  		};
>  	};
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716161923.2663=
15-1-akkun11.open@gmail.com?part=3D7
