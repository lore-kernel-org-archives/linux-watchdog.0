Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559BB4A3D3B;
	Thu, 10 Sep 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047366; cv=none; b=BXedFSebTpL/0ObGs9U7YUmyYX7OzWZh3xIvIg4Cg/v1OYfawjmfuf0t79QH1roOp1R4ruX/tIfS3PSez9U271uiiHCYgQ7198j7N6+EqcyurnyfauZ2n4CdyB09Crnbev35qLhyRyo8z/7IhsBLJL/KpQE4JaN3Bp1pxcmMTh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047366; c=relaxed/simple;
	bh=y95iMjL+/4gPGyfqmJUXWWrWO3erfYszuzxma4S8pwY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUQryWEdDA+9RQrLxyXFL3lvWUVxjBKLZhOuVUKh6q07KTZhyc2XIR+arA7ywmlzxXcau+8Vexinnohk/HL5ZOucmGaln/guR7vnmTo+I8EW5ipG00GMkgvY5kYwJHOSU8UzsqcHe3zf9RpkMi3uPPGoivALzqtFwcoKZGqnCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPykt444; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPykt444"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E861F000FF;
	Thu, 10 Sep 2026 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047365;
	bh=tMx4N0gjhiphBW4hq+I1VHtDp7kBjsTy0u9rFYpARZo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZPykt4448AVQnP9XK8dpXi3XtreTlXxBp8TLXrZD+k5eL8VgTsPdUdsoxT7kJc0aP
	 UncSnO4UV7BPvsbAyYYwJsOuTOw9nOOME+3Qj/9sXtzKFx3HxcCE/Oa6x9BXNwNIKU
	 lC8dT6P9bszln+jR3wi0//uxhoTqcAgBEGLOnSHYp8j+b4ZJlZ0qN0rS9UV+SxoOq9
	 aa14sIBa1R7HqxWlv3Ohhy80X4yUrH3PRge4tfelxhCgx3KP0XlOuJ/S4N4xsM6NUU
	 N8KFmP1uY6Jxm6TEs+NjxCsQ+f+1MlScaN7v0pOCTBKd/v5C8SoP1hIcfwvXIcVkdw
	 o110d4ap8bOdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] ARM: dts: mediatek: mt8127: Add watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zakariya Hadrami" <zkh@mailbox.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260910-mt8127-amazon-ford-basic-v5-3-3cb9eeaffd5c@mailbox.org>
References: <20260910-mt8127-amazon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org>
 <20260910-mt8127-amazon-ford-basic-v5-3-3cb9eeaffd5c@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 13:36:04 +0000
Message-Id: <20260910133604.A1E861F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The watchdog node is disabled by default in the SoC .dtsi, which is=
 a device tree anti-pattern for internal IPs without board-specific depende=
ncies.
--

commit 00ce16ebfa121cfaa7d2f6798bebf7e7aabf4c90
Author: Zakariya Hadrami <zkh@mailbox.org>

ARM: dts: mediatek: mt8127: Add watchdog support

This commit adds the watchdog node for MT8127 and explicitly disables it by
default in the SoC dtsi.

> diff --git a/arch/arm/boot/dts/mediatek/mt8127.dtsi b/arch/arm/boot/dts/m=
ediatek/mt8127.dtsi
> index bd61ec7e70c0c..9bdf55d2da479 100644
> --- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
> @@ -99,6 +99,13 @@ soc {
>  		compatible =3D "simple-bus";
>  		ranges;
> =20
> +		watchdog: watchdog@10007000 {
> +			compatible =3D "mediatek,mt8127-wdt", "mediatek,mt6589-wdt";
> +			reg =3D <0 0x10007000 0 0x100>;
> +			interrupts =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> +			status =3D "disabled";

[Severity: Low]
Is it necessary to disable this watchdog by default?

The watchdog timer is a core internal IP of the SoC that does not require
board-specific configuration. Standard device tree practice is to omit
status =3D "disabled" for internal IPs in the SoC .dtsi file.

The commit message states "disable it by default as it was not present
initially". Will this require every board file inheriting this .dtsi to
redundantly set status =3D "okay"?

> +		};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-mt8127-ama=
zon-ford-basic-v5-0-3cb9eeaffd5c@mailbox.org?part=3D3
