Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA73EA968;
	Thu,  1 Oct 2026 17:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874198; cv=none; b=TrQnFlKADXZEgzc60hOYLjdSYVYniWrmsv9LVn9PZc8xltRbG2zOUn8Tqp0tgXdsjFR5rFg0W5eDuab8FKJWGyLxxo3+WoOc/AxznN5hgp50/lFZkRx07hHYqOESnN3d/vZChf/fXTWmAGTBO1GVVcmCd0Ku+4bLeJq94Fs4q1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874198; c=relaxed/simple;
	bh=k4oG2VPvJTBhQUFLFk9Lx688pZ6WUP+DvDBKdDYXAwg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j9z+Gb6duMmdP/wPWY+H/JKu5o7AIYReQ26qwfWh1m5bXO6C41SS8UqE91O7EO9HKRqdRtNTSlWipq4gKq6aTKdEW6yoVXSH8q3lrSYDJ3q1eaMpiUoHc54lrAYVESNMqaRprGpN48e9+hgyODnTRUTxQbT1CJ1ZcG1mFPRDO1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG/ZRB33; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG/ZRB33"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A0C1F000FF;
	Thu,  1 Oct 2026 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790874189;
	bh=sZET9s6iYFU5NkWtvGNZMHQuWgx3Mq5B40yI/lXqW5c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JG/ZRB33clUUplNX2l9wM0JiQLVmUbonIwu6qf1kn/w3UcVuYvNQ3xpW0I0EpvdUS
	 77d1nu0hVUjD2lPyQjmyeWYs30RNY+WjLPwCWMyQLQbq1HyUocAQ7Ly692abZt7LdG
	 7eM7GFjIAmmONBhgVLo1F0Oa9VqZrdLiHieDFc4ezgeF6/MU97K49M7w7C/kUK3ob9
	 o30WWblb4mIs2GvObJGy7IBTEaelBq9ihrqf8tPTfeP4ZfSIeDZTdWZJJhE2d9Vnki
	 ViH+dNnNIFH/b0yYdk9nNlQLTXKgIZ4leWs1TqoQijn3JxZxfrEFwp0/dJjiRiXHsb
	 v1fodT3ohmlmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] arm64: dts: renesas: r9a09g077: Use CPG/MSSR
 syscon for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-watchdog@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261001165201.763882-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001165201.763882-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261001165201.763882-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 17:03:08 +0000
Message-Id: <20261001170308.B5A0C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] dt-bindings: ABI breakage in r9a09g077 wdt nodes due to remove=
d reg
--

commit 73d1717297166d802fe57978f0ccd518dcd4b8df
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access

This commit replaces the direct mapping of WDTDCR registers with a syscon
regmap interface. The individual watchdog nodes now use the renesas,sysc
property instead of multiple reg entries.

> diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g077.dtsi
> index 674e35e4f2425..18d748661a609 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> @@ -327,61 +327,61 @@ channel1 {
> =20
>  		wdt0: watchdog@80082000 {
>  			compatible =3D "renesas,r9a09g077-wdt";
> -			reg =3D <0 0x80082000 0 0x400>,
> -			      <0 0x81295100 0 0x04>;
> +			reg =3D <0 0x80082000 0 0x400>;

[Severity: Critical]
Does removing this second reg entry break forward compatibility for older
kernels?

Older kernels that unconditionally expect to map index 1 for the
renesas,r9a09g077-wdt binding during probe will fail to initialize the
watchdog device when booted with this updated device tree. Calling
devm_platform_ioremap_resource(pdev, 1) will return -EINVAL and abort
the probe.

Since device tree files are treated as firmware ABIs, removing the reg entry
without providing a fallback or changing the compatible string constitutes =
an
ABI breakage. Could the second reg entry be retained alongside the new
renesas,sysc property to preserve compatibility?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001165201.7638=
82-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D6
