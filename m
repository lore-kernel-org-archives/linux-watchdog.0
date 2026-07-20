Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE53ACA4B;
	Mon, 20 Jul 2026 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784528900; cv=none; b=GUsQZ0suAA9JVwkcaMcTDFDyDdpb71Hlr8W5fSknYy34+eeqivZqR0hkN0ozszdC0Ot6jAqRHeFIoz6edHkuFSE3kADryUUkicAO0cpI5HQhnc5M4KA+RfREyRMj+vxPqCmOVYXzELg6qNuRtiKvZTXUqPmGBlCsOIRN4EskbOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784528900; c=relaxed/simple;
	bh=iNplZIAwmtZ5oRKqbuZSgYhaeSlRcCEPrUbQ15YlT4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdGHmpWzKhASHmZ8jdKg1cedKb1hJdcZ6ZfrCMZF8EnrOm8zSfPb8TEX7rSWYqyQkMYr+pSAsMTL5up3P/iLYKicaYmgb7VrktRltgX2piT+UDX+nFQcxcbMu2MVcac/4KMZyUhGKs+0reVRNiiMsfxo1ERgk9yG/pD8Uv7PAiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGjqX56g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGjqX56g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123151F000E9;
	Mon, 20 Jul 2026 06:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784528897;
	bh=sBtofq2dwkDOIwnJJ36YEL5yOid3HxsrtC6tPY9ePh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GGjqX56gFt9uwd2dt4cVR/k7XySW2WBd9udKR8W3xIL1ky6nSbWz0V8GHIpN91XgV
	 OzcGvlX9xOigMAQwBHsaF1A7WPpsfNZNko9bbpnKh2C1U/GYoxlHHGz+m99SRzrxGs
	 sfsJfTTWO+kfE/7sBhXzKZYW2zMQie10IDIZxHdFrI7Nk4JEpvcaITvoBhAwTFAnTA
	 IwyAnfiZ5UE5v2+LI/38FHatY5xBg/ftbOnBbzumCUpT7ubz1Q06F/akkxKJ4v5df2
	 Dd8cp9LaXPHiYHR3gf0GOEugQKadtuV7NAA/Z8rC3EHrIArJ+hJWguhOWXWp2ebioK
	 WDyQlHxwYCAVg==
Date: Mon, 20 Jul 2026 08:28:13 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/7] dt-bindings: reset: Add reset controller
 constants for mt8167
Message-ID: <20260720-authentic-gleeful-asp-20bebd@quoll>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-5-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717163959.714561-5-l.scorcia@gmail.com>

On Fri, Jul 17, 2026 at 06:39:15PM +0200, Luca Leonardo Scorcia wrote:
> Add the various bits that identify watchdog and mmsys resets. IDs for
> mmsys resets restart from zero as they are used in a different device.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../reset/mediatek,mt8167-resets.h            | 53 +++++++++++++++++++

I do not see any user of this ABI nor explanation why you are doing it.

>  1 file changed, 53 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt8167-resets.h
> 
> diff --git a/include/dt-bindings/reset/mediatek,mt8167-resets.h b/include/dt-bindings/reset/mediatek,mt8167-resets.h
> new file mode 100644
> index 000000000000..85d2d0e99c68
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt8167-resets.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8167
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT8167
> +
> +/* TOPRGU resets, these are actual bits in the register */
> +#define MT8167_TOPRGU_DDRPHY_FLASH_RST		0
> +#define MT8167_TOPRGU_AUD_PAD_RST		1
> +#define MT8167_TOPRGU_MM_RST			2
> +#define MT8167_TOPRGU_MFG_RST			3
> +#define MT8167_TOPRGU_MDSYS_RST			4
> +#define MT8167_TOPRGU_CONN_RST			5
> +#define MT8167_TOPRGU_PAD2CAM_DIG_MIPI_RX_RST	6
> +#define MT8167_TOPRGU_DIG_MIPI_TX_RST		7
> +#define MT8167_TOPRGU_SPI_PAD_MACRO_RST		8
> +/* bit 9 is reserved, unused according to data sheet */

NAK, how driver can reserve something? Fix your driver.

This is ABI for Linux driver.

Best regards,
Krzysztof

