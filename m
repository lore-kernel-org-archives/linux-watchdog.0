Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228849E12F;
	Wed, 23 Sep 2026 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790161528; cv=none; b=JhMKFidqPb5tiJYnl2twRD00GHrYwhs0gcXRpza8S3pGzc9NYhoW+WC3VDwy3Xjg90cBbRI3xAxiDGlkRKUYVyGS259xvH9kaANXBZ2bRvQ3vC55hDGzIWtXPYjzUDC8ap4/UVGutyXEbwwqsglj/kxGX3OeD+b5ySIzbtdItFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790161528; c=relaxed/simple;
	bh=BG1LmYBJycGlKHga2vrOYqUq3jgnoVTEd0ZyQF+IuZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RhXID9JvlwTKkHWGgh0pG8+zu4MFwGN9K5g+pOxeLCSvvxY9qeFY88JrOyEt2SionVX1Q8Y6GSzF8cqdoRYkJZ8SgIM+pC5bgSTKJzsYB0WjItZOXs6NfJY+3DDVLi89Jd18rR5wljaJ+D6IIYXXVa14R88e28mUpUJu4fty6cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krh++msq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krh++msq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CC1F008A0;
	Wed, 23 Sep 2026 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790161519;
	bh=VjMgowPyf5El8SVb8JYGwulnTmp0N7MctuHOd2JswAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Krh++msqfLEB0KIsbN2fUSgby5I7F2mnfLMh8rv5LNfAdOxC4GFNW9oOBDg+Y+Q4y
	 imSUx0yS/EuY+5Rkk/L9eJ63MEyEI75mMThtkVPPUw7OSwAgl53AjUbikwDWya/PiV
	 T7L9TKpY+x2SYfce+Sv8e1ZoN0BbHOPmMyL5UdhHtP0Ucxl1aWkbMo3cu0anQ7nFTl
	 YyQ9ZKENsWrk8UN/kNaOBMPQ8Q4zLW7JBCqodbCssA7bCay1GGUOgoOd155LuMf1uR
	 +9HfrNTZQ9//3tdGeQn4ItBsdyudNBOhqjWEpUtoTN3Q4JsOopQguxMvMWYD1+09uP
	 f7Z/hz54SLorA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] arm64: dts: renesas: r9a09g077: Use CPG/MSSR
 syscon for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260923104054.3324830-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 11:05:18 +0000
Message-Id: <20260923110519.1A7CC1F008A0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] probe: watchdog driver perpetually fails to probe due to invalid s=
yscon target
--

commit 4e5d24eec602a0526d0eac3d1f59b54aa0dd4798
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access

The WDTDCR registers for wdt0-wdt5 reside in the second register region of
the CPG/MSSR block. This multi-function block is now exposed via a unified
syscon regmap interface.

> diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g077.dtsi
> index 40494159831d8..ad5189d55cef2 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> @@ -327,61 +327,61 @@ channel1 {
> =20
>  		wdt0: watchdog@80082000 {
>  			compatible =3D "renesas,r9a09g077-wdt";
> -			reg =3D <0 0x80082000 0 0x400>,
> -			      <0 0x81295100 0 0x04>;
> +			reg =3D <0 0x80082000 0 0x400>;
>  			clocks =3D <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
>  			clock-names =3D "pclk";
>  			power-domains =3D <&cpg>;
> +			renesas,sysc =3D <&cpg 0>;

[Severity: High]
Does the cpg node have the "syscon" compatible string?

Looking at the cpg node definition in arch/arm64/boot/dts/renesas/r9a09g077=
.dtsi:

		cpg: clock-controller@80280000 {
			compatible =3D "renesas,r9a09g077-cpg-mssr";
			reg =3D <0 0x80280000 0 0x10000>,
			      <0 0x81280000 0 0x10000>;

Because it lacks the "syscon" compatible string, and its driver does not
manually register a syscon regmap, won't syscon_regmap_lookup_by_phandle_ar=
gs()
perpetually fail and return -EPROBE_DEFER during the watchdog driver probe?

Furthermore, if it were treated as a generic syscon, the generic driver only
maps the first memory region (size 0x10000), meaning max_register is 0xFFFC.
Since the WDTDCR offset is calculated as 0x15100 + n*4, won't all register
accesses be rejected by the regmap subsystem as out-of-bounds?

>  			status =3D "disabled";
>  		};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923104054.3324=
830-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7
