Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29E2DCF45;
	Wed, 17 Jun 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781663407; cv=none; b=mBsMABO2l+DSpJw07jwYpZM2/Jwg/FGWzWjdBvtepeI76LzDF6zbfHMSTHPsWqdkz0Y3Fn/o+vVI2RNga1dXBXI/XNRVDVF3dSUW+7Vb/6bkk9k0xgWz1aDR4O6CHUAvSewonTxsYIppGThQnKT3/6KN1CrCt4xZ5I3524HHGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781663407; c=relaxed/simple;
	bh=GI+Q1G3oSoarLrOKE4bFbAyALBZMLwWPZjg5zK8Trc8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f2m3CHr9qnkLH1VHy+o80dxcU95V/6RbqEI0MtGl/4Wm8n7O4FHidz5zKhZmLn9MSFW5FnKA9KzU04sL5X7xBXXKmfwbKXV4pkI6qgSoi3ifVY/UbL9QmmmK7Emrr9y+LUgYs7aXu4kbIS+7OnxEKTUTVBJtV9bdWJvIdIJt7ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AauKwA7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AauKwA7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5692C1F000E9;
	Wed, 17 Jun 2026 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781663405;
	bh=ZTSJ9iepdr64svjsCaE5LolI7ATuKISE2YZner16UK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AauKwA7cOlttIpcHtf51aEs4uJSb5e2WtlFjFTEAui5CBkkB+Mksz3WdxUsiEOw3+
	 LIG4dUpr3Ze46FxeSkcHeFebqURYQ5M5tJh3y2zwwjfdIKeberKvSgxRAsZK/fmy6o
	 Qt0d+7dMfpGbtCi1sRe663ZaCYqStCH/XCLpk179kjDVYYXd7/1xWCvWThUoZFA9Su
	 A1LczKeYn0Ei5ezWegmkaSlv/cXqyzjjC5ecUYJLJ44yFM81qNcTF9fr8BgdGz9SCM
	 e7tKEAO+qDZVha3Y8HDefPVi3MqFhcy9RxBGWrKdueciftGXWDFxDaxBgYOrwrcUqc
	 srWLtQEpgRwCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] ARM: dts: mediatek: mt8127: Add watchdog support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zakariya Hadrami via B4 Relay" <devnull+zkh1.proton.me@kernel.org>
Cc: robh@kernel.org, linux-watchdog@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v1-2-d02ad15ac359@proton.me>
References: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
 <20260617-mt8127-amazon-ford-basic-v1-2-d02ad15ac359@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 02:30:04 +0000
Message-Id: <20260617023005.5692C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Device tree nodes are not sorted by unit address.
--

commit 7452ca22e20f1d82f0774e2f81b86b3196a78313
Author: Zakariya Hadrami <zkh1@proton.me>
ARM: dts: mediatek: mt8127: Add watchdog support

This commit adds the watchdog node to the mt8127 device tree. It is
disabled by default since it was not present initially.

> diff --git a/arch/arm/boot/dts/mediatek/mt8127.dtsi b/arch/arm/boot/dts/m=
ediatek/mt8127.dtsi
> index bd61ec7e70c0c..1855dda42710f 100644
> --- a/arch/arm/boot/dts/mediatek/mt8127.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt8127.dtsi
> @@ -159,5 +159,12 @@ uart3: serial@11005000 {
>  			clocks =3D <&uart_clk>;
>  			status =3D "disabled";
>  		};
> +
> +		watchdog: watchdog@10007000 {

[Severity: Low]
Should this node be sorted by its unit address?=20

It looks like watchdog@10007000 is being placed after serial@11005000 at the
end of the soc node. Device tree styling conventions usually require sibling
nodes to be sorted in ascending order of their unit address, which would
place this earlier in the file (likely before timer@10008000).

> +			compatible =3D "mediatek,mt8127-wdt","mediatek,mt6589-wdt";
> +			reg =3D <0 0x10007000 0 0x100>;
> +			interrupts =3D <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
> +			status =3D "disabled";
> +		};
>  	};
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-mt8127-ama=
zon-ford-basic-v1-0-d02ad15ac359@proton.me?part=3D2
