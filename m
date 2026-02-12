Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D152DEA87;
	Thu, 12 Feb 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889967; cv=none; b=WE/a4qDGG0F1/KU3wuBQWoL/tbfcBKxHb7rkHQQV7FDIZiXPf/hqTOrdfXy6DQVBNA7uby2+am7EPngsBkL2BIuWu5SKoxtLQUovme3P/2ykNuCrT0dHZel/DXCKiKTAZpydakIO7/002vvMbElbTfvV+btxBu7HJIgE0Qu7Ajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889967; c=relaxed/simple;
	bh=XdhwoC7iS38ULTyh2EON1SSrsr8JoG9YgWk25wcUu1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mi1h6JQ+8auwNaKx+R0jqQhbg6ppJuY4HVopFAYhet8OzNzZ64cNxrce36i8tcHGeqkvhFDIX+L7lCHrHsNiaNuXgbkLpiN+dfOZhfvNUlyK0gmXKLnxqGGwV14LOklr0rOUSyUDI9dibfLS0O64Y+H2Zl+9Lxw8Nsql8hGmaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jxBXkaCC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jxBXkaCC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770889965;
	bh=XdhwoC7iS38ULTyh2EON1SSrsr8JoG9YgWk25wcUu1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jxBXkaCCehCEGRtm/lDxy90bvOIljkvSpHjISKeu7XJHPkgwiuMmFGfNw1xJBsoqt
	 LucvoHrLeKLch+SU6tUQ9QbeW6PYb0IKZzWdkbauwKYhLXnlxi24XmUaycDo172MPz
	 EMqN4xoHZOmwYXOUXTiYiPnX7GpNL9K0T5En86rkJ/ALFoDa6ZUVyggQ7nbq7AK43m
	 Dhj4fyLuR4c3SvbWrUPl1+H6waNII7/UjImwrKsL0wbgAiPrJpYe75leAIASZ9E6Em
	 fYhsg+g49VZYL2MWnSYRJMnpSYPVN1Z2q8j1uDbfKJR8ZIAkovYzbupMaks7P/9v/4
	 AagrFDEpfaS7A==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 832C217E114C;
	Thu, 12 Feb 2026 10:52:44 +0100 (CET)
Message-ID: <1908b0e4-6684-4192-8ae4-9e3d1abad21a@collabora.com>
Date: Thu, 12 Feb 2026 10:52:44 +0100
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: mt8167: Add the mmsys reset bit to reset
 dsi
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 linux-mediatek@lists.infradead.org
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <cover.1770836189.git.l.scorcia@gmail.com>
 <72dcec7fe8bfd8ee7e8ef58708690268f3c07d42.1770836190.git.l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <72dcec7fe8bfd8ee7e8ef58708690268f3c07d42.1770836190.git.l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/02/26 20:03, Luca Leonardo Scorcia ha scritto:
> DSI hardware reset is needed to prevent different settings between
> the bootloader and the kernel.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8167.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> index caf51f203dd3..ee2792d53b2c 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/clock/mt8167-clk.h>
>   #include <dt-bindings/memory/mt8167-larb-port.h>
>   #include <dt-bindings/power/mt8167-power.h>
> +#include <dt-bindings/reset/mt8167-resets.h>

Change header name.

Cheers,
Angelo

>   
>   #include "mt8167-pinfunc.h"
>   
> @@ -189,6 +190,7 @@ dsi: dsi@14012000 {
>   				 <&mmsys CLK_MM_DSI_DIGITAL>,
>   				 <&mipi_tx>;
>   			clock-names = "engine", "digital", "hs";
> +			resets = <&mmsys MT8167_MMSYS_SW0_RST_B_DISP_DSI0>;
>   			phys = <&mipi_tx>;
>   			phy-names = "dphy";
>   			status = "disabled";
> @@ -295,6 +297,7 @@ mmsys: syscon@14000000 {
>   			compatible = "mediatek,mt8167-mmsys", "syscon";
>   			reg = <0 0x14000000 0 0x1000>;
>   			#clock-cells = <1>;
> +			#reset-cells = <1>;
>   		};
>   
>   		smi_common: smi@14017000 {


