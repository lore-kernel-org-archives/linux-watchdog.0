Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83A38E8CE;
	Mon, 20 Jul 2026 06:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784529039; cv=none; b=EO54WXgp0qLLKOk+9G1c93jYu+sNPb26E0M9BOXwW7n62pB0D1jbVDIIKos3c5tN8GipbVi9T/3kNMFyQvKN53cEpOTZgpZMVFR12NVLu8183PHtJcMjQmuaUfdDQuOfo8+1wkmRR2lcou0c30Zt4Sx0Vt8ocjD3YyRE0Adywjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784529039; c=relaxed/simple;
	bh=NyTqXF3RpAZPeTVsmdmzeY/QgV4y3u9oc3K7fapXlBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfllmwlM27m3gOIrAnAzEbDwFo7Q9Eor7uzeJhLB1Jhwbhd1H77vX2zd/Uh0M6exwRNOJgp/F+FVw1Y31h+eRuP9dW3CsejeT/TsuRRFs7R+sIIvYJjxiTLS8N1+MjfS6CUb7Rs8oOByMvBD8pRg+vOH7tOZkkAbLGW3y7L5lRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AN/hPycR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AN/hPycR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDDE1F00A3F;
	Mon, 20 Jul 2026 06:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784529035;
	bh=OXitATJsY8BgpfJq75nn2osjYyBgvb24SDjAaK1q/mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AN/hPycRKmYYZ4fB3Ovk1WuhT+00HOSwbACoLd+io1ObBH6pzFJoyA6LF4Lx/shZS
	 oHFIqdIUgqKdQuRYEoBgGskZrt/Xr2XUr510kF4fOnFKmCWU7vsJrg6nbMcpRINhCH
	 CA8YmePU5HVhv4n9W8WAh/mTIEmyUKrldsxjl8Q706pQf2WteX7OXLV/yvxq+69NNA
	 DNKISipFLm5IU2CzC+4yueIdxX5VQ8i+SyHxXqjojdLKDVp8wtKNX5VXkxUtZ1mvPW
	 ceQG+paOL1RuRlEhIQHrfZv+/hwBLvMS+z8Pq2wERYmSt3X0H7UwWON7w0eZAdV5Pw
	 5GCi2EjX7gosA==
Date: Mon, 20 Jul 2026 08:30:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org, 
	Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/7] soc: mediatek: mtk-mmsys: Add resets for mt8167
Message-ID: <20260720-elegant-flawless-vole-aa3c1f@quoll>
References: <20260717163959.714561-1-l.scorcia@gmail.com>
 <20260717163959.714561-8-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260717163959.714561-8-l.scorcia@gmail.com>

On Fri, Jul 17, 2026 at 06:39:18PM +0200, Luca Leonardo Scorcia wrote:
> The mt8167 SoC has 64 MMSYS resets, split in two contiguous 32-bits
> registers, MMSYS_SW0_RST_B (0x140) and MMSYS_SW1_RST_B (0x144), as
> also stated in the downstream kernel for the Lenovo Smart Clock
> in the ddp_reg.h header.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>  drivers/soc/mediatek/mt8167-mmsys.h | 41 +++++++++++++++++++++++++++++
>  drivers/soc/mediatek/mtk-mmsys.c    |  3 +++
>  2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/mt8167-mmsys.h
> index eef14083c47b..dc3e882a9893 100644
> --- a/drivers/soc/mediatek/mt8167-mmsys.h
> +++ b/drivers/soc/mediatek/mt8167-mmsys.h
> @@ -3,6 +3,47 @@
>  #ifndef __SOC_MEDIATEK_MT8167_MMSYS_H
>  #define __SOC_MEDIATEK_MT8167_MMSYS_H
>  
> +#include <linux/soc/mediatek/mtk-mmsys.h>
> +#include <dt-bindings/reset/mediatek,mt8167-resets.h>
> +
> +#define MT8167_MMSYS_SW0_RST_B				0x140
> +#define MT8167_MMSYS_SW1_RST_B				0x144
> +
> +/* MMSYS resets */
> +static const u8 mmsys_mt8167_rst_tb[] = {

No, data structures NEVER go to the headers because it leads easily to
duplicated data.

Best regards,
Krzysztof

