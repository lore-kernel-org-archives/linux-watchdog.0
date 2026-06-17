Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFB93803CC;
	Wed, 17 Jun 2026 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693751; cv=none; b=F1YVQKMXj43Co4thZhwC8soEAR6t8CFeP2X1S8wnW3UCyu6l1dMfis7lC7zGov+tOBAy057KVNOvCpOhA3loo8PZqtpwz8WgP8tu+lA8LXkPxXuCbCmwkPAAM/MR56CvwL/Am1MlK+3XI40dnF4dImGRyWfoImlqtz4vqEAA2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693751; c=relaxed/simple;
	bh=s8/9NbIAn+PDYjuEUhzQukO8hHAyZwvwv9o1lJ6TcLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9iVtx1P5Pc83nqFY5ZBa7I+s1fhD9hQ8pt8sZCooGmzIW5vMOH6VOyzzhkTrIPDvXEau48tBkC+9rQWe6OphNDH/0fy5gJpLkisgqKoZ8KRl3qG13JjkuwsHmInduYhEoPyh/Z0isfDB11W7gnfQzCcjLiHpuT5sghjpjj8tKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeYLfkHI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeYLfkHI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2FE1F000E9;
	Wed, 17 Jun 2026 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781693750;
	bh=Jd1Dq3uJKlFCrDae889n8fcid3u1wezxaIUUcFz2JSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aeYLfkHIPDWI4FZo6IxYeiVudZZXIFmd/L3ka6Iw1XGscOakItLDpUR9d4WquAELH
	 yXIokVSA9E8gwS4vak7agTzgTv1CTRFyfhW3r6c7qjgBBxvkUjVElU+46gb2rsSKuF
	 63Wsm856Bj+fvM6veBMG893etX9OyMM19QgYGwKV/LCPDn8Wji33PuR5FwiMD8eVMQ
	 CbH7NJ6aaV3D7v45rWk4QCsR3uKaWcVkQ18XKiaWJuhKD0VfjD2glz7AGORsqf1Wkz
	 5mxiYrDup5sjuD622kwu6xnt9IGPxhwDIkuinNJ4kKpwwI9vTx72w0pSaF/dlV5bR3
	 qQKHMVVveMBpw==
Date: Wed, 17 Jun 2026 12:55:46 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zakariya Hadrami <zkh1@proton.me>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sean Wang <sean.wang@mediatek.com>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 3/5] ARM: dts: mediatek: Add basic support for Amazon
 ford board
Message-ID: <20260617-fat-lively-rottweiler-ef0cf1@quoll>
References: <20260617-mt8127-amazon-ford-basic-v1-0-d02ad15ac359@proton.me>
 <20260617-mt8127-amazon-ford-basic-v1-3-d02ad15ac359@proton.me>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260617-mt8127-amazon-ford-basic-v1-3-d02ad15ac359@proton.me>

On Wed, Jun 17, 2026 at 11:20:12AM +0900, Zakariya Hadrami wrote:
> This tablet uses a MediaTek MT8127 system-on-chip with 1GB of RAM.
> It can currently boot into initramfs with a working UART and
> Simple Framebuffer using already initialized panel by the bootloader.
> 
> Signed-off-by: Zakariya Hadrami <zkh1@proton.me>
> ---
>  arch/arm/boot/dts/mediatek/Makefile               |  1 +
>  arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts | 46 +++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mediatek/Makefile b/arch/arm/boot/dts/mediatek/Makefile
> index 37c4cded0eae..a610bc75c7d9 100644
> --- a/arch/arm/boot/dts/mediatek/Makefile
> +++ b/arch/arm/boot/dts/mediatek/Makefile
> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  	mt7623n-rfb-emmc.dtb \
>  	mt7623n-bananapi-bpi-r2.dtb \
>  	mt7629-rfb.dtb \
> +	mt8127-amazon-ford.dtb \
>  	mt8127-moose.dtb \
>  	mt8135-evbp1.dtb
> diff --git a/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> new file mode 100644
> index 000000000000..21bdab0e43f8
> --- /dev/null
> +++ b/arch/arm/boot/dts/mediatek/mt8127-amazon-ford.dts
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +#include "mt8127.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8127 Amazon Ford";
> +	compatible = "amazon,ford", "mediatek,mt8127";

Please organize the patch documenting the compatible (DT bindings)
before the patch using that compatible.
See also: https://elixir.bootlin.com/linux/v6.14-rc6/source/Documentation/devicetree/bindings/submitting-patches.rst#L46

Best regards,
Krzysztof

