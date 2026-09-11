Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF60C38F249;
	Fri, 11 Sep 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126359; cv=none; b=GOGHB+/zvs84irXmHufzJ5mt2cngmWKM4tNrINqwFBKjDD3t8HJd2/nfyJdrRrrnhyPItnKg9LtSP5OeaF3ykw/Q/SgCCLFxWoaeFUPxRiZApynFKs7ncypdHm3wG0ZtGTM9dPTZefHmnbPoJ1LTl4QDy6CDhg8M1KQDGYvtwY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126359; c=relaxed/simple;
	bh=9O0JP8UsQvKZjUAyRh3tLvaGVOxqgPF8lwwIZ66XuzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B5d3BUfc1fxv219wZ09XvazyDe+VBR8n7yUtjLXGfV7qkWXxJNbsiRp9416+rI8wrz3A+EUGIrd+onfVDm9e40fj+1N3QVmY/eXd+QhaDL3GrcdWQFhB4s21V1iOLAlHkkhjC2Uxy5q3Lg9LLks5X+KMvyIqKosejn6soOO9pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoLQS3dt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoLQS3dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3810F1F00893;
	Fri, 11 Sep 2026 11:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126336;
	bh=nPb6ePHD3DBCwEh+6AehohjVlwhe7RL16iLnzLf8xrA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YoLQS3dtADRMhVFlPQzNe2w3oj5fzfbXgW7ed9nYHeeiWOSbRMHteBxE+EuT1lcJz
	 6UNnYamBFLZ6iKjEMfBgXysoarLN4RF5KAJdo5TjDXV0mTSdgWBTyzWtHYFKim6NPe
	 YjpB/Ae8YxdBA98g02eaoP84usAU0Q3uYBey4SGnGqH16QYnIuOryINNPaoDFctI1r
	 mBy0/o+tOV2cBAuRDa5XGKp4v1rJqeQY29TfmHMxAM+VWJLaVA2oN20navkg9a5A0A
	 h4NDrWG6RfBOGzhGGA4BgDzJILAFVSVZDbsZaGOUaCmRPvJp7KmhWVfEFx/wiXaar4
	 aJBDaHRjNmDOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/8] arm64: dts: renesas: r9a09g077: Use CPG/MSSR
 syscon for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-watchdog@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260911111731.3404308-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:32:15 +0000
Message-Id: <20260911113216.3810F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The transition to using a syscon regmap for WDTDCR access is broke=
n, preventing the watchdog from probing and containing an out-of-bounds reg=
map access flaw.
--

commit 0e87a2089f722e3ac7bcab46cff76d445536d9fd
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR acc=
ess

This patch replaces the direct mapping of individual WDTDCR registers for
watchdogs wdt0-wdt5 with a new "renesas,sysc" phandle property pointing
to the CPG/MSSR block. The watchdog driver is expected to use a unified
syscon regmap interface for these accesses.

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
Does this node successfully acquire a syscon regmap from the cpg node?

The cpg node lacks the "syscon" compatible string in its definition:

		cpg: clock-controller@80280000 {
			compatible =3D "renesas,r9a09g077-cpg-mssr";
			reg =3D <0 0x80280000 0 0x10000>,
			      <0 0x81280000 0 0x10000>;
			...
		};

Without the "syscon" compatible string, syscon_node_to_regmap() will return
-EPROBE_DEFER indefinitely, preventing the watchdog driver from probing.

Furthermore, will the generic syscon regmap allow access to the WDTDCR
registers in the second memory region?

The generic syscon framework only maps the first reg resource region, which
the cpg node defines as 0x10000 bytes. The watchdog driver calculates a
WDTDCR offset of 0x15100 via:

drivers/watchdog/rzv2h_wdt.c:RZT2H_SYS_BLOCK1()
#define RZT2H_SYS_BLOCK1(n)	(BIT(16) | (0x5100 + (n) * 4))

This offset exceeds the max_register limit (0xFFFC) of the generic syscon
regmap. When rzt2h_wdt_wdtdcr_count_stop() passes this offset to
regmap_set_bits(), the regmap core will reject the write with -EINVAL.

>  			status =3D "disabled";
>  		};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911111731.3404=
308-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D7
