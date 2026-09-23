Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE7448A2BC;
	Wed, 23 Sep 2026 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160844; cv=none; b=RtUf6E+zDBTnaFXjvYG4yR5e2wnMEDH5tfXmHEUENszBjSwrXwe9QfMsu2kw3oIL92lgk3Aawu+37uqPdqa9bEy+l6K7ZqoECZOPHUYc41xa9NDJOHM1m6ND1QvyIE8ADDCP5cuZPdjRUvZEHABKMmGJ9arXacF+WiC+y9ibxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160844; c=relaxed/simple;
	bh=+oIZbFpHTw9nfUFFjBBG6YWXvv6tX/rhXqvCXnCjjRY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nEBjUZo8nV5RcCM9t1JGZiLnTLrLp+Y7U18OultRJIuAzaVJ6KN5IYaw877pkmxwBoIOntkSXPBVz0VBzfniGFkXsSQpMD1FC9gk2NA2IODvYRvpGRh1xbgikPGfPttVAYOlFCbgnTQbMHgWMzpdpH8UmhPJ+AQaMuNmiUejrt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/kFR9EM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M/kFR9EM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A761F000FF;
	Wed, 23 Sep 2026 10:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790160828;
	bh=znEvxhsA08M8RphyNPGHQFkIQ21uevMFNp9f+9lE14Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M/kFR9EMHVZVu0NTLBJ8n/GqzVybZm1nU+AwTRYp1TzUG+Gl/7DBiHcOTQXEli0Iw
	 HrScEzsb5559aShIoR3Xr3a08uMV7qDzhGwfcf60CdQpyK7yVIo6m2SbDnJ2PzXJ/f
	 CPGNCMldLl3DhsimjIHxrdDMgXkKOIgCh+ZIDZV65vh2Tv0DhscGPyx1K7DO/JqVrU
	 FpILbkD9rSxT8uOvYcv3Yyx+QtUjGYV8fGtfABQz5fVIpgXqdEzB4l4YUMjFnDyVFZ
	 m7miWLBv297ZnODuys6IQfUZ5GtBGko2eaWftpgk+1Q1k3ccEqqqmD01uWYperiwGL
	 ZVYOct6OM8EwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] arm64: dts: renesas: r9a09g087: Use CPG/MSSR
 syscon for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org
In-Reply-To: <20260923104054.3324830-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 10:53:48 +0000
Message-Id: <20260923105348.68A761F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] arm64: dts: syscon regmap lookup fails for WDT due to non-syscon C=
PG node
--

commit 965ed970b62c83d1a303f6e2583dfa7e66ebde5d
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access

This commit replaces direct register mappings for watchdog timers
wdt0-wdt5 with a syscon phandle pointing to the CPG/MSSR block. The WDTDCR
registers are noted to reside in the second register region of the CPG.

> diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g087.dtsi
> index e8d4f76949ccb..40ffe56a40353 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi

[ ... ]

> @@ -327,61 +327,61 @@ channel1 {
> =20
>  		wdt0: watchdog@80082000 {
>  			compatible =3D "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
> -			reg =3D <0 0x80082000 0 0x400>,
> -			      <0 0x81295100 0 0x04>;
> +			reg =3D <0 0x80082000 0 0x400>;
>  			clocks =3D <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
>  			clock-names =3D "pclk";
>  			power-domains =3D <&cpg>;
> +			renesas,sysc =3D <&cpg 0>;

[Severity: High]
Does this property correctly resolve the syscon regmap?

Looking at the driver implementation, it appears to use
syscon_regmap_lookup_by_phandle_args() on the cpg node. However, the cpg
node lacks the "syscon" compatible string, and the CPG driver does not
manually register a regmap via of_syscon_register_regmap(). Will this cause
the lookup to perpetually fail with -EPROBE_DEFER and leave the watchdog
unavailable?

Additionally, if the cpg node were defined as a standard syscon, it would
only map its first reg region (size 0x10000). The watchdog driver generates
an offset of 0x15100. Writing to this offset would exceed the regmap's size
limit and cause an out-of-bounds -EIO failure.

Applying the offset to the first region also entirely misses the physically
correct second region address of 0x81295100.

Are there additional patches that update the CPG node or driver to handle
these secondary regions and avoid the regmap lookup failures?

>  			status =3D "disabled";
>  		};

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923104054.3324=
830-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8
