Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733491A6827;
	Wed, 13 May 2026 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778640939; cv=none; b=oaR60s/R1q8z6iNXreOuureep0qnx/3UV54HeSk4GqiQJK7ymC3gfq2CQBaNzbgrMc8dVW2UTSzmKKRpyUUPjmJuu9pYrI4ccRMZabtYr2nA9diwS9k7rMQ5STwQZF0ytHsZqKYBgW1u+AZjsqmtBbMtGY09MsYp10Ze2jfDQcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778640939; c=relaxed/simple;
	bh=KY5EBXwZQG5saMPKhdqgNw/ld46j/zdvuqz7wPdRRAY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KJL++7HEMfIoMuw93/C2BDkJqnwPdk4rbm8KDox5tRZbI29bXuWiUXIpkv8mSir0AqBZt61zfw5nm5i0Tg5XjNlS+js4tVOeURaNC2nKPDsESBfLGfU/4AL8BpSJ61hHd6QlArEkHQshQMBVKSTYtPYncXlNEYa2mkd4g8P5nI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe8SRaGF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe8SRaGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB93C2BCB0;
	Wed, 13 May 2026 02:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778640939;
	bh=KY5EBXwZQG5saMPKhdqgNw/ld46j/zdvuqz7wPdRRAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Pe8SRaGFkkY3bTqZg0/aGWBG6m/SxIT2xm8EezxGWnpj3xB3YgjAR7fU8q2VM+HsR
	 qT9idlO6QhMsLlL9o0ejjchkB/zivk/FP/0C/Oxj3bh/IPjUvcVwg7LInCXsRkqwcY
	 A24aHixXvhTIab09MvY8sagcBITkFgsSev26grrc7We+hE6gd/XUdAzp2TREu6Fx8n
	 ssPMlPiMgZboL0hyWysyPQF+s90QOvmGgd0A+yhE1ZqCNcKsFAH2HvIIJc/wW07HqE
	 Qvlosib4h9z3ZisBOiMrAGgBjf8d1vItM8dARSTD5x/dYi9hLVwPfAXM1W/x1w2x27
	 s2yIF6VrAIshA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 8/9] arm64: dts: renesas: r9a09g077: Use SYS syscon
 for WDTDCR access
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-watchdog@vger.kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260511185058.1926869-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 02:55:38 +0000
Message-Id: <20260513025538.CDB93C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Removing the second `reg` entry breaks backward compatibility wi=
th older kernels.
--

commit 4d641e4436b59e57d0434635cc0bb0ee418c05e5
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

arm64: dts: renesas: r9a09g077: Use SYS syscon for WDTDCR access

This commit updates the r9a09g077 device tree to use the SYS syscon for
WDTDCR access. It removes the second reg entry from the watchdog nodes and
adds a new renesas,sys phandle property.

> diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot=
/dts/renesas/r9a09g077.dtsi
> index 59e5de7438261..b076bea9cb709 100644
> --- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
> @@ -327,61 +327,61 @@ channel1 {
> =20
>  		wdt0: watchdog@80082000 {
>  			compatible =3D "renesas,r9a09g077-wdt";
> -			reg =3D <0 0x80082000 0 0x400>,
> -			      <0 0x81295100 0 0x04>;
> +			reg =3D <0 0x80082000 0 0x400>;

Does removing the second reg entry cause a backward compatibility regression
with older kernels?

Device tree is considered a stable ABI, and older kernels lacking the
new syscon driver support might attempt to parse the second reg entry for
the WDTDCR register region.

Because the second entry is removed, devm_platform_ioremap_resource(pdev, 1)
would return an error, causing the watchdog driver to fail to probe.

Could the second reg entry be retained, or a new compatible string
introduced, to preserve DT ABI stability?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511185058.1926=
869-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D8
