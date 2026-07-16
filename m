Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C093B2D18;
	Thu, 16 Jul 2026 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784219788; cv=none; b=Boa+bjbbnv7bdfxVr225ZBagk8MpltYGVJO/o2zn27kpm2ElvvhmRpojc2YcJebVQboJpF6oib2IE/nRxB0gfWl6gyFlbimRwl8iMgmAFI2uBmVt+bxw5berOiAJUQR5Akm7wloBQ9fK4TkRAtPsyBOCzwzYdiVoGR6j+/OnBbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784219788; c=relaxed/simple;
	bh=yaGoNR5kPstQGxwyYxjXk2G9D3lyMYEguXrCKlmZkWQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bossi0ZCaT2PcL5oiKhkAw213K92GElTPp1yAVBmGuywv/CKhUdAyBBlQk0wWLmAbCsXkJVg1GhI+F4QkgCXnsZ/erAWencOQL2e6sAJZ4St+GZKLYTlHcn+uYf0dF6g3F790wYv/pzDAnirbDsFaudiUe/aXP4usmrOrr5sol0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRlKXti8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRlKXti8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3E41F000E9;
	Thu, 16 Jul 2026 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784219777;
	bh=QHs/8acbISpYksOlAfBWfTDUAQlEelfrnI0ofkB1d64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kRlKXti8yJPG9ESmC6Fu1CzscCWRqoHcJMk8VRcJyyVzsJIX5yimy3CyIqSQdCpVO
	 qImEAUh8xh/uJLk1eWms8xuSPkbivTka+njxUmhk+aZRJFwLbeVYIbIHleUWABrTjF
	 2YmIq7gJqmy08SYMhvAhLJLx38zuYZNT2feK1ilumOUxUQy2iKuLAf+pEeU1hGoJwT
	 kmM0QZXduw5M5L4q26miqnUuF8URF8gEcdTaB5AEoaA803XY0n80pPUzYw4tURBt7x
	 PTiFqTU9fI6hC8UMU1LD25H+Rnms+po97TVfAiBUCIdpS3XEk/NErWoCCstmt8O0lI
	 /VmZt0HQteG2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/7] arm/arm64: dts: mediatek: drop mt6589 fallback from
 watchdog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Akari Tsuyukusa" <akkun11.open@gmail.com>
Cc: linux-watchdog@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260716161923.266315-4-akkun11.open@gmail.com>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-4-akkun11.open@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 16:36:16 +0000
Message-Id: <20260716163616.BA3E41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Removing the fallback compatible string 'mediatek,mt6589-wdt' =
from device trees breaks forward compatibility (ABI breakage) with older ke=
rnels.

Device trees are treated as a stable ABI in Linux, meaning a newly compiled=
 Device Tree Blob (DTB) must be able to boot successfully on older kernels.=
 Older LTS/stable kernels rely entirely on the generic 'mediatek,mt6589-wdt=
' fallback string to probe the watchdog driver for these Mediatek SoCs (e.g=
., mt2701, mt6572, mt8173), because older driver versions do not include th=
e SoC-specific strings in their `of_match_table`.

By removing the fallback string from the `.dtsi` files, a new DTB will fail=
 to bind the watchdog driver on any older kernel. Because this watchdog dri=
ver also registers the system's reset controller (`toprgu_register_reset_co=
ntroller()`), its failure to probe will cascade, breaking other devices tha=
t depend on those resets.

Although the previous patch in this series added the specific compatibles t=
o the new kernel's driver, standard Device Tree practice dictates that vali=
d fallback strings must not be removed once they have been established, pre=
cisely to preserve compatibility with older kernels.
--

--- Patch [3]: [PATCH 3/7] arm/arm64: dts: mediatek: drop mt6589 fallback f=
rom watchdog ---
commit 32f0d12ddf1053eabd5133b535f4e55a874b71e9
Author: Akari Tsuyukusa <akkun11.open@gmail.com>

arm/arm64: dts: mediatek: drop mt6589 fallback from watchdog

This commit removes the "mediatek,mt6589-wdt" fallback string from several
Mediatek device trees, leaving only the SoC-specific compatibles.

> diff --git a/arch/arm/boot/dts/mediatek/mt2701.dtsi b/arch/arm/boot/dts/m=
ediatek/mt2701.dtsi
> index 128b87229f3d5..f23a6d860a53b 100644
> --- a/arch/arm/boot/dts/mediatek/mt2701.dtsi
> +++ b/arch/arm/boot/dts/mediatek/mt2701.dtsi
> @@ -160,8 +160,7 @@ scpsys: power-controller@10006000 {
>  	};
> =20
>  	watchdog: watchdog@10007000 {
> -		compatible =3D "mediatek,mt2701-wdt",
> -			     "mediatek,mt6589-wdt";
> +		compatible =3D "mediatek,mt2701-wdt";

[Severity: Critical]
Does removing the fallback string break ABI forward compatibility with older
kernels?

Device trees are typically treated as a stable ABI, meaning a newly compiled
DTB needs to boot successfully on older kernels. Older LTS or stable kernels
might rely entirely on the generic "mediatek,mt6589-wdt" fallback string to
probe the watchdog driver for these Mediatek SoCs, because older driver
versions do not include the SoC-specific strings in their of_match_table.

By removing the fallback string here and in the other included dtsi files,
will a new DTB fail to bind the watchdog driver on an older kernel? Because
this watchdog driver also registers the system's reset controller, this
failure could cascade and break other devices that depend on those resets.

>  		reg =3D <0 0x10007000 0 0x100>;
>  	};
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716161923.2663=
15-1-akkun11.open@gmail.com?part=3D3
