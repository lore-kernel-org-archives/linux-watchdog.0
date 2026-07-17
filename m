Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB963B19AF;
	Fri, 17 Jul 2026 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279897; cv=none; b=sWQM+OJcu+/GaxnucGtyb+FpXagqo93yNBISovLsAAc8CeSbsQOlk+n2t1LLd0QDD/NyBXetl0xm7RZPwxXELKY1joNleqvVEPhA4/8hoULMWIWb8FXUyInmP0KvO/5OYpKNLZGbDLkIj/TzrOKEmw7gS9QfNQcncpylleH2xz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279897; c=relaxed/simple;
	bh=6SWx8qQGsQZgVBljHKSvItwVJKc1vh7TrxTrg0P1deE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHzcCWdQoET5LpCIgC3Und4EcCxF69z/xfAoi70dBcBlIOJB16Rvmq/QxEiT9ytRjNNrjqRdra6wSVndzyUIksL/QwPQtvx0Ls+6odVS1epJ8XDhj0gkoZirhATuUu5gXYTTgJ/0TJa4dy30uCom0heUOQT4+wkiXN47hlBdycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOKFWh+p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOKFWh+p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BC11F000E9;
	Fri, 17 Jul 2026 09:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784279896;
	bh=1UT95bLXGY5IEzB0fijX3mfVzEGvJ1LcjJS5f8nS+1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GOKFWh+pfFbTfNTJR4GU/Twcbplcra7BM0uZsF1hLDaY5hFOTheKAhi24IHPeWNw0
	 xAhEo1uL47D1idT9QYYG6fxLWaQKFHIRdCF7lML/D9RTF+SdNGJzSUME0pCxZFEfAr
	 OKgmkexnRF0aa0tw/Ez6YksJ4fAZXeF5PupjPdB3um/cY3uQf5JzeTe54WNlQ89JlM
	 eVa0jT0lfg+WRmFOQ6sSB8hpERpoKGRZswKv21hqTor1xhKfS1IqU/BgySTBiTNYBu
	 c7XK3H7pyov/rVrAUxTjgIb7RM4m7AXXAcUntnauH6X0mJ0RhA0v5eYjM3f5UfvBGp
	 H6E1sW3gZ9enQ==
Date: Fri, 17 Jul 2026 11:18:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Akari Tsuyukusa <akkun11.open@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	"open list:WATCHDOG DEVICE DRIVERS" <linux-watchdog@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, 
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, Roman Vivchar <rva333@protonmail.com>
Subject: Re: [PATCH 5/7] dt-bindings: reset: Add bindings for MediaTek MT6589
 reset controller
Message-ID: <20260717-rattlesnake-of-enjoyable-dignity-42da64@quoll>
References: <20260716161923.266315-1-akkun11.open@gmail.com>
 <20260716161923.266315-6-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260716161923.266315-6-akkun11.open@gmail.com>

On Fri, Jul 17, 2026 at 01:19:21AM +0900, Akari Tsuyukusa wrote:
> Add MT6589 reset controller bindings.
> 
> Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
> ---
>  include/dt-bindings/reset/mt6589-resets.h | 25 +++++++++++++++++++++++

Filename must match compatible.

Why is this separate from the patch adding the binding? Where is this
explained?

>  1 file changed, 25 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt6589-resets.h
> 
> diff --git a/include/dt-bindings/reset/mt6589-resets.h b/include/dt-bindings/reset/mt6589-resets.h
> new file mode 100644
> index 000000000000..18ef729022a9
> --- /dev/null
> +++ b/include/dt-bindings/reset/mt6589-resets.h
> @@ -0,0 +1,25 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2026 Akari Tsuyukusa <akkun11.open@gmail.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_MT6589_RESETS_H
> +#define _DT_BINDINGS_RESET_MT6589_RESETS_H
> +
> +/* TOPRGU */
> +#define MT6589_TOPRGU_INFRA_RST		0
> +#define MT6589_TOPRGU_DISP_RST		1
> +#define MT6589_TOPRGU_MFG_RST		2
> +#define MT6589_TOPRGU_VENC_RST		3
> +#define MT6589_TOPRGU_VDEC_RST		4
> +#define MT6589_TOPRGU_IMG_RST		5
> +#define MT6589_TOPRGU_DDRPHY_RST	6
> +#define MT6589_TOPRGU_MD_RST		7
> +#define MT6589_TOPRGU_INFRA_AO_RST	8
> +#define MT6589_TOPRGU_MD_LITE_RST	9
> +#define MT6589_TOPRGU_APMIXED_RST	10
> +#define MT6589_TOPRGU_PWRAP_SPICTL_RST	11
> +
> +#define MT6589_TOPRGU_RST_NUM		12

Not a binding, drop.

Best regards,
Krzysztof

