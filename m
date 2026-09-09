Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC0B3AD522;
	Wed,  9 Sep 2026 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946932; cv=none; b=p6yZEknz/BoWlwi6MU9U6agqt3bliTEYQJ9Ybef990HyHnJ5b6RHhcQfCCAMZruYaHoZ9J+I8nFcAVDfhwwe8MYf9bcQmKh40SismAV2XTDuINTb+PAkNBEukBXoBix9Pxnjn1fUxZFSzNXgv1i4H524kpu4LxHdtzmC1f10j4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946932; c=relaxed/simple;
	bh=RlquV2qEWjV+inAs1mB0hDuB0wfVFPu3WzBSbEbDSP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cn/fiR6S5edhuK5dxnzI2GG9HGxKx6PXPgzKjNVeBVCO79KL0yNv0GMFO/UCsr8nHpNYnvBSc7ANy7Fmrr0TDZqb8VXEK2/NbAgOfKDVy5MCB8CKGNI9C1DZDJ8eruC+4m9a2yaU0/Kfl/FAI4cXENF6vdCkLz5q88vsIlTNPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jnOJ3Xo9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jnOJ3Xo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788946927;
	bh=RlquV2qEWjV+inAs1mB0hDuB0wfVFPu3WzBSbEbDSP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jnOJ3Xo9TUxGgqRwcdLIyZ6ln+F4/SN/xIoK8efS/zB+lcAcCqY7BxfY1ew6r7Vrr
	 ytlTtrzrTIE8NHHm3tAX5uIgvBthOQH548iAjYlDTY91jX3yZUGy7a5v7a8zDOHWNF
	 l2TUceV4RBarZ8UXG0Vo5TGYK/eMqMjddCkJCnL1Dw1YSsNuNdjC8W4we2647Zm0+E
	 N7TeOVKYM6y1uh28q5D+K7tdzapc84R/cDJEJoPMgFQAYFiixA+/0yHl5kp4FlXj7D
	 heJQ+K7sQYxq0+1Hdksa5YduKxqEMnA5JfIDi3cH5+m/2WqCmcBRVxwiPV3J16JfO2
	 AX43Jork0HVYQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8998C17E0260;
	Wed, 09 Sep 2026 11:42:06 +0200 (CEST)
Message-ID: <f57e326d-50f1-4ca3-a61d-d7de4723f7cf@collabora.com>
Date: Wed, 9 Sep 2026 11:42:06 +0200
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] Add support for mt8167 toprgu and mmsys resets
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260908174259.9009-1-l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260908174259.9009-1-l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 19:38, Luca Leonardo Scorcia wrote:
> Currently mt8167 inherits its watchdog from the included mt8516 dtsi,
> which in turn falls back on mt6589-wdt, which does not support toprgu
> resets yet. In the first two patches we add support for the 12 mt6589
> toprgu resets.
> 
> However, according to its data sheet, mt8167 has 14 sw resets instead of
> 12, and its reset bits are non-contiguous. This is currently unsupported
> by the mtk-wdt driver and it caused confusion between reset IDs and reset
> bits in other mtk SoCs device tree includes.
> 
> Therefore we introduce a dedicated mediatek,mt8167-wdt compatible for the
> watchdog driver that describes correctly this SoC's resets. Since its
> reset bits are non-contiguous, we add support for a watchdog reset table
> to accommodate the distinction between device tree reset IDs and the
> actual bits in the registers. Code is inspired by the reset table
> currently implemented in the mmsys driver. There should be no effect
> on existing sequential wdt resets.
> 
> In the last three patches we describe the mmsys reset table for the SoC.
> According to the datasheet there are 28 mmsys reset bits divided across
> two adjacent registers.
> 
> The series has been tested on a Sony PlayStation Classic Mini, on a Xiaomi
> Mi Smart Clock and on a Lenovo Smart Clock 2.
> 

Whole series is

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


> Changes in v5:
> - Dropped the binding header for mt6589 reset IDs;
> - Moved the definition of the number of resets for mt6589 inside
>    mtk-wdt driver;
> - Separated the mmsys related changes to the last three commits.
> 
> Changes in v4 [4]:
> - Squashed the reset IDs includes together with the bindings change;
> - Added support for a reset table to the mtk-wdt driver. This allows us
>    to decouple reset IDs from device trees from reset bits and lets us
>    describe correctly the non-contiguous reset bits of mt8167;
> - Improved explanations in commit messages.
> 
> Changes in v3 [3]:
> - Improved explanations in the commit messages;
> - Added the #reset-cells property to mt6589 watchdog node;
> - Included the mediatek,mt6589-resets.h file in mt6589.dtsi;
> - Included the mediatek,mt8167-resets.h file in mt8167.dtsi;
> - Moved the mmsys reset table from the mt8167-mmsys.h header file to
>    the mmsys driver implementation.
> 
> Changes in v2 [2]:
> - Sashiko pointed out correctly a missing entry in the mmsys reset table
>    in the last patch.
> 
> Initial version: [1]
> 
> [1] https://lore.kernel.org/linux-mediatek/20260717151134.678839-1-l.scorcia@gmail.com/
> [2] https://lore.kernel.org/linux-mediatek/20260717163959.714561-1-l.scorcia@gmail.com/
> [3] https://lore.kernel.org/linux-mediatek/20260809160643.33991-1-l.scorcia@gmail.com/
> [4] https://lore.kernel.org/linux-mediatek/20260819101853.44681-1-l.scorcia@gmail.com/
> 
> Luca Leonardo Scorcia (8):
>    watchdog: mediatek: Add wdt/toprgu resets for mt6589
>    arm: dts: mediatek: mt6589: Enable toprgu reset controller
>    dt-bindings: watchdog: Add compatible for MediaTek mt8167
>    watchdog: mediatek: Add support for mt8167 toprgu/watchdog
>    arm64: dts: mt8167: Properly describe the SoC watchdog resets
>    dt-bindings: reset: Add mmsys reset ids for mt8167
>    soc: mediatek: mtk-mmsys: Add resets for mt8167
>    arm64: dts: mt8167: Add support for mmsys resets
> 
>   .../bindings/watchdog/mediatek,mtk-wdt.yaml   |  1 +
>   arch/arm/boot/dts/mediatek/mt6589.dtsi        |  1 +
>   arch/arm64/boot/dts/mediatek/mt8167.dtsi      |  9 ++++
>   drivers/soc/mediatek/mt8167-mmsys.h           |  3 ++
>   drivers/soc/mediatek/mtk-mmsys.c              | 38 +++++++++++++
>   drivers/watchdog/mtk_wdt.c                    | 54 +++++++++++++++++--
>   .../dt-bindings/reset/mediatek,mt8167-mmsys.h | 35 ++++++++++++
>   .../dt-bindings/reset/mediatek,mt8167-wdt.h   | 21 ++++++++
>   8 files changed, 157 insertions(+), 5 deletions(-)
>   create mode 100644 include/dt-bindings/reset/mediatek,mt8167-mmsys.h
>   create mode 100644 include/dt-bindings/reset/mediatek,mt8167-wdt.h
> 
