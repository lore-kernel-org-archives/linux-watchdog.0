Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA52E2F14;
	Thu, 12 Feb 2026 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770889961; cv=none; b=ng5q+A+woHxO4sI/c6EQGmUaCkjLfRC5mwaPMFgqpWYDNz7whE2DBM9dKl5u2Sixd6456GOr+LpCzFeBe4dXrPzO79qpXJM4ReBZGO8iDQCLtBX58e2Kw+T+fK/ZKJo66hHYyQYR+hio3UEjtFUB/mDI37dmdWV+LbwkIbmUjZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770889961; c=relaxed/simple;
	bh=FNUiiSr9MTBi4O+hJNPTKiukGQQ1+8FhXxrhgA80IAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0GD9SKswR2l5n+xhnlt17YSP0P2+N0MlGpUP9i/u075aTTg6CBqU5UOMz4RRJuUUGxLUDsvtraI/LH7y1RHEKM/uytEsca829UDj0iFW+1fR4fC0IfPBIZsRlO5EKN+/TUj8FISUJig+TNJMdPRzx0SMo/6KTAchHT+svDOP+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=h1p0EAdu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="h1p0EAdu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1770889958;
	bh=FNUiiSr9MTBi4O+hJNPTKiukGQQ1+8FhXxrhgA80IAU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h1p0EAduRXkTTq9tpnphLv1eM/MTFgqJtbF10e5OyZvzP8zM9/yLGL4r57zYI21cV
	 shlPoevqFv9+fehRiVePTFEGEhanXoLOwck4jxUOj+y769TdX7wFRf+5TbKAMo/kOX
	 A6xHKcboP9Obd7kWcB86wOqTI9sDb5C1nOAJf18t60pgvGVj8y5YD6GJon4gvKrVOl
	 506b69++mZ9aGrb9yltCp6rFF2D+dImhmfTfrjvX7iYnFBiKIGCvPpPT+GgeOGTKJt
	 wwwMxdhPvIjKbbqFDjERR1tegYdVRe7Cr0kefyEx7Icto6HEebr5V8gsTkcXNg1Bca
	 7qB9F6ffz8YOw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0EA8B17E110D;
	Thu, 12 Feb 2026 10:52:38 +0100 (CET)
Message-ID: <7c1fff1f-dd9d-4900-9c50-e8a34c1ed969@collabora.com>
Date: Thu, 12 Feb 2026 10:52:37 +0100
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] watchdog: mediatek: Add support for mt8167 TOPRGU/WDT
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
 <77434edba7ab5050f5c0fd03302bf9eb4b1c60ca.1770836190.git.l.scorcia@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <77434edba7ab5050f5c0fd03302bf9eb4b1c60ca.1770836190.git.l.scorcia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/02/26 20:03, Luca Leonardo Scorcia ha scritto:
> Add support for the Top Reset Generation Unit/Watchdog Timer found on
> mt8167.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
> ---
>   drivers/watchdog/mtk_wdt.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 91d110646e16..ded16173105b 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -13,6 +13,7 @@
>   #include <dt-bindings/reset/mediatek,mt6735-wdt.h>
>   #include <dt-bindings/reset/mediatek,mt6795-resets.h>
>   #include <dt-bindings/reset/mt7986-resets.h>
> +#include <dt-bindings/reset/mt8167-resets.h>

After changing the filename of that header, you'll obviously have to change it
here and everywhere else - so with that name changed:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


>   #include <dt-bindings/reset/mt8183-resets.h>
>   #include <dt-bindings/reset/mt8186-resets.h>
>   #include <dt-bindings/reset/mt8188-resets.h>
> @@ -105,6 +106,10 @@ static const struct mtk_wdt_data mt7988_data = {
>   	.has_swsysrst_en = true,
>   };
>   
> +static const struct mtk_wdt_data mt8167_data = {
> +	.toprgu_sw_rst_num = MT8167_TOPRGU_SW_RST_NUM,
> +};
> +
>   static const struct mtk_wdt_data mt8183_data = {
>   	.toprgu_sw_rst_num = MT8183_TOPRGU_SW_RST_NUM,
>   };
> @@ -498,6 +503,7 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
>   	{ .compatible = "mediatek,mt6795-wdt", .data = &mt6795_data },
>   	{ .compatible = "mediatek,mt7986-wdt", .data = &mt7986_data },
>   	{ .compatible = "mediatek,mt7988-wdt", .data = &mt7988_data },
> +	{ .compatible = "mediatek,mt8167-wdt", .data = &mt8167_data },
>   	{ .compatible = "mediatek,mt8183-wdt", .data = &mt8183_data },
>   	{ .compatible = "mediatek,mt8186-wdt", .data = &mt8186_data },
>   	{ .compatible = "mediatek,mt8188-wdt", .data = &mt8188_data },


