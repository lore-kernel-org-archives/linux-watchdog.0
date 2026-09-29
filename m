Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFD450B414;
	Tue, 29 Sep 2026 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790679624; cv=none; b=cVpF/SKjO4WKQRQcJmsFSOC+kwnnVCvdXRWIt6Dxs80S8DWzmia+HjYK5Mg2gFmQUta5ayg4VHRU4Ee5ZsQy+sDKbqlRSRD3SaB++zVTss9rL38ELjHBRElsA34mF7edsSe+JyN6nLr159KtSYLaH1C7OpJZWWvYTBiik2juq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790679624; c=relaxed/simple;
	bh=PaEKjhTUvqHmgyMmOg9z3d5z29C1/JYRTWzMTC8K820=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kN9a8pmRr622RPt5xigQ/6Bb45+YV4N1oN6D3g2oVLujheyvo6p+uBQFuqpeBBiugT1kUNBiN2l9F4ROoG9vU3grkXDRQ791s7bRECTYeFkymkyS7ndmCMsRpz9OskvDP6zqcSo+rlOoGAdKokBBE2BfiwxJPPyhYqkLgpac/BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7xhJ+D9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7xhJ+D9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830251F000FF;
	Tue, 29 Sep 2026 11:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790679619;
	bh=9FwcPsgy/8MQSekMQyAYgYEn09YnIK5mnKMDv/Ijd+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b7xhJ+D9NHyR/WByArv9t6eOMRrQLyrpHVayoCP50B21hX4reD1QaaWSh6qnWsqJQ
	 ut1dp9u6kdRfdADw9ct7ijfmapdoMlrrA2/kOhBuyzfFhQISQDHqch9UWLSGwEiJb1
	 huyM0oqt3Av4/DeQu+YrlSpaheOV0c7MtcbkG4PK8Z58PRq2fMXmOmVppNyNOZrCEO
	 xHZpyyRLvXoAHjvRLMT01y7869wwYxUK98oFp8IMqJmqNOYtBIhxThklkWFtggTEg4
	 gpmzROsWsFPYqsGDZyC8VpTEHKArD1pK4qyXmnSxSoXtJ0+6qWG9hg5Kc3BBjDpPJg
	 vUEOvQhudO9tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 8/8] arm64: dts: renesas: r9a09g087: Use CPG/MSSR
 syscon for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-clk@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
In-Reply-To: <20260929105021.542730-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929105021.542730-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260929105021.542730-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:00:19 +0000
Message-Id: <20260929110019.830251F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] dt-bindings: removing second 'reg' entry breaks old kernel com=
patibility
--

commit 74168eab64567b9dfb3f02ff14712a6e81564a41
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

This commit updates the device tree to replace the direct mapping of
individual WDTDCR registers with a syscon phandle to the CPG/MSSR block.
This consolidates the multi-function block access via a unified syscon
regmap interface.

> diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g087.dtsi
> index 68c8daed557bd..abca7aa894589 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> @@ -327,61 +327,61 @@ channel1 {
> =20
>  		wdt0: watchdog@80082000 {
>  			compatible =3D "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
> -			reg =3D <0 0x80082000 0 0x400>,
> -			      <0 0x81295100 0 0x04>;
> +			reg =3D <0 0x80082000 0 0x400>;

[Severity: Critical]
Does removing the second reg entry here break backward compatibility with
older kernels?

Device tree bindings are typically treated as a stable ABI, meaning newer
device trees should be able to boot older kernels. The rzv2h_wdt driver
in existing kernels unconditionally calls:

devm_platform_ioremap_resource(pdev, 1)

for this compatible string. By completely removing the second reg entry at
index 1, older kernels might fail to probe the watchdog entirely. Is there
a way to deprecate this gracefully or retain the second reg entry for
compatibility?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929105021.5427=
30-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8
