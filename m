Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20611414A30;
	Tue, 11 Aug 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438560; cv=none; b=OboZTRb4WIZD0pcro5VIsOJfLVOjP2OQcPjFCwSoSX3cVYyrVpMa4dJdeXsPSGa7hP/6s/ab1jPpYhTJ5V/kS7BOSoq1K8YLGoBUZHA6Z60+e2e5xr3sWiA9qyPDFnGJZ4CWT2ReTBY8TBC9XQdFGU8BfLvwToq41VIOGNSrbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438560; c=relaxed/simple;
	bh=4GRvX524cZvnTWy/v8eWkJ60u8wYo8ZMzOxJ3CJC41c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEDlNZ2d9XLivA1e/u3BY0yFN+x0E3lSKDzTIV3uBvSikpWnglh56bBlloDC61z9E1cp1gkLgGDSIX4J2pA3jnlia9uKDZLAT0g4uMHrZjSW+UJ+d2QCUkDBHdc6jX4/3nyg546GJGsPanxdRwpEnPftoxuSFGQxdIedWWb+Gxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BInhLC3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BInhLC3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392D81F000E9;
	Tue, 11 Aug 2026 08:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786438558;
	bh=aOPB5s1AVVEESZAsbtL0NPJBawQgvnyA8F7vvZJJ3SY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BInhLC3A9EzYUaIcBOGFb/4Zc7qX4oBcukJnnBBuerT8zvQHOdCgMRb5oIMruRkEr
	 5uesCaUdNbkWekEA1yxrUoorWZ+Yx4GF6BtF0Xg74JxfGJ7u0s6hE8nk5ER3B4S9fE
	 140EPNujt84y8LwVfVWrhURIXrWohLWGhP2IEu2kXNEmyLT6CnnBisL0VvTX7zlyK7
	 gWB6JBabTcFRLIGb/5h+s2X28XhXs90IC/PSxg2vUDq1N18YcIZIrYI046itSObl7s
	 Olr1JoR345kNMqwnQg2ZwGHzKXOTd1YBkbd/3bP9PaUOJFH+5LAYiqEheiVypyUh33
	 TkVsNIDz8TPlQ==
Date: Tue, 11 Aug 2026 10:55:54 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 5/8] dt-bindings: reset: Add reset controller
 constants for mt8167
Message-ID: <20260811-roaring-bat-of-blizzard-63ffee@quoll>
References: <20260809160643.33991-1-l.scorcia@gmail.com>
 <20260809160643.33991-6-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809160643.33991-6-l.scorcia@gmail.com>

On Sun, Aug 09, 2026 at 06:03:29PM +0200, Luca Leonardo Scorcia wrote:
> Add the various bits that identify watchdog and mmsys resets. IDs for
> mmsys resets restart from zero as they are used in a different device.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  .../reset/mediatek,mt8167-resets.h            | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mediatek,mt8167-resets.h
> 
> diff --git a/include/dt-bindings/reset/mediatek,mt8167-resets.h b/include/dt-bindings/reset/mediatek,mt8167-resets.h
> new file mode 100644
> index 000000000000..af8a3e499f8b
> --- /dev/null
> +++ b/include/dt-bindings/reset/mediatek,mt8167-resets.h
> @@ -0,0 +1,53 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8167
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT8167
> +
> +/* TOPRGU resets, these are actual bits in the register */

Not a binding, drop these.

> +#define MT8167_TOPRGU_DDRPHY_FLASH_RST		0
> +#define MT8167_TOPRGU_AUD_PAD_RST		1
> +#define MT8167_TOPRGU_MM_RST			2
> +#define MT8167_TOPRGU_MFG_RST			3
> +#define MT8167_TOPRGU_MDSYS_RST			4
> +#define MT8167_TOPRGU_CONN_RST			5
> +#define MT8167_TOPRGU_PAD2CAM_DIG_MIPI_RX_RST	6
> +#define MT8167_TOPRGU_DIG_MIPI_TX_RST		7
> +#define MT8167_TOPRGU_SPI_PAD_MACRO_RST		8
> +/* The data sheet describes bit 9 as "reserved, unused" */

ID cannot be unused. If it is unused, then just use next one here, so MT8167_TOPRGU_APMIXED_RST=9.

Best regards,
Krzysztof

