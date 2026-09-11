Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEF43D4E2;
	Fri, 11 Sep 2026 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126416; cv=none; b=APlvhwcMQU0tjEtQ/wd8Tzg5PU+bgYNL/a489SSRwYMx2hpT7Aw+CTTM4gVxeZ8/GoK/hT/bDUtvyGJqR+JZtegZn208B7jnLOmdgt+rdtfhvrHncHhUBaD+ZSGagjYFGalU3T5eS/z7R1tMmlIZTGaJzXW8gAwzE2N+arIqzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126416; c=relaxed/simple;
	bh=eFZ5tqRkAUa6Ovsg9USVVfAZEZEhVAvMt9yEthqqVj8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lDs2qEgv+YYieIuSR6OoC0qMDi7fsBT4yYxfMZdqk8c46TbnqO/7Pr8l9MovqKHMFJW2R7j0Yn/kwpuIRDD2XwqmmVyk5qL0QlRwavnmW/H1AQn8LHF+vpKejzDxXMp/Y5gz5rZqFQDokhFw1ybwDqVT4jXZRrxIcZiCbeTDJtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2RJhE4e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2RJhE4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03531F000FF;
	Fri, 11 Sep 2026 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789126403;
	bh=TRLMOkxzmtsNF9RKy/kC3dC+5lDk67f+HUX8e+PCXAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q2RJhE4eJgUjvWh2vfSRpsOTYT/ZPAJ/mTB8UP5zniHSFreaFR1ejruIjj9rLrPEs
	 JEFNwidl8jkFGGH1uRqSshjmcqT2nnd0dM0zS2zfpQqY93bROdOczp/ZJnGJ/6ce7D
	 ImloJwwsrIiIFefwwn34pFwQn+N6LeW2ZRJvDFKZNkqGoXW0xwh+9bpXG7GwIvjIEw
	 8P2Ll4maPRu4Ph8jDD+PsIl2k7N5czYHE62yEXEboBe0/eoPEF305ON5Ptq5TrjZx4
	 mdVuT3xwfvHbNtXCS79/ET8DA4oMCI7rpR5NReCiGzKWZRW21z3omBx0CPzTGTxBHJ
	 XCuy4HXgIbkJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] arm64: dts: renesas: r9a09g087: Use CPG/MSSR
 syscon for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260911111731.3404308-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260911111731.3404308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260911111731.3404308-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:33:22 +0000
Message-Id: <20260911113322.F03531F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Watchdog probe failure due to missing syscon compatible string in =
CPG/MSSR node and invalid physical memory bounds for the disjoint second re=
gister region.
--

commit 026369134b14659a11e1791a537a1142aec5c877
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

This commit replaces the direct mapping of WDTDCR registers for watchdogs w=
ith
a renesas,sysc phandle to the CPG/MSSR node. It updates wdt0-wdt5 to remove
the second register region and use the syscon interface instead.

> diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g087.dtsi
> index e8d4f76949ccb..40ffe56a40353 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> @@ -327,61 +327,61 @@ channel1 {
> =20
>  		wdt0: watchdog@80082000 {
>  			compatible =3D "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
> -			reg =3D <0 0x80082000 0 0x400>,
> -			      <0 0x81295100 0 0x04>;
> +			reg =3D <0 0x80082000 0 0x400>;

[Severity: High]
Does this change cause a silent mismatch with the actual hardware topology?

Generic syscons map only the first contiguous reg block. The driver computes
the WDTDCR offset as 0x15100. Since the first CPG block mapped is typically
0x80280000 with size 0x10000, accessing 0x15100 either fails the regmap bou=
nds
check or mistakenly accesses 0x80295100 instead of the previously configured
0x81295100 located in the second CPG block.

>  			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
>  			clock-names =3D "pclk";
>  			power-domains =3D <&cpg>;
> +			renesas,sysc =3D <&cpg 0>;

[Severity: High]
Will the watchdog driver probe fail indefinitely here?

When the rzv2h_wdt driver uses syscon_regmap_lookup_by_phandle_args() to pa=
rse
this renesas,sysc phandle, it evaluates syscon_node_to_regmap() on the cpg
node.

Because the cpg node in r9a09g087.dtsi lacks the syscon compatible string,
and the renesas-cpg-mssr driver doesn't register a custom regmap (e.g., via
of_syscon_register_regmap()), the lookup fails and returns
ERR_PTR(-EPROBE_DEFER). This prevents the watchdog hardware from functionin=
g.

>  			status =3D "disabled";
>  		};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911111731.3404=
308-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8
